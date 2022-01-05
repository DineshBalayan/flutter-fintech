import 'dart:async';
import 'dart:io';

import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Model/add_lead_arguments.dart';
import 'package:bank_sathi/Model/request/login_request.dart';
import 'package:bank_sathi/Model/response/login_response.dart';
import 'package:bank_sathi/Model/response/login_verification_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/OtpBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_retriever/sms_retriever.dart';
import 'package:truecaller_sdk/truecaller_sdk.dart';

class LoginController extends BaseController {
  RxBool _isMsgShowed = false.obs;
  RxBool _isInputValid = true.obs;
  RxBool _isTrueCallerUsable = false.obs;

  final RxBool _showCheckIcon = false.obs;

  get showCheckIcon => _showCheckIcon.value;

  set showCheckIcon(val) => _showCheckIcon.value = val;

  bool get isInputValid => _isInputValid.value;
  bool get isMsgShowed => _isMsgShowed.value;

  bool get isTrueCallerUsable => _isTrueCallerUsable.value;

  set isTrueCallerUsable(value) => _isTrueCallerUsable.value = value;

  set isInputValid(value) => _isInputValid.value = value;
  set isMsgShowed(value) => _isMsgShowed.value = value;

  FocusNode focusNode = FocusNode();

  late TextEditingController inputController;
  AddLeadArguments? arguments;
  String appCode = '';

  final _title = ''.obs;

  get title => _title.value;

  set title(val) => _title.value = val;

  @override
  void onInit() {
    super.onInit();
    arguments = Get.arguments;
    inputController = new TextEditingController();
    inputController.addListener(() {
      if (inputController.value.text.isNotEmpty && !isInputValid) {
        isInputValid = true;
      }
      if (inputController.text.length == 10) {
        showCheckIcon = true;
      } else {
        showCheckIcon = false;
      }
    });
    SmsRetriever.getAppSignature().then((value) => appCode = value);
  }

  late StreamSubscription streamSubscription;

  void createStreamBuilder() {
    streamSubscription =
        TruecallerSdk.streamCallbackData.listen((truecallerSdkCallback) {
      switch (truecallerSdkCallback.result) {
        case TruecallerSdkCallbackResult.success:
          trueCallerLogin(truecallerSdkCallback.profile);
          break;
        case TruecallerSdkCallbackResult.failure:
          print(truecallerSdkCallback.error.message);
          break;
        case TruecallerSdkCallbackResult.verification:
          break;
        default:
          print("Invalid result");
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    FocusScope.of(Get.context!).requestFocus(focusNode);

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (GetPlatform.isAndroid && inputController.text.isEmpty) {
          SmsRetriever.getPhoneNumber().then((phone) {
            if (phone.startsWith("+91")) {
              phone = phone.replaceAll("+91", "");
            }
            inputController.text = phone.replaceAll(" ", "");
            validateAndLogin();
          }).catchError((onError) {
            print(onError);
          });
        }
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  validateAndLogin() {
    if (pageState == PageStates.PAGE_IDLE) {
      var input = inputController.value.text;
      if (input.isNotEmpty && input.length == 10 && input.isNumericOnly) {
        login();
        // true;CallerLoginByNumber();
      } else {
        isInputValid = false;
      }
    }
  }

  login() {
    prefManager.saveMobile(inputController.value.text);
    pageState = PageStates.PAGE_BUTTON_LOADING;
    restClient
        .login(LoginRequest(
            mobile_no: inputController.value.text,
            app_code: Platform.isIOS ? "zjxhje" : appCode))
        .then((response) {
      hideDialog();
      if (response.success) {
        pageState = PageStates.PAGE_IDLE;
        Get.bottomSheet(
            OtpBottomSheet(
              onVerifyClick: verifyUser,
              onResendClick: resendClick,
              mobileNo: inputController.text,
            ),
            isScrollControlled: true,
            isDismissible: false);
      }
    }).catchError((error) {
      pageState = PageStates.PAGE_IDLE;
    });
  }

  Future<bool> resendClick() async {
    prefManager.saveMobile(inputController.value.text);
    LoginResponse response = await restClient.login(
        LoginRequest(mobile_no: inputController.value.text, app_code: appCode));
    return response.success;
  }

  Future verifyUser(String otp) async {
    if (otp.length != 4) {
      handleError(msg: otp_error_four_digit.tr);
    } else {
      LoginVerificationResponse response = await restClient.verifyLogin(
          LoginRequest(mobile_no: prefManager.getMobile(), otp: otp));
      if (response.success) {
        prefManager.saveToken(response.data.token);
        prefManager.saveUserId(response.data.user.id);
        if (response.data.user.user_code != null) {
          await getUser();
          Get.offAllNamed(Routes.DASHBOARD);
        } else {
          Get.offAllNamed(Routes.LOGIN + Routes.AADHAR_VERIFICATION);
        }
      } else {
        handleError(msg: response.message);
      }
    }
  }

  getProfile() async {
    if (isTrueCallerUsable) {
      TruecallerSdk.getProfile();
    } else {
      handleError();
    }
  }

  trueCallerLogin(profile) {
    String phoneNumber = profile.phoneNumber;
    if (phoneNumber.startsWith("+91")) {
      phoneNumber = phoneNumber.replaceAll("+91", "");
    }
    prefManager.saveMobile(phoneNumber);
    showLoadingDialog();
    restClient.trueLogin(LoginRequest(mobile_no: phoneNumber)).then((response) {
      hideDialog();
      if (response.success) {
        prefManager.saveToken(response.data.token);
        prefManager.saveUserId(response.data.user.id);
        if (response.data.user.user_code != null) {
          showLoadingDialog();
          getUser().then((value) {
            hideDialog();
            Get.offAllNamed(Routes.DASHBOARD);
          });
        } else {
          Get.offAllNamed(Routes.LOGIN + Routes.REGISTER, arguments: profile);
        }
      } else {
        handleError(msg: response.message);
      }
    }).catchError((onError) {});
  }

  trueCallerLoginByNumber() {
    showLoadingDialog();
    prefManager.saveMobile('9414468070');
    restClient
        .trueLogin(LoginRequest(mobile_no: '9414468070'))
        .then((response) {
      hideDialog();
      if (response.success) {
        prefManager.saveToken(response.data.token);
        prefManager.saveUserId(response.data.user.id);
        if (response.data.user.user_code != null) {
          showLoadingDialog();
          getUser().then((value) {
            hideDialog();
            Get.offAllNamed(Routes.DASHBOARD);
          });
        } else {
          Get.offAllNamed(Routes.LOGIN + Routes.REGISTER);
        }
      } else {
        handleError(msg: response.message);
      }
    }).catchError((onError) {});
  }

  void initTruecaller() async {
    TruecallerSdk.initializeSDK(
        sdkOptions: TruecallerSdkScope.SDK_OPTION_WITHOUT_OTP,
        consentMode: TruecallerSdkScope.CONSENT_MODE_BOTTOMSHEET,
        consentTitleOptions: TruecallerSdkScope.SDK_CONSENT_TITLE_VERIFY,
        footerType: TruecallerSdkScope.FOOTER_TYPE_CONTINUE,
        buttonShapeOptions: TruecallerSdkScope.BUTTON_SHAPE_RECTANGLE,
        buttonColor: ColorUtils.blue.value,
        buttonTextColor: ColorUtils.white.value);

    isTrueCallerUsable = await TruecallerSdk.isUsable;
    print(isTrueCallerUsable);
  }
}
