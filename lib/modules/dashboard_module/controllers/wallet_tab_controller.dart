import 'dart:convert';
import 'dart:typed_data';

import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/request/MPinRequest.dart';
import 'package:bank_sathi/Model/response/base_response.dart';
import 'package:bank_sathi/Model/response/lead_transaction_response.dart';
import 'package:bank_sathi/Model/response/referral_transactions_response.dart';
import 'package:bank_sathi/Model/response/withdrawal_transactions_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steel_crypt/steel_crypt.dart';
import 'package:crypto/crypto.dart';

class WalletTabController extends BaseController
    with SingleGetTickerProviderMixin {
  final _total_amount = "0".obs;
  final _total_balance = "0".obs;
  DashboardController dashController = Get.find<DashboardController>();

  get total_amount => _total_amount.value;

  set total_amount(val) => _total_amount.value = val;

  String get total_balance => _total_balance.value;

  set total_balance(val) => _total_balance.value = val;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
     Future.delayed(500.milliseconds, () {
      int currentTab = int.parse(Get.parameters['index'] ?? "0");
      changeIndex(currentTab);
    });
  }

 /* encryptAESCryptoJS() {
     try {
      // var key32 = CryptKey().genFortuna(len: 32);
      var key32 = 'XwG1XP3DHaps7XSG+bWl4FVcog7xydSmxEWrv7GdEHU=';
      // var iv16 = CryptKey().genDart(len: 16);
      var iv16 = 'A9oozycMsGoYHAq1Ra/Jrg==';

      var bytes = utf8.encode(key32);
      Digest sha256Result = sha256.convert(bytes);


      var bytesIV = utf8.encode(key32);
      Digest sha256ResultIV = sha256.convert(bytesIV);
      String base64Key = base64.encode(sha256ResultIV.bytes);

      List<int> iv = base64.decode(iv16);
      Hmac hmac2 = new Hmac(sha256, base64.decode(iv16.substring(0, 16)));
      Digest digest2 = hmac2.convert(iv);
      String base64Key2 = base64.encode(digest2.bytes);

      print(sha256Result);
      print(base64Key2);
      print('sagar');
      String s = 'SagarSable SagarSable SagarSable SagarSable SagarSable SagarSable';

      var aesEncrypted = AesCrypt(key: base64Key, padding: PaddingAES.none);
      String encrypted = aesEncrypted.cbc.encrypt(inp: s, iv: base64Key2);

      print('sagar');
      print(encrypted);
    } catch (error) {
      throw error;
    }
  }
*/
  changeIndex(position) async {
    try {
      pageController.animateTo(position,
          curve: Curves.easeInExpo, duration: 500.milliseconds);
    } catch (e) {
      print(e);
    }
  }

  late TabController pageController = TabController(length: 3, vsync: this);

  withDrawToWallet(String mobileNo) async {
    showLoadingDialog();
    try {
      BaseResponse response =
          await restClient.withdrawRequest(getUserId().toString(), mobileNo);
      await dashController.dashboardApi();
      await Get.find<WithdrawalController>().onRefresh();
      hideDialog();
      if (response.success) {
        Get.back();
        Get.dialog(WidgetUtil.showDialog(() {
          Get.back();
        },
            title: response.message == 'Unauthorizede Access'? "Error" :response.message.contains('under maintenance')? "Hold On!": "Success",
            dialogType: response.message == 'Unauthorizede Access'
                ? DialogType.ERROR
                : DialogType.INFO,
            message: response.message));
      }
    } catch (e) {
      hideDialog();
    }
  }

  Future withDrawToBank() async {
    showLoadingDialog();
    try {
      BaseResponse response =
          await restClient.withdrawRequestBank(getUserId().toString());
      await dashController.dashboardApi();
      await Get.find<WithdrawalController>().onRefresh();
      hideDialog();
      if (response.success) {
        Get.back();
        Get.dialog(WidgetUtil.showDialog(() {
          Get.back();
        },
            title: response.message == 'Unauthorizede Access'
                ? "Error"
                : "Success",
            dialogType: response.message == 'Unauthorizede Access'
                ? DialogType.ERROR
                : DialogType.INFO,
            message: response.message));
      }
    } catch (e) {
      hideDialog();
    }
    return;
  }
}

class ReferralController extends BaseController {
  int totalPage = 2;
  int currentPage = 1;
  RxList<ReferralTransactions> _transactionList = <ReferralTransactions>[].obs;

  List<ReferralTransactions> get transactionList => _transactionList.value;

  set transactionList(val) => _transactionList = val;

  Future<void> onRefresh() async {
    totalPage = 2;
    currentPage = 1;
    await fetchTransaction();
    return;
  }

  @override
  void onReady() async {
    super.onReady();
    fetchTransaction();
  }

  Future<void> fetchTransaction() async {
    if (currentPage <= totalPage) {
      try {
        pageState = currentPage == 1
            ? PageStates.PAGE_LOADING
            : PageStates.PAGE_LOADING_MORE;

        MPinRequest request = MPinRequest(
          user_id: getUserId(),
        );

        final response = await restClient.referralTransactions(
            page: currentPage, transactionRequest: request);

        if (response.success) {
          if (currentPage == 1) {
            transactionList.clear();
          }
          transactionList.addAll(response.data.referral_payout.data);

          currentPage++;

          totalPage = response.data.referral_payout.last_page;
        } else {
          handleError(msg: response.message);
        }
      } on Exception {
      } finally {
        if (transactionList.length == 0) {
          pageState = PageStates.PAGE_EMPTY_DATA;
        } else {
          pageState = PageStates.PAGE_IDLE;
        }
      }
      _transactionList.refresh();
    }
    return;
  }
}

class PayoutTransactionsController extends BaseController {
  int totalPage = 2;
  int currentPage = 1;
  RxList<LeadTransactions> _transactionList = <LeadTransactions>[].obs;

  List<LeadTransactions> get transactionList => _transactionList.value;

  set transactionList(val) => _transactionList = val;

  Future<void> onRefresh() async {
    totalPage = 2;
    currentPage = 1;
    await fetchTransaction();
    return;
  }

  @override
  void onReady() async {
    super.onReady();
    fetchTransaction();
  }

  Future<void> fetchTransaction() async {
    if (currentPage <= totalPage) {
      try {
        pageState = currentPage == 1
            ? PageStates.PAGE_LOADING
            : PageStates.PAGE_LOADING_MORE;

        MPinRequest request = MPinRequest(
          user_id: getUserId(),
        );

        final response = await restClient.leadTransactions(
            page: currentPage, transactionRequest: request);

        if (response.success) {
          if (currentPage == 1) {
            transactionList.clear();
          }
          currentPage++;
          transactionList.addAll(response.data.lead_payout.data);
          totalPage = response.data.lead_payout.last_page;
        } else {
          handleError(msg: response.message);
        }
      } on Exception {
      } finally {
        if (transactionList.length == 0) {
          pageState = PageStates.PAGE_EMPTY_DATA;
        } else {
          pageState = PageStates.PAGE_IDLE;
        }
      }
      _transactionList.refresh();
    }
    return;
  }
}

class WithdrawalController extends BaseController {
  WalletTabController walletTabController = Get.find();
  int totalPage = 2;
  int currentPage = 1;
  RxList<WithdrawalTransections> _transactionList =
      <WithdrawalTransections>[].obs;

  List<WithdrawalTransections> get transactionList => _transactionList.value;

  set transactionList(val) => _transactionList = val;

  Future<void> onRefresh() async {
    totalPage = 2;
    currentPage = 1;
    await fetchTransaction();
    return;
  }

  @override
  void onReady() async {
    super.onReady();
    fetchTransaction();
  }

  Future<void> fetchTransaction() async {
    if (currentPage <= totalPage) {
      try {
        pageState = currentPage == 1
            ? PageStates.PAGE_LOADING
            : PageStates.PAGE_LOADING_MORE;

        MPinRequest request = MPinRequest(
          user_id: getUserId(),
        );

        final response = await restClient.withdrawTransactions(
            page: currentPage, transactionRequest: request);

        if (response.success) {
          walletTabController.total_amount = response.data.total_earning;
          walletTabController.total_balance = response.data.total_balance;
          if (currentPage == 1) {
            transactionList.clear();
          }

          transactionList.addAll(response.data.withdrawals.data);

          currentPage++;

          totalPage = response.data.withdrawals.last_page;
        } else {
          handleError(msg: response.message);
        }
      } on Exception {
      } finally {
        if (transactionList.length == 0) {
          pageState = PageStates.PAGE_EMPTY_DATA;
        } else {
          pageState = PageStates.PAGE_IDLE;
        }
      }
      _transactionList.refresh();
    }
    return;
  }
}
