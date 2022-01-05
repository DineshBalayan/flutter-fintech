import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/response/get_training_video_response.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/controllers/help_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/model/training_model.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HelpTraining extends GetView<HelpController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Stack(children: [
              Positioned.fill(
                  child: Align(
                child: Divider(
                  height: 2,
                  thickness: 1,
                  color: Colors.grey.shade300,
                ),
                alignment: Alignment.bottomRight,
              )),
              TabBar(
                  controller: controller.trainingVideoController,
                  labelColor: ColorUtils.orange,
                  unselectedLabelColor: Colors.black,
                  indicatorColor: Colors.black,
                  tabs: ['Training Session', 'Training Video']
                      .map((e) => Tab(text: e))
                      .toList()),
            ]).marginSymmetric(horizontal: 40.sp)),
        body: TabBarView(
          controller: controller.trainingVideoController,
          children: [tabOne(), tabTwo()],
        ),
      ),
    );
  }

  Widget tabOne() {
    return RefreshIndicator(
        child: Obx(
          () => ListView.builder(
            itemCount: controller.trainingVideo.length + 1,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              TrainingVideo video = index == controller.trainingVideo.length
                  ? TrainingVideo()
                  : controller.trainingVideo[index];
              return index == controller.trainingVideo.length
                  ? SizedBox(
                      height: 200.sp,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 30.sp, vertical: 25.sp),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.sp),
                        boxShadow: [
                          BoxShadow(
                            color: "#F2F2F2".hexToColor(),
                            spreadRadius: 50.sp,
                            blurRadius: 40.sp,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.sp, vertical: 2.sp),
                              decoration: BoxDecoration(
                                  color: "#ED3833".hexToColor(),
                                  borderRadius: BorderRadius.circular(15.sp)),
                              child: CustomText(
                                "• LIVE",
                                fontweight: Weight.LIGHT,
                                color: Colors.white,
                                fontSize: 28.sp,
                              ),
                            ).visibility(video.start_date
                                    .serverToDateTime()
                                    .isSameDate(DateTime.now()) &&
                                video.start_time
                                    .isCurrentTimeInTimeRange(video.end_time)),
                            top: 0,
                            right: 50.sp,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  height: 180.sp,
                                  child: AspectRatio(
                                      aspectRatio: 1.16,
                                      child: video.product_icon!=null?video.product_icon.endsWith('.svg')
                                          ? CustomImage.networkSVG(
                                              video.product_icon,
                                            )
                                          : CustomImage.network(
                                              video.product_icon,
                                            ):Container())),
                              Expanded(
                                child: SizedBox(
                                  height: 250.sp,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        video.title,
                                        textAlign: TextAlign.start,
                                        fontweight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 42.sp,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomText(
                                              (video.start_date
                                                      .serverToDateTime()
                                                      .isSameDate(
                                                          DateTime.now())
                                                  ? "Today | ${video.start_time.toTimeServerToTimeUi()} - ${video.end_time.toTimeServerToTimeUi()}"
                                                  : video.start_date
                                                          .serverToDateTime()
                                                          .toFormat(
                                                              'dd MMMM yyyy')! +
                                                      ' | ${video.start_time.toTimeServerToTimeUi()}'),
                                              fontweight: FontWeight.w400,
                                              fontSize: 35.sp,
                                              textAlign: TextAlign.start,
                                              color: "#535353".hexToColor(),
                                            ).marginOnly(bottom: 20.sp),
                                          ),
                                        ],
                                      ),
                                      video.is_enrolled == 0
                                          ? Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.sp),
                                                      border: Border.all(
                                                          color:
                                                              ColorUtils.orange,
                                                          width: 1)),
                                                  child: CustomText(
                                                    'Enroll Me Now',
                                                    color: ColorUtils.orange,
                                                    fontSize: 34.sp,
                                                  ).paddingSymmetric(
                                                      horizontal: 20.sp,
                                                      vertical: 5.sp))
                                              .onClick(() {
                                              controller.enrollTraining(
                                                  video.id.toString());
                                            })
                                          : Row(
                                              children: [
                                                Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 35.sp,
                                                            vertical: 15.sp),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.sp),
                                                      color: "#449523"
                                                          .hexToColor(),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .check_circle_outline_outlined,
                                                          size: 50.sp,
                                                          color: Colors.white,
                                                        ),
                                                        CustomText(
                                                                'Join Now'
                                                                    .toUpperCase(),
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 32.sp,
                                                                fontweight:
                                                                    Weight
                                                                        .LIGHT)
                                                            .marginOnly(
                                                                left: 15.sp)
                                                      ],
                                                    )).onClick(() {
                                                  controller.launchURL(
                                                      video.video_url);
                                                }),
                                                SizedBox(
                                                  width: 50.sp,
                                                ),
                                                Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 35.sp,
                                                            vertical: 15.sp),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    100.sp),
                                                        color: "#3B3736"
                                                            .hexToColor()),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.share,
                                                          size: 50.sp,
                                                          color: Colors.white,
                                                        ),
                                                        CustomText(
                                                          'Invite Friends'
                                                              .toUpperCase(),
                                                          color: Colors.white,
                                                          fontSize: 32.sp,
                                                          fontweight:
                                                              Weight.LIGHT,
                                                        ).marginOnly(
                                                            left: 15.sp)
                                                      ],
                                                    )).onClick(() {
                                                  controller.shareLinkText(
                                                      video.share_msg +
                                                          " " +
                                                          video.video_url);
                                                })
                                              ],
                                            )
                                    ],
                                  ),
                                ).marginOnly(left: 30.sp),
                              )
                            ],
                          ).marginSymmetric(horizontal: 30.sp, vertical: 10.sp)
                        ],
                      ));
            },
          ),
        ),
        onRefresh: controller.getZoomTrainingVideo);
  }

  Widget tabTwo() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: AlwaysScrollableScrollPhysics(),
      child: Obx(
        () => ListView.builder(
            primary: true,
            physics: PageScrollPhysics(),
            itemCount: controller.trainingData.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (_, videoPosition) {
              if (videoPosition % 2 == 0) {
                return Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    // borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                  ),
                  child: oddNumberArray(videoPosition),
                );
              } else {
                return Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    // borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                  ),
                  child: evenNumberArray(videoPosition),
                );
              }
            }).paddingOnly(bottom: 200.sp),
      ),
    );
  }

  Widget oddNumberArray(int videoPosition) {
    return Column(
      children: [
        CustomText(
          '${controller.trainingData[videoPosition].title}',
          color: ColorUtils.blackDark,
          fontweight: Weight.NORMAL,
          fontSize: 45.sp,
        ).marginOnly(left: 40.sp).alignTo(Alignment.topLeft),
        Container(
          height: 450.sp,
          child: Obx(() => ListView.builder(
              itemCount:
                  controller.trainingData[videoPosition].helpSection.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (_, position) {
                return Card(
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25.sp)),
                      boxShadow: [
                        BoxShadow(
                          color: ColorUtils.blackDark.withOpacity(0.1),
                          spreadRadius: 5.sp,
                          blurRadius: 5.sp,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Container(
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: CustomImage.network(
                              '${controller.trainingData[videoPosition].helpSection[position].videoUrl.thumbnail}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.grey.shade200, width: 1),
                                  color: Colors.white),
                              child: Icon(
                                Icons.play_arrow,
                                size: 75.sp,
                                color: ColorUtils.orange,
                              ).marginAll(10.sp),
                            ).marginAll(20.sp),
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ).marginAll(10.sp).onClick(() => Get.dialog(
                      WidgetUtil.videoDialog(controller
                          .trainingData[videoPosition]
                          .helpSection[position]
                          .videoUrl
                          .videoId!),
                    ));
              })),
        ).marginOnly(top: 15.sp),
      ],
    );
  }

  Widget evenNumberArray(int videoPosition) {
    TrainingData training = controller.trainingData[videoPosition];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CustomText(
              '${controller.trainingData[videoPosition].title}',
              color: ColorUtils.blackDark,
              fontweight: Weight.NORMAL,
              fontSize: 45.sp,
            ).marginOnly(left: 40.sp).alignTo(Alignment.topLeft),
            Obx(() => CustomText(
                      training.isExpanded ? view_less.tr : view_all.tr,
                      fontSize: 35.sp,
                      color: ColorUtils.grey,
                    ).marginOnly(right: 40.sp))
                .visibility(training.helpSection.length > 2),
          ],
        ).onClick(() {
          training.isExpanded = !training.isExpanded;
        }).marginOnly(top: 15.sp),
        Container(
          child: Obx(() => ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: training.isExpanded || training.helpSection.length <= 2
                  ? training.helpSection.length
                  : 2,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (_, position) {
                return Container(
                  padding: EdgeInsets.all(20.sp),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25.sp)),
                    boxShadow: [
                      BoxShadow(
                        color: ColorUtils.blackDark.withOpacity(0.03),
                        spreadRadius: 5.sp,
                        blurRadius: 5.sp,
                        offset: Offset(1, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.sp)),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                child: AspectRatio(
                                  aspectRatio: 16 / 10,
                                  child: CustomImage.network(
                                    '${controller.trainingData[videoPosition].helpSection[position].videoUrl.thumbnail}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.grey.shade200,
                                            width: 1),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.play_arrow,
                                      size: 45.sp,
                                      color: ColorUtils.orange,
                                    ),
                                  ).marginAll(10.sp),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                              '${controller.trainingData[videoPosition].helpSection[position].title}',
                              fontweight: Weight.LIGHT,
                              color: ColorUtils.blackLight,
                            ).marginOnly(left: 40.sp)),
                      ),
                    ],
                  ),
                )
                    .marginOnly(
                        left: 15.sp, right: 15.sp, top: 5.sp, bottom: 20.sp)
                    .onClick(() => Get.dialog(
                          WidgetUtil.videoDialog(controller
                              .trainingData[videoPosition]
                              .helpSection[position]
                              .videoUrl
                              .videoId!),
                        ));
              }).marginOnly(top: 15.sp)),
        ),
      ],
    );
  }
}
