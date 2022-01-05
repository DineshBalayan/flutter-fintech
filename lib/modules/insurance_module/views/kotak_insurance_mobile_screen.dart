import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/data_helper.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/modules/insurance_module/controllers/kotak_insurance_mobile_controller.dart';
import 'package:bank_sathi/widgets/ButtonState.dart';
import 'package:bank_sathi/widgets/IconedButton.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class KotakMobileScreen extends GetView<KotakInsuranceMobileController> {
  DashboardController dashController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(overflow: Overflow.visible, children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorUtils.window_bg,
        alignment: Alignment.topRight,
      ),
      Positioned(
        child: SvgPicture.asset(
          'assets/images/new_images/topcurve_insurance.svg',
          width: Get.width,
          fit: BoxFit.fitWidth,
        ),
        top: 0,
        right: 0,
      ),
      Positioned(
        child: SvgPicture.asset(
          'assets/images/new_images/top_curve.svg',
          width: Get.width - (Get.width * .2),
          color: '#42454E'.hexToColor(),
        ),
        top: 0,
        right: 0,
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            titleSpacing: 0,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: UnconstrainedBox(
                child: SvgPicture.asset(
              'assets/images/ic_back_arrow.svg',
              width: 60.sp,
              height: 60.sp,
              color: ColorUtils.white,
            )).onClick(() => Get.back()),
            title: CustomText(
              insurance.tr,
              color: ColorUtils.white,
            ),
            actions: [WidgetUtil.getSupportIcon()],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/new_images/insurance/insurance_banner.png',
                  width: Get.width * .6,
                ),
                SizedBox(
                  height: 70.sp,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      sell_kotak_insurance.tr.toUpperCase(),
                      fontSize: 50.sp,
                      fontweight: Weight.BOLD,
                    ),
                    CustomText(
                      earn_kotak_insurance.tr,
                      color: ColorUtils.greylight,
                      fontSize: 36.sp,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.sp,
                ),
                Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.sp)),
                          boxShadow: [
                            BoxShadow(
                              color: ColorUtils.greyshade.withOpacity(0.08),
                              spreadRadius: 30.sp,
                              blurRadius: 70.sp,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(() => CustomTextField(
                                  controller: controller.mobileNoController,
                                  hideUnderLine: true,
                                  maxLength: 10,
                                  textInputAction: TextInputAction.done,
                                  verticalMargin: 0,
                                  textStyle: StyleUtils.textStyleMediumPoppins(
                                      isBold: false),
                                  keyboardType: TextInputType.phone,
                                  hint: enter_customer_mobile.tr,
                                  suffixIconSize: 70.sp,
                                  prefixIcon: Center(
                                    child: CustomText(
                                      "+91  ",
                                      style: StyleUtils.textStyleMediumPoppins(
                                          isBold: false),
                                    ),
                                  ),
                                  suffixIcon: controller.showCheckIcon
                                      ? SvgPicture.asset(
                                          'assets/images/ic_check.svg',
                                          fit: BoxFit.scaleDown,
                                        )
                                      : SvgPicture.asset(
                                          'assets/images/new_images/contact_book.svg',
                                          fit: BoxFit.scaleDown,
                                        ).onClick(controller.pickContact),
                                )).marginOnly(left: 10.sp, right: 10.sp),
                            Divider(
                              color: ColorUtils.grey,
                              thickness: 3.sp,
                            ),
                            Obx(
                              () => Visibility(
                                  visible: controller.pageState ==
                                      PageStates.PAGE_BUTTON_ERROR,
                                  child: CustomText(
                                    'Error: ' + controller.err_name,
                                    color: ColorUtils.red,
                                  ).marginOnly(
                                    top: 30.sp,
                                  )),
                            ),
                            Obx(() => ProgressButton.icon(
                                    radius: 100.sp,
                                    height: 120.sp,
                                    progressIndicator:
                                        CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                    iconedButtons: {
                                      ButtonState.idle: IconedButton(
                                          text: proceed.tr,
                                          icon: Icon(Icons.send,
                                              size: 0, color: Colors.white),
                                          color: ColorUtils.black),
                                      ButtonState.loading: IconedButton(
                                          text: verifying.tr,
                                          color: ColorUtils.orange),
                                      ButtonState.fail: IconedButton(
                                          text: retry.tr,
                                          icon: Icon(Icons.cancel,
                                              color: Colors.white),
                                          color: Colors.red.shade300),
                                      ButtonState.success: IconedButton(
                                          text: success.tr,
                                          icon: Icon(
                                            Icons.check_circle,
                                            color: Colors.white,
                                          ),
                                          color: Colors.green.shade400)
                                    },
                                    textStyle:
                                        StyleUtils.textStyleNormalPoppins(
                                            color: ColorUtils.white,
                                            fontSize: 50.sp,
                                            weight: FontWeight.w500),
                                    onPressed: () =>
                                        controller.validateAndLogin(),
                                    state: controller
                                        .pageState.getMatchingButtonState)
                                .marginOnly(top: 40.sp)),
                          ],
                        ).marginOnly(
                            top: 50.sp,
                            bottom: 60.sp,
                            left: 50.sp,
                            right: 50.sp))
                    .marginOnly(top: 30.sp),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Divider(
                      color: ColorUtils.greylight.withAlpha(150),
                      thickness: 2.sp,
                      endIndent: 8,
                    )),
                    CustomText(
                      benefits_of_policy.tr,
                      color: ColorUtils.greytext,
                    ),
                    Expanded(
                        child: Divider(
                      color: ColorUtils.greylight.withAlpha(150),
                      thickness: 2.sp,
                      indent: 8,
                    )),
                  ],
                ).marginOnly(top: 60.sp),
                GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30.sp,
                    mainAxisSpacing: 40.sp,
                    childAspectRatio: 2.5,
                    shrinkWrap: true,
                    children: List.generate(
                      getKIFeatures().length,
                      (index) {
                        return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.sp)),
                              border: Border.all(
                                  color: ColorUtils.greylight.withAlpha(150),
                                  width: 1.sp),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    height: 140.sp,
                                    width: 140.sp,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(30.sp),
                                      color: "#f7691d".hexToColor(),
                                    ),
                                    child: UnconstrainedBox(
                                      child: SvgPicture.asset(
                                          getKIFeatures()[index].picAsset,
                                          height: 70.sp,
                                          fit: BoxFit.contain,
                                          color: ColorUtils.white),
                                    )),
                                Expanded(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      getKIFeatures()[index].title,
                                      color: ColorUtils.blackLight,
                                      fontSize: 38.sp,
                                    ),
                                    CustomText(
                                      getKIFeatures()[index].variant,
                                      color: ColorUtils.grey,
                                      fontSize: 36.sp,
                                    ),
                                  ],
                                ).marginOnly(left: 30.sp)),
                              ],
                            ).marginAll(20.sp));
                      },
                    )).marginOnly(top: 60.sp),
              ],
            ).marginAll(35.sp),
          ))
    ]));
  }
}
