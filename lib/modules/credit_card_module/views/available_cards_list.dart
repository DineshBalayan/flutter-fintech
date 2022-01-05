import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/response/credit_card_list.dart';
import 'package:bank_sathi/custom_paints/MyPainter.dart';
import 'package:bank_sathi/modules/credit_card_module/controllers/available_cards_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AvailableCardsList extends GetView<AvailableCardsController> {
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
            color: ColorUtils.black_shadow,
            width: Get.width - (Get.width * .2),
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
              'assets/images/new_images/back.svg',
              width: 60.sp,
              height: 60.sp,
              color: ColorUtils.white,
            )).onClick(() => Get.back()),
            title: CustomText(
              select_a_card.tr,
              color: ColorUtils.white,
            ),
            actions: [
              WidgetUtil.getNotificationIcon(),
              WidgetUtil.getSupportIcon()
            ],
          ),
          body: Obx(() =>
              controller.cardsList == null || controller.cardsList.length == 0
                  ? emptyWidget()
                  : Obx(() => ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.cardsList == null
                          ? 0
                          : controller.cardsList.length,
                      itemBuilder: (context, position) {
                        return CardWidget(controller.cardsList[position]);
                      }))).marginOnly(left: 15.sp, right: 15.sp, top: 60.sp),
        )
      ]);
    }));
  }

  Widget CardWidget(BankCardDetail card) {
    return Card(
      margin: EdgeInsets.all(20.sp),
      elevation: 30.sp,
      shadowColor: ColorUtils.lightShade,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.sp))),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150.sp,
                width: 150.sp,
                child: Card(
                  margin: EdgeInsets.zero,
                  shadowColor: ColorUtils.lightShade,
                  color: ColorUtils.white_bg,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.sp))),
                  elevation: 3.sp,
                  clipBehavior: Clip.antiAlias,
                  child: CustomImage.network('jhds',
                      height: 150.sp,
                      width: 150.sp,
                      errorWidget: UnconstrainedBox(
                        child: SvgPicture.asset(
                          'assets/images/pic_credit_card.svg',
                          height: 150.sp,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      fit: BoxFit.fill),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    card.card_name.toString().toUpperCase(),
                    fontSize: 48.sp,
                    fontweight: FontWeight.w600,
                    color: ColorUtils.black,
                  ),
                  CustomText(
                    card.bank_name,
                    fontSize: 42.sp,
                    color: ColorUtils.orange_gr_light,
                  ),
                ],
              ).marginOnly(left: 40.sp),
            ],
          ),
          Row(children: [
            Expanded(
                flex: 6,
                child: CustomText(
                  card.rewards_point_details,
                  fontSize: 36.sp,
                  color: ColorUtils.greytext,
                ).marginOnly(top: 40.sp)),
            Expanded(
              flex: 4,
              child: Card(
                shadowColor: ColorUtils.greyshade,
                color: ColorUtils.black_gr_dark,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(60.sp))),
                elevation: 3.sp,
                clipBehavior: Clip.antiAlias,
                child: CustomText(
                  'Get This Card',
                  fontSize: 36.sp,
                  color: ColorUtils.white_dull,
                  textAlign: TextAlign.center,
                ).marginOnly(
                    top: 20.sp, bottom: 20.sp, left: 30.sp, right: 60.sp),
              ).marginOnly(top: 0.sp),
            )
          ])
        ],
      ).marginAll(30.sp).onClick(() {
        controller.submitCard(card.id);
      }),
    );
  }

  Widget emptyWidget() {
    return Align(
      alignment: Alignment.topCenter,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.w),
          ),
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                no_card_available.tr,
                textAlign: TextAlign.center,
                color: ColorUtils.black,
                fontweight: Weight.LIGHT,
                customTextStyle: CustomTextStyle.MEDIUM,
              ).marginSymmetric(vertical: 20),
              TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90.w),
                      )),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 40.sp)),
                      backgroundColor:
                          MaterialStateProperty.all(ColorUtils.orange),
                      fixedSize:
                          MaterialStateProperty.all(Size.fromHeight(80.sp))),
                  onPressed: () {
                    Get.offNamedUntil(Routes.DASHBOARD + Routes.MY_LEADS,
                        (route) => route.settings.name == Routes.DASHBOARD);
                  },
                  child: CustomText(
                    got_to_leads.tr,
                    color: ColorUtils.white,
                    fontweight: Weight.LIGHT,
                  )).marginOnly(left: 15.sp, right: 15.sp)
            ],
          ).marginAll(20)),
    );
  }
}
