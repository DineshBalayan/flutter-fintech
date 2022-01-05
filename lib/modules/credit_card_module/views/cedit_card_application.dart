import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/custom_paints/MyPainter.dart';
import 'package:bank_sathi/modules/credit_card_module/controllers/credit_card_application_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/widgets/ButtonState.dart';
import 'package:bank_sathi/widgets/IconedButton.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class CreditCardApplication extends GetView<CreditCardApplicationController> {
  DashboardController dashController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: LayoutBuilder(builder: (_, constraintSuper) {
      return Stack(overflow: Overflow.visible, children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          alignment: Alignment.topRight,
        ),
        CustomPaint(
          painter: MyPainter(),
          child: Container(
            width: Get.width,
            height: Get.width * 0.9,
          ),
        ),
        Positioned(
          child: SvgPicture.asset(
            'assets/images/new_images/top_curve.svg',
            width: Get.width - (Get.width * .2),
            color: ColorUtils.black_shadow,
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
              application_details.tr,
              color: ColorUtils.white,
            ),
            actions: [
              WidgetUtil.getNotificationIcon(),
              WidgetUtil.getSupportIcon()
            ],
          ),
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Card(
                        margin: EdgeInsets.all(2),
                        clipBehavior: Clip.antiAlias,
                        elevation: 15,
                        shadowColor: ColorUtils.lightShade,
                        borderOnForeground: false,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36.sp),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            CustomText(
                              personal.tr.toUpperCase(),
                              fontSize: 50.sp,
                              color: ColorUtils.orange_gr_light,
                              fontweight: FontWeight.w600,
                            ),
                            Divider(
                              thickness: 2.sp,
                              color: ColorUtils.greylight.withAlpha(210),
                            ),
                            CustomText(
                              full_name.tr,
                              fontweight: Weight.LIGHT,
                              color: ColorUtils.greylight,
                              fontSize: 36.sp,
                            ).marginOnly(top: 30.sp),
                            Obx(() => CustomText(
                                  controller.nameOnCard.isEmpty
                                      ? name_on_pan.tr
                                      : controller.nameOnCard.toUpperCase(),
                                  fontSize: 44.sp,
                                  color: controller.nameOnCard.isEmpty
                                      ? ColorUtils.greylight
                                      : ColorUtils.textColor,
                                  fontweight: FontWeight.w500,
                                )),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          pan_card_number.tr,
                                          fontweight: Weight.LIGHT,
                                          color: ColorUtils.grey,
                                          fontSize: 33.sp,
                                        ).marginOnly(top: 15.sp),
                                        Obx(() => CustomText(
                                              controller.ispanCard
                                                  ? controller
                                                      .panNumberController.text
                                                  : pan_card_number.tr,
                                              color: controller.ispanCard
                                                  ? ColorUtils.textColor
                                                  : ColorUtils.greylight,
                                              fontSize: 42.sp,
                                              fontweight: FontWeight.w500,
                                            )),
                                      ],
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          residence_pincode.tr,
                                          fontweight: Weight.LIGHT,
                                          color: ColorUtils.grey,
                                          fontSize: 33.sp,
                                        ).marginOnly(top: 15.sp),
                                        Obx(() => CustomText(
                                              controller.pincode.isEmpty
                                                  ? residence_pincode.tr
                                                      .toUpperCase()
                                                  : controller.pincode
                                                      .toUpperCase(),
                                              color: controller.pincode.isEmpty
                                                  ? ColorUtils.greylight
                                                  : ColorUtils.textColor,
                                              fontSize: 42.sp,
                                              fontweight: FontWeight.w500,
                                            )),
                                      ],
                                    ))
                              ],
                            ).marginOnly(top: 40.sp),
                            CustomText(
                              professional.tr.toUpperCase(),
                              fontSize: 50.sp,
                              color: ColorUtils.orange_gr_light,
                              fontweight: FontWeight.w600,
                            ).marginOnly(top: 80.sp),
                            /*Divider(
                              thickness: 2.sp,
                              color: ColorUtils.silver,
                            ),*/
                            CustomText(
                              working_as.tr,
                              fontweight: Weight.LIGHT,
                              color: ColorUtils.grey,
                              fontSize: 33.sp,
                            ).marginOnly(top: 60.sp),
                            Obx(() => CustomText(
                                  controller.isSalaried
                                      ? salaried.tr.toUpperCase()
                                      : non_salaried.tr.toUpperCase(),
                                  color: ColorUtils.textColor,
                                  fontSize: 42.sp,
                                  fontweight: FontWeight.w500,
                                )),
                            CustomText(
                              controller.isSalaried
                                  ? monthly_salary.tr
                                  : latest_itr_amount.tr,
                              fontweight: Weight.LIGHT,
                              color: ColorUtils.grey,
                              fontSize: 33.sp,
                            ).marginOnly(top: 50.sp),
                            Obx(() => CustomText(
                                  controller.earning == 0.0
                                      ? controller.isSalaried
                                          ? monthly_salary.tr.toUpperCase()
                                          : latest_itr_amount.tr.toUpperCase()
                                      : controller.earning.toString(),
                                  color: controller.earning == 0.0
                                      ? ColorUtils.greylight
                                      : ColorUtils.textColor,
                                  fontSize: 42.sp,
                                  fontweight: FontWeight.w500,
                                )),
                            CustomText(
                              company_name.tr,
                              fontweight: Weight.LIGHT,
                              color: ColorUtils.grey,
                              fontSize: 33.sp,
                            ).marginOnly(top: 50.sp),
                            Obx(() => CustomText(
                                  controller.cname.isEmpty
                                      ? company_name.tr.toUpperCase()
                                      : controller.cname,
                                  color: controller.cname.isEmpty
                                      ? ColorUtils.greylight
                                      : ColorUtils.textColor,
                                  fontSize: 42.sp,
                                  fontweight: FontWeight.w500,
                                )),
                            CustomText(
                              office_area_code.tr,
                              fontweight: Weight.LIGHT,
                              color: ColorUtils.grey,
                              fontSize: 33.sp,
                            ).marginOnly(top: 50.sp),
                            Obx(() => CustomText(
                                  controller.opincode.isEmpty
                                      ? office_area_code.tr.toUpperCase()
                                      : controller.opincode.toString(),
                                  color: controller.opincode.isEmpty
                                      ? ColorUtils.greylight
                                      : ColorUtils.textColor,
                                  fontSize: 42.sp,
                                  fontweight: FontWeight.w500,
                                )),
                            SizedBox(
                              height: 30.sp,
                            )
                          ],
                        ).marginAll(50.sp))
                    .marginOnly(top: 30.sp),
                ProgressButton.icon(
                        radius: 100.sp,
                        progressIndicator: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        iconedButtons: {
                          ButtonState.idle: IconedButton(
                              text: get_card_now.tr.toUpperCase(),
                              icon: Icon(
                                Icons.domain_verification_sharp,
                                size: 0,
                                color: ColorUtils.orange_gr_light,
                              ),
                              color: ColorUtils.textColorLight),
                          ButtonState.loading: IconedButton(
                              text: verifying.tr, color: ColorUtils.orange),
                          ButtonState.fail: IconedButton(
                              text: get_card_now.tr,
                              icon: Icon(Icons.domain_verification,
                                  size: 0, color: Colors.white),
                              color: Colors.red.shade300),
                          ButtonState.success: IconedButton(
                              text: success.tr,
                              icon: Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                              color: Colors.green.shade400)
                        },
                        textStyle: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.white,
                            fontSize: 40.sp,
                            weight: FontWeight.w500),
                        onPressed: () => controller.eligibilityApi(),
                        state: controller.pageState.getMatchingButtonState)
                    .marginAll(50.sp),
              ],
            ),
          ).marginAll(35.sp),
        ),
      ]);
    }));
  }
}
