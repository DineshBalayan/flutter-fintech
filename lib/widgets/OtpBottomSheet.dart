import 'dart:async';

import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/widgets/ButtonState.dart';
import 'package:bank_sathi/widgets/IconedButton.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_retriever/sms_retriever.dart';

typedef OnVerifyClick = Future Function(String otp);
typedef OnResendClick<bool> = Future Function();

class OtpBottomSheet extends StatelessWidget {
  final OnResendClick onResendClick;
  final OnVerifyClick onVerifyClick;
  final mobileNo;

  const OtpBottomSheet(
      {Key? key,
      required this.onResendClick,
      required this.onVerifyClick,
      required this.mobileNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpBottomSheetController>(
        init: OtpBottomSheetController(onVerifyClick),
        builder: (controller) {
          return BasePageView(
              controller: controller,
              idleWidget: Container(
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
                    CustomText(
                      make_sure_its_you.tr,
                      fontweight: FontWeight.w500,
                      color: ColorUtils.textColor,
                      fontSize: 60.sp,
                    ).marginOnly(top: 50.sp),
                    RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: enter_the_otp_sent_on.tr,
                                    style: StyleUtils.textStyleNormalPoppins(
                                      color: ColorUtils.greylight,
                                      weight: FontWeight.w400,
                                    )),
                                TextSpan(
                                    text:
                                        ' ${mobileNo[0]}${mobileNo[1]}******${mobileNo[8]}${mobileNo[9]}\n',
                                    style: StyleUtils.textStyleNormalPoppins(
                                      color: ColorUtils.greylight,
                                      weight: FontWeight.w400,
                                    )),
                                /* TextSpan(
                                    text: to_verify_cus_mobile.tr,
                                    style: StyleUtils.textStyleNormalPoppins(
                                      color: ColorUtils.grey,
                                      weight: FontWeight.w300,
                                    )),*/
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
                      length: 4,
                      controller: controller.otpController,
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
                      onCompleted: (pin) {
                        controller.verify(pin);
                      },
                      keyboardType: TextInputType.number,
                    ).marginSymmetric(horizontal: 130.sp, vertical: 30.sp),
                    Obx(() => ProgressButton.icon(
                            radius: 200.sp,
                            progressIndicator: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            iconedButtons: {
                              ButtonState.idle: IconedButton(
                                  text: ' ${verify_otp.tr} ',
                                  icon: Icon(Icons.send, color: Colors.white),
                                  color: ColorUtils.orange),
                              ButtonState.loading: IconedButton(
                                  text: verifying.tr, color: ColorUtils.orange),
                              ButtonState.fail: IconedButton(
                                  text: failed.tr,
                                  icon: Icon(Icons.cancel, color: Colors.white),
                                  color: Colors.red.shade300),
                              ButtonState.success: IconedButton(
                                  text: success.tr,
                                  icon: Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                  ),
                                  color: Colors.green.shade400)
                            },
                            textStyle: StyleUtils.textStyleMediumPoppins(
                                color: ColorUtils.white,
                                weight: FontWeight.w600),
                            onPressed: () {
                              if (controller.pageState ==
                                  PageStates.PAGE_IDLE) {
                                controller
                                    .verify(controller.otpController.text);
                              }
                            },
                            state: controller.pageState.getMatchingButtonState)
                        .marginOnly(top: 30.sp)),

                    /* SizedBox(
                        width: Get.width * 0.6,
                        child: WidgetUtil.getOrangeButton(
                            () => onVerifyClick(controller.otpController.text),
                            label: verify_now.tr.toUpperCase())),*/
                    Obx(() => Center(
                        child: controller.timerSeconds > 0
                            ? CustomText(
                                "${resend_code.tr} ${controller.remainingMinutes}:${controller.remainingSeconds}",
                                fontSize: 36.sp,
                                color: ColorUtils.orange,
                                textAlign: TextAlign.center,
                              )
                            : RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '${didnt_receive_otp.tr} ',
                                        style:
                                            StyleUtils.textStyleNormalPoppins(
                                          color: ColorUtils.greylight,
                                          weight: FontWeight.w400,
                                        )),
                                    TextSpan(
                                        text: resend_code.tr,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => controller
                                              .resendOtp(onResendClick),
                                        style:
                                            StyleUtils.textStyleNormalPoppins(
                                          color: ColorUtils.orange,
                                          weight: FontWeight.w500,
                                        )),
                                  ],
                                )))).marginOnly(top: 80.sp, bottom: 20.sp),
                  ],
                ).marginAll(50.sp),
              ));
        });
  }
}

class OtpBottomSheetController extends BaseController {
  verify(otp) async {
    pageState = PageStates.PAGE_BUTTON_LOADING;
    try {
      await onVerifyClick(otp);
    } finally {
      pageState = PageStates.PAGE_IDLE;
      otpController.text = '';
    }
  }

  TextEditingController otpController = TextEditingController();
  final onVerifyClick;
  final _timerSeconds = 0.obs;

  OtpBottomSheetController(this.onVerifyClick);

  get timerSeconds => _timerSeconds.value;

  set timerSeconds(val) => _timerSeconds.value = val;

  late Timer recurringTask;

  resendOtp(OnResendClick onResendClick) async {
    showLoadingDialog();
    try {
      await onResendClick();
      hideDialog();
      startTimer();
    } catch (e) {
      hideDialog();
    }
  }

  startTimer() {
    timerSeconds = 60;
    recurringTask = Timer.periodic(1.seconds, (timer) {
      --timerSeconds;
      if (timerSeconds == 0) {
        timer.cancel();
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    startListening();
    startTimer();
  }

  startListening() {
    SmsRetriever.startListening().then((value) async {
      await SmsRetriever.stopListening();
      otpController.text = getCode(value);
    }).catchError((e) {});
  }

  @override
  void dispose() async {
    try {
      await SmsRetriever.stopListening();
      recurringTask.cancel();
    } finally {
      super.dispose();
    }
  }

  getCode(String? sms) {
    if (sms != null) {
      final intRegex = RegExp(r'\d+', multiLine: true);
      final code = intRegex.allMatches(sms).first.group(0);
      return code;
    }
    return null;
  }

  String otpError = '';

  String get remainingMinutes =>
      (timerSeconds ~/ 60).toString().padLeft(2, "0");

  String get remainingSeconds => (timerSeconds % 60).toString().padLeft(2, "0");
}
