import 'dart:async';

import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/add_lead_arguments.dart';
import 'package:bank_sathi/Model/request/login_request.dart';
import 'package:bank_sathi/Model/response/add_lead_info_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_retriever/sms_retriever.dart';

class PersonalLoanMobileController extends BaseController {
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  final RxString _err_name = ''.obs;

  String get err_name => _err_name.value;

  set err_name(val) => _err_name.value = val;

  final RxBool _showCheckIcon = false.obs;

  get showCheckIcon => _showCheckIcon.value;

  set showCheckIcon(val) => _showCheckIcon.value = val;

  RxBool _isInputValid = true.obs;

  bool get isInputValid => _isInputValid.value;

  set isInputValid(value) => _isInputValid.value = value;

  @override
  void onInit() {
    super.onInit();
    mobileNoController.addListener(() {
      if (mobileNoController.value.text.isNotEmpty && !isInputValid) {
        isInputValid = true;
      }
      showCheckIcon = mobileNoController.text.length == 10;
    });
  }

  pickContact() async {
    int permission = await SmsRetriever.hasContactPermission();
    if (permission == 1) {
      PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
      String phoneNumber = contact.phoneNumber!.number!;
      if (phoneNumber.startsWith("+91")) {
        phoneNumber = phoneNumber.replaceAll("+91", "");
      }
      mobileNoController.text = phoneNumber.replaceAll(" ", "");
    } else if (permission == 2) {
      openAppSetting('Grant Contact permission from App Setting.');
    } else {
      bool permissionGranted = await FlutterContactPicker.requestPermission();
      if (permissionGranted) {
        pickContact();
      } else {
        handleError(msg: "Need Contact permission to pick contact.");
      }
    }
  }

  AddLeadArguments arguments = AddLeadArguments();

  final _timerSeconds = 0.obs;

  get timerSeconds => _timerSeconds.value;

  set timerSeconds(val) => _timerSeconds.value = val;

  String otpError = '';

  String get remainingMinutes =>
      (timerSeconds ~/ 60).toString().padLeft(2, "0");

  String get remainingSeconds => (timerSeconds % 60).toString().padLeft(2, "0");

  validateAndLogin() async {
    var input = mobileNoController.value.text;
    arguments.mobileNo = input;
    if (input.isNotEmpty && input.length == 10 && input.isNumericOnly) {
      sendOtpToLeadMobile();
    } else {
      isInputValid = false;
    }
  }

  sendOtpToLeadMobile() {
    pageState = PageStates.PAGE_BUTTON_LOADING;
    restClient.PLVerifyOTP(LoginRequest(mobile_no: mobileNoController.text)).then((value) async {
      if (value.success) {
        pageState = PageStates.PAGE_IDLE;
        arguments.plData = value.data;
        Get.offAndToNamed(Routes.PERSONAL_LOAN_LEAD, arguments: arguments);
      } else {
        pageState = PageStates.PAGE_BUTTON_ERROR;
        err_name = value.message;
      }
    }).catchError((onError) {
      err_name = 'Something went wrong';
      pageState = PageStates.PAGE_BUTTON_ERROR;
    });
  }
}
