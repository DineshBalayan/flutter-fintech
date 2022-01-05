import 'package:bank_sathi/Helpers/Constant.dart';
import 'package:bank_sathi/Helpers/DottedLine.dart';
import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/controllers/help_controller.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:bank_sathi/widgets/dashboard_slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sms_retriever/sms_retriever.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dashboard.dart';

class HomeTab extends GetView<DashboardController> {
  _topWidget() => Column(
        children: [
          Showcase(
              overlayPadding: EdgeInsets.all(5),
              key: controller.showKey4,
              title: showcase_wallet_title.tr,
              description: showcase_wallet_des.tr,
              contentPadding: EdgeInsets.all(8.0),
              showcaseBackgroundColor: ColorUtils.black_gr_light,
              textColor: ColorUtils.white,
              shapeBorder: RoundedRectangleBorder(),
              child: Container(
                  color: '#F3F1F6'.hexToColor(),
                  child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.sp)),
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Card(
                                        color: "#f5f4f9".hexToColor(),
                                        child: SvgPicture.asset(
                                                'assets/images/new_images/withdrawals.svg',
                                                height: 65.sp,
                                                fit: BoxFit.scaleDown,
                                                color: ColorUtils.black)
                                            .marginAll(40.sp),
                                        shape: CircleBorder(),
                                        elevation: 0.sp,
                                        clipBehavior: Clip.antiAlias,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            balance.tr.toUpperCase(),
                                            color: ColorUtils.greylight,
                                            fontweight: FontWeight.w400,
                                            fontSize: 36.sp,
                                          ),
                                          Obx(() => CustomText(
                                                Constant.RUPEE_SIGN +
                                                    controller
                                                        .totalWithdrawAmount,
                                                color: "#000000".hexToColor(),
                                                fontweight: FontWeight.w500,
                                                fontSize: 42.sp,
                                              )),
                                        ],
                                      ).marginOnly(left: 20.sp),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 100.sp,
                                    child: RaisedButton(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.w),
                                      ),
                                      highlightColor: ColorUtils.orange,
                                      onPressed: () async {
                                        print(controller.totalWithdrawAmount
                                            .toDouble());
                                        if (controller.totalWithdrawAmount
                                                .toDouble() ==
                                            0) {
                                          WidgetUtil.addLeadView();
                                        } else {
                                          checkCases();
                                        }
                                      },
                                      color: ColorUtils.black,
                                      child: Obx(() => CustomText(
                                            (controller.totalWithdrawAmount
                                                        .toDouble() ==
                                                    0)
                                                ? add_lead_earn.tr.toUpperCase()
                                                : withdraw_now.tr.toUpperCase(),
                                            style: TextStyle(
                                                color: ColorUtils.white,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 36.sp),
                                          )),
                                    ),
                                  )
                                ],
                              ),
                              DottedLine(
                                dashColor: '#b2b2b2'.hexToColor(),
                                dashGapLength: 1,
                                dashLength: 4,
                              ).marginSymmetric(vertical: 10.sp),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    total_earning.tr.toUpperCase(),
                                    color: "#000000".hexToColor(),
                                    fontweight: FontWeight.w400,
                                    fontSize: 42.sp,
                                  ),
                                  Obx(() => CustomText(
                                        Constant.RUPEE_SIGN +
                                            controller.totalAmount,
                                        color: "#000000".hexToColor(),
                                        fontweight: FontWeight.w500,
                                        fontSize: 42.sp,
                                      )),
                                ],
                              )
                            ],
                          ).marginSymmetric(horizontal: 40.sp, vertical: 10.sp))
                      .onClick(() =>
                          Get.toNamed(Routes.DASHBOARD + Routes.WALLET_SCREEN)!
                              .then((value) => bottomNavigationKey.currentState!
                                  .reAnimate()))
                      .marginOnly(
                          left: 40.sp,
                          right: 40.sp,
                          bottom: 40.sp,
                          top: 40.sp))),
          Obx(() => Visibility(
                child: controller.bannerList != null &&
                        controller.bannerList.length > 0
                    ? DashboardSliderWidget(controller.bannerList)
                        .marginOnly(top: 40.sp)
                    : Container(),
                visible: controller.bannerList != null &&
                    controller.bannerList.length > 0,
              )),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtils.window_bg,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Showcase(
              key: controller.showKey1,
              title: 'Profile Section',
              description: 'Click here to go to your profile sections.',
              contentPadding: EdgeInsets.all(8.0),
              showcaseBackgroundColor: ColorUtils.black_gr_light,
              textColor: ColorUtils.white,
              shapeBorder: CircleBorder(),
              child: Card(
                color: ColorUtils.white,
                child: Obx(
                  () => CustomImage.network(controller.user.profile_photo,
                      height: 50.sp,
                      width: 50.sp,
                      errorWidget: UnconstrainedBox(
                        child: SvgPicture.asset(
                          'assets/images/new_images/user.svg',
                          height: 50.sp,
                          width: 50.sp,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      fit: BoxFit.fill),
                ),
                shape: CircleBorder(),
                elevation: 1,
                clipBehavior: Clip.antiAlias,
              )
                  .marginOnly(
                      left: 25.sp, right: 15.sp, top: 15.sp, bottom: 15.sp)
                  .onClick(() async {
                var goToVisitingCard = await Get.toNamed(Routes.MY_DETAIL);
                bottomNavigationKey.currentState!.reAnimate();
                if (goToVisitingCard != null && goToVisitingCard) {
                  Get.find<DashboardController>().handleNotifications(null,
                      screen: Routes.DASHBOARD + "?index=3&page=1");
                }
              })),
          title: Obx(() => RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: 'Hi ',
                      style: StyleUtils.textStyleNormalPoppins(
                          color: ColorUtils.black,
                          weight: FontWeight.w400,
                          fontSize: 48.sp)),
                  TextSpan(
                      text: controller.user.first_name != null
                          ? controller.user.first_name
                              .toString()
                              .capitalizeFirst
                          : '',
                      style: StyleUtils.textStyleNormalPoppins(
                          color: ColorUtils.orange,
                          weight: FontWeight.w600,
                          fontSize: 48.sp)),
                ],
              ))),
          actions: [
            WidgetUtil.getLiveTrainingWidget().marginOnly(right: 40.sp).onClick(() {
              Get.find<DashboardController>().currentTab = 3;
              Future.delayed(500.milliseconds, () {
                Get.find<HelpController>().updateSelectedValue(1);
              });
            }),
            Showcase(
                overlayPadding: EdgeInsets.all(5),
                key: controller.showKey2,
                title: 'Notifications',
                description: 'Tap to see Latest Notifications from Banksathi.',
                contentPadding: EdgeInsets.all(8.0),
                showcaseBackgroundColor: ColorUtils.black_gr_light,
                textColor: ColorUtils.white,
                shapeBorder: CircleBorder(),
                child: WidgetUtil.getNotificationIcon().marginOnly(right: 50.sp)),
          ],
        ),
        body: BasePageView(
            controller: controller,
            idleWidget: RefreshIndicator(
                onRefresh: controller.dashboardApi,
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      _topWidget(),
                      CustomText(
                        sell_earn.tr,
                        fontweight: Weight.NORMAL,
                      )
                          .marginOnly(top: 40.sp, left: 40.sp)
                          .alignTo(Alignment.topLeft),
                      Obx(() => GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            childAspectRatio: 1.7,
                            padding: EdgeInsets.only(
                                left: 40.sp, right: 40.sp, top: 40.sp),
                            crossAxisSpacing: 30.sp,
                            mainAxisSpacing: 30.sp,
                            shrinkWrap: true,
                            children: controller.activeProducts.map((e) {
                              String? bgColor =
                                  controller.prefManager.getProductsColor() ==
                                              null ||
                                          !controller.prefManager
                                              .getProductsColor()!
                                              .any((element) =>
                                                  element.category_id == e.id)
                                      ? null
                                      : controller.prefManager
                                          .getProductsColor()!
                                          .firstWhere((element) =>
                                              element.category_id == e.id)
                                          .bg;
                              String? iconColor =
                                  controller.prefManager.getProductsColor() ==
                                              null ||
                                          !controller.prefManager
                                              .getProductsColor()!
                                              .any((element) =>
                                                  element.category_id == e.id)
                                      ? null
                                      : controller.prefManager
                                          .getProductsColor()!
                                          .firstWhere((element) =>
                                              element.category_id == e.id)
                                          .icon;
                              return Container(
                                child: Card(
                                    elevation: 0,
                                    color: (bgColor ?? "#F3F1F6").hexToColor(),
                                    margin: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(40.sp),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: CustomText(
                                                e.title + "\n",
                                                maxLines: 2,
                                                fontSize: 40.sp,
                                                color: "#303C49".hexToColor(),
                                                textAlign: TextAlign.left,
                                              ).marginOnly(top: 15.sp),
                                            ),
                                            Container(
                                                height: 125.sp,
                                                width: 125.sp,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                                child: UnconstrainedBox(
                                                    child: SizedBox(
                                                  width: 65.sp,
                                                  height: 65.sp,
                                                  child: SvgPicture.network(
                                                    e.icon,
                                                    color:
                                                        (iconColor ?? "#968E9F")
                                                            .hexToColor(),
                                                    width: 65.sp,
                                                    height: 65.sp,
                                                    fit: BoxFit.scaleDown,
                                                    placeholderBuilder: (_) =>
                                                        Center(
                                                            child: SizedBox(
                                                      height: 40.sp,
                                                      width: 40.sp,
                                                      child: Center(
                                                        child: Lottie.asset(
                                                            'assets/animation/loading.json',
                                                            width: 40.sp,
                                                            fit: BoxFit
                                                                .fitWidth),
                                                      ),
                                                    )),
                                                  ),
                                                )).marginAll(20.sp))
                                          ],
                                        ),
                                        WidgetUtil.getContainer(e.message,
                                                color: "#303C49".hexToColor())
                                            .marginOnly(bottom: 20.sp),
                                      ],
                                    ).marginSymmetric(
                                        horizontal: 30.sp, vertical: 20.sp)),
                              ).onClick(() {
                                Get.toNamed(Routes.DASHBOARD +
                                        Routes.PRODUCT_LIST_SCREEN +
                                        "?product_id=" +
                                        e.id.toString())!
                                    .then((value) => bottomNavigationKey
                                        .currentState!
                                        .reAnimate());
                              });
                            }).toList(),
                          )),
                      Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CustomText(
                                top_leaders.tr,
                                fontweight: Weight.NORMAL,
                              ).marginOnly(left: 40.sp),
                              CustomText(
                                view_all.tr,
                                fontSize: 35.sp,
                                color: ColorUtils.grey,
                              ).marginOnly(right: 40.sp)
                            ],
                          )
                              .onClick(() => Get.toNamed(
                                      Routes.DASHBOARD + Routes.LEADERBOARD)!
                                  .then((value) => bottomNavigationKey
                                      .currentState!
                                      .reAnimate()))
                              .visibility(controller.topLeaders != null &&
                                  controller.topLeaders.isNotEmpty)).marginOnly(
                          top: 60.sp),
                      Obx(() => SizedBox(
                            height: 450.sp,
                            child: Obx(() => ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: PageScrollPhysics(),
                                itemCount: controller.topLeaders.length,
                                controller: PageController(),
                                itemBuilder: (_, pos) {
                                  return Container(
                                          height: 400.sp,
                                          width: (Get.width - 150.sp) / 3,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 280.sp,
                                                width: 280.sp,
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle),
                                                child: CustomImage.network(
                                                    controller.topLeaders[pos]
                                                        .profile_photo,
                                                    height: 230.sp,
                                                    width: 230.sp,
                                                    errorWidget: Container(
                                                        height: 180.sp,
                                                        width: 180.sp,
                                                        color: '#F3F1F6'
                                                            .hexToColor(),
                                                        child: UnconstrainedBox(
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/images/ic_cc_user.svg',
                                                            color: '#9a92a2'
                                                                .hexToColor(),
                                                            height: 30,
                                                            fit: BoxFit
                                                                .scaleDown,
                                                          ),
                                                        )),
                                                    fit: BoxFit.cover),
                                              ),
                                              CustomText(
                                                (controller.topLeaders[pos]
                                                        .getFullName())
                                                    .capitalize,
                                                color: ColorUtils.orange,
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                fontSize: 34.sp,
                                              ).marginOnly(top: 10.sp),
                                              CustomText(
                                                Constant.RUPEE_SIGN +
                                                    controller
                                                        .topLeaders[pos].earning
                                                        .toString(),
                                                color: ColorUtils.textColor,
                                                textAlign: TextAlign.center,
                                                fontSize: 32.sp,
                                              )
                                            ],
                                          ))
                                      .marginOnly(
                                          left: pos == 0 ? 40.sp : 20.sp,
                                          right: pos ==
                                                  controller.topLeaders.length -
                                                      1
                                              ? 40.sp
                                              : 20.sp);
                                })),
                          ).marginOnly(top: 40.sp).visibility(
                              controller.topLeaders != null &&
                                  controller.topLeaders.isNotEmpty)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomText(
                            featured_videos.tr,
                            fontweight: Weight.NORMAL,
                          )
                              .marginOnly(top: 10.sp, left: 40.sp)
                              .alignTo(Alignment.topLeft),

                          /*  CustomText(
                            view_all.tr,
                            fontSize: 35.sp,
                            color: ColorUtils.grey,
                          ).marginOnly(top: 40.sp, right: 40.sp)*/
                        ],
                      ),
                      /*  .onClick(() =>
                          Get.toNamed(Routes.DASHBOARD + Routes.KNOWLEDGE)!
                              .then((value) => bottomNavigationKey.currentState!
                                  .reAnimate())),*/
                      SizedBox(
                        height: 320.sp,
                        child: Obx(() => ListView.builder(
                            itemCount: controller.featuredVideo.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, videoPosition) {
                              return AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  padding: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(40.sp)),
                                  ),
                                  child: Stack(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: CustomImage.network(
                                          controller
                                              .featuredVideo[videoPosition]
                                              .thumbnail,
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
                              )
                                  .marginOnly(
                                      right: videoPosition ==
                                              controller.featuredVideo.length -
                                                  1
                                          ? 30.sp
                                          : 0,
                                      left: 40.sp)
                                  .onClick(() => Get.dialog(
                                        WidgetUtil.videoDialog(
                                            controller
                                                .featuredVideo[videoPosition]
                                                .videoId!,
                                            description: ''),
                                      ));
                            })),
                      ).marginOnly(top: 40.sp),
                      Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 0,
                              color: "#379BE6".hexToColor(),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.sp)),
                              margin: EdgeInsets.only(
                                  top: 40.sp,
                                  bottom: 40.sp,
                                  left: 40.sp,
                                  right: 40.sp),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    join_us_telegram.tr.toUpperCase(),
                                    color: Colors.white,
                                  ),
                                  SvgPicture.asset(
                                    'assets/images/new_images/telegram.svg',
                                    width: 80.sp,
                                  ).marginOnly(left: 30.sp)
                                ],
                              ).marginAll(40.sp))
                          .marginOnly(top: 15.sp)
                          .onClick(() {
                        launch("https://t.me/banksathi_t");
                      }),
                      SizedBox(
                        height: 220.sp,
                      )
                    ],
                  ),
                )))
    );
  }

  checkCases() async {
    if (controller.user.is_adhar_verified == "0") {
      Get.dialog(WidgetUtil.showDialog(() async {
        Get.back();
        await Get.toNamed(Routes.MY_DETAIL + Routes.KYC_DETAILS);
        checkCases();
      }, message: verify_aadhar_msg.tr, title: kyc.tr, button: 'GO'));
    } else if (controller.user.is_pan_verified == "0") {
      Get.dialog(WidgetUtil.showDialog(() async {
        Get.back();
        await Get.toNamed(Routes.MY_DETAIL + Routes.KYC_DETAILS);
        checkCases();
      }, message: verify_pan_msg.tr, title: kyc.tr, button: 'GO'));
    } else if ((controller.user.relbank == null ||
            controller.user.relbank.status == "0") &&
        (controller.user.paytm_no_status == "0")) {
      Get.dialog(WidgetUtil.showDialog(() async {
        Get.back();
        await Get.toNamed(Routes.MY_DETAIL + Routes.BANK_DETAILS);
        checkCases();
      }, message: verify_bank_paytm.tr, title: banking.tr, button: go.tr));
    } else {
      SmsRetriever.unlockApp().then((platformAuth) async {
        if (platformAuth == 'true') {
          Get.dialog(withDrawDialog(controller));
        }
      }).catchError((e) async {
        if (e.code == "1") {
          Get.dialog(withDrawDialog(controller));
        } else {}
      });
    }
  }

  Widget withDrawDialog(DashboardController controller) {
    controller.user.paytm_mobile_no = controller.user.paytm_mobile_no == null
        ? controller.user.mobile_no
        : controller.user.paytm_mobile_no;
    TextEditingController mobileNoController =
        TextEditingController(text: controller.user.paytm_mobile_no);
    RxBool isMobile = (controller.user.paytm_no_status != "0").obs;
    return BasePageView(
        controller: controller,
        idleWidget: UnconstrainedBox(
          child: SizedBox(
            height: Get.height * .62,
            width: Get.width * .95,
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.sp)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      select_mode.tr,
                      fontSize: 50.sp,
                      fontweight: Weight.BOLD,
                    ),
                    Container(
                      width: 180.sp,
                      height: 2,
                      color: ColorUtils.orange,
                    ).marginSymmetric(vertical: 30.sp),
                    CustomText(
                      payout_withdrawal_msg.tr,
                      textAlign: TextAlign.center,
                      fontSize: 38.sp,
                      fontweight: FontWeight.w300,
                      color: ColorUtils.grey,
                    ).marginOnly(left: 100.sp, right: 100.sp),
                    Row(
                      children: [
                        Expanded(
                            child: IgnorePointer(
                          ignoring: (controller.user.paytm_mobile_no == null ||
                              controller.user.paytm_mobile_no
                                  .toString()
                                  .isEmpty),
                          child: Obx(() => WidgetUtil.getRadio(
                              label: paytm_transfer.tr,
                              fontSize: 38.sp,
                              border: false,
                              bold: true,
                              onTap: () {
                                mobileNoController.text =
                                    controller.user.paytm_mobile_no;
                                isMobile.value = true;
                              },
                              isSelected: isMobile.value)),
                        )),
                        Expanded(
                            child: IgnorePointer(
                                ignoring: (controller.user.relbank == null ||
                                    controller.user.relbank.status == "0" ||
                                    controller.prefManager
                                            .getDashboardData()!
                                            .data
                                            .limit_amount
                                            .toDouble()! >
                                        Get.find<DashboardController>()
                                            .totalWithdrawAmount
                                            .toDouble()!),
                                child: Obx(() => WidgetUtil.getRadio(
                                    label: bank_transfer.tr,
                                    fontSize: 38.sp,
                                    bold: true,
                                    border: false,
                                    onTap: () {
                                      mobileNoController.text =
                                          controller.user.relbank.account_no;
                                      isMobile.value = false;
                                    },
                                    isSelected: !isMobile.value))))
                      ],
                    ).marginSymmetric(horizontal: 25.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (controller.user.paytm_mobile_no == null ||
                                controller.user.paytm_mobile_no
                                    .toString()
                                    .isEmpty)
                            ? Center(
                                child: Row(
                                  children: [
                                    Icon(Icons.info_outlined,
                                        size: 20,
                                        color: '#6c7483'.hexToColor()),
                                    CustomText(
                                      'Add PayTm number for wallet transfer',
                                      style: TextStyle(
                                        color: '#6c7483'.hexToColor(),
                                        decoration: TextDecoration.underline,
                                      ),
                                      fontSize: 32.sp,
                                      fontweight: Weight.NORMAL,
                                    ).onClick(() async {
                                      Get.back();
                                      await Get.toNamed(Routes.MY_DETAIL +
                                          Routes.BANK_DETAILS);
                                      Get.dialog(withDrawDialog(controller));
                                    }),
                                  ],
                                ),
                              )
                            : Container(),
                        (controller.user.relbank == null ||
                                controller.user.relbank.status == "0" ||
                                controller.prefManager
                                        .getDashboardData()!
                                        .data
                                        .limit_amount
                                        .toDouble()! >
                                    Get.find<DashboardController>()
                                        .totalWithdrawAmount
                                        .toDouble()!)
                            ? Center(
                                child: Row(
                                  children: [
                                    Icon(Icons.info_outlined,
                                        size: 20,
                                        color: '#6c7483'.hexToColor()),
                                    CustomText(
                                      'Add Bank details for bank transfer',
                                      style: TextStyle(
                                        color: '#6c7483'.hexToColor(),
                                        decoration: TextDecoration.underline,
                                      ),
                                      fontSize: 32.sp,
                                      fontweight: Weight.NORMAL,
                                    ).onClick(() async {
                                      Get.back();
                                      await Get.toNamed(Routes.MY_DETAIL +
                                          Routes.BANK_DETAILS);
                                      Get.dialog(withDrawDialog(controller));
                                    }),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ).marginSymmetric(horizontal: 25.sp),
                    Container(
                            margin: EdgeInsets.only(top: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Obx(() => CustomTextField(
                                      isEnabled: false,
                                      controller: mobileNoController,
                                      outlinedBorder: true,
                                      textInputAction: TextInputAction.done,
                                      verticalMargin: 0,
                                      prefixText:
                                          isMobile.value ? '+91 ' : null,
                                      suffixIconSize: 80.sp,
                                      suffixIcon: SvgPicture.asset(
                                        'assets/images/new_images/check.svg',
                                        width: 50.sp,
                                      ).marginOnly(right: 20.sp),
                                      textStyle:
                                          StyleUtils.textStyleNormalPoppins()
                                              .copyWith(
                                                  letterSpacing: 2,
                                                  fontSize: 45.sp,
                                                  fontWeight: FontWeight.bold),
                                      keyboardType: TextInputType.phone,
                                    ))
                                .marginOnly(left: 10.sp, right: 10.sp)
                                .paddingAll(5.sp))
                        .marginSymmetric(vertical: 10.sp, horizontal: 45.sp),
                    Container(
                      color: "#F5F6F8".hexToColor(),
                      padding: EdgeInsets.symmetric(
                          horizontal: 45.sp, vertical: 40.sp),
                      margin: EdgeInsets.symmetric(vertical: 30.sp),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                'Total Payout',
                                fontweight: Weight.NORMAL,
                                color: '#6c7483'.hexToColor(),
                              ),
                              CustomText(
                                Constant.RUPEE_SIGN +
                                    Get.find<DashboardController>()
                                        .totalWithdrawAmount,
                                color: '#6c7483'.hexToColor(),
                                fontweight: Weight.NORMAL,
                              ),
                            ],
                          ).marginSymmetric(vertical: 20.sp),
                          Row(
                            children: [
                              CustomText(
                                'TDS Deduction (-5%) ',
                                fontweight: Weight.NORMAL,
                                color: '#6c7483'.hexToColor(),
                              ),
                              SvgPicture.asset(
                                'assets/images/new_images/profile_image/information.svg',
                                color: '#6c7483'.hexToColor(),
                                width: 42.sp,
                              ).onClick(() async {
                                Get.back();
                                await Get.toNamed(
                                    Routes.MY_DETAIL + Routes.TDS_INFO);
                                Get.dialog(withDrawDialog(controller));
                              }),
                              Spacer(),
                              CustomText(
                                '-' +
                                    Constant.RUPEE_SIGN +
                                    (Get.find<DashboardController>()
                                                .totalWithdrawAmount
                                                .toDouble()! *
                                            .05)
                                        .toString(),
                                color: '#6c7483'.hexToColor(),
                                fontweight: Weight.NORMAL,
                              ),
                            ],
                          ).paddingOnly(bottom: 20.sp),
                          Divider(color: ColorUtils.grey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                'Amount to be transfer',
                                fontweight: Weight.BOLD,
                              ),
                              CustomText(
                                Constant.RUPEE_SIGN +
                                    (Get.find<DashboardController>()
                                                .totalWithdrawAmount
                                                .toDouble()! -
                                            (Get.find<DashboardController>()
                                                    .totalWithdrawAmount
                                                    .toDouble()! *
                                                .05))
                                        .toString(),
                                fontweight: Weight.NORMAL,
                              ),
                            ],
                          ).paddingOnly(top: 20.sp, bottom: 20.sp),
                        ],
                      ),
                    ),
                    WidgetUtil.getStateButton(
                      controller: controller,
                      color: ColorUtils.orange,
                      onPressed: () async {
                        if (isMobile.value) {
                          // Get.back();
                          await controller.withDrawToWallet(
                              controller.user.paytm_mobile_no);
                        } else {
                          // Get.back();
                          await controller.withDrawToBank();
                        }
                      },
                      textStyle: StyleUtils.textStyleNormalPoppins(
                          color: ColorUtils.white,
                          weight: FontWeight.w500,
                          fontSize: 40.sp),
                      width: 600.sp,
                      label: confirm_withdraw.tr,
                    ).marginOnly(top: 25.sp)
                  ],
                )),
          ),
        ).adjustForTablet());
  }

  YoutubePlayerController setVideoController(videoID) {
    return YoutubePlayerController(
      initialVideoId: videoID,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }
}
