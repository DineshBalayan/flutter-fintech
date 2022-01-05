import 'package:avatar_glow/avatar_glow.dart';
import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/controllers/my_lead_detail_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_scaffold.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class MyLeadDetail extends GetView<MyLeadDetailsController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showAppIcon: true,
      title: lead_details.tr,
      body: BasePageView(
          controller: controller,
          idleWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              leadDetailWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Get.width * .45,
                    child: Column(
                      children: [
                        CustomText(
                          lead_status.tr,
                          textAlign: TextAlign.left,
                          color: '#4c4058'.hexToColor(),
                          fontSize: 44.sp,
                        ),
                        Divider(
                          thickness: 5.sp,
                          color: ColorUtils.orange_deep,
                        ).marginOnly(top: 10.sp)
                      ],
                    ),
                  ).marginOnly(left: 40.sp, top: 30.sp),
                  SvgPicture.asset(
                    'assets/images/new_images/profile_image/information.svg',
                    height: 60.sp,
                  ).marginOnly(right: 50.sp).onClick(() {
                    Get.find<DashboardController>().showSectionInfoById(1);
                  })
                ],
              ),
              Obx(() => Expanded(
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                              controller: controller.scrollController,
                              shrinkWrap: true,
                              itemCount: controller.journeylist.length + 1,
                              itemBuilder: (context, position) {
                                return position == controller.journeylist.length
                                    ? SizedBox(height: 50.sp)
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: ColorUtils.white,
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(40))),
                                              width: 180.sp,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 2, 10, 2),
                                                child: CustomText(
                                                  controller
                                                              .journeylist[
                                                                  position]
                                                              .updated_at ==
                                                          null
                                                      ? ""
                                                      : controller
                                                          .journeylist[position]
                                                          .updated_at
                                                          .toString()
                                                          .toDDMM(),
                                                  color: ColorUtils.textColor,
                                                  fontSize: 30.sp,
                                                ).alignTo(Alignment.center),
                                              )),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SizedBox(
                                                  height: position ==
                                                          controller.journeylist
                                                                  .length -
                                                              1
                                                      ? 0
                                                      : 20.sp,
                                                  child: VerticalDivider(
                                                    color: position == 0
                                                        ? ColorUtils.white
                                                        : Colors.grey.shade300,
                                                    width: 20.sp,
                                                    thickness: 1,
                                                  )),
                                              (position ==
                                                      controller.journeylist
                                                              .length -
                                                          1
                                                  ? Transform.translate(
                                                      offset: Offset(-30.sp, 0),
                                                      child: AvatarGlow(
                                                          glowColor:
                                                              ColorUtils.orange,
                                                          endRadius: 40.sp,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  2000),
                                                          repeat: true,
                                                          showTwoGlows: true,
                                                          repeatPauseDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      100),
                                                          child: Container(
                                                              width: 20.sp,
                                                              height: 20.sp,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    ColorUtils
                                                                        .orange,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            60.sp)),
                                                              ))))
                                                  : Container(
                                                      width: 20.sp,
                                                      height: 20.sp,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            ColorUtils.orange,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    60.sp)),
                                                      ))),
                                              Container(
                                                width: 1,
                                                height: 150.sp,
                                                color: position ==
                                                        controller.journeylist
                                                                .length -
                                                            1
                                                    ? ColorUtils.white
                                                    : Colors.grey.shade300,
                                              )
                                            ],
                                          ).marginOnly(
                                              left: 60.sp,
                                              right: position ==
                                                      controller.journeylist
                                                              .length -
                                                          1
                                                  ? 0.sp
                                                  : 60.sp),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                    controller
                                                                .journeylist[
                                                                    position]
                                                                .lead_status_title !=
                                                            null
                                                        ? controller
                                                            .journeylist[
                                                                position]
                                                            .lead_status_title
                                                            .toString()
                                                        : ' ',
                                                    color: position ==
                                                            controller
                                                                    .journeylist
                                                                    .length -
                                                                1
                                                        ? ColorUtils.orange
                                                        : null,
                                                    fontSize: 40.sp),
                                                CustomText(
                                                  controller
                                                              .journeylist[
                                                                  position]
                                                              .updated_at !=
                                                          null
                                                      ? '-' +
                                                          controller
                                                              .journeylist[
                                                                  position]
                                                              .updated_at
                                                              .toString()
                                                              .toTime()
                                                      : '',
                                                  color: ColorUtils.grey,
                                                  fontSize: 33.sp,
                                                  fontweight: Weight.LIGHT,
                                                ),
                                                Container(
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                         decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.sp),
                                                          color: "#FDF3ED"
                                                              .hexToColor(),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Visibility(
                                                              child: CustomText(
                                                                controller
                                                                            .journeylist[
                                                                                position]
                                                                            .lead_sub_status !=
                                                                        null
                                                                    ? controller
                                                                        .journeylist[
                                                                            position]
                                                                        .lead_sub_status
                                                                        .toString()
                                                                    : '',
                                                                color: ColorUtils
                                                                    .blackLight,
                                                                fontSize: 33.sp,
                                                              ),
                                                              visible: controller
                                                                      .journeylist[
                                                                          position]
                                                                      .lead_sub_status !=
                                                                  null,
                                                            ),
                                                            Visibility(
                                                              child: CustomText(
                                                                controller
                                                                            .journeylist[
                                                                                position]
                                                                            .lead_sub_remark !=
                                                                        null
                                                                    ? controller
                                                                        .journeylist[
                                                                            position]
                                                                        .lead_sub_remark
                                                                        .toString()
                                                                    : '',
                                                                color: ColorUtils
                                                                    .greyshade,
                                                                fontSize: 33.sp,
                                                                maxLines: 3,
                                                                fontweight:
                                                                    Weight
                                                                        .LIGHT,
                                                              ),
                                                              visible: controller
                                                                      .journeylist[
                                                                          position]
                                                                      .lead_sub_remark !=
                                                                  null,
                                                            ),
                                                          ],
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                        ).marginAll(20.sp).paddingOnly(left:20.sp,right: 20.sp,bottom: 10.sp,top: 10.sp))
                                                    .marginOnly(top: 25.sp)
                                                    .visibility(position ==
                                                        controller.journeylist
                                                                .length -
                                                            1)
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                              })
                          .marginOnly(left: 40.sp, right: 40.sp, top: 20.sp)))),
              Obx(() => Visibility(
                  visible: controller.leadData.show_button == 1,
                  child: _bottomBar()))
            ],
          )),
    );
  }

  _bottomBar() => Container(
        color: Colors.white,
        width: double.infinity,
        height: 180.sp,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(() => Container(
                    decoration: BoxDecoration(
                        color: ColorUtils.blackLight,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: CustomText(
                        controller.leadData.button_text != null
                            ? controller.leadData.button_text.capitalize
                            : view_more_details.tr,
                        color: Colors.white,
                        fontSize: 42.sp,
                      ),
                    )).onClick(() {
                  controller.launchURL(
                      "https://wa.me/91${controller.leadData.mobile_no}?text=${controller.leadData.lead_remark}");
                 }),
            ),
          ],
        ),
      );

  Widget leadDetailWidget() {
    return Obx(() => controller.leadData.costomer_name == null ||
            controller.leadData.costomer_name.isEmpty
        ? Container()
        : Column(children: [
            Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.all(30.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.sp),
                  border: Border.all(color: Colors.grey.shade300),
                  color: '#F3F1F6'.hexToColor(),
                ),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            controller.leadData.product_icon,
                            width: 90.sp,
                          ).marginOnly(right: 30.sp),
                          Expanded(
                              flex: 5,
                              child: CustomText(
                                controller.leadData.lead_title == null
                                    ? ''
                                    : controller.leadData.lead_title,
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                color: '#4c4058'.hexToColor(),
                                fontSize: 42.sp,
                              )),
                          SvgPicture.asset(
                            'assets/images/new_images/profile_image/calendar.svg',
                            width: 40.sp,
                          ).marginSymmetric(horizontal: 15.sp),
                          CustomText(
                            DateTime.parse(controller.leadData.created_at)
                                .toFormat('dd MMM yyyy'),
                            fontSize: 36.sp,
                          ),
                        ]).marginOnly(top: 30.sp),
                    Divider(
                      height: 1,
                    ).marginOnly(top: 30.sp),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/images/new_images/profile_image/name.svg',
                                width: 50.sp,
                                color: '#574b5f'.hexToColor(),
                              ),
                              CustomText(
                                controller.leadData.costomer_name,
                                fontSize: 38.sp,
                                color: '#574b5f'.hexToColor(),
                              ).marginOnly(left: 30.sp),
                              Spacer(),
                              Container(
                                  decoration: BoxDecoration(
                                      color: [
                                        2,
                                        3,
                                        7,
                                        11,
                                        15,
                                        20,
                                        24,
                                        25,
                                        43,
                                        46,
                                        49
                                      ].contains(controller
                                              .leadData.lead_status_id)
                                          ? ColorUtils.red
                                          : controller.leadData
                                                      .lead_status_id ==
                                                  1
                                              ? ColorUtils.green
                                              : Colors.yellow.shade900,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40))),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(12, 3, 12, 3),
                                    child: CustomText(
                                      controller.leadData.lead_status != null
                                          ? controller.leadData.lead_status
                                              .capitalizeFirst
                                              .toString()
                                              .toUpperCase()
                                          : 'Processing',
                                      color: Colors.white,
                                      fontSize: 28.sp,
                                    ),
                                  )),
                            ],
                          ).marginOnly(top: 30.sp),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/images/new_images/profile_image/telephone.svg',
                                height: 50.sp,
                                color: '#574b5f'.hexToColor(),
                              ),
                              CustomText(
                                controller.leadData.mobile_no,
                                textAlign: TextAlign.end,
                                color: '#574b5f'.hexToColor(),
                                fontSize: 38.sp,
                              ).marginOnly(left: 30.sp),
                              Spacer(),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                          color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40))),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(12, 3, 12, 3),
                                    child: CustomText(
                                      "CALL NOW",
                                      color: ColorUtils.textColor,
                                      fontSize: 28.sp,
                                    ),
                                  )).onClick(() {
                                launch(
                                    "tel://${controller.leadData.mobile_no}");
                              })
                            ],
                          ).marginOnly(top: 40.sp),
                          Divider(
                            height: 1,
                          ).marginOnly(top: 30.sp),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText('Remark : '),
                              Expanded(
                                  child: CustomText(
                                controller.leadData.lead_remark,
                                fontweight: Weight.LIGHT,
                                color: Colors.grey.shade700,
                              ))
                            ],
                          ).marginSymmetric(vertical: 25.sp)
                        ],
                      ),
                    ),
                  ],
                ).marginSymmetric(horizontal: 50.sp, vertical: 0.sp)),
          ]));
  }

  Widget bottomSheetView() {
    return WillPopScope(
        child: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                  color: ColorUtils.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.sp),
                    topRight: Radius.circular(50.sp),
                  ),
                ),
                child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().screenHeight /
                                        ScreenUtil().screenWidth <
                                    1.30
                                ? ScreenUtil().screenWidth / 10
                                : 0),
                        child: Card(
                            color: ColorUtils.white,
                            margin: EdgeInsets.zero,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shadowColor: ColorUtils.white_bg,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(60.sp),
                                    topRight: Radius.circular(60.sp))),
                            child: Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: controller.leadData
                                                        .button_title !=
                                                    null
                                                ? controller
                                                        .leadData
                                                        .button_title
                                                        .capitalizeFirst
                                                        .toString() +
                                                    '\n'
                                                : 'View More Details',
                                            style: StyleUtils
                                                .textStyleNormalPoppins(
                                                    color: ColorUtils.textColor,
                                                    weight: FontWeight.w600,
                                                    fontSize: 54.sp)),
                                        /*TextSpan(
                                            text: 'PAN Number\n',
                                            style: StyleUtils.textStyleNormalPoppins(
                                                color: ColorUtils.orange_gr_light,
                                                weight: FontWeight.w600,
                                                fontSize: 54.sp)),*/
                                        TextSpan(
                                            text: controller.leadData
                                                        .button_content !=
                                                    null
                                                ? controller
                                                    .leadData
                                                    .button_content
                                                    .capitalizeFirst
                                                    .toString()
                                                : 'View More content',
                                            style: StyleUtils
                                                .textStyleNormalPoppins(
                                                    weight: FontWeight.w500,
                                                    color: ColorUtils.greylight,
                                                    fontSize: 40.sp)),
                                      ],
                                    )).marginOnly(top: 30.sp),
                                Container(
                                        decoration: BoxDecoration(
                                            color: ColorUtils.orange_deep,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40))),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 10, 15, 10),
                                          child: CustomText(
                                            controller.leadData.button_text !=
                                                    null
                                                ? controller.leadData
                                                    .button_text.capitalizeFirst
                                                    .toString()
                                                : 'View More Details',
                                            color: Colors.white,
                                            fontSize: 42.sp,
                                          ),
                                        ))
                                    .marginOnly(top: 50.sp)
                                    .onClick(() => Share.share(
                                        controller.leadData.button_content)),
                                CustomText(
                                  'Ignore if already done',
                                  fontSize: 34.sp,
                                  fontweight: FontWeight.w400,
                                )
                                    .marginOnly(top: 25.sp)
                                    .onClick(() => Get.back())
                              ],
                            )).marginAll(40.sp)))
                    .adjustForTablet())),
        onWillPop: () async {
          //double back; 1 for bottom sheet
          Get.back();
          return true;
        });
  }
}
