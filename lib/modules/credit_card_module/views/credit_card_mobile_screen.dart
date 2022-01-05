import 'package:bank_sathi/Helpers/Constant.dart';
import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/custom_paints/MyPainter.dart';
import 'package:bank_sathi/modules/credit_card_module/controllers/credit_card_mobile_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/widgets/ButtonState.dart';
import 'package:bank_sathi/widgets/IconedButton.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CreditCardMobileScreen extends GetView<CreditCardMobileController> {
  DashboardController dashController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(overflow: Overflow.visible, children: [
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
            credit_card.tr,
            color: ColorUtils.white,
          ),
          actions: [
            WidgetUtil.getNotificationIcon(),
            WidgetUtil.getSupportIcon()
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                  margin: EdgeInsets.all(1),
                  clipBehavior: Clip.antiAlias,
                  elevation: 2,
                  color: ColorUtils.blackLight,
                  borderOnForeground: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.sp),
                  ),
                  child: LayoutBuilder(builder: (_, cons) {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              'assets/images/new_images/cc_bg.jpg',
                              width: double.infinity,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    offer_credit_card.tr.toUpperCase(),
                                    color: ColorUtils.orange_gr_light,
                                    fontSize: 52.sp,
                                    fontweight: Weight.BOLD,
                                  ),
                                  CustomText(
                                    sell_credit_card.tr,
                                    color: ColorUtils.white,
                                    fontSize: 40.sp,
                                    fontweight: FontWeight.w400,
                                  ).marginOnly(top: 5.sp),
                                  RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: you_earn_upto.tr,
                                          style:
                                              StyleUtils.textStyleNormalPoppins(
                                            color: ColorUtils.white,
                                            weight: FontWeight.w500,
                                            fontSize: 40.sp,
                                          )),
                                      TextSpan(
                                          text: Constant.RUPEE_SIGN + '2500 ',
                                          style: StyleUtils.textStyleNormal(
                                            color: ColorUtils.white,
                                            weight: FontWeight.w500,
                                            fontSize: 40.sp,
                                          )),
                                      TextSpan(
                                          text: per_card.tr,
                                          style:
                                              StyleUtils.textStyleNormalPoppins(
                                            color: ColorUtils.white,
                                            weight: FontWeight.w500,
                                            fontSize: 40.sp,
                                          )),
                                    ]),
                                  ),
                                ]).marginAll(45.sp),
                            Positioned(
                                bottom: 32.sp,
                                left: 45.sp,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/cards/master_card.png',
                                      height: 60.sp,
                                    ),
                                    Image.asset(
                                      'assets/images/cards/maestro.png',
                                      height: 50.sp,
                                    ).marginOnly(left: 15.sp),
                                    Image.asset(
                                      'assets/images/cards/visa.png',
                                      height: 40.sp,
                                    ).marginOnly(left: 15.sp),
                                  ],
                                )),
                            Positioned(
                                bottom: 20.sp,
                                right: 45.sp,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      Constant.RUPEE_SIGN,
                                      fontType: FontType.OPEN_SANS,
                                      customTextStyle: CustomTextStyle.BIG,
                                      color: ColorUtils.white,
                                      fontweight: Weight.BOLD,
                                    ),
                                    CustomText(
                                      ' * * * *',
                                      color: ColorUtils.white,
                                      fontweight: Weight.BOLD,
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ],
                    );
                  })).marginOnly(top: 10.sp),
              SizedBox(
                height: 80.sp,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    hello.tr,
                    color: ColorUtils.orange_gr_light,
                    fontSize: 75.sp,
                    fontweight: Weight.BOLD,
                  ).alignTo(Alignment.topLeft),
                  CustomText(
                    enter_number_to_apply.tr,
                    color: ColorUtils.black_gr_light.withAlpha(210),
                    fontweight: FontWeight.w400,
                    fontSize: 46.sp,
                  ),
                  SizedBox(
                      width: 160.sp,
                      child: Divider(
                        color: ColorUtils.black_gr_light.withAlpha(230),
                        thickness: 4.sp,
                      )).marginOnly(top: 10.sp),
                ],
              ).marginAll(15.sp),
              CustomText(
                vital_credit_card.tr,
                color: ColorUtils.greylight,
                fontSize: 36.sp,
              ).marginOnly(left: 15.sp, top: 30.sp),
              SizedBox(
                height: 80.sp,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => CustomTextField(
                        controller: controller.mobileNoController,
                        hideUnderLine: true,
                        maxLength: 10,
                        textInputAction: TextInputAction.done,
                        verticalMargin: 0,
                        textStyle:
                            StyleUtils.textStyleMediumPoppins(isBold: false),
                        keyboardType: TextInputType.phone,
                        hint: enter_mobile_number.tr,
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
                      )).marginOnly(left: 40.sp, right: 40.sp),
                  Divider(
                    color: ColorUtils.blackLight,
                    thickness: 3.sp,
                  ),
                  Obx(
                    () => Visibility(
                        visible: controller.pageState ==
                            PageStates.PAGE_BUTTON_ERROR,
                        child: CustomText(
                          'Error: ' + controller.err_name,
                          color: ColorUtils.red,
                        ).marginOnly(top: 20.sp, bottom: 10.sp)),
                  ),
                  Obx(() => ProgressButton.icon(
                          radius: 100.sp,
                          progressIndicator: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          iconedButtons: {
                            ButtonState.idle: IconedButton(
                                text: proceed.tr,
                                icon: Icon(Icons.send,
                                    size: 0, color: Colors.white),
                                color: ColorUtils.textColorLight),
                            ButtonState.loading: IconedButton(
                                text: verifying.tr, color: ColorUtils.orange),
                            ButtonState.fail: IconedButton(
                                text: retry.tr,
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
                          textStyle: StyleUtils.textStyleNormalPoppins(
                              color: ColorUtils.white,
                              fontSize: 50.sp,
                              weight: FontWeight.w500),
                          onPressed: () => controller.validateAndLogin(),
                          state: controller.pageState.getMatchingButtonState)
                      .marginOnly(top: 50.sp)),
                ],
              ).marginAll(15.sp)
            ],
          ),
        ).marginAll(35.sp),
      )
    ]));
  }
}
