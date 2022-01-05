import 'dart:convert';

import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/auth_module/controllers/aadhar_verification_controller.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/widgets/ButtonState.dart';
import 'package:bank_sathi/widgets/IconedButton.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AadharVerification extends GetView<AAdharVerificationController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(clipBehavior: Clip.hardEdge, children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorUtils.window_bg,
        alignment: Alignment.topRight,
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Form(
              key: controller.globalKey_aadhar,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        child: Image.asset(
                          'assets/images/new_images/aadhar_background.png',
                          width: Get.width,
                          fit: BoxFit.fill,
                        ),
                        top: 0,
                        right: 0,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Obx(() => SvgPicture.asset(
                                    'assets/images/ic_back_arrow.svg',
                                    width: 60.sp,
                                    fit: BoxFit.scaleDown,
                                    color: Colors.white,
                                  )
                                      .visibility(controller.fromKycDetail)
                                      .alignTo(Alignment.centerLeft)
                                      .marginOnly(
                                          left: 40.sp,
                                          top: 40.sp,
                                          right: 40.sp)).onClick(() {
                                Get.back();
                              }),
                            ],
                          ),
                          Obx(() => SizedBox(
                                height:
                                    controller.fromKycDetail ? 40.sp : 90.sp,
                              )),
                          CustomText(
                            kyc_verification.tr,
                            color: '#E2E8F6'.hexToColor(),
                            fontweight: FontWeight.w500,
                            fontSize: 52.sp,
                          ).alignTo(Alignment.topLeft).marginOnly(left: 60.sp),
                          SizedBox(
                                  width: 160.sp,
                                  child: Divider(
                                    color: ColorUtils.orange_gr_light
                                        .withAlpha(230),
                                    thickness: 5.sp,
                                  ))
                              .alignTo(Alignment.topLeft)
                              .marginOnly(left: 60.sp),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Image.asset(
                                      'assets/images/cards/aadhar_bg.png'),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: ColorUtils.white,
                                            border: Border.all(
                                                width: 3.sp,
                                                color: '#FFF6DD'.hexToColor())),
                                        child: Obx(() => CustomTextField(
                                              controller: controller
                                                  .adharNumberController,
                                              verticalMargin: 0,
                                              hideUnderLine: true,
                                              isRequired: true,
                                              autoFocus: true,
                                              maxLength: 14,
                                              inputFormatter: [
                                                MaskTextInputFormatter(
                                                    mask: "#### #### ####")
                                              ],
                                              suffixIconSize:
                                                  controller.showCheckIconA
                                                      ? 50.sp
                                                      : 0,
                                              suffixIcon: SvgPicture.asset(
                                                'assets/images/ic_check.svg',
                                                fit: BoxFit.scaleDown,
                                              ),
                                              textInputAction:
                                                  TextInputAction.done,
                                              hint: enter_aadhar.tr,
                                              keyboardType:
                                                  TextInputType.number,
                                              textStyle: StyleUtils
                                                      .textStyleNormalPoppins(
                                                          fontSize: 55.sp)
                                                  .copyWith(letterSpacing: 2),
                                            ).marginOnly(right: 20.sp)),
                                      ).marginOnly(top: 140.sp),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Obx(() => Container(
                                              width: Get.width * .45,
                                              alignment: Alignment.topLeft,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp),
                                                  color:
                                                      '#DCF7E6'.hexToColor()),
                                              child: CustomText(
                                                controller.name,
                                                fontSize: 40.sp,
                                                maxLines: 1,
                                              ).marginOnly(
                                                left: 15.sp,
                                                right: 15.sp,
                                              ))),
                                          Obx(() => Container(
                                              width: Get.width * .35,
                                              alignment: Alignment.topLeft,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp),
                                                  color:
                                                      '#DCF7E6'.hexToColor()),
                                              child: CustomText(
                                                controller.address,
                                                maxLines: 1,
                                                fontSize: 40.sp,
                                              ).marginOnly(
                                                left: 15.sp,
                                                right: 15.sp,
                                              ))),
                                        ],
                                      ).marginOnly(top: 70.sp)
                                    ],
                                  ).marginAll(40.sp)
                                ],
                              ).marginOnly(
                                  top: 40.sp, left: 50.sp, right: 50.sp),

                              Obx(() => ProgressButton.icon(
                                      radius: 200.sp,
                                      progressIndicator:
                                          CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                      iconedButtons: {
                                        ButtonState.idle: IconedButton(
                                            text: verify_now.tr,
                                            icon: Icon(
                                              Icons.arrow_right_alt_sharp,
                                              color: ColorUtils.white,
                                              size: 0,
                                            ),
                                            color: ColorUtils.orange),
                                        ButtonState.loading: IconedButton(
                                            text: updating.tr,
                                            color: ColorUtils.orange),
                                        ButtonState.fail: IconedButton(
                                            text: verify_now.tr,
                                            icon: Icon(Icons.cancel,
                                                color: Colors.white, size: 0),
                                            color: '#E2E0E1'.hexToColor()),
                                        ButtonState.success: IconedButton(
                                            text: success.tr,
                                            icon: Icon(
                                              Icons.check_circle,
                                              color: Colors.white,
                                            ),
                                            color: Colors.green.shade400)
                                      },
                                      textStyle:
                                          StyleUtils.textStyleMediumPoppins(
                                              color: ColorUtils.white,
                                              fontSize: 48.sp,
                                              weight: FontWeight.w500),
                                      onPressed: () =>
                                          controller.aadharValidation(),
                                      state: controller
                                          .pageState.getMatchingButtonState)
                                  .marginOnly(top: 50.sp)),
                              Obx(() => CustomText(
                                    do_later.tr,
                                    color: '#33363D'.hexToColor(),
                                    fontweight: FontWeight.w500,
                                    fontSize: 42.sp,
                                  )
                                      .marginOnly(top: 90.sp)
                                      .onClick(() => controller.pageState !=
                                              PageStates.PAGE_BUTTON_LOADING
                                          ? Get.toNamed(
                                              Routes.LOGIN + Routes.REGISTER)
                                          : {})
                                      .visibility(!controller.fromKycDetail)),
                            ],
                          ).marginOnly(top: 100.sp),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )),
      Positioned.fill(
          child: Align(
        child: WidgetUtil.needHelpButton(5, controller: controller)
            .marginAll(40.sp),
        alignment: Alignment.bottomRight,
      ))
    ]));
  }
}
