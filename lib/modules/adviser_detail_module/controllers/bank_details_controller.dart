import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/request/login_request.dart';
import 'package:bank_sathi/Model/response/base_response.dart';
import 'package:bank_sathi/Model/response/login_verification_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/mixin/state_city_mixin.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/OtpBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:sms_retriever/sms_retriever.dart';

class BankDetailController extends BaseController
    with StateCityMixin, SingleGetTickerProviderMixin {
  final _isVerified = false.obs;

  bool get isVerified => _isVerified.value;

  set isVerified(val) => _isVerified.value = val;

  final globalKey = GlobalKey<FormState>();

  TextEditingController accountNumber = TextEditingController(),
      payTmController = TextEditingController(),
      ifscCode = TextEditingController();

  late TabController pageController = TabController(length: 2, vsync: this);

  @override
  void onClose() {
    accountNumber.dispose();
    ifscCode.dispose();
    super.onClose();
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
  void onInit() {
    super.onInit();
  }

  void upload() async {
    if (selectedBank == null) {
      Get.dialog(WidgetUtil.showDialog(() => Get.back(),
          dialogType: DialogType.ALERT,
          title: alert.tr,
          message: select_bank.tr));
    } else if (globalKey.currentState!.validate() && selectedBank != null) {
      pageState = PageStates.PAGE_BUTTON_LOADING;
      restClient
          .verifyBankAccount(user.id.toString(), accountNumber.text, "",
              ifscCode.text, selectedBank!.id.toString())
          .then((value) {
        pageState = PageStates.PAGE_IDLE;
        Fluttertoast.showToast(msg: value.data['statusMessage']);
        if (value.success) {
          getUser();
          Get.back();
        }
      }).catchError((onError) {
        pageState = PageStates.PAGE_IDLE;
      });
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
        Get.dialog(WidgetUtil.showDialog(() {
          Get.back();
        },
            button: 'OK',
            title: "Verified",
            message: "Your PayTm account is verified now.",
            dialogType: DialogType.INFO));
        await getUser();
      } else {
        handleError(msg: response.message);
      }
    }
  }
}
