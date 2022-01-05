import 'dart:ui';
import 'package:bank_sathi/Helpers/Constant.dart';
import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/response/LeaderBoardResponse.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/custom_paints/MyPainter.dart';
import 'package:bank_sathi/custom_paints/hexagon_painter.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/leaderboard_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LeaderBoard extends GetView<LeaderBoardController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // _topWidget(),
                Stack(
                  children: [
                    Image.asset("assets/images/leaderboard_bg.jpg")
                        .marginOnly(bottom: 260.sp),
                    AppBar(
                      titleSpacing: 0,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                      title: Obx(() => Row(children: [UnconstrainedBox(
                          child: SvgPicture.asset(
                            'assets/images/ic_back_arrow.svg',
                            width: 60.sp,
                            height: 60.sp,
                            color: ColorUtils.white,
                          )).marginAll(30.sp).onClick(() => Get.back()),
                        Wrap(
                            alignment: WrapAlignment.start,
                            direction: Axis.horizontal,
                            spacing: 0,
                            children: [
                              ActionChip(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: controller.selectedChip == 1
                                            ? ColorUtils.orange
                                            : ColorUtils.white,
                                        width: .2),
                                    borderRadius:
                                    BorderRadius.circular(60.sp)),
                                label: CustomText(
                                  'This Week'.toUpperCase(),
                                  fontSize: 34.sp,
                                  color: ColorUtils.white,
                                ),
                                labelPadding:
                                EdgeInsets.symmetric(horizontal: 50.sp),
                                backgroundColor: controller.selectedChip == 1
                                    ? ColorUtils.orange
                                    : '#3a3e45'.hexToColor(),
                                onPressed: () {
                                  controller.selectedChip = 1;
                                  controller.leaderBoard();
                                },
                              ),
                              ActionChip(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: controller.selectedChip == 2
                                            ? ColorUtils.orange
                                            : ColorUtils.white,
                                        width: .2),
                                    borderRadius:
                                    BorderRadius.circular(60.sp)),
                                label: CustomText(
                                  'Last Week'.toUpperCase(),
                                  fontSize: 34.sp,
                                  color: ColorUtils.white,
                                ),
                                labelPadding:
                                EdgeInsets.symmetric(horizontal: 50.sp),
                                backgroundColor: controller.selectedChip == 2
                                    ? ColorUtils.orange
                                    : '#3a3e45'.hexToColor(),
                                onPressed: () {
                                  controller.selectedChip = 2;
                                  controller.leaderBoard();
                                },
                              ).marginSymmetric(
                                horizontal: 30.sp,
                              ),
                            ]).marginOnly(left: 20.sp)
                      ],)),
                      // actions: [WidgetUtil.getSupportIcon()],
                    ),
                    Positioned(
                        top: 0,
                        bottom: 250.sp,
                        left: 140.sp,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              'Leaders',
                              style: StyleUtils.textStyleMediumPoppins(
                                      color: ColorUtils.orange,
                                      fontSize: 50.sp,
                                      weight: FontWeight.w500)
                                  .copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            CustomText(
                              'Who create\nHistory',
                              style: StyleUtils.textStyleMediumPoppins(
                                      color: ColorUtils.white,
                                      fontSize: 54.sp,
                                      weight: FontWeight.w500)
                                  .copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        )),
                    Positioned(
                        bottom: 0,
                        left: 50.sp,
                        right: 50.sp,
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(flex:10,child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Card(
                                      elevation: .1,
                                      margin: EdgeInsets.zero,
                                      color: '#f8f8f8'.hexToColor(),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(100.sp),
                                          side: BorderSide(
                                            color: '#d9dae0'.hexToColor(),
                                            width: 1.2,
                                          )),
                                      child: CustomImage.network(
                                          controller.userslist.length < 2
                                              ? ""
                                              : controller
                                              .userslist[1].profile_photo
                                              .toString(),
                                          height: 200.sp,
                                          width: 200.sp,
                                          errorWidget: UnconstrainedBox(
                                            child: SvgPicture.asset(
                                              'assets/images/ic_cc_user.svg',
                                              color: '#e4e3e7'.hexToColor(),
                                              height: 20,
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                    Image.asset('assets/images/gold_medal2.png',
                                        width: 60.sp),
                                    CustomText(
                                      controller.userslist.length < 2
                                          ? "Topper 2"
                                          : controller.userslist[1].first_name
                                          .capitalizeFirst
                                          .toString() +
                                          ' ' +
                                          (controller.userslist[1]
                                              .last_name ==
                                              null
                                              ? ""
                                              : controller
                                              .userslist[1].last_name
                                              .toString()
                                              .capitalizeFirst!),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      fontSize: 38.sp,
                                      color: ColorUtils.blackLight,
                                    ).marginOnly(top: 10.sp),
                                    CustomText(
                                      controller.userslist.length < 2
                                          ? Constant.RUPEE_SIGN + "0.0"
                                          : Constant.RUPEE_SIGN +
                                          controller.userslist[1].earning
                                              .capitalizeFirst
                                              .toString(),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      fontSize: 34.sp,
                                      color: ColorUtils.textColorLight,
                                      fontweight: FontWeight.w400,
                                    ),
                                  ],
                                ),),
                                Expanded(flex:18,child: Column(
                                  children: [
                                    Card(
                                      elevation: 0.2,
                                      margin: EdgeInsets.zero,
                                      color: '#f8f8f8'.hexToColor(),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(150.sp),
                                          side: BorderSide(
                                            color: ColorUtils.orange,
                                            width: 1.5,
                                          )),
                                      child: CustomImage.network(
                                          controller.userslist.length < 1
                                              ? ""
                                              : controller
                                                  .userslist[0].profile_photo
                                                  .toString(),
                                          height: 235.sp,
                                          width: 235.sp,
                                          errorWidget: UnconstrainedBox(
                                            child: SvgPicture.asset(
                                              'assets/images/ic_cc_user.svg',
                                              color: '#e4e3e7'.hexToColor(),
                                              height: 20,
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                    Image.asset('assets/images/gold_medal1.png', width: 60.sp),
                                    CustomText(
                                      controller.userslist.length < 1
                                          ? "Topper 1"
                                          : controller.userslist[0].first_name
                                                  .capitalizeFirst
                                                  .toString() +
                                              ' ' +
                                              (controller.userslist[0]
                                                          .last_name ==
                                                      null
                                                  ? ""
                                                  : controller
                                                      .userslist[0].last_name
                                                      .toString()
                                                      .capitalizeFirst!),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      fontSize: 38.sp,
                                      color: ColorUtils.blackLight,
                                    ).marginOnly(top: 10.sp),
                                    CustomText(
                                      controller.userslist.length < 1
                                          ? Constant.RUPEE_SIGN + "0.0"
                                          : Constant.RUPEE_SIGN +
                                              controller.userslist[0].earning
                                                  .capitalizeFirst
                                                  .toString(),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      fontSize: 34.sp,
                                      color: ColorUtils.textColorLight,
                                      fontweight: FontWeight.w400,
                                    ),
                                  ],
                                )),
                                Expanded(flex:10,child: Column(
                                  children: [
                                    Card(
                                      elevation: .1,
                                      margin: EdgeInsets.zero,
                                      color: '#f8f8f8'.hexToColor(),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.sp),
                                          side: BorderSide(
                                            color: '#d9dae0'.hexToColor(),
                                            width: 1.2,
                                          )),
                                      child: CustomImage.network(
                                          controller.userslist.length < 3
                                              ? ""
                                              : controller
                                                  .userslist[2].profile_photo
                                                  .toString(),
                                          height: 200.sp,
                                          width: 200.sp,
                                          errorWidget: UnconstrainedBox(
                                            child: SvgPicture.asset(
                                              'assets/images/ic_cc_user.svg',
                                              color: '#e4e3e7'.hexToColor(),
                                              height: 20,
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                    Image.asset('assets/images/gold_medal3.png',
                                        width: 60.sp),
                                    CustomText(
                                      controller.userslist.length < 3
                                          ? "Topper 3"
                                          : controller.userslist[2].first_name
                                                  .capitalizeFirst
                                                  .toString() +
                                              ' ' +
                                              (controller.userslist[2]
                                                          .last_name ==
                                                      null
                                                  ? ""
                                                  : controller
                                                      .userslist[2].last_name
                                                      .toString()
                                                      .capitalizeFirst!),
                                      maxLines: 1,
                                      fontSize: 38.sp,
                                      textAlign: TextAlign.center,
                                      color: ColorUtils.blackLight,
                                    ).marginOnly(top: 10.sp),
                                    CustomText(
                                      controller.userslist.length < 3
                                          ? Constant.RUPEE_SIGN + "0.0"
                                          : Constant.RUPEE_SIGN +
                                              controller.userslist[2].earning
                                                  .capitalizeFirst
                                                  .toString(),
                                      maxLines: 1,
                                      fontSize: 34.sp,
                                      textAlign: TextAlign.center,
                                      color: ColorUtils.textColorLight,
                                      fontweight: FontWeight.w400,
                                    ),
                                  ],
                                )),
                              ],
                            )))
                  ],
                ),

                BasePageView(
                    controller: controller,
                    idleWidget: Column(
                      children: [
                        SizedBox(
                          height: 15.sp,
                        ),
                        Visibility(
                          child: _userWidget(
                              true,
                              AllUser(
                                earning: controller.leadData.value.earning,
                                first_name:
                                    controller.leadData.value.first_name,
                                last_name: controller.leadData.value.last_name,
                                profile_photo:
                                    controller.leadData.value.profile_photo,
                                rank: controller.leadData.value.rank,
                                location: controller.leadData.value.location,
                                total_leads: controller.leadData.value.total_leads,
                              )).marginOnly(top: 15.sp),
                          visible: true,
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: ((context, position) => _userWidget(
                              false, controller.userslist[position + 3])),
                          itemCount: controller.userslist.isEmpty
                              ? 0
                              : controller.userslist.length <= 3
                                  ? 0
                                  : controller.userslist.length - 3,
                        )
                      ],
                    )),
              ],
            )),
      ),
    ));
  }

  Widget _userWidget(bool isUser, AllUser user) {
    return Container(
      decoration: BoxDecoration(
        color: isUser ? ColorUtils.orange : ColorUtils.white,
        border: Border.all(
            color: isUser ? ColorUtils.orange : '#e4e3e7'.hexToColor(),
            width: 1),
        borderRadius: BorderRadius.circular(30.sp),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              isUser ? ColorUtils.orange_gr_light :Colors.white,
              isUser ? ColorUtils.orange_gr_dark :Colors.white,
            ]),
      ),
      child: Row(children: [
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: rank.tr.toUpperCase()+'\n',
                  style: StyleUtils.textStyleNormal(
                      color: isUser ? ColorUtils.white : ColorUtils.greylight,
                      weight: FontWeight.w400,
                      fontSize: 24.sp)),
              TextSpan(
                  text: user.rank.toString(),
                  style: StyleUtils.textStyleNormal(
                      color: isUser ? ColorUtils.white : ColorUtils.orange,
                      weight: FontWeight.w500,
                      fontSize:  40.sp)),
            ])).marginOnly(left: 20.sp),
        SizedBox(
          width: 160.sp,
          height: 160.sp,
          child: Card(
            elevation: 1,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(50.sp),
                side: BorderSide(
                  color: isUser ? Colors.white : '#e4e3e7'.hexToColor(),
                  width: 6.sp,
                )),
            child: CustomImage.network(user.profile_photo.toString(),
                height: 150.sp,
                width: 150.sp,
                errorWidget: UnconstrainedBox(
                  child: SvgPicture.asset(
                    'assets/images/ic_cc_user.svg',
                    color: '#e4e3e7'.hexToColor(),
                    height: 20,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                fit: BoxFit.cover),
          ),
        ).marginOnly(left: 10.sp),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                        "${user.first_name.capitalizeFirst} ${user.last_name == null ? "" : user.last_name.toString().capitalizeFirst!}",
                        style: StyleUtils.textStyleNormalPoppins(
                            color: isUser
                                ? ColorUtils.white
                                : ColorUtils.blackLight,
                            weight: FontWeight.w500,
                            fontSize: 42.sp))),
                Text(
                    user.earning == null
                        ? Constant.RUPEE_SIGN + "0"
                        : Constant.RUPEE_SIGN + user.earning,
                    style: StyleUtils.textStyleNormal(
                        color: isUser ? ColorUtils.white : ColorUtils.orange,
                        weight: FontWeight.w500,
                        fontSize: 40.sp))
              ],
            ),
            Row(
              children: [
                Text("${user.location == null ? "Location NA" : user.location}",
                    style: StyleUtils.textStyleNormal(
                        color: isUser
                            ? ColorUtils.white_bg
                            : ColorUtils.textColorLight,
                        weight: FontWeight.w400,
                        fontSize: 34.sp)),
                Spacer(),
                Text(earning.tr.toUpperCase(),
                    style: StyleUtils.textStyleNormalPoppins(
                        color: isUser
                            ? ColorUtils.white_bg
                            : ColorUtils.textColorLight,
                        weight: FontWeight.w400,
                        fontSize: 32.sp)),
              ],
            )
          ],
        ).marginOnly(left: 15.sp, right: 15.sp))
      ]).marginSymmetric(vertical: 20.sp, horizontal: 10.sp),
    ).marginSymmetric(horizontal: 40.sp, vertical: 15.sp);
  }

  Widget _topWidget() {
    return Container(
      height: 600.sp,
      width: double.infinity,
      margin: EdgeInsets.only(left: 40.sp, right: 40.sp, top: 170.sp),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(40.sp)),
      child: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(children: [
                    Card(
                      color: Colors.grey.shade200,
                      child: SvgPicture.asset(
                              'assets/images/new_images/wallet.svg',
                              height: 65.sp,
                              fit: BoxFit.scaleDown,
                              color: ColorUtils.orange)
                          .marginAll(30.sp),
                      shape: CircleBorder(),
                      elevation: 0.sp,
                      clipBehavior: Clip.antiAlias,
                    ).marginOnly(bottom: 10.sp),
                    CustomText('Lead Earning'.toUpperCase(),
                        style: StyleUtils.textStyleNormal(
                            color: ColorUtils.textColor.withAlpha(200),
                            weight: FontWeight.w500,
                            fontSize: 32.sp)),
                    CustomText(
                        Constant.RUPEE_SIGN +
                            (controller.leadData.value.earning == null
                                ? ""
                                : controller.leadData.value.earning.toString()),
                        style: StyleUtils.textStyleNormal(
                            color: ColorUtils.textColor,
                            weight: FontWeight.w600,
                            fontSize: 50.sp)),
                  ])),
                  Transform.translate(
                      offset: Offset(0, -170.sp),
                      child: Center(
                        child: CircleAvatar(
                            radius: 172.sp,
                            backgroundColor: ColorUtils.white,
                            child: Card(
                              elevation: 1,
                              color: ColorUtils.white,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(170.sp),
                              ),
                              child: CustomImage.network(
                                  controller.leadData.value.profile_photo ==
                                          null
                                      ? ""
                                      : controller.leadData.value.profile_photo,
                                  height: 340.sp,
                                  errorWidget: UnconstrainedBox(
                                    child: SvgPicture.asset(
                                      'assets/images/ic_cc_user.svg',
                                      color: ColorUtils.black,
                                      height: 100.sp,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  width: 340.sp,
                                  fit: BoxFit.fill),
                            )),
                      )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        color: Colors.grey.shade200,
                        child: SvgPicture.asset(
                                'assets/images/new_images/ranking.svg',
                                height: 65.sp,
                                fit: BoxFit.scaleDown,
                                color: ColorUtils.orange)
                            .marginAll(30.sp),
                        shape: CircleBorder(),
                        elevation: 0.sp,
                        clipBehavior: Clip.antiAlias,
                      ).marginOnly(bottom: 10.sp),
                      CustomText('Rank'.toUpperCase(),
                          style: StyleUtils.textStyleNormal(
                              color: ColorUtils.textColor.withAlpha(200),
                              weight: FontWeight.w500,
                              fontSize: 32.sp)),
                      CustomText(
                          (controller.leadData.value.rank == null
                              ? ""
                              : controller.leadData.value.rank.toString()),
                          style: StyleUtils.textStyleNormal(
                              color: ColorUtils.textColor,
                              weight: FontWeight.w600,
                              fontSize: 80.sp)),
                    ],
                  )),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    'assets/images/ic_play_button.svg',
                    color: ColorUtils.black_light,
                    height: 90.sp,
                    width: 90.sp,
                  ),
                  CustomText('How to earn more with Banksathi?')
                ],
              ).marginAll(20.sp).onClick(() => Get.dialog(
                  WidgetUtil.videoDialog(
                      'https://www.youtube.com/watch?v=QRNWMtsrn64'.videoId!))),
              Divider(),
            ],
          )),
    );
  }
}
