import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/tds_info_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_scaffold.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TDSInfoScreen extends GetView<TDSInfoController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: about_tds.tr,
        showNotification: false,
        body: BasePageView(
            controller: controller,
            idleWidget: SingleChildScrollView(
                child: Column(
              children: [
                Obx(() => Html(
                      data: controller.htmldata,
                    ).marginSymmetric(horizontal: 40.sp)),
                Container(
                  height: 30.sp,
                  width: double.infinity,
                  color: "#F5F5F5".hexToColor(),
                ),
                Obx(() => controller.helpdata.length != 0
                    ? Container(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().screenHeight /
                                            ScreenUtil().screenWidth <
                                        1.30
                                    ? ScreenUtil().screenWidth / 10
                                    : 0),
                            child: SingleChildScrollView(
                                child: Column(children: <Widget>[
                              CustomText(
                                "Some FAQ's",
                                fontSize: 52.sp,
                                color: ColorUtils.textColor,
                              )
                                  .marginOnly(
                                      top: 30.sp, left: 40.sp, bottom: 30.sp)
                                  .alignTo(Alignment.topLeft),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (_, position) {
                                  YoutubePlayerController?
                                      youtubePlayerController = controller
                                                  .helpdata[0]
                                                  .que_ans[position]
                                                  .video_url ==
                                              null
                                          ? null
                                          : setVideoController(
                                              controller
                                                  .helpdata[0]
                                                  .que_ans[position]
                                                  .video_url!
                                                  .videoId,
                                              autoPlay: false);

                                  return Column(
                                    children: [
                                      Container(
                                        color: "#F5F5F5".hexToColor(),
                                        height: 2,
                                        width: double.infinity,
                                      )
                                          .visibility(position == 0)
                                          .marginOnly(bottom: 10.sp),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: CustomText(controller
                                                      .helpdata[0]
                                                      .que_ans[position]
                                                      .question)
                                                  .marginSymmetric(
                                                      vertical: 30.sp)),
                                          Obx(() => controller
                                                  .helpdata[0]
                                                  .que_ans[position]
                                                  .isExpanded
                                                  .value
                                              ? Icon(
                                                  Icons.remove,
                                                  size: 48.sp,
                                                  color: ColorUtils.textColor,
                                                )
                                              : Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 48.sp,
                                                  color: ColorUtils.textColor,
                                                )).marginOnly(
                                              left: 40.sp, top: 40.sp),
                                        ],
                                      ),
                                      Obx(() => controller
                                                  .helpdata[0]
                                                  .que_ans[position]
                                                  .isExpanded
                                                  .value &&
                                              controller
                                                      .helpdata[0]
                                                      .que_ans[position]
                                                      .answer !=
                                                  null &&
                                              controller
                                                  .helpdata[0]
                                                  .que_ans[position]
                                                  .answer
                                                  .isNotEmpty
                                          ? Html(
                                              data: controller.helpdata[0]
                                                  .que_ans[position].answer,
                                              style: {
                                                "body": Style(
                                                  fontSize: FontSize(42.sp),
                                                  color: ColorUtils.textColor,
                                                )
                                              },
                                            ).marginOnly(bottom: 20.sp)
                                          : Container()),
                                      Obx(() => controller
                                                  .helpdata[0]
                                                  .que_ans[position]
                                                  .isExpanded
                                                  .value &&
                                              controller
                                                      .helpdata[0]
                                                      .que_ans[position]
                                                      .video_url !=
                                                  null &&
                                              controller
                                                  .helpdata[0]
                                                  .que_ans[position]
                                                  .video_url
                                                  .isNotEmpty
                                          ? UnconstrainedBox(
                                              child: Container(
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                  ),
                                                  width: 800.sp,
                                                  height: 450.sp,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.sp),
                                                    child: YoutubePlayer(
                                                      showVideoProgressIndicator:
                                                          true,
                                                      bottomActions: [
                                                        const SizedBox(
                                                            width: 14.0),
                                                        CurrentPosition(),
                                                        const SizedBox(
                                                            width: 8.0),
                                                        ProgressBar(
                                                          isExpanded: true,
                                                        ),
                                                        RemainingDuration(),
                                                      ],
                                                      progressColors:
                                                          ProgressBarColors(
                                                              playedColor:
                                                                  Colors.amber,
                                                              handleColor: Colors
                                                                  .amberAccent),
                                                      controller:
                                                          youtubePlayerController!,
                                                    ),
                                                  )),
                                            ).marginOnly(bottom: 35.sp)
                                          : Container()),
                                      Container(
                                        color: "#F5F5F5".hexToColor(),
                                        height: 2,
                                        width: double.infinity,
                                      ).marginOnly(top: 10.sp),
                                    ],
                                  ).onClick(() {
                                    controller.helpdata[0].que_ans
                                        .forEach((element) {
                                      if (controller.helpdata[0].que_ans
                                              .indexOf(element) !=
                                          position) {
                                        element.isExpanded.value = false;
                                      }
                                    });
                                    controller.helpdata[0].que_ans[position]
                                            .isExpanded.value =
                                        !controller.helpdata[0]
                                            .que_ans[position].isExpanded.value;
                                  });
                                },
                                shrinkWrap: true,
                                itemCount:
                                    controller.helpdata[0].que_ans.length,
                              ).marginSymmetric(horizontal: 60.sp),
                            ])))).marginOnly(top: 30.sp)
                    : Container())
              ],
            ))));
  }
}
