import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bank_sathi/Model/request/update_account_request.dart';
import 'package:bank_sathi/Model/response/CaptchaResponse.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/db/db_controller.dart';
import 'package:bank_sathi/db/pincode_helper.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:dio/dio.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:truecaller_sdk/truecaller_sdk.dart';

class RegisterController extends BaseController {
  final globalKey = GlobalKey<FormState>();
  final globalKey_aadhar = GlobalKey<FormState>();
  final cardKey = GlobalKey();

  CancelToken cancelToken = CancelToken();

  late TextEditingController firstNameController,
      addressContoller,
      adharNumberController,
      captchaController,
      emailController,
      otpController,
      referralController;

  final _currentStep = 0.obs;

  int get currentStep => _currentStep.value;

  set currentStep(val) => _currentStep.value = val;

  Rxn<CaptchaData> _capData = Rxn<CaptchaData>();
  CaptchaData? get captchaData => _capData.value;
  set captchaData(val) => _capData.value = val;

  PinCodeHelper pinCodeHelper = PinCodeHelper();

  final _enableReferralCode = true.obs;

  get enableReferralCode => _enableReferralCode.value;

  set enableReferralCode(val) => _enableReferralCode.value = val;

  TruecallerUserProfile? profile;

  final _dashCircle = <double>[3, 1].obs;

  List<double> get dash_circle => _dashCircle.value;

  set dash_circle(val) => _dashCircle.value = val;

  final _name = ''.obs;
  get name => _name.value;
  set name(val) => _name.value = val;

  final _address = ''.obs;
  get address => _address.value;
  set address(val) => _address.value = val;

  final _email = ''.obs;

  get email => _email.value;

  set email(val) => _email.value = val;

  final _pincode = ''.obs;

  get pincode => _pincode.value;

  set pincode(val) => _pincode.value = val;

  final _pinAddress = ''.obs;

  get pinAddress => _pinAddress.value;

  set pinAddress(val) => _pinAddress.value = val;

  @override
  void onInit() async {
    super.onInit();
    firstNameController = TextEditingController();
    addressContoller = TextEditingController();
    emailController = TextEditingController();
    otpController = TextEditingController();
    referralController = TextEditingController();

    profile = Get.arguments;
    if (profile != null) {
      firstNameController.text = profile!.firstName + ' ' + profile!.lastName;
      emailController.text = profile!.email;
    }

    await pinCodeHelper.init();

    pinCodeHelper.pinCodeController.addListener(() {
      pincode = pinCodeHelper.pinCodeController.text.toString();
    });

    initDynamicLinks();

    Timer.periodic(
        250.milliseconds,
        (timer) => dash_circle =
            dash_circle[0] == 3 ? <double>[5, 2] : <double>[3, 1]);
  }

  @override
  void onClose() {
    super.onClose();
  }

  validation() async {
    if (globalKey.currentState!.validate()) {
      if (currentStep == 0) {
        if (await pincodeValidation()) {
          currentStep = 1;
        }
      } else if (currentStep == 1) {
          currentStep = 2;
      }else {
        updateAccount();
      }
    }
  }

  final _timerSeconds = 0.obs;
  get timerSeconds => _timerSeconds.value;
  set timerSeconds(val) => _timerSeconds.value = val;
  String otpError = '';
  String get remainingMinutes =>
      (timerSeconds ~/ 60).toString().padLeft(2, "0");
  String get remainingSeconds => (timerSeconds % 60).toString().padLeft(2, "0");
  late Timer recurringTask;

  shareCard() async {
    try {
      RenderRepaintBoundary boundary = this
          .cardKey
          .currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: Get.pixelRatio);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      final directory = (await getApplicationDocumentsDirectory()).path;
      String fileName = "Card";
      var path = '$directory/$fileName.png';
      File imgFile = new File(path);
      await imgFile.writeAsBytes(pngBytes);
      await Share.shareFiles([imgFile.path]);
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<bool> pincodeValidation() async {
    if (await pinCodeHelper.isValidPinCode() == -1) {
      handleError(msg: enter_correct_pin_code.tr);
      return false;
    } else {
      List<PinCodeRow> pinCodes = await pinCodeHelper
          .getSuggestions(pinCodeHelper.pinCodeController.text);
      CityRow cityRow = await pinCodeHelper.dbController
          .getCityByCityId(pinCodes.first.city_id!);
      StateRow stateRow =
          await pinCodeHelper.dbController.getStateById(cityRow.state_id!);
      pinAddress =
          cityRow.city_name.toString() + ', ' + stateRow.state_name.toString();
      return true;
    }
  }

  updateAccount() {
    if (user.profile_photo != null) {
      var updateAccountRequest = UpdateAccountRequest(
          email: emailController.text,
          first_name: firstNameController.text,
          address: addressContoller.text,
          pincode: pinCodeHelper.pinCodeController.text,
          referral_code: referralController.text,
          user_id: prefManager.getUserId().toString());
      pageState = PageStates.PAGE_BUTTON_LOADING;

      restClient.updateAccount(updateAccountRequest).then((response) {
        pageState = PageStates.PAGE_IDLE;
        if (response.success) {
          prefManager.saveUserId(response.data.user.id);
          getUser().then((value) {
            currentStep++;
            pageState = PageStates.PAGE_IDLE;
          });
        } else {
          handleError(msg: response.message);
        }
      }).catchError((e) {
        print(e);
      });
    } else {
      Get.snackbar(
          'Card missing user photo!!', 'Please upload your profile photo.');
    }
  }

  initDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (data != null) {
      final Uri deepLink = data.link;

      String? code = deepLink.queryParameters['code'];
      referralController.text = code ?? '';
      enableReferralCode = code == null;

      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData? dynamicLink) async {
            final Uri deepLink = dynamicLink!.link;
            String code = deepLink.queryParameters['code'] ?? '';
            referralController.text = code;
            enableReferralCode = false;
          },
          onError: (OnLinkErrorException e) async {});
    }
  }
}
