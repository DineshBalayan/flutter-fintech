import 'dart:async';

import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Model/response/CaptchaResponse.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/ButtonState.dart';
import 'package:bank_sathi/widgets/IconedButton.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:truecaller_sdk/truecaller_sdk.dart';

class AAdharVerificationController extends BaseController {
  final globalKey_aadhar = GlobalKey<FormState>();

  late TextEditingController adharNumberController, otpController;


  TruecallerUserProfile? profile;

  final RxBool _showCheckIconA = false.obs;

  get showCheckIconA => _showCheckIconA.value;

  set showCheckIconA(val) => _showCheckIconA.value = val;


  final _requestID = ''.obs;

  get requestID => _requestID.value;

  set requestID(val) => _requestID.value = val;

 final _name = ''.obs;

  get name => _name.value;

  set name(val) => _name.value = val;

  final _address = ''.obs;

  get address => _address.value;

  set address(val) => _address.value = val;

  late Timer recurringTask;

  final _timerSeconds = 0.obs;

  get timerSeconds => _timerSeconds.value;

  set timerSeconds(val) => _timerSeconds.value = val;

  String get remainingMinutes =>
      (timerSeconds ~/ 60).toString().padLeft(2, "0");

  String get remainingSeconds => (timerSeconds % 60).toString().padLeft(2, "0");

  FocusNode focusNode = FocusNode();

  final _fromKycDetail = false.obs;

  bool get fromKycDetail => _fromKycDetail.value;

  set fromKycDetail(val) => _fromKycDetail.value = val;

  @override
  void onInit() async {
    super.onInit();
    adharNumberController = TextEditingController();
     otpController = TextEditingController();

  }

  @override
  void onReady() {
    super.onReady();
    fromKycDetail = Get.parameters["from_kyc_detail"] != null;
    adharNumberController.addListener(() {
      showCheckIconA = adharNumberController.text.length == 14;
      if (!showCheckIconA)
        pageState = PageStates.PAGE_BUTTON_FAIL;
      else
        pageState = PageStates.PAGE_IDLE;
    });

    FocusScope.of(Get.context!).requestFocus(focusNode);
  }

  @override
  void onClose() {
    adharNumberController.dispose();
    otpController.dispose();
    super.onClose();
  }

  startTimer() {
    timerSeconds = 600;
    recurringTask = Timer.periodic(1.seconds, (timer) {
      --timerSeconds;
      if (timerSeconds == 0) {
        timer.cancel();
      }
    });
  }

  submitaadharOTP() async {
    if (otpController.text.length == 6) {
      pageState = PageStates.PAGE_BUTTON_LOADING;
      restClient
          .verifyAdharOTP(getUserId(), requestID,
          otpController.text)
          .then((response) {
        if (response.success) {
          getUser().then((value) {
            pageState = PageStates.PAGE_IDLE;
            if (!fromKycDetail) {
              Get.offAndToNamed(Routes.LOGIN + Routes.PAN_VERIFICATION);
            } else {
              if (Get.isBottomSheetOpen!) {
                Get.back();
              }
              Get.back();
            }
          });
        } else {
          pageState = PageStates.PAGE_IDLE;
          handleError(msg: response.message);
          otpController.text = '';
        }
      }).catchError((e) {
        pageState = PageStates.PAGE_IDLE;
        otpController.text = '';
        print(e);
      });
    }
  }
// 974663377564
//9812 5432 0936//263262093523 ////8083 4101 4551 /// 7801 2045 2804

  aadharValidation() async {
    if (globalKey_aadhar.currentState!.validate()) {
      pageState = PageStates.PAGE_BUTTON_LOADING;
      restClient
          .getAdharOTP(getUserId(),
          adharNumberController.text.toString().replaceAll(' ', ''))
          .then((response) {
        pageState = PageStates.PAGE_IDLE;
        if (response.success) {
          requestID = response.data['request_id'];
          Get.bottomSheet(
              BasePageView(
                  controller: this,
                  idleWidget: Container(
                      decoration: BoxDecoration(
                        color: ColorUtils.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.sp),
                          topRight: Radius.circular(50.sp),
                        ),
                      ),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        CustomText(
                          'Make Sure It\'s You',
                          fontweight: FontWeight.w500,
                          color: ColorUtils.textColor,
                          fontSize: 60.sp,
                        ).marginOnly(top: 50.sp),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                    'Enter the OTP that sent on the mobile number linked with Aadhar Card\n',
                                    style:
                                    StyleUtils.textStyleNormalPoppins(
                                      color: ColorUtils.greylight,
                                      weight: FontWeight.w400,
                                    )),
                              ],
                            ))
                            .marginOnly(
                            left: 100.sp,
                            right: 100.sp,
                            top: 15.sp,
                            bottom: 40.sp),
                        PinCodeTextField(
                          cursorColor: ColorUtils.white,
                          onChanged: (val) {},
                          length: 6,
                          controller: otpController,
                          appContext: Get.context!,
                          enablePinAutofill: false,
                          autoDisposeControllers: false,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            borderRadius: BorderRadius.circular(5),
                            selectedColor: ColorUtils.orange,
                            inactiveColor: ColorUtils.greylight,
                            activeColor: ColorUtils.blackLight,
                            fieldHeight: 100.sp,
                            fieldWidth: 130.sp,
                            selectedFillColor: Colors.white70,
                            inactiveFillColor: ColorUtils.white,
                            activeFillColor: ColorUtils.white,
                          ),
                          textStyle: StyleUtils.textStyleNormalPoppins(
                              fontSize: 65.sp, weight: FontWeight.w500),
                          onCompleted: (pin) {},
                          keyboardType: TextInputType.number,
                        ).marginSymmetric(horizontal: 130.sp, vertical: 30.sp),
                        Obx(() => ProgressButton.icon(
                            radius: 200.sp,
                            progressIndicator: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            iconedButtons: {
                              ButtonState.idle: IconedButton(
                                  text: ' Verify OTP ',
                                  icon:
                                  Icon(Icons.send, color: Colors.white),
                                  color: ColorUtils.orange),
                              ButtonState.loading: IconedButton(
                                  text: "Verifying",
                                  color: ColorUtils.orange),
                              ButtonState.fail: IconedButton(
                                  text: "Failed",
                                  icon: Icon(Icons.cancel,
                                      color: Colors.white),
                                  color: Colors.red.shade300),
                              ButtonState.success: IconedButton(
                                  text: "Success",
                                  icon: Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                  ),
                                  color: Colors.green.shade400)
                            },
                            textStyle: StyleUtils.textStyleMediumPoppins(
                                color: ColorUtils.white,
                                weight: FontWeight.w600),
                            onPressed: () => submitaadharOTP(),
                            state: pageState.getMatchingButtonState)
                            .marginOnly(top: 30.sp)),
                        Obx(() => Center(
                            child: timerSeconds > 0
                                ? CustomText(
                              "${resend_code.tr} ${remainingMinutes}:${remainingSeconds}",
                              fontSize: 36.sp,
                              color: ColorUtils.orange,
                              textAlign: TextAlign.center,
                            )
                                : RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Didn\'t receive OTP yet? ',
                                        style: StyleUtils
                                            .textStyleNormalPoppins(
                                          color: ColorUtils.greylight,
                                          weight: FontWeight.w400,
                                        )),
                                    TextSpan(
                                        text: resend_code.tr,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.back();
                                            aadharValidation();
                                          },
                                        style: StyleUtils
                                            .textStyleNormalPoppins(
                                          color: ColorUtils.orange,
                                          weight: FontWeight.w500,
                                        )),
                                  ],
                                )))).marginOnly(top: 80.sp, bottom: 20.sp),
                      ]).marginOnly(top: 80.sp, bottom: 20.sp))),
              isScrollControlled: true,
              isDismissible: false);


          startTimer();
          /* Get.snackbar(response.data['message'], '',
              snackPosition: SnackPosition.BOTTOM);*/
        } else {
          handleError(msg: response.data['err_msg'][0]);
        }
      }).catchError((e) {
        pageState = PageStates.PAGE_IDLE;
        print(e);
      });
    }
  }

}
