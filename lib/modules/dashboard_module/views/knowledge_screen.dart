import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/response/get_knowledge_response.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/knowledge_controller.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_scaffold.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class KnowledgeScreen extends GetView<KnowledgeController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Training",
      body: BasePageView(
        controller: controller,
        idleWidget: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.knowledgeList.length,
                  shrinkWrap: true,
                  itemBuilder: (_, position) {
                    List<Video> videoList =
                        controller.knowledgeList[position].video_list;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          controller
                              .knowledgeList[position].category_name.capitalize,
                          style: StyleUtils.textStyleNormalPoppins(
                              fontSize: 48.sp, weight: FontWeight.w500),
                        ).marginOnly(top: 10.sp, bottom: 10.sp, left: 40.sp),
                        Container(
                          width: Get.width,
                          height: 720.sp,
                          child: ListView.builder(
                              itemCount: videoList.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, videoPosition) {
                                return UnconstrainedBox(
                                    child: Container(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        margin: EdgeInsets.only(
                                            left: 30.sp,
                                            top: 30.sp,
                                            bottom: 30.sp,
                                            right: 30.sp),
                                        width: Get.width * .8,
                                        height: 600.sp,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(60.sp)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorUtils.grey
                                                  .withOpacity(0.1),
                                              spreadRadius: 30.sp,
                                              blurRadius: 30.sp,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: AspectRatio(
                                                  aspectRatio: 16 / 8,
                                                  child: CustomImage.network(
                                                    videoList[videoPosition]
                                                        .video_url
                                                        .thumbnail,
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                            Expanded(child: LayoutBuilder(
                                                builder: (_, constraint) {
                                              print("constraint :" +
                                                  constraint.toString());
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                          width: constraint
                                                                  .maxWidth -
                                                              200.sp,
                                                          child: CustomText(
                                                            videoList[
                                                                    videoPosition]
                                                                .title,
                                                            fontweight:
                                                                Weight.NORMAL,
                                                          ))
                                                      .alignTo(
                                                          Alignment.centerLeft)
                                                      .marginOnly(
                                                          left: 50.sp,
                                                          top: 20.sp,
                                                          bottom: 20.sp),
                                                  SvgPicture.asset(
                                                    'assets/images/new_images/play.svg',
                                                    width: 100.sp,
                                                    color: Colors.deepOrange,
                                                  ).marginOnly(
                                                      right: 50.sp,
                                                      top: 20.sp,
                                                      bottom: 20.sp)
                                                ],
                                              );
                                            }))
                                          ],
                                        ))).onClick(() => Get.dialog(
                                    WidgetUtil.videoDialog(
                                        videoList[videoPosition].videoId,
                                        description:
                                            videoList[videoPosition].title)));
                              }),
                        )
                      ],
                    );
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
