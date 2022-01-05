import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/controllers/help_controller.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HelpFaqSubCategory extends GetView<HelpController> {

  Widget _sectionFaq() => Column(children: [
        Obx(
          () => ListView.separated(
            itemCount: controller.subCatQuestionAnswer.length,
            physics: NeverScrollableScrollPhysics(),
            primary: false,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  backgroundColor: Colors.white,
                  collapsedBackgroundColor: Colors.white,
                  childrenPadding: EdgeInsets.zero,
                  tilePadding: EdgeInsets.zero,
                  maintainState: false,
                  // initiallyExpanded: index == 0,
                  textColor: Colors.orange,
                  title: Container(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    transform: Matrix4.translationValues(0.0, 3.0, 0.0),
                    child: CustomText(
                      '${controller.subCatQuestionAnswer[index].question.capitalize}',
                      fontweight: Weight.NORMAL,
                      style: TextStyle(
                        color: ColorUtils.blackLight,
                        wordSpacing: 0.001,
                        letterSpacing: 0.01,
                      ),
                      fontSize: 40.sp,
                    ),
                  ),
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                      transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                      padding: (controller.subCatQuestionAnswer[index].videoUrl?.isEmpty ?? true)
                          ? const EdgeInsets.fromLTRB(0, 0, 50, 10)
                          : const EdgeInsets.only(right: 50.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          '${controller.subCatQuestionAnswer[index].answer}',
                          fontweight: Weight.LIGHT,
                          style: TextStyle(
                            color: ColorUtils.blackShade,
                            wordSpacing: 0.001,
                            letterSpacing: 0.01,
                          ),
                          textAlign: TextAlign.justify,
                          fontSize: 35.sp,
                        ),
                      ),
                    ),
                    (controller.subCatQuestionAnswer[index].videoUrl?.isEmpty ?? true)
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 10.0, bottom: 20.0),
                            width: Get.width,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.sp)),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorUtils.grey.withOpacity(0.05),
                                  spreadRadius: 10.sp,
                                  blurRadius: 10.sp,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Stack(children: [
                              Container(
                                child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: CustomImage.network(
                                      '${controller.subCatQuestionAnswer[index].videoUrl?.thumbnail}',
                                      fit: BoxFit.cover,
                                    )),
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
                                      size: 75.sp,
                                      color: ColorUtils.orange,
                                    ).marginAll(10.sp),
                                  ).marginAll(20.sp),
                                  alignment: Alignment.center,
                                ),
                              )
                            ]).onClick(() => Get.dialog(
                                  WidgetUtil.videoDialog(controller.subCatQuestionAnswer[index]
                                      .videoUrl
                                      .videoId!),
                                )),
                          ),
                  ],
                  collapsedIconColor: Colors.orange,
                  iconColor: Colors.orange,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 5,
                color: ColorUtils.lightDivider.withOpacity(.1),
              );
            },
          ),
        ),
      ]);

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async {
        // controller.pageState = PageStates.PAGE_IDLE;
        Get.back();
        return true;
      },
      child: SafeArea(
        child: new Scaffold(
          backgroundColor: ColorUtils.topCurveColor,
          appBar: new AppBar(
            backgroundColor: ColorUtils.orange_shadow,
            elevation: 0,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: ColorUtils.white),
              onPressed: () {
                controller.pageState = PageStates.PAGE_IDLE;
                Get.back();
              },
            ),
            title: CustomText(
              '${controller.subCategory[controller.faqSubCatIndex].subTitle}',
              fontweight: Weight.NORMAL,
              fontSize: 48.sp,
              color: ColorUtils.white,
            ),
          ),
          body: BasePageView(
            controller: controller,
            idleWidget: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        (controller.subCatQuestionAnswer.length ==
                                0)
                            ? Container()
                            : Container(
                                margin: EdgeInsets.all(45.sp),
                                decoration: BoxDecoration(
                                    color: ColorUtils.white,
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.only(
                                    left: 60.sp,
                                    top: 30.sp,
                                    right: 60.sp,
                                    bottom: 30.sp),
                                child: _sectionFaq(),
                              ),
                      ],
                    ),
                  ).paddingOnly(bottom:300.sp),
                ],
              ),
            ),
          ),
          floatingActionButton:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.support_agent,
                            color: ColorUtils.orange, size: 80.sp),
                        CustomText(
                          'Call Us',
                          fontSize: 40.sp,
                          color: ColorUtils.blackDark,
                        ).paddingOnly(left: 20.sp)
                      ],
                    ).paddingOnly(left: 60.sp,top: 30.sp,right: 60.sp,bottom: 30.sp))
                    .onClick(() {
                  controller.makePhoneCall();

                }),
              ).marginOnly(left: 30.sp),

              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.email_outlined,
                            color: ColorUtils.orange, size: 80.sp),
                        CustomText(
                          'E-Mail Us',
                          fontSize: 40.sp,
                          color: ColorUtils.blackDark,
                        ).paddingOnly(left: 20.sp)
                      ],
                    ).paddingOnly(left: 60.sp,top: 30.sp,right: 60.sp,bottom: 30.sp))
                    .onClick(() {
                  controller.mailShare();
                }),
              ),


              /*   FloatingActionButton.extended(
                            backgroundColor: ColorUtils.black,
                            elevation: 0.0,
                            icon: Icon(Icons.email, color: ColorUtils.white),
                            onPressed: () {
                              Get.toNamed(
                                  Routes.DASHBOARD + Routes.HELP_FAQ_QUERY);
                            },
                            label: Text("Mail Us"))
                        .marginOnly(left: 20.sp),*/
            ],
          ),
      /*    floatingActionButton: FloatingActionButton.extended(
              backgroundColor: ColorUtils.black,
              elevation: 5.0,
              icon: Icon(Icons.email, color: ColorUtils.white),
              onPressed: () {
                Get.toNamed(Routes.DASHBOARD + Routes.HELP_FAQ_QUERY);
                // controller.mailShare();
              },
              label: Text("Send Query")),*/
        ),
      ),
    );
  }

}
