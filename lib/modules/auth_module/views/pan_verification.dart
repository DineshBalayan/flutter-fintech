import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/custom_input_mask.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/auth_module/controllers/panVerificationController.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/widgets/ButtonState.dart';
import 'package:bank_sathi/widgets/IconedButton.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PanVerification extends GetView<PanVerificationController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(overflow: Overflow.visible, children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        alignment: Alignment.topRight,
        child: SafeArea(
            child: SvgPicture.asset(
          'assets/images/new_images/top_curve.svg',
          color: ColorUtils.topCurveColor,
          width: Get.width - (Get.width * .2),
        )),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          title: Obx(() => CustomText(
                pan_verification.tr,
                style: GoogleFonts.mulish(
                    color: ColorUtils.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 48.sp),
                textAlign: TextAlign.center,
              ).visibility(controller.fromKycDetail)),
          leading: Obx(() => SvgPicture.asset(
                'assets/images/ic_back_arrow.svg',
                width: 75.sp,
                fit: BoxFit.scaleDown,
              ).onClick(() {
                Get.back();
              }).visibility(controller.fromKycDetail)),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Hi, ',
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.textColor,
                            weight: FontWeight.w600,
                            fontSize: 65.sp)),
                    TextSpan(
                        text: controller.getUserFullName().toUpperCase(),
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.orange_gr_light,
                            weight: FontWeight.w600,
                            fontSize: 65.sp)),
                    TextSpan(
                        text: pan_verification_msg.tr,
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.grey,
                            weight: FontWeight.w500,
                            fontSize: 38.sp)),
                  ],
                )),
            Obx(() => Container(
                    width: Get.width,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: '#F1F4F9'.hexToColor(),
                        borderRadius: BorderRadius.all(Radius.circular(30.sp))),
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: constraints.maxWidth * .6,
                                child: Obx(() => CustomTextField(
                                          controller:
                                              controller.referralController,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          isRequired: true,
                                          verticalMargin: 0,
                                          hideleftspace: true,
                                          keyboardType: TextInputType.number,
                                  isEnabled: !controller.isRefferalSubmit,
                                          textAlign: TextAlign.center,
                                          hint: have_referral.tr,
                                          textStyle:
                                              StyleUtils.textStyleNormalPoppins(
                                                      fontSize: 50.sp,
                                                      color: !controller
                                                              .isRefferalSubmit
                                                          ? ColorUtils.textColor
                                                          : ColorUtils
                                                              .greyshade,
                                                      weight: FontWeight.w500)
                                                  .copyWith(letterSpacing: 1),
                                          textInputAction: TextInputAction.done,
                                        ))
                                    .marginOnly(
                                        left: 40.sp,
                                        right: 20.sp,
                                        bottom: 40.sp)),
                            Obx(() => Container(
                                    alignment: Alignment.bottomRight,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50.sp)),
                                        border: Border.all(
                                            width: 3.sp,
                                            color: controller.isRefferalSubmit
                                                ? ColorUtils.greyshade
                                                : controller.showCheckIconR
                                                    ? ColorUtils.orange
                                                    : '#22314D'.hexToColor())),
                                    child: CustomText(
                                      controller.isRefferalSubmit
                                          ? successful.tr
                                          : update_now.tr.toUpperCase(),
                                      color: controller.isRefferalSubmit
                                          ? ColorUtils.greyshade
                                          : controller.showCheckIconR
                                              ? ColorUtils.orange
                                              : '#22314D'.hexToColor(),
                                      fontSize: 40.sp,
                                    ).marginOnly(
                                        left: 30.sp,
                                        right: 30.sp,
                                        top: 10.sp,
                                        bottom: 10.sp)))
                                .marginOnly(
                                    left: 10.sp,
                                    right: 30.sp,
                                    top: 10.sp,
                                    bottom: 10.sp)
                                .onClick(() {
                              if (controller.showCheckIconR &&
                                  !controller.isRefferalSubmit)
                                controller.verifyPancard(true);
                              context.hideKeyboard();
                            }),
                          ],
                        );
                      },
                    ))
                .marginOnly(top: 100.sp)
                .visibility(!controller.fromKycDetail)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: ColorUtils.white_dull),
                      bottom:
                          BorderSide(width: 1.0, color: ColorUtils.white_dull),
                    ),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          aadhar_kyc.tr,
                          fontSize: 40.sp,
                        ),
                        Obx(() => controller.user.is_adhar_verified == "1"
                            ? SvgPicture.asset(
                                'assets/images/new_images/check.svg',
                                height: 46.sp,
                              ).marginOnly(left: 30.sp)
                            : Icon(
                                Icons.info_outline,
                                color: ColorUtils.insta_color3,
                                size: 56.sp,
                              ).marginOnly(left: 30.sp)),
                      ],
                    ).marginOnly(
                        top: 30.sp, bottom: 30.sp, left: 50.sp, right: 50.sp),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      top:
                          BorderSide(width: 3.sp, color: ColorUtils.white_dull),
                      bottom:
                          BorderSide(width: 3.sp, color: ColorUtils.white_dull),
                    ),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          pan_kyc.tr,
                          fontSize: 40.sp,
                        ),
                        Obx(() => controller.user.is_pan_verified == "1"
                            ? SvgPicture.asset(
                                'assets/images/new_images/check.svg',
                                height: 46.sp,
                              ).marginOnly(left: 30.sp)
                            : Icon(
                                Icons.info_outline,
                                color: ColorUtils.insta_color3,
                                size: 56.sp,
                              ).marginOnly(left: 30.sp)),
                      ],
                    ).marginOnly(
                        top: 30.sp, bottom: 30.sp, left: 40.sp, right: 40.sp),
                  ),
                ),
              ],
            ).marginOnly(top: 100.sp),
            Stack(
              children: [
                Image.asset('assets/images/cards/pan_bg.png'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      verify_pan.tr.toUpperCase(),
                      color: '#884C5E'.hexToColor(),
                      fontweight: FontWeight.w600,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 53,
                            child: CustomText(
                              'pan number'.toUpperCase(),
                              color: '#7A85AF'.hexToColor(),
                              fontSize: 30.sp,
                            )),
                        Expanded(
                          flex: 47,
                          child: CustomText(
                            'Date of Birth'.toUpperCase(),
                            color: '#7A85AF'.hexToColor(),
                            fontSize: 30.sp,
                          ),
                        )
                      ],
                    ).marginOnly(top: 40.sp),
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Container(
                              height: 120.sp,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  color: '#F4F4F4'.hexToColor()),
                              width: constraints.maxWidth * .47,
                              child: CustomTextField(
                                controller: controller.panNumberController,
                                verticalMargin: 0,
                                hideUnderLine: true,
                                isDense: true,
                                maxLength: 12,
                                inputFormatter: [
                                  CustomTextInputMask(
                                    mask: "AAAAA 9999 A",
                                  )
                                ],
                                suffixIconSize: 60.sp,
                                textAlignVertical: TextAlignVertical.center,
                                suffixIcon: Obx(() => controller.showCheckIconP
                                    ? SvgPicture.asset(
                                        'assets/images/new_images/pancheck.svg',
                                        fit: BoxFit.scaleDown,
                                      ).marginOnly(right: 10.sp)
                                    : Container()),
                                validator: (String value) {
                                  Pattern pattern = "[A-Z]{5}[0-9]{4}[A-Z]{1}";
                                  RegExp regex = new RegExp(pattern.toString());
                                  if (!regex.hasMatch(value.toUpperCase())) {
                                    return correct_pan_msg.tr;
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.done,
                                hint: 'Ex.KHPKU 5487 U',
                                textCapitalization: true,
                                keyboardType: TextInputType.text,
                                textStyle: StyleUtils.textStyleNormalPoppins(
                                    fontSize: 40.sp),
                              ).marginOnly(right: 10.sp),
                            )),
                            Container(
                              width: 30.sp,
                            ),
                            Container(
                              height: 120.sp,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  color: '#F4F4F4'.hexToColor()),
                              width: constraints.maxWidth * .47,
                              child: Row(children: [
                                Expanded(
                                    child: Obx(
                                  () => CustomText(controller.user.dob,
                                      style: StyleUtils.textStyleNormalPoppins(
                                          fontSize: 40.sp)),
                                )),
                                Obx(() => SvgPicture.asset(
                                      'assets/images/new_images/pancheck.svg',
                                      fit: BoxFit.scaleDown,
                                      width: 50.sp,
                                    ).visibility(controller.user.dob != null &&
                                        controller.user.dob
                                            .toString()
                                            .isNotEmpty))
                              ]).marginOnly(right: 20.sp, left: 30.sp),
                            ),
                          ],
                        );
                      },
                    ).marginOnly(top: 10.sp),
                    CustomText(
                      name_on_pan.toUpperCase(),
                      color: '#7A85AF'.hexToColor(),
                      fontSize: 30.sp,
                    ).marginOnly(top: 40.sp),
                    Obx(() => CustomText(
                          controller.getUserFullName(),
                          fontSize: 50.sp,
                        )),
                  ],
                ).marginAll(40.sp)
              ],
            ).marginOnly(top: 100.sp),
            Obx(() => ProgressButton.icon(
                    radius: 200.sp,
                    minWidth: 700.sp,
                    maxWidth: 700.sp,
                    progressIndicator: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    iconedButtons: {
                      ButtonState.idle: IconedButton(
                          text: save_continue.tr,
                          icon: Icon(Icons.arrow_right_alt_sharp,
                              color: ColorUtils.white),
                          color: ColorUtils.orange),
                      ButtonState.loading: IconedButton(
                          text: updating.tr, color: ColorUtils.orange),
                      ButtonState.fail: IconedButton(
                          text: "Failed",
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
                        fontSize: 44.sp,
                        weight: FontWeight.w500),
                    onPressed: () {
                      if (controller.panNumberController.text.isNotEmpty)
                        controller.verifyPancard(false);
                      else
                        Get.snackbar(app_alert.tr, cant_empty_pan.tr,
                            snackPosition: SnackPosition.BOTTOM);
                    },
                    state: controller.pageState.getMatchingButtonState)
                .marginOnly(top: 100.sp).paddingOnly(left: 20.sp,right: 20.sp)),
            Obx(() => CustomText(
                  do_later.tr,
                  fontweight: FontWeight.w400,
                  fontSize: 42.sp,
                )
                    .marginOnly(top: 100.sp)
                    .onClick(() => Get.offAllNamed(Routes.DASHBOARD))
                    .visibility(!controller.fromKycDetail)),
          ],
        ).marginAll(50.sp)),
      ),
      Positioned.fill(
          child: Align(
        child: WidgetUtil.needHelpButton(4, controller: controller)
            .marginAll(40.sp),
        alignment: Alignment.bottomRight,
      ))
    ]));
  }
}
