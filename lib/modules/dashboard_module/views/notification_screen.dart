import 'package:bank_sathi/Helpers/TimeAgo.dart';
import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/notification_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_scaffold.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationScreen extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: notification.tr,
        showNotification: false,
        body: BasePageView(
            controller: controller,
            idleWidget: Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, position) {
                  return Container(
                    margin: EdgeInsets.only(
                        left: 40.sp, right: 40.sp, bottom: 40.sp, top: 10.sp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                      boxShadow: [
                        BoxShadow(
                          color: ColorUtils.grey.withOpacity(0.1),
                          spreadRadius: 30.sp,
                          blurRadius: 30.sp,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Visibility(
                            child: CustomImage.network(
                                controller.notificationList[position].image),
                            visible:
                                controller.notificationList[position].image !=
                                        null &&
                                    controller.notificationList[position].image
                                        .isNotEmpty),
                        Row(
                          children: <Widget>[
                            Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: 0,
                                    color: "#f5f4f9".hexToColor(),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(120.sp)),
                                    child: SizedBox(
                                      height: 70.sp,
                                      width: 70.sp,
                                      child: SvgPicture.asset(
                                        'assets/images/new_images/logoicon.svg',
                                        fit: BoxFit.contain,
                                      ),
                                    ).marginAll(25.sp))
                                .marginOnly(left: 10.sp, right: 10.sp)
                                .visibility(controller
                                            .notificationList[position].image ==
                                        null ||
                                    controller.notificationList[position].image
                                        .isEmpty),
                            //if image is empty added padding to title else removed padding and title close to image
                            (controller.notificationList[position].image ==
                                        null ||
                                    controller.notificationList[position].image
                                        .isEmpty)
                                ? Expanded(
                                    child: CustomText(
                                    controller.notificationList[position].title,
                                    fontType: FontType.OPEN_SANS,
                                    fontweight: Weight.BOLD,
                                  ).marginOnly(right: 42.sp, left: 0.sp))
                                : Expanded(
                                    child: CustomText(
                                    controller.notificationList[position].title,
                                    fontType: FontType.OPEN_SANS,
                                    fontweight: Weight.BOLD,
                                  ).marginOnly(right: 42.sp, left: 30.sp)),
                          ],
                        ).paddingAll(10.sp),
                        Align(
                                alignment: Alignment.topLeft,
                                child: LayoutBuilder(builder: (context, size) {
                                  return Obx(() => Linkify(
                                        text: controller
                                            .notificationList[position].content,
                                        onOpen: (link) async {
                                          if (await canLaunch(link.url)) {
                                            await launch(link.url);
                                          } else {}
                                        },
                                        style:
                                            StyleUtils.textStyleNormalPoppins(
                                                fontSize: 42.sp,
                                                weight: FontWeight.w400,
                                                color: ColorUtils.greyDark),
                                      ));
                                }))
                            .marginOnly(left: 50.sp, right: 30.sp)
                            .visibility(
                                controller.notificationList[position].image ==
                                        null ||
                                    controller.notificationList[position].image
                                        .isEmpty),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Obx(() => Row(
                                    children: [
                                      CustomText(
                                        TimeAgo.isReturningDate(controller
                                                .notificationList[position]
                                                .updated_at)
                                            ? TimeAgo.timeAgoSinceDate(
                                                    controller
                                                        .notificationList[
                                                            position]
                                                        .updated_at)
                                                .split(" ")
                                                .first
                                            : TimeAgo.timeAgoSinceDate(
                                                controller
                                                    .notificationList[position]
                                                    .updated_at),
                                        fontType: FontType.OPEN_SANS,
                                        color: TimeAgo.isReturningDate(
                                                controller
                                                    .notificationList[position]
                                                    .updated_at)
                                            ? ColorUtils.orange
                                            : ColorUtils.textColor,
                                        fontSize: 34.sp,
                                      ),
                                      CustomText(
                                        TimeAgo.isReturningDate(controller
                                                .notificationList[position]
                                                .updated_at)
                                            ? TimeAgo.timeAgoSinceDate(
                                                        controller
                                                            .notificationList[
                                                                position]
                                                            .updated_at)
                                                    .split(" ")[1] +
                                                TimeAgo.timeAgoSinceDate(
                                                        controller
                                                            .notificationList[
                                                                position]
                                                            .updated_at)
                                                    .split(" ")[2]
                                            : "",
                                        fontType: FontType.OPEN_SANS,
                                        fontSize: 34.sp,
                                      ).marginOnly(left: 10.sp)
                                    ],
                                  )),
                            ).marginOnly(top: 15.sp),
                            Spacer(),
                          ],
                        ).marginOnly(left: 50.sp, right: 30.sp, bottom: 30.sp),
                      ],
                    ),
                  ).onClick(() {
                    Get.find<DashboardController>().handleNotifications(null,
                        screen: GetUtils.isURL(
                                controller.notificationList[position].link)
                            ? null
                            : controller.notificationList[position].link,
                        link: controller.notificationList[position].link);
                  });
                },
                itemCount: controller.notificationList.length,
              ),
            )));
  }
}
