import 'dart:async';

import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/add_lead_arguments.dart';
import 'package:bank_sathi/Model/request/login_request.dart';
import 'package:bank_sathi/Model/response/InsuranceProfile.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_retriever/sms_retriever.dart';

class KotakInsuranceMobileController extends BaseController {
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

  AddLeadArguments arguments = AddLeadArguments();

  String otpError = '';

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

  validateAndLogin() {
    var input = mobileNoController.value.text;
    if (input.isNotEmpty && input.length == 10 && input.isNumericOnly) {
      arguments.mobileNo = mobileNoController.text;
      getUserProfile();
    } else {
      isInputValid = false;
    }
  }

  Future<void> getUserProfile() async {
    try {
      pageState = PageStates.PAGE_BUTTON_LOADING;
      InsuranceProfile response =
          await restClient.kotakInsVerifyOTP(LoginRequest(
        mobile_no: arguments.mobileNo,
      ));
      if (response.success) {
        pageState = PageStates.PAGE_IDLE;
        arguments.kiData = response.data;
        Get.offAndToNamed(Routes.DASHBOARD + Routes.KOTAK_INSURANCE_LEAD,
            arguments: arguments);
      } else {
        pageState = PageStates.PAGE_BUTTON_ERROR;
        err_name = response.message;
      }
    } catch (e) {
      pageState = PageStates.PAGE_BUTTON_ERROR;
      err_name = 'Something went wrong.';
    }
    return;
  }

  Widget get bottomSheet => Container(
        decoration: BoxDecoration(
          color: ColorUtils.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.sp),
            topRight: Radius.circular(50.sp),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: enter_the_otp_sent_on.tr,
                            style: StyleUtils.textStyleNormalPoppins(
                              color: ColorUtils.grey,
                              weight: FontWeight.w300,
                            )),
                        TextSpan(
                            text: arguments.mobileNo + '\n',
                            style: StyleUtils.textStyleNormalPoppins(
                              color: ColorUtils.black,
                              weight: FontWeight.w500,
                            )),
                        TextSpan(
                            text: to_verify_cus_mobile.tr,
                            style: StyleUtils.textStyleNormalPoppins(
                              color: ColorUtils.grey,
                              weight: FontWeight.w300,
                            )),
                      ],
                    ))
                .marginOnly(
                    left: 100.sp, right: 100.sp, top: 30.sp, bottom: 30.sp),
            PinCodeTextField(
              cursorColor: ColorUtils.white,
              onChanged: (val) {},
              length: 4,
              controller: otpController,
              appContext: Get.context!,
              enablePinAutofill: false,
              autoDisposeControllers: false,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 100.sp,
                inactiveColor: ColorUtils.grey,
                fieldWidth: 100.sp,
                selectedFillColor: Colors.white70,
                activeColor: ColorUtils.grey,
                inactiveFillColor: ColorUtils.white,
                activeFillColor: ColorUtils.white,
              ),
              textStyle: StyleUtils.textStyleNormalPoppins(
                  fontSize: 60.sp, weight: FontWeight.w400),
              onCompleted: (pin) {},
              keyboardType: TextInputType.number,
            ).marginSymmetric(horizontal: 180.sp, vertical: 30.sp),
            (otpError.isNotEmpty)
                ? CustomText(otpError, color: Colors.red)
                : SizedBox(
                    height: 60.sp,
                  ),
            SizedBox(
                width: Get.width * 0.6,
                child: WidgetUtil.getOrangeButton(() => getUserProfile(),
                    label: verify_now.tr.toUpperCase())),
            /*Obx(() => Center(
                  child: timerSeconds > 0
                      ? CustomText(
                          "${resend_code.tr} $remainingMinutes:$remainingSeconds",
                          fontSize: 36.sp,
                          color: ColorUtils.blue,
                          textAlign: TextAlign.center,
                        )
                      : RaisedButton(
        elevation: 0,
                          onPressed: () => sendOtpToLeadMobile(),
                          color: Colors.transparent,
                          elevation: 0,
                          child: CustomText(resend_code.tr,
                              color: ColorUtils.orange),
                        ),
                )).marginAll(40.sp),*/
          ],
        ).marginAll(10.sp),
      );
}
