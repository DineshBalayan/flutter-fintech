import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/modules/adviser_detail_module/controllers/kyc_controller.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_scaffold.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class KYCDetails extends GetView<KYCController> {
  Widget getContainer(String string) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.sp),
          border: Border.all(color: ColorUtils.orange, width: 1)),
      child: CustomText(
        string,
        color: ColorUtils.orange,
        fontSize: 28.sp,
      ).paddingSymmetric(horizontal: 20.sp, vertical: 10.sp),
    ).marginOnly(top: 20.sp);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: kyc.tr,
      showAppIcon: true,
      floatingActionButton: WidgetUtil.needHelpButton(3),
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.sp, vertical: 10.sp),
              child: Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText("Aadhar ID Number"),
                      Obx(() => controller.user.is_adhar_verified == "0"
                          ? getContainer("Verify Now").onClick(() {
                              Get.toNamed(Routes.LOGIN +
                                  Routes.AADHAR_VERIFICATION +
                                  "?from_kyc_detail=yes");
                            })
                          : SvgPicture.asset(
                              'assets/images/new_images/profile_image/check.svg',
                              height: 60.sp,
                            ))
                    ],
                  ).marginOnly(top: 10.sp, left: 20.sp, right: 20.sp),
                  Stack(
                    children: [
                      Image.asset('assets/images/cards/aadhar_bg_kyc.png'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                color: ColorUtils.white),
                            child: Obx(() => CustomTextField(
                                  controller: controller.aadharNumberController,
                                  verticalMargin: 0,
                                  hideUnderLine: true,
                                  isEnabled: false,
                                  maxLength: 12,
                                  isRequired: true,
                                  suffixIconSize: controller.showCheckIconAadhar
                                      ? 50.sp
                                      : 0,
                                  suffixIcon: SvgPicture.asset(
                                    'assets/images/ic_check.svg',
                                    fit: BoxFit.scaleDown,
                                  ),
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.number,
                                  textStyle: StyleUtils.textStyleNormalPoppins(
                                          fontSize: 60.sp)
                                      .copyWith(letterSpacing: 2),
                                ).marginOnly(right: 40.sp)),
                          ).marginOnly(top: 130.sp),
                          CustomText(
                            'full name'.toUpperCase(),
                            color: '#9BBCAB'.hexToColor(),
                            fontSize: 30.sp,
                          ).marginOnly(top: 25.sp),
                          Obx(() => Container(
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: CustomText(
                                controller.getUserFullName().toUpperCase(),
                                fontSize: 40.sp,
                                maxLines: 1,
                              ).marginOnly(
                                left: 15.sp,
                                right: 15.sp,
                              )).marginOnly(top: 10.sp)),
                          CustomText(
                            'permanent address'.toUpperCase(),
                            color: '#9BBCAB'.hexToColor(),
                            fontSize: 30.sp,
                          ).marginOnly(top: 25.sp),
                          Obx(() => Container(
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: CustomText(
                                controller.user.full_address,
                                maxLines: 2,
                                fontSize: 38.sp,
                              ).marginOnly(
                                left: 15.sp,
                                right: 15.sp,
                              )).marginOnly(top: 1.sp)),
                        ],
                      ).marginAll(40.sp)
                    ],
                  ).marginOnly(top: 50.sp).onClick(() {
                    if (controller.user.is_adhar_verified == "0") {
                      Get.toNamed(Routes.LOGIN +
                          Routes.AADHAR_VERIFICATION +
                          "?from_kyc_detail=yes");
                    }
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText("PAN"),
                      Obx(() => controller.user.is_pan_verified == "0"
                          ? getContainer("Verify Now").onClick(() {
                              Get.toNamed(Routes.LOGIN +
                                  Routes.PAN_VERIFICATION +
                                  "?from_kyc_detail=yes");
                            })
                          : SvgPicture.asset(
                              'assets/images/new_images/profile_image/check.svg',
                              height: 60.sp,
                            ))
                    ],
                  ).marginOnly(top: 50.sp, left: 20.sp, right: 20.sp),
                  Stack(
                    children: [
                      Image.asset('assets/images/cards/pan_bg.png'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            'Verify pan Details'.toUpperCase(),
                            color: '#884C5E'.hexToColor(),
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
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Container(
                                    height: 140.sp,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                        color: '#F4F4F4'.hexToColor()),
                                    width: constraints.maxWidth * .47,
                                    child: Obx(() => CustomTextField(
                                          controller: controller.panController,
                                          verticalMargin: 0,
                                          isEnabled: false,
                                          hideUnderLine: true,
                                          maxLength: 12,
                                          isDense: true,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          inputFormatter: [
                                            MaskTextInputFormatter(
                                                mask: "AAAAA #### A")
                                          ],
                                          suffixIconSize:
                                              controller.showCheckIconPan
                                                  ? 50.sp
                                                  : 0,
                                          suffixIcon: Obx(() {
                                            return controller
                                                        .user.is_pan_verified ==
                                                    "1"
                                                ? SvgPicture.asset(
                                                    'assets/images/new_images/pancheck.svg',
                                                    width: 50.sp,
                                                  )
                                                : Container();
                                          }),
                                          validator: (String value) {
                                            Pattern pattern =
                                                "[A-Z]{5}[0-9]{4}[A-Z]{1}";
                                            RegExp regex =
                                                new RegExp(pattern.toString());
                                            if (!regex.hasMatch(
                                                value.toUpperCase())) {
                                              return correct_pan_msg.tr;
                                            }
                                            return null;
                                          },
                                          textInputAction: TextInputAction.done,
                                          hint: 'Ex. KHPKU 5487 U',
                                          textCapitalization: true,
                                          keyboardType: TextInputType.text,
                                          textStyle:
                                              StyleUtils.textStyleNormalPoppins(
                                                  fontSize: 40.sp),
                                        )).marginOnly(right: 10.sp),
                                  )),
                                  Container(
                                    width: 30.sp,
                                  ),
                                  Container(
                                    height: 140.sp,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                        color: '#F4F4F4'.hexToColor()),
                                    width: constraints.maxWidth * .47,
                                    child: Row(children: [
                                      Expanded(
                                          child: Obx(() => CustomText(
                                              controller.user.dob
                                                  .toString()
                                                  .toDDMMYYYY(),
                                              style: StyleUtils
                                                  .textStyleNormalPoppins(
                                                      fontSize: 40.sp)))),
                                      Obx(() {
                                        return controller
                                                    .user.is_pan_verified ==
                                                "1"
                                            ? SvgPicture.asset(
                                                'assets/images/new_images/pancheck.svg',
                                                width: 50.sp,
                                              )
                                            : Container();
                                      })
                                    ]).marginOnly(right: 10.sp, left: 30.sp),
                                  ),
                                ],
                              );
                            },
                          ).marginOnly(top: 10.sp),
                          CustomText(
                            'Name As on PAN CARD'.toUpperCase(),
                            color: '#7A85AF'.hexToColor(),
                            fontSize: 30.sp,
                          ).marginOnly(top: 40.sp),
                          Obx(() => CustomText(
                                controller.getUserFullName().toUpperCase(),
                                fontSize: 50.sp,
                              )),
                        ],
                      ).marginAll(30.sp)
                    ],
                  )
                      .marginOnly(
                    top: 50.sp,
                  )
                      .onClick(() {
                    if (controller.user.is_pan_verified == "0") {
                      Get.toNamed(Routes.LOGIN +
                          Routes.PAN_VERIFICATION +
                          "?from_kyc_detail=yes");
                    }
                  }),
                ],
              )))),
    );
  }
}
