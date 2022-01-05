import 'dart:async';

import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerifyWidget extends StatefulWidget {
  const OtpVerifyWidget(
      {Key? key,
      required this.mobile_no,
      required this.onverifyclick,
      required this.onresendclick})
      : super(key: key);

  final String mobile_no;
  final onverifyclick;
  final onresendclick;

  @override
  _OtpVerifyWidgetState createState() => _OtpVerifyWidgetState();
}

class _OtpVerifyWidgetState extends State<OtpVerifyWidget> {
  TextEditingController otpController = TextEditingController();
  var _timerSeconds = 60;
  var remainingMinutes = '';
  var remainingSeconds = '';

  Timer? _recurringTask;

  _OtpVerifyWidgetState() {
    _recurringTask = Timer.periodic(1.seconds, (timer) {
      setState(() {
        --_timerSeconds;
        remainingMinutes = (_timerSeconds ~/ 60).toString().padLeft(2, "0");
        remainingSeconds = (_timerSeconds % 60).toString().padLeft(2, "0");
        if (_timerSeconds == 0) {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _recurringTask!.cancel();
    otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          text: widget.mobile_no + '\n',
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
            textStyle: StyleUtils.textStyleNormal(
                fontSize: 60.sp, weight: FontWeight.w400),
            onCompleted: (pin) {},
            keyboardType: TextInputType.number,
          ).marginOnly(left: 200.sp, right: 200.sp, top: 40.sp, bottom: 30.sp),
          SizedBox(
            height: 60.sp,
          ),
          SizedBox(
              width: Get.width * 0.6,
              child: WidgetUtil.getOrangeButton(() {},
                  label: verify_now.tr.toUpperCase())),
          Obx(() => Center(
                child: _timerSeconds > 0
                    ? CustomText(
                        "${resend_code.tr} $remainingMinutes:$remainingSeconds",
                        fontSize: 48.sp,
                        color: ColorUtils.blue,
                        textAlign: TextAlign.center,
                      )
                    : RaisedButton(
                        elevation: 0,
                        onPressed: () => widget.onresendclick(),
                        color: Colors.transparent,
                        child: CustomText(resend_code.tr,
                            color: ColorUtils.orange),
                      ),
              )).marginAll(50.sp),
        ],
      ).marginAll(50.sp),
    );
  }
}
