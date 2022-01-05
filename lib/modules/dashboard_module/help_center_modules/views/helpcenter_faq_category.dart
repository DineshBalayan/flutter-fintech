import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/controllers/help_controller.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HelpFaqCategory extends GetView<HelpController> {
  Widget _sectionFaq() => Column(children: [
        Obx(
          () => ListView.separated(
            key: Key('builder ${controller.expandIndex.toString()}'),
            itemCount: controller.questionAnswer.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.white),
                child: ExpansionTile(
                  key: Key(index.toString()),
                  backgroundColor: Colors.white,
                  collapsedBackgroundColor: Colors.white,
                  childrenPadding: EdgeInsets.zero,
                  tilePadding: EdgeInsets.zero,
                  maintainState: false,
                  initiallyExpanded: index == controller.expandIndex,
                  // initiallyExpanded: index == 0,
                  textColor: Colors.orange,
                  onExpansionChanged: ((newState) {
                    if (newState) {
                      Duration(seconds: 1);
                      controller.expandIndex = index;
                    } else {
                      controller.expandIndex = -1;
                    }
                  }),
                  title: Container(
                    padding: EdgeInsets.only(left: 15.sp, right: 0.sp),
                    // transform: Matrix4.translationValues(0.0, 3.0, 0.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: CustomText(
                        '${controller.questionAnswer[index].question}',
                        fontweight: Weight.BOLD,
                        style: TextStyle(
                          color: ColorUtils.blackDark,
                          wordSpacing: 0.001,
                          letterSpacing: 0.01,
                        ),
                        fontSize: 40.sp,
                      ),
                    ),
                  ),
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15.sp, right: 0.sp),
                      transform: Matrix4.translationValues(0.0, -4.0, 0.0),
                      padding:
                          (controller.questionAnswer[index].videoUrl?.isEmpty ??
                                  true)
                              ? EdgeInsets.fromLTRB(0, 0, 150.sp, 30.sp)
                              : EdgeInsets.only(right: 150.sp),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: CustomText(
                          '${controller.questionAnswer[index].answer}',
                          fontweight: Weight.LIGHT,
                          fontSize: 35.sp,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              height: 1.7, color: ColorUtils.blackShade),
                        ),
                      ),
                    ),
                    (controller.questionAnswer[index].videoUrl?.isEmpty ?? true)
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
                                      '${controller.questionAnswer[index].videoUrl.thumbnail}',
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
                              ),
                            ]),
                          ).onClick(() => Get.dialog(
                              WidgetUtil.videoDialog(controller
                                  .questionAnswer[index].videoUrl.videoId!),
                            )),
                  ],
                  // collapsedIconColor: Colors.orange,
                  iconColor: Colors.orange,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 2,
                color: ColorUtils.lightDivider.withOpacity(.2),
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
                // controller.pageState = PageStates.PAGE_IDLE;
                Get.back();
              },
            ),
            title: CustomText(
              '${controller.faqForTitle[controller.faqIndex].title}',
              fontweight: Weight.NORMAL,
              fontSize: 48.sp,
              color: ColorUtils.white,
            ),
          ),
          body: BasePageView(
              controller: controller,
              idleWidget: Stack (
                children: [
                  Column(children : [ 
                    Expanded(child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                (controller.faqForTitle[controller.faqIndex]
                                    .queAns.length ==
                                    0)
                                    ? Container()
                                    : Container(
                                  margin: EdgeInsets.all(45.sp),
                                  decoration: BoxDecoration(
                                      color: ColorUtils.white,
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  padding: EdgeInsets.only(
                                      left: 60.sp,
                                      top: 30.sp,
                                      right: 60.sp,
                                      bottom: 30.sp),
                                  child: _sectionFaq(),
                                ),
                                controller.showEmptySubCategory() == 0
                                    ? Container()
                                    : Container(
                                  margin: EdgeInsets.fromLTRB(
                                      45.sp, 45.sp, 45.sp, 45.sp),
                                  decoration: BoxDecoration(
                                      color: ColorUtils.white,
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  padding: EdgeInsets.only(
                                      left: 60.sp,
                                      right: 60.sp,
                                      bottom: 30.sp),
                                  child: Column(children: [
                                    (controller
                                        .faqForTitle[
                                    controller.faqIndex]
                                        .queAns
                                        .length ==
                                        0)
                                        ? Container(height: 30.sp)
                                        : Container(
                                      padding:
                                      EdgeInsets.only(top: 50.sp),
                                      child: Align(
                                        alignment:
                                        Alignment.centerLeft,
                                        child: CustomText(
                                          'Other Topics',
                                          fontweight: Weight.BOLD,
                                          fontSize: 45.sp,
                                          color: ColorUtils.blackDark,
                                        ),
                                      ),
                                    ),
                                    Obx(
                                          () => ListView.separated(
                                        itemCount:
                                        controller.subCategory.length,
                                        physics:
                                        NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (BuildContext context,
                                            int index) {
                                          return (controller
                                              .subCategory[index]
                                              .queAns
                                              .length ==
                                              0)
                                              ? Container()
                                              : Theme(
                                            data: Theme.of(context)
                                                .copyWith(
                                                dividerColor: Colors
                                                    .transparent),
                                            child: ListTile(
                                              // dense: true,
                                              tileColor:
                                              ColorUtils.white,
                                              trailing: Icon(
                                                  Icons
                                                      .keyboard_arrow_right,
                                                  color: ColorUtils
                                                      .blackShade),
                                              onTap: () {
                                                controller
                                                    .faqCategoryArrayUpdate(
                                                    controller
                                                        .subCategory[
                                                    index]
                                                        .queAns,
                                                    index);
                                                Get.toNamed(Routes
                                                    .DASHBOARD +
                                                    Routes
                                                        .HELP_FAQ_SUB_CAT);
                                              },
                                              contentPadding:
                                              EdgeInsets.zero,
                                              title: Container(
                                                padding:
                                                EdgeInsets.only(
                                                    left: 15.sp,
                                                    right: 15.sp),
                                                transform: Matrix4
                                                    .translationValues(
                                                    0.0,
                                                    3.0,
                                                    0.0),
                                                child: CustomText(
                                                  '${controller.subCategory[index].subTitle}',
                                                  fontweight:
                                                  Weight.NORMAL,
                                                  style: TextStyle(
                                                    color: ColorUtils
                                                        .blackLight,
                                                    wordSpacing:
                                                    0.001,
                                                    letterSpacing:
                                                    0.01,
                                                  ),
                                                  fontSize: 40.sp,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context,
                                            int index) {
                                          return (controller
                                              .subCategory[index]
                                              .queAns
                                              .length ==
                                              0)
                                              ? Container()
                                              : Divider(
                                              thickness: 2,
                                              color: ColorUtils
                                                  .lightDivider
                                                  .withOpacity(.2));
                                        },
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ).paddingOnly(bottom: 200.sp),
                        ],
                      ),
                    ))
                  ]),
                  controller.showEmptySubCategory() > 0
                      ? Container()
                      : Positioned(
                          bottom: 0,
                          child: Container(
                              width: Get.width,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Card(
                                    elevation: 1.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.sp),
                                    ),
                                    child: Container(
                                            child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/new_images/call_support.svg',
                                          color: '#f37021'.hexToColor(),
                                          height: 70.sp,
                                        ),

                                        CustomText(
                                          'Call Support'.toUpperCase(),
                                          fontSize: 38.sp,
                                          color: ColorUtils.blackDark,
                                        ).paddingOnly(left: 20.sp)
                                      ],
                                    ).paddingOnly(left:40.sp,right:40.sp,top:30.sp,bottom:30.sp))
                                        .onClick(() {
                                      controller.makePhoneCall();
                                    }),
                                  ),
                                  Card(
                                    elevation: 1.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.sp),
                                    ),
                                    child: Container(
                                            child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/new_images/mail_support.svg',
                                          color: '#f37021'.hexToColor(),
                                          height: 60.sp,
                                        ).paddingOnly(top: 5.sp,bottom: 5.sp),
                                        CustomText(
                                          'E-Mail Support'.toUpperCase(),
                                          fontSize: 40.sp,
                                          color: ColorUtils.blackDark,
                                        ).paddingOnly(left: 20.sp,)
                                      ],
                                    ).paddingOnly(left:40.sp,right:40.sp,top:30.sp,bottom:30.sp)).onClick(() {
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
                              ).marginOnly(top:20.sp,bottom: 20.sp))),
                ],
              )),
        ),
      ),
    );
  }
}
