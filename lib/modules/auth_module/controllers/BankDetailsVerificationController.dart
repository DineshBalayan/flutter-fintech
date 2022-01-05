import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/request/login_request.dart';
import 'package:bank_sathi/Model/response/base_response.dart';
import 'package:bank_sathi/Model/response/login_verification_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/mixin/state_city_mixin.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/widgets/OtpBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sms_retriever/sms_retriever.dart';

class BankDetailsVerificationController extends BaseController
    with StateCityMixin {
  final _isVerified = false.obs;

  bool get isVerified => _isVerified.value;

  set isVerified(val) => _isVerified.value = val;
  final globalKey = GlobalKey<FormState>();

  TextEditingController accountNumber = TextEditingController(),
      payTmController = TextEditingController(),
      ifscCode = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await fetchData();
    if (user.relbank != null) {
      accountNumber.text = user.relbank.account_no;
      ifscCode.text = user.relbank.ifsc_code;
      selectedBank =
          bankList.firstWhere((element) => element.id == user.relbank?.bank_id);
      isVerified = user.relbank.status != null && user.relbank.status == "1";
    }
    payTmController.text = user.paytm_mobile_no;
  }

  @override
  void onClose() {
    accountNumber.dispose();
    ifscCode.dispose();
    super.onClose();
  }

  void upload() async {
    if (selectedBank != null && globalKey.currentState!.validate()) {
      pageState = PageStates.PAGE_BUTTON_LOADING;
      restClient
          .verifyBankAccount(user.id.toString(), accountNumber.text, "",
              ifscCode.text, selectedBank!.id.toString())
          .then((value) {
        pageState = PageStates.PAGE_IDLE;
        Fluttertoast.showToast(msg: value.data['statusMessage']);
        if (value.success) {
          if (payTmController.text.isNotEmpty) {
            submitPayTmNumber();
          } else {
            getUser();
            Get.offAllNamed(Routes.DASHBOARD);
          }
        }
      }).catchError((onError) {
        pageState = PageStates.PAGE_IDLE;
      });
    } else if (selectedBank == null) {
      if (accountNumber.text.isNotEmpty || ifscCode.text.isNotEmpty) {
        handleError(msg: select_bank.tr);
      } else {
        if (payTmController.text.length == 10 &&
            payTmController.text.isNumericOnly) {
          submitPayTmNumber();
        } else {
          handleError(
              msg:
                  "PayTM account or Bank account details are required for payout withdrawal.");
        }
      }
    }
  }

  Future<void> submitPayTmNumber() async {
    if (payTmController.text.length == 10 &&
        payTmController.text.isNumericOnly) {
      pageState = PageStates.PAGE_BUTTON_LOADING;
      try {
        BaseResponse response = await restClient.getPaytmOtp(LoginRequest(
            mobile_no: payTmController.text,
            app_code: await SmsRetriever.getAppSignature()));
        pageState = PageStates.PAGE_IDLE;
        if (response.success) {
          if (!Get.isBottomSheetOpen!) {
            Get.bottomSheet(
                OtpBottomSheet(
                    onResendClick: submitPayTmNumber,
                    onVerifyClick: verifyOtp,
                    mobileNo: payTmController.text),
                isScrollControlled: true);
          }
        }
      } catch (e) {
        pageState = PageStates.PAGE_IDLE;
      }
    } else {
      handleError(msg: "Enter valid mobile number");
    }
  }

  Future<void> verifyOtp(String otp) async {
    if (otp.length != 4) {
      handleError(msg: otp_error_four_digit.tr);
    } else {
      LoginVerificationResponse response = await restClient.verifyPaytmOtp(
          LoginRequest(
              mobile_no: payTmController.text, otp: otp, user_id: getUserId()));
      if (response.success) {
        Get.back();
        getUser();
        Get.dialog(WidgetUtil.showDialog(() {
          Get.back();
          Get.offAllNamed(Routes.DASHBOARD);
        },
            button: 'OK',
            title: "Verified",
            message: "Your PayTm account is verified now.",
            dialogType: DialogType.INFO));
      } else {
        handleError(msg: response.message);
      }
    }
  }
}
