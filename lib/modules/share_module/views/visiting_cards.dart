import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/share_tab_controller.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class VisitingCards extends GetView<ShareTabController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 486 / 626,
              child: RepaintBoundary(
                  key: controller.globalKey,
                  child: Container(
                    child: Card(
                      margin: EdgeInsets.all(1),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 6,
                      color: '#F2F3F8'.hexToColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.sp),
                      ),
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Stack(
                            children: [
                              Image.asset(
                                  'assets/images/new_images/visiting_card.jpg'),
                              Positioned.fill(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Stack(children: [
                                      CircleAvatar(
                                          radius: constraints.maxHeight * .17,
                                          backgroundColor: ColorUtils.white,
                                          child: Card(
                                            elevation: 1,
                                            color: ColorUtils.white,
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      constraints.maxHeight *
                                                          .17),
                                            ),
                                            child: Obx(() =>
                                                CustomImage.network(
                                                    controller
                                                        .user.profile_photo,
                                                    height:
                                                        constraints.maxHeight *
                                                            .34,
                                                    width:
                                                        constraints.maxHeight *
                                                            .34,
                                                    errorWidget:
                                                        UnconstrainedBox(
                                                      child: SvgPicture.asset(
                                                        'assets/images/new_images/user.svg',
                                                        color: ColorUtils
                                                            .greyshade,
                                                        height: 200.sp,
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                    ),
                                                    fit: BoxFit.fill)),
                                          )),
                                    ])).marginOnly(top: 120.sp),
                                    Row(
                                      children: <Widget>[
                                        Obx(() => CustomText(
                                            controller
                                                .getUserFullName()
                                                .split(" ")
                                                .take(2)
                                                .join(" ")
                                                .toUpperCase(),
                                            fontSize: 55.sp,
                                            color: ColorUtils.textColor,
                                            fontweight: Weight.BOLD,
                                            textAlign: TextAlign.center)),
                                        Obx(() => SvgPicture.asset(
                                              'assets/images/new_images/verify.svg',
                                              height: 20,
                                              width: 20,
                                            )
                                                .marginOnly(
                                                    left: 20.sp,
                                                    top: 20.sp,
                                                    bottom: 20.sp)
                                                .visibility(controller
                                                        .user.user_status ==
                                                    "3"))
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                    ).marginOnly(
                                        left: 20.sp,
                                        right: 20.sp,
                                        top: constraints.maxHeight * .08),
                                    Obx(() => CustomText(
                                        '${advisor_code.tr} - ' +
                                            controller.getUserCode(),
                                        fontSize: 38.sp,
                                        color: ColorUtils.orange,
                                        fontweight: FontWeight.w500,
                                        textAlign: TextAlign.center)),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            width: 70.sp,
                                            height: 70.sp,
                                            child: UnconstrainedBox(
                                                child: SvgPicture.asset(
                                              'assets/images/new_images/mail.svg',
                                              width: 60.sp,
                                              color: ColorUtils.textColor,
                                              fit: BoxFit.scaleDown,
                                            ))),
                                        Container(
                                          constraints: BoxConstraints(
                                              maxWidth: Get.width * .65),
                                          child: Obx(() => CustomText(
                                                controller.user.email,
                                                softWrap: true,
                                                fontweight: FontWeight.w500,
                                                color:
                                                    ColorUtils.textColorLight,
                                                fontSize: 40.sp,
                                              )),
                                        ).paddingOnly(left: 30.sp)
                                      ],
                                    ).marginOnly(
                                        top: 30.sp,
                                        left: constraints.maxWidth * .15,
                                        right: 40.sp),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            width: 70.sp,
                                            height: 70.sp,
                                            child: UnconstrainedBox(
                                                child: SvgPicture.asset(
                                              'assets/images/new_images/call.svg',
                                              width: 60.sp,
                                              color: ColorUtils.textColor,
                                              fit: BoxFit.scaleDown,
                                            ))),
                                        Container(
                                            constraints: BoxConstraints(
                                                maxWidth: Get.width * .8),
                                            child: CustomText(
                                              '+91 ' +
                                                  controller.prefManager
                                                      .getMobile()
                                                      .toString(),
                                              softWrap: true,
                                              fontweight: FontWeight.w500,
                                              color: ColorUtils.textColorLight,
                                              fontSize: 40.sp,
                                            )).paddingOnly(left: 30.sp)
                                      ],
                                    ).marginOnly(
                                        top: 20.sp,
                                        left: constraints.maxWidth * .16,
                                        right: 40.sp),
                                  ],
                                ),
                                top: constraints.maxHeight * .035,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    color: Colors.white,
                  )),
            ).marginOnly(top: 20.sp),
            Container(
              height: 140.sp,
              width: 400.sp,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(75.sp),
                  border:
                      Border.all(color: ColorUtils.textColorLight, width: 1)),
              child: CustomText(
                share_now.tr,
                fontSize: 44.sp,
              ),
            ).marginOnly(top: 100.sp).onClick(controller.shareCard)
          ],
        ).marginSymmetric(horizontal: 40.sp),
      ),
    );
  }
}
