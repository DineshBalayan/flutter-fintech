import 'dart:ui';

import 'package:bank_sathi/Helpers/Constant.dart';
import 'package:bank_sathi/Helpers/TimeAgo.dart';
import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/response/get_user_response.dart';
import 'package:bank_sathi/Model/response/lead_transaction_response.dart';
import 'package:bank_sathi/Model/response/withdrawal_transactions_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/data/pref_manager.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/wallet_tab_controller.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sms_retriever/sms_retriever.dart';
import 'package:url_launcher/url_launcher.dart';

class WalletTab extends StatelessWidget {
  late List<Widget> tabs = [tabPayout(), tabReferral(), tabHistory()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          SvgPicture.asset(
            'assets/images/new_images/profile_image/information.svg',
            height: 64.sp,
          ).marginOnly(right: 50.sp).onClick(() {
            Get.find<DashboardController>().showSectionInfoById(9);
          })
        ],
        backgroundColor: Colors.transparent,
        leading: SvgPicture.asset(
          'assets/images/ic_back_arrow.svg',
          width: 75.sp,
          fit: BoxFit.scaleDown,
        ).onClick(() {
          Get.back();
        }),
        title: CustomText(
          earning.tr,
          style: GoogleFonts.mulish(
              color: ColorUtils.black,
              fontWeight: FontWeight.w600,
              fontSize: 48.sp),
          textAlign: TextAlign.center,
        ),
        elevation: 0,
      ),
      body: GetBuilder<WalletTabController>(
          builder: (controller) => Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      color: '#F3F1F6'.hexToColor(),
                      child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.sp)),
                              margin: EdgeInsets.zero,
                              elevation: 0,
                              child: Container(
                                padding: EdgeInsets.all(30.sp),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Card(
                                          color: ColorUtils.orange,
                                          child: SvgPicture.asset(
                                                  'assets/images/new_images/wallet.svg',
                                                  height: 66.sp,
                                                  fit: BoxFit.scaleDown,
                                                  color: ColorUtils.white)
                                              .marginAll(25.sp),
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
                                              color: ColorUtils.grey,
                                              fontweight: Weight.LIGHT,
                                              fontSize: 30.sp,
                                            ),
                                            Obx(() => CustomText(
                                                  Constant.RUPEE_SIGN +
                                                      controller.total_balance,
                                                  color: ColorUtils.black,
                                                  fontSize: 50.sp,
                                                )),
                                          ],
                                        ).marginOnly(left: 15.sp)
                                      ],
                                    )),
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Card(
                                          child: Container(
                                            color: '#eceef2'.hexToColor(),
                                            child: SvgPicture.asset(
                                                    'assets/images/new_images/withdrawals.svg',
                                                    height: 66.sp,
                                                    fit: BoxFit.scaleDown,
                                                    color: ColorUtils.black)
                                                .marginAll(25.sp),
                                          ),
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
                                              total_earning.tr.toUpperCase(),
                                              color: ColorUtils.grey,
                                              fontweight: Weight.LIGHT,
                                              fontSize: 30.sp,
                                            ),
                                            Obx(() => CustomText(
                                                  Constant.RUPEE_SIGN +
                                                      controller.total_amount,
                                                  color: ColorUtils.black,
                                                  fontSize: 50.sp,
                                                )),
                                          ],
                                        ).marginOnly(left: 15.sp),
                                      ],
                                    )),
                                  ],
                                ),
                              ))
                          .marginOnly(
                              left: 40.sp,
                              right: 40.sp,
                              bottom: 40.sp,
                              top: 40.sp)),
                  Container(
                    color: ColorUtils.white,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              TextSpan(
                                text: get_payout_in.tr + ' ',
                                style: StyleUtils.textStyleNormalPoppins(
                                    fontSize: 38.sp),
                              ),
                              TextSpan(
                                text: paytm_or_bank_account.tr,
                                style: StyleUtils.textStyleNormalPoppins(
                                    fontSize: 38.sp, weight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: ' ' + in_quickest_time.tr,
                                style: StyleUtils.textStyleNormalPoppins(
                                    fontSize: 38.sp),
                              ),
                            ]),
                          ).marginSymmetric(horizontal: 20.sp),
                        ),
                        SizedBox(
                          height: 120.h,
                          child: RaisedButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.w),
                            ),
                            highlightColor: ColorUtils.orange,
                            onPressed: () async {
                              if (controller.total_balance != null &&
                                  controller.total_balance
                                      .toString()
                                      .isNotEmpty &&
                                  controller.total_balance
                                          .toString()
                                          .toDouble()! >=
                                      1.00) {
                                checkCases(controller);
                              } else {
                                List<Products> products =
                                    Get.find<PrefManager>()
                                            .getProductsStatus() ??
                                        [];
                                List<Products> activeProducts = products
                                    .where((element) => element.status == "1")
                                    .toList();
                                List<CategoryColor> colorsNew = Get.find<PrefManager>().getProductsColor() ?? [];

                                Get.bottomSheet(LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    return Container(
                                        height: constraints.maxHeight,
                                        width: constraints.maxWidth,
                                        alignment: Alignment.bottomRight,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(.5),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(50.sp),
                                            topRight: Radius.circular(50.sp),
                                          ),
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: ScreenUtil()
                                                                .screenHeight /
                                                            ScreenUtil()
                                                                .screenWidth <
                                                        1.30
                                                    ? ScreenUtil().screenWidth /
                                                        10
                                                    : 0),
                                            child: Card(
                                                color: ColorUtils.white,
                                                margin: EdgeInsets.zero,
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                shadowColor:
                                                    ColorUtils.white_bg,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(
                                                            60.sp),
                                                        topRight:
                                                            Radius.circular(
                                                                60.sp))),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          CustomText(
                                                            select_and_add_lead
                                                                .tr,
                                                            color: ColorUtils
                                                                .black,
                                                            customTextStyle:
                                                                CustomTextStyle
                                                                    .MEDIUM,
                                                          ),
                                                          Container(
                                                            height: 72.sp,
                                                            width: 72.sp,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(40
                                                                            .sp),
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .black)),
                                                            child: Icon(
                                                              Icons.clear,
                                                              color:
                                                                  Colors.black,
                                                              size: 48.sp,
                                                            ),
                                                          ).onClick(
                                                              () => Get.back())
                                                        ],
                                                      ).paddingOnly(
                                                          left: 60.sp,
                                                          top: 60.sp,
                                                          right: 60.sp),
                                                      Divider(
                                                        height: 60.sp,
                                                        thickness: 1,
                                                      ),
                                                      GridView.count(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        crossAxisCount: 2,
                                                        childAspectRatio: 1,
                                                        shrinkWrap: true,
                                                        children: activeProducts
                                                            .map(
                                                                (e) {
                                                                  String? bgColor =  (colorsNew == null || !colorsNew.any((element) =>
                                                                  element.category_id == e.id)) ? null : colorsNew.firstWhere((element) => element.category_id == e.id).bg;

                                                                  String? iconColor = (colorsNew == null || !colorsNew.any((element) =>
                                                                  element.category_id == e.id)) ? null : colorsNew.firstWhere((element) => element.category_id == e.id).icon;

                                                                  return Container(
                                                                    margin: EdgeInsets
                                                                        .symmetric(
                                                                        horizontal: 10
                                                                            .sp,
                                                                        vertical:
                                                                        15.sp),
                                                                    child: Card(
                                                                        elevation: 0,
                                                                        color: (bgColor ?? "#F3F1F6").hexToColor(),
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius
                                                                                .circular(
                                                                                40
                                                                                    .sp),
                                                                            side: BorderSide(
                                                                              color: Colors
                                                                                  .grey
                                                                                  .shade200,
                                                                              width: 1,
                                                                            )),
                                                                        child: Column(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                          children: [
                                                                          Container(
                                                                  height: 150.sp,
                                                                  width: 150.sp,
                                                                  decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  shape:
                                                                  BoxShape.circle),
                                                                  child: UnconstrainedBox(
                                                                  child:  SizedBox(
                                                                              child: SvgPicture
                                                                                  .network(
                                                                                e
                                                                                    .icon,
                                                                                color:
                                                                                (iconColor ?? "#968E9F")
                                                                                    .hexToColor(),
                                                                                height: 85
                                                                                    .sp,
                                                                                fit: BoxFit
                                                                                    .scaleDown,
                                                                                placeholderBuilder: (
                                                                                    _) =>
                                                                                    Center(
                                                                                        child: SizedBox(
                                                                                          height: 60
                                                                                              .sp,
                                                                                          width: 60
                                                                                              .sp,
                                                                                          child: Center(
                                                                                            child: Lottie
                                                                                                .asset(
                                                                                                'assets/animation/loading.json',
                                                                                                width: 40
                                                                                                    .sp,
                                                                                                fit: BoxFit
                                                                                                    .fitWidth),
                                                                                          ),
                                                                                        )),
                                                                              ),
                                                                              height: 85
                                                                                  .sp,
                                                                              width: 85
                                                                                  .sp,
                                                                            ),
                                                                            ),
                                                                            ),
                                                                            CustomText(
                                                                              e
                                                                                  .title,
                                                                              fontSize: 42
                                                                                  .sp,
                                                                              textAlign: TextAlign
                                                                                  .center,
                                                                            )
                                                                                .marginOnly(
                                                                                top: 15
                                                                                    .sp),
                                                                            WidgetUtil
                                                                                .getContainer(
                                                                                e
                                                                                    .message)
                                                                          ],
                                                                        )
                                                                            .marginSymmetric(
                                                                            vertical: 60
                                                                                .sp,
                                                                            horizontal: 20
                                                                                .sp)),
                                                                  ).onClick(
                                                                          () {
                                                                        Get
                                                                            .back();
                                                                        Get
                                                                            .toNamed(
                                                                            Routes
                                                                                .DASHBOARD +
                                                                                Routes
                                                                                    .PRODUCT_LIST_SCREEN +
                                                                                "?product_id=" +
                                                                                e
                                                                                    .id
                                                                                    .toString());
                                                                      });
                                                                }
                                                        )
                                                            .toList(),
                                                      ).marginOnly(
                                                          bottom: 150.sp).paddingOnly(
                                                          left: 20.sp, right: 20.sp)
                                                    ],
                                                  ),
                                                ))));
                                  },
                                ), isScrollControlled: true);
                              }
                            },
                            color: ColorUtils.blackLight,
                            child: Obx(() => CustomText(
                                  controller.total_balance != null &&
                                          controller.total_balance
                                              .toString()
                                              .isNotEmpty &&
                                          controller.total_balance
                                                  .toString()
                                                  .toDouble()! >=
                                              1.00
                                      ? withdraw_now.tr.toUpperCase()
                                      : add_lead_now.tr.toUpperCase(),
                                  style: TextStyle(
                                      color: ColorUtils.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 36.sp),
                                )),
                          ),
                        )
                      ],
                    ).marginSymmetric(horizontal: 40.sp, vertical: 30.sp),
                  ),
                  Expanded(
                    child: BasePageView(
                      controller: controller,
                      idleWidget: DefaultTabController(
                          length: 3,
                          child: Scaffold(
                            backgroundColor: Colors.transparent,
                            appBar: PreferredSize(
                              preferredSize: Size(double.infinity, 60),
                              child: Container(
                                  color: '#F3F1F6'.hexToColor(),
                                  child: TabBar(
                                      padding: EdgeInsets.zero,
                                      indicatorPadding: EdgeInsets.zero,
                                      controller: controller.pageController,
                                      labelColor: ColorUtils.orange,
                                      unselectedLabelColor: Colors.black,
                                      isScrollable: false,
                                      indicatorColor: Colors.black,
                                      tabs: [
                                        Tab(
                                          text: payout.tr,
                                        ),
                                        Tab(
                                          text: referral.tr,
                                        ),
                                        Tab(
                                          text: history.tr,
                                        )
                                      ])),
                            ),
                            body: TabBarView(
                              controller: controller.pageController,
                              children: [
                                tabPayout(),
                                tabReferral(),
                                tabHistory()
                              ],
                            ),
                          )),
                    ),
                  )
                ],
              )),
    );
  }

  checkCases(WalletTabController controller) {
    if (controller.user.is_adhar_verified == "0") {
      Get.dialog(WidgetUtil.showDialog(() async {
        Get.back();
        await Get.toNamed(Routes.MY_DETAIL + Routes.KYC_DETAILS);
        checkCases(controller);
      }, message: verify_aadhar_msg.tr, title: kyc.tr, button: 'GO'));
    } else if (controller.user.is_pan_verified == "0") {
      Get.dialog(WidgetUtil.showDialog(() async {
        Get.back();
        await Get.toNamed(Routes.MY_DETAIL + Routes.KYC_DETAILS);
        checkCases(controller);
      }, message: verify_pan_msg.tr, title: kyc.tr, button: 'GO'));
    } else if ((controller.user.relbank == null ||
            controller.user.relbank.status == "0") &&
        (controller.user.paytm_no_status == "0")) {
      Get.dialog(WidgetUtil.showDialog(() async {
        Get.back();
        await Get.toNamed(Routes.MY_DETAIL + Routes.BANK_DETAILS);
        checkCases(controller);
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

  Widget tabHistory() {
    return GetBuilder<WithdrawalController>(
      builder: (controller) => NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo is ScrollEndNotification &&
                scrollInfo.metrics.extentAfter == 0) {
              controller.fetchTransaction();
              return true;
            }
            return false;
          },
          child: BasePageView(
            errorOrEmptyWidget: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    no_withdrawal.tr,
                    fontweight: Weight.NORMAL,
                    fontSize: 50.sp,
                  ),
                  CustomText(
                    withdraw_show_here.tr,
                    fontweight: Weight.NORMAL,
                    fontSize: 38.sp,
                    textAlign: TextAlign.center,
                    color: ColorUtils.grey,
                  ).marginSymmetric(horizontal: 40.sp),
                  Image.asset(
                    'assets/images/new_images/wallet/no_earning_pic.png',
                    height: 500.sp,
                  ).marginSymmetric(vertical: 60.sp),
                ],
              ),
            ),
            idleWidget: RefreshIndicator(
                onRefresh: controller.onRefresh,
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                child: Scaffold(
                    appBar: null,
                    body: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Expanded(
                                child: Obx(() => ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(0),
                                      itemCount:
                                          controller.transactionList.length,
                                      itemBuilder: (BuildContext context,
                                              int position) =>
                                          ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        onTap: () {
                                          _showTdsBottomSheet(controller
                                              .transactionList[position]);
                                        },
                                        leading: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(30.sp),
                                                height: 120.sp,
                                                width: 120.sp,
                                                decoration: BoxDecoration(
                                                    color:
                                                        "#F5F6F8".hexToColor(),
                                                    shape: BoxShape.circle),
                                                child: SvgPicture.asset(
                                                  controller
                                                              .transactionList[
                                                                  position]
                                                              .transaction_type ==
                                                          "PayTm Wallet"
                                                      ? 'assets/images/new_images/wallet/paytm.svg'
                                                      : 'assets/images/new_images/wallet/bank.svg',
                                                  width: 100.sp,
                                                ),
                                              ),
                                            ]),
                                        title: Row(children: [
                                          Expanded(
                                              child: RichText(
                                                  textAlign: TextAlign.start,
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: controller
                                                                    .transactionList[
                                                                        position]
                                                                    .transaction_type !=
                                                                null
                                                            ? controller
                                                                    .transactionList[
                                                                        position]
                                                                    .transaction_type +
                                                                ' '
                                                            : "",
                                                        style: StyleUtils
                                                            .textStyleNormalPoppins(
                                                                color:
                                                                    ColorUtils
                                                                        .black,
                                                                weight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    42.sp)),
                                                    WidgetSpan(
                                                        child: SvgPicture.asset(
                                                      controller
                                                                  .transactionList[
                                                                      position]
                                                                  .status ==
                                                              "0"
                                                          ? "assets/images/new_images/profile_image/pending.svg"
                                                          : controller
                                                                      .transactionList[
                                                                          position]
                                                                      .status ==
                                                                  "1"
                                                              ? "assets/images/new_images/profile_image/check.svg"
                                                              : "assets/images/new_images/error.svg",
                                                      height: 40.sp,
                                                    )),
                                                    TextSpan(
                                                        text:
                                                            '\nTDS Deduction : ${Constant.RUPEE_SIGN + controller.transactionList[position].tds.toString()}',
                                                        style: StyleUtils
                                                            .textStyleNormalPoppins(
                                                                color: Colors
                                                                    .grey
                                                                    .shade600,
                                                                weight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    36.sp)),
                                                  ]))),
                                          Expanded(
                                              child: RichText(
                                                  textAlign: TextAlign.end,
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: "- ",
                                                        style: StyleUtils
                                                            .textStyleNormal(
                                                                color: Colors
                                                                    .red
                                                                    .shade700,
                                                                weight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    52.sp)),
                                                    TextSpan(
                                                        text: Constant
                                                                .RUPEE_SIGN +
                                                            controller
                                                                .transactionList[
                                                                    position]
                                                                .amount
                                                                .toString() +
                                                            "\n",
                                                        style: StyleUtils
                                                            .textStyleNormal(
                                                                color:
                                                                    ColorUtils
                                                                        .black,
                                                                weight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    44.sp)),
                                                    TextSpan(
                                                        text: TimeAgo.timeAgoSinceOnlyDate(
                                                            controller
                                                                .transactionList[
                                                                    position]
                                                                .updated_at
                                                                .toString()),
                                                        style: StyleUtils
                                                            .textStyleNormalPoppins(
                                                                color:
                                                                    ColorUtils
                                                                        .grey,
                                                                weight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    34.sp)),
                                                  ])))
                                        ]),
                                      ).paddingOnly(
                                              left: 40.sp,
                                              bottom: 20.sp,
                                              top: 20.sp,
                                              right: 40.sp),
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                          height: 1,
                                          color: ColorUtils.lightDivider,
                                        ).marginOnly(left: 25.sp, right: 25.sp);
                                      },
                                    ))),
                            Obx(() => Visibility(
                                  child: DefaultPageLoading(),
                                  visible: controller.pageState ==
                                      PageStates.PAGE_LOADING_MORE,
                                ))
                          ],
                        ).marginOnly(bottom: 20.sp)))),
            controller: controller,
          )),
    );
  }

  Widget tabReferral() {
    return GetBuilder<ReferralController>(builder: (controller) {
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo is ScrollEndNotification &&
                scrollInfo.metrics.extentAfter == 0) {
              controller.fetchTransaction();
              return true;
            }
            return false;
          },
          child: RefreshIndicator(
              onRefresh: controller.onRefresh,
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              child: BasePageView(
                  controller: controller,
                  errorOrEmptyWidget: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          refer_income_msg.tr,
                          fontweight: Weight.NORMAL,
                          fontSize: 50.sp,
                          textAlign: TextAlign.center,
                        ),
                        CustomText(
                          refer_income_shown_here.tr,
                          fontweight: Weight.NORMAL,
                          fontSize: 38.sp,
                          textAlign: TextAlign.center,
                          color: ColorUtils.grey,
                        ).marginSymmetric(horizontal: 40.sp),
                        Image.asset(
                          'assets/images/new_images/wallet/no_earning_pic.png',
                          height: 500.sp,
                        ).marginSymmetric(vertical: 60.sp),
                      ],
                    ),
                  ),
                  idleWidget: Scaffold(
                      appBar: null,
                      /*floatingActionButton: Card(
                              color: '#222222'.hexToColor(),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.sp)),
                              elevation: 5,
                              child: Container(
                                width: 120.sp,
                                height: 120.sp,
                                child: UnconstrainedBox(
                                  child: SvgPicture.asset(
                                    'assets/images/new_images/wallet/filter.svg',
                                    height: 45.sp,
                                    color: ColorUtils.white,
                                  ),
                                ),
                              ))
                          .onClick(() => Get.bottomSheet(filterDrawer(),
                              ignoreSafeArea: false, isScrollControlled: true))
                          .marginOnly(left: 40.sp),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.miniEndFloat,
                      */
                      body: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                child: Obx(() => ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(0),
                                      itemCount:
                                          controller.transactionList.length,
                                      itemBuilder: (BuildContext context,
                                              int position) =>
                                          ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        leading: Container(
                                          padding: EdgeInsets.all(30.sp),
                                          height: 120.sp,
                                          width: 120.sp,
                                          decoration: BoxDecoration(
                                              color: "#F5F6F8".hexToColor(),
                                              shape: BoxShape.circle),
                                          child: SvgPicture.asset(
                                            'assets/images/new_images/wallet/referal.svg',
                                            height: 56.sp,
                                            color: Colors.black,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                        title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                  textAlign: TextAlign.start,
                                                  text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: controller
                                                                        .transactionList[
                                                                            position]
                                                                        .name !=
                                                                    null
                                                                ? '' +
                                                                    controller
                                                                        .transactionList[
                                                                            position]
                                                                        .name
                                                                        .toLowerCase()
                                                                        .capitalizeFirst! +
                                                                    "\n"
                                                                : '\n',
                                                            style: StyleUtils
                                                                .textStyleNormalPoppins(
                                                                    color: ColorUtils
                                                                        .black,
                                                                    weight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        44.sp)),
                                                        TextSpan(
                                                            text: controller
                                                                        .transactionList[
                                                                            position]
                                                                        .earning !=
                                                                    null
                                                                ? Constant
                                                                        .RUPEE_SIGN +
                                                                    controller
                                                                        .transactionList[
                                                                            position]
                                                                        .earning
                                                                : '',
                                                            style: StyleUtils
                                                                .textStyleNormal(
                                                                    color:
                                                                        ColorUtils
                                                                            .grey,
                                                                    weight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        38.sp)),
                                                      ])),
                                              RichText(
                                                  textAlign: TextAlign.end,
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: Constant
                                                                .RUPEE_SIGN +
                                                            controller
                                                                .transactionList[
                                                                    position]
                                                                .amount
                                                                .toString() +
                                                            "\n",
                                                        style: StyleUtils
                                                            .textStyleNormal(
                                                                color:
                                                                    ColorUtils
                                                                        .black,
                                                                weight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    44.sp)),
                                                    TextSpan(
                                                        text: TimeAgo.timeAgoSinceOnlyDate(
                                                            controller
                                                                .transactionList[
                                                                    position]
                                                                .created_at),
                                                        style: StyleUtils
                                                            .textStyleNormalPoppins(
                                                                color:
                                                                    ColorUtils
                                                                        .grey,
                                                                weight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    34.sp)),
                                                  ]))
                                            ]),
                                      ).paddingOnly(
                                              left: 40.sp,
                                              bottom: 20.sp,
                                              top: 20.sp,
                                              right: 40.sp),
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                          height: 1,
                                          color: ColorUtils.lightDivider,
                                        ).marginOnly(left: 25.sp, right: 25.sp);
                                      },
                                    )),
                              ),
                              Obx(() => Visibility(
                                    child: DefaultPageLoading(),
                                    visible: controller.pageState ==
                                        PageStates.PAGE_LOADING_MORE,
                                  ))
                            ],
                          ).marginOnly(bottom: 20.sp))))));
    });
  }

  Widget tabPayout() {
    return GetBuilder<PayoutTransactionsController>(
        builder: (PayoutTransactionsController controller) {
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo is ScrollEndNotification &&
                scrollInfo.metrics.extentAfter == 0) {
              controller.fetchTransaction();
              return true;
            }
            return false;
          },
          child: RefreshIndicator(
              onRefresh: controller.onRefresh,
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              child: BasePageView(
                  idleWidget: Scaffold(
                      appBar: null,
                      body: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                child: Obx(() => ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.all(0),
                                      itemCount:
                                          controller.transactionList.length,
                                      itemBuilder: (BuildContext context,
                                              int position) =>
                                          ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        onTap: () {
                                          if (controller
                                                  .transactionList[position]
                                                  .on_task_amt !=
                                              null) {
                                            Get.bottomSheet(
                                                bottomSheetOnTaskPayout(
                                                    controller.transactionList[
                                                        position]));
                                          }
                                        },
                                        leading: Container(
                                          padding: EdgeInsets.all(30.sp),
                                          height: 120.sp,
                                          width: 120.sp,
                                          decoration: BoxDecoration(
                                              color: "#eceef2".hexToColor(),
                                              shape: BoxShape.circle),
                                          child: SvgPicture.asset(
                                            'assets/images/new_images/inr.svg',
                                            height: 56.sp,
                                            color: Colors.black,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                        title: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                  textAlign: TextAlign.start,
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: controller
                                                                    .transactionList[
                                                                        position]
                                                                    .name !=
                                                                null
                                                            ? controller
                                                                    .transactionList[
                                                                        position]
                                                                    .name
                                                                    .toLowerCase()
                                                                    .capitalizeFirst! +
                                                                " "
                                                            : " ",
                                                        style: StyleUtils
                                                            .textStyleNormalPoppins(
                                                                color:
                                                                    ColorUtils
                                                                        .black,
                                                                weight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    44.sp)),
                                                    WidgetSpan(
                                                      child: (controller
                                                                  .transactionList[
                                                                      position]
                                                                  .on_task_amt ==
                                                              null
                                                          ? Container()
                                                          : Icon(
                                                              controller
                                                                          .transactionList[
                                                                              position]
                                                                          .on_task_payout
                                                                          .toDouble()! >
                                                                      0
                                                                  ? Icons
                                                                      .check_circle_outline_outlined
                                                                  : Icons
                                                                      .info_outline,
                                                              size: 50.sp,
                                                              color: controller
                                                                  .transactionList[
                                                              position]
                                                                  .on_task_payout
                                                                  .toDouble()! >
                                                                  0?"#4caf50".hexToColor():"#ffb129".hexToColor(),
                                                            ).marginOnly(
                                                              top: 10.sp,
                                                              left: 10.sp)),
                                                    ),
                                                    TextSpan(
                                                        text: "\n" +
                                                            controller
                                                                .transactionList[
                                                                    position]
                                                                .adviser_name.toLowerCase()
                                                        .capitalizeFirst! ,
                                                        style: StyleUtils
                                                            .textStyleNormalPoppins(
                                                                color:
                                                                    ColorUtils
                                                                        .grey,
                                                                weight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    38.sp)),
                                                  ])),
                                              Spacer(),
                                              RichText(
                                                  textAlign: TextAlign.end,
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: Constant
                                                                .RUPEE_SIGN +
                                                            controller
                                                                .transactionList[
                                                                    position]
                                                                .amount
                                                                .toString() +
                                                            "\n",
                                                        style: StyleUtils
                                                            .textStyleNormal(
                                                                color:
                                                                    ColorUtils
                                                                        .black,
                                                                weight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    44.sp)),
                                                    TextSpan(
                                                        text: TimeAgo.timeAgoSinceOnlyDate(
                                                            controller
                                                                .transactionList[
                                                                    position]
                                                                .created_at),
                                                        style: StyleUtils
                                                            .textStyleNormalPoppins(
                                                                color:
                                                                    ColorUtils
                                                                        .grey,
                                                                weight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    34.sp)),
                                                  ]))
                                            ]),
                                      ).paddingOnly(
                                              left: 40.sp,
                                              bottom: 20.sp,
                                              top: 20.sp,
                                              right: 40.sp),
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                          height: 1,
                                          color: ColorUtils.lightDivider,
                                        ).marginOnly(left: 25.sp, right: 25.sp);
                                      },
                                    )),
                              ),
                              Obx(() => Visibility(
                                    child: DefaultPageLoading(),
                                    visible: controller.pageState ==
                                        PageStates.PAGE_LOADING_MORE,
                                  ))
                            ],
                          ).marginOnly(bottom: 20.sp))),
                  errorOrEmptyWidget: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          add_first_lead_to_start_earning.tr,
                          fontweight: Weight.NORMAL,
                          textAlign: TextAlign.center,
                          fontSize: 50.sp,
                        ),
                        CustomText(
                          comission_shown_here.tr,
                          fontweight: Weight.NORMAL,
                          fontSize: 38.sp,
                          textAlign: TextAlign.center,
                          color: ColorUtils.grey,
                        ).marginSymmetric(horizontal: 40.sp),
                        Image.asset(
                          'assets/images/new_images/wallet/no_earning_pic.png',
                          height: 500.sp,
                        ).marginSymmetric(vertical: 60.sp),
                      ],
                    ),
                  ),
                  controller: controller)));
    });
  }

  Widget filterDrawer() {
    final selectedFilter = 'Sort'.obs;
    // DateTime? fromDate = controller.fromDateController.text.toDateTime();
    // DateTime? toDate = controller.toDateController.text.toDateTime();
    final _selectedTime = /*controller.selectedTime*/ 1.obs;
    //
    RxBool isSortByDate = /*controller.isSortByDate*/ false.obs;
    //
    // DateRangePickerController dateController = DateRangePickerController();
    List filterType = ["Sort", "Time"];
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 40.sp),
                      child: Stack(
                        children: [
                          Center(
                            child: CustomText(
                              "Filter Referral",
                              fontSize: 48.sp,
                            ),
                          ),
                          Align(
                            child: SvgPicture.asset(
                                    'assets/images/ic_back_arrow.svg')
                                .marginOnly(left: 40.sp)
                                .onClick(() => Get.back(), showEffect: false),
                            alignment: Alignment.centerLeft,
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        Container(
                          color: "#F8F8F8".hexToColor(),
                          child: Column(
                              children: filterType
                                  .map(
                                    (e) => Obx(() => Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: selectedFilter.value == e
                                                  ? ColorUtils.orange
                                                  : ColorUtils.white,
                                              border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width: .5)),
                                          width: Get.width * .25,
                                          height: 200.sp,
                                          child: CustomText(
                                            e,
                                            color: selectedFilter.value == e
                                                ? ColorUtils.white
                                                : ColorUtils.textColor,
                                          ),
                                        ).onClick(
                                            () => selectedFilter.value = e)),
                                  )
                                  .toList()),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Obx(() {
                                int index =
                                    filterType.indexOf(selectedFilter.value);
                                Widget widget = Container();
                                if (index == 0) {
                                  widget = Expanded(
                                    child: Column(
                                      children: [
                                        Obx(() => WidgetUtil.getRadio(
                                                onTap: () {
                                                  isSortByDate.value = true;
                                                },
                                                isSelected: isSortByDate.value,
                                                label: "Recent Added"))
                                            .marginAll(30.sp),
                                        Obx(() => WidgetUtil.getRadio(
                                                onTap: () {
                                                  isSortByDate.value = false;
                                                },
                                                isSelected: !isSortByDate.value,
                                                label: "Top Earner"))
                                            .marginAll(30.sp),
                                      ],
                                    ),
                                  );
                                } else if (index == 1) {
                                  widget = Expanded(
                                      child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Obx(
                                          () => Wrap(
                                            alignment: WrapAlignment.start,
                                            direction: Axis.horizontal,
                                            spacing: 0,
                                            children: [
                                              ActionChip(
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: _selectedTime
                                                                    .value ==
                                                                1
                                                            ? ColorUtils.orange
                                                            : ColorUtils
                                                                .greylight,
                                                        width: .5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60.sp)),
                                                label: CustomText(
                                                  'Last 7 Days',
                                                  fontweight: Weight.LIGHT,
                                                  fontSize: 36.sp,
                                                  color: _selectedTime.value ==
                                                          1
                                                      ? ColorUtils.white
                                                      : ColorUtils.textColor,
                                                ),
                                                labelPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 30.sp),
                                                backgroundColor:
                                                    _selectedTime.value == 1
                                                        ? ColorUtils.orange
                                                        : Colors.grey.shade200,
                                                onPressed: () {
                                                  /* toDate = DateTime.now();
                                                          fromDate = DateTime.now();
                                                          fromDate = fromDate!
                                                              .subtract(6.days);

                                                          dateController.selectedRange =
                                                              PickerDateRange(
                                                                  fromDate, toDate);

                                                          print(fromDate!.toUiDate());*/
                                                  _selectedTime.value = 1;
                                                },
                                              ).marginSymmetric(
                                                horizontal: 10.sp,
                                              ),
                                              ActionChip(
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: _selectedTime
                                                                    .value ==
                                                                2
                                                            ? ColorUtils.orange
                                                            : ColorUtils
                                                                .greylight,
                                                        width: .5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60.sp)),
                                                label: CustomText(
                                                  'Last 30 Days',
                                                  fontweight: Weight.LIGHT,
                                                  fontSize: 36.sp,
                                                  color: _selectedTime.value ==
                                                          2
                                                      ? ColorUtils.white
                                                      : ColorUtils.textColor,
                                                ),
                                                labelPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 30.sp),
                                                backgroundColor:
                                                    _selectedTime.value == 2
                                                        ? ColorUtils.orange
                                                        : Colors.grey.shade200,
                                                onPressed: () {
                                                  _selectedTime.value = 2;
                                                  /* toDate = DateTime.now();
                                                          fromDate = DateTime.now();
                                                          fromDate = fromDate!
                                                              .subtract(29.days);
                                                          dateController.selectedRange =
                                                              PickerDateRange(
                                                                  fromDate, toDate);

                                                          print(fromDate!.toUiDate());*/
                                                },
                                              ).marginSymmetric(
                                                horizontal: 10.sp,
                                              ),
                                              ActionChip(
                                                  shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: _selectedTime
                                                                      .value ==
                                                                  3
                                                              ? ColorUtils
                                                                  .orange
                                                              : ColorUtils
                                                                  .greylight,
                                                          width: .5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60.sp)),
                                                  label: CustomText(
                                                    'Select Date',
                                                    fontweight: Weight.LIGHT,
                                                    fontSize: 36.sp,
                                                    color:
                                                        _selectedTime.value == 3
                                                            ? ColorUtils.white
                                                            : ColorUtils
                                                                .textColor,
                                                  ),
                                                  labelPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 30.sp),
                                                  backgroundColor:
                                                      _selectedTime.value == 3
                                                          ? ColorUtils.orange
                                                          : Colors
                                                              .grey.shade200,
                                                  onPressed: () {
                                                    _selectedTime.value = 3;
                                                  }).marginSymmetric(
                                                horizontal: 10.sp,
                                              ),
                                              /*Obx(() => IgnorePointer(
                                                        ignoring:
                                                        _selectedTime.value !=
                                                            3,
                                                        child: Container(
                                                          width:
                                                          constraints.maxWidth *
                                                              .7,
                                                          child: SfDateRangePicker(
                                                            controller:
                                                            dateController,
                                                            onSelectionChanged:
                                                                (args) {
                                                              fromDate = (args.value
                                                              as PickerDateRange)
                                                                  .startDate;
                                                              toDate = (args.value
                                                              as PickerDateRange)
                                                                  .endDate;
                                                            },
                                                            maxDate: DateTime.now(),
                                                            selectionMode:
                                                            DateRangePickerSelectionMode
                                                                .range,
                                                            initialSelectedRange:
                                                            PickerDateRange(
                                                                fromDate,
                                                                toDate),
                                                          ),
                                                        ),
                                                      ))*/
                                            ],
                                          ).marginSymmetric(
                                              horizontal: 20.sp,
                                              vertical: 40.sp),
                                        ),
                                      ],
                                    ),
                                  ));
                                }
                                return widget;
                              }),
                              Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100.sp),
                                          border: Border.all(
                                              color: Colors.grey.shade500,
                                              width: 1)),
                                      child: CustomText(
                                        'CLEAR ALL',
                                        fontweight: Weight.LIGHT,
                                        color: Colors.grey.shade700,
                                      )
                                          .marginSymmetric(
                                              horizontal: 40.sp,
                                              vertical: 20.sp)
                                          .onClick(() {
                                        Get.back();

                                        // controller.toDateController.text = "";
                                        // controller.fromDateController.text = "";
                                        // controller.isSortByDate = true;
                                        // controller.selectedTime = 0;
                                        // controller.currentPage = 1;
                                        // controller.fetchTeam();
                                      }, showEffect: false),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: ColorUtils.orange,
                                          borderRadius:
                                              BorderRadius.circular(100.sp),
                                          border: Border.all(
                                              color: ColorUtils.orange,
                                              width: 1)),
                                      child: CustomText(
                                        '\t\t\tFilter\t\t\t',
                                        fontweight: Weight.LIGHT,
                                        color: Colors.white,
                                      )
                                          .marginSymmetric(
                                              horizontal: 40.sp,
                                              vertical: 20.sp)
                                          .onClick(() {
                                        Get.back();
                                        try {
                                          print("DONE DONE");

                                          /*controller.toDateController.text =
                                              toDate == null
                                                  ? ""
                                                  : toDate!.toServerDate()!;
                                              controller.fromDateController.text =
                                              fromDate == null
                                                  ? ""
                                                  : fromDate!.toServerDate()!;
                                              controller.isSortByDate =
                                                  isSortByDate.value;
                                              controller.selectedTime =
                                                  _selectedTime.value;
                                              controller.currentPage = 1;
                                              print("DONE DONE");
                                              controller.fetchTeam();
                                            */
                                        } catch (e) {
                                          print(e);
                                        }
                                      }, showEffect: false),
                                    )
                                  ])
                                  .marginAll(40.sp)
                                  .alignTo(Alignment.bottomRight)
                            ],
                          ),
                        )
                      ],
                    )),
                  ],
                ));
          },
        ),
      ),
    );
  }

  Widget withDrawDialog(WalletTabController controller) {
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
                                    Icon(Icons.info_outlined,size: 20,  color: '#ffb129'.hexToColor()),
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
                                    Icon(Icons.info_outlined,size: 20,  color: '#ffb129'.hexToColor()),
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
                          Get.back();
                          await controller.withDrawToWallet(controller.user.paytm_mobile_no);
                        } else {
                          Get.back();
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

  void _showTdsBottomSheet(WithdrawalTransections transaction) {
    Widget bottomSheet = LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Padding(
          padding: EdgeInsets.symmetric(
              horizontal:
                  ScreenUtil().screenHeight / ScreenUtil().screenWidth < 1.30
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
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    SizedBox(height: 30.sp),
                    Row(
                      children: [
                        CustomText(
                          'Payout Transferred',
                          fontSize: 52.sp,
                        ),
                        SvgPicture.asset(
                          transaction.status == "0"
                              ? "assets/images/new_images/profile_image/pending.svg"
                              : transaction.status == "1"
                                  ? "assets/images/new_images/profile_image/check.svg"
                                  : "assets/images/new_images/error.svg",
                          height: 50.sp,
                        ).marginOnly(left: 20.sp),
                        Spacer(),
                        Container(
                          height: 72.sp,
                          width: 72.sp,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.sp),
                              border:
                                  Border.all(width: 1, color: Colors.black)),
                          child: Icon(
                            Icons.clear,
                            color: Colors.black,
                            size: 48.sp,
                          ),
                        ).onClick(() => Get.back()),
                      ],
                    ).marginSymmetric(horizontal: 60.sp, vertical: 30.sp),
                    Divider(),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/ic_check.svg',
                          width: 50.sp,
                        ),
                        CustomText(
                          'Withdraw Date : ',
                          fontSize: 34.sp,
                          fontweight: Weight.BOLD,
                        ).marginSymmetric(horizontal: 30.sp),
                        Spacer(),
                        CustomText(
                          DateTime.parse(
                            transaction.created_at,
                          ).toFormat('dd MMMM yyyy | hh:mm a'),
                          fontSize: 34.sp,
                          color: ColorUtils.grey,
                        )
                      ],
                    ).marginSymmetric(horizontal: 40.sp),
                    Container(
                      width: .8,
                      height: 30.sp,
                      color: "#3bb54a".hexToColor(),
                    ).marginOnly(left: 65.sp),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/ic_check.svg',
                          width: 50.sp,
                        ),
                        CustomText(
                          'Updated Date : ',
                          fontSize: 34.sp,
                          fontweight: Weight.BOLD,
                        ).marginSymmetric(horizontal: 30.sp),
                        Spacer(),
                        CustomText(
                          DateTime.parse(
                            transaction.updated_at,
                          ).toFormat('dd MMMM yyyy | hh:mm a'),
                          fontSize: 34.sp,
                          color: ColorUtils.grey,
                        )
                      ],
                    ).marginSymmetric(horizontal: 40.sp),
                    Container(
                      padding: EdgeInsets.all(30.sp),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.shade200, width: 1),
                          borderRadius: BorderRadius.circular(30.sp)),
                      child: Column(
                        children: [
                          SizedBox(height: 10.sp),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText('Transaction ID'),
                                  CustomText(
                                    transaction.order_id,
                                    color: Colors.grey,
                                    fontweight: Weight.LIGHT,
                                  )
                                ],
                              )),
                              Container(
                                padding: EdgeInsets.all(30.sp),
                                height: 120.sp,
                                width: 120.sp,
                                decoration: BoxDecoration(
                                    color: "#F5F6F8".hexToColor(),
                                    shape: BoxShape.circle),
                                child: SvgPicture.asset(
                                  transaction.transaction_type == "PayTm Wallet"
                                      ? 'assets/images/new_images/wallet/paytm.svg'
                                      : 'assets/images/new_images/wallet/bank.svg',
                                  width: 100.sp,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10.sp),
                          Divider(),
                          SizedBox(height: 10.sp),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                'Total Payout',
                                color: "#6c7483".hexToColor(),
                                fontweight: Weight.NORMAL,
                              ),
                              CustomText(
                                Constant.RUPEE_SIGN +
                                    transaction.amount.toString(),
                                color: "#6c7483".hexToColor(),
                                fontweight: Weight.NORMAL,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.sp),
                          Row(
                            children: [
                              CustomText(
                                'TDS Deduction (5%) ',
                                color: "#6c7483".hexToColor(),
                                fontweight: Weight.NORMAL,
                              ),
                              Spacer(),
                              CustomText(
                                Constant.RUPEE_SIGN +
                                    transaction.tds.toString(),
                                color: "#6c7483".hexToColor(),
                                fontweight: Weight.NORMAL,
                              ),
                            ],
                          ),
                          SizedBox(height: 20.sp),
                          Container(
                              margin: EdgeInsets.all(10.sp),
                              padding: EdgeInsets.all(30.sp),
                              decoration: BoxDecoration(
                                  color: "#F5F6F8".hexToColor(),
                                  border: Border.all(
                                      color: "#F5F6F8".hexToColor(), width: 1),
                                  borderRadius: BorderRadius.circular(30.sp)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    'Why TDS deducted from my Payout?'
                                        .toUpperCase(),
                                    fontSize: 38.sp,
                                    color: "#285477".hexToColor(),
                                  ).onClick(() async {
                                    Get.back();
                                    await Get.toNamed(
                                        Routes.MY_DETAIL + Routes.TDS_INFO);
                                    _showTdsBottomSheet(transaction);
                                  }),
                                  Icon(
                                    Icons.chevron_right_outlined,
                                    color: "#285477".hexToColor(),
                                    size: 50.sp,
                                  )
                                ],
                              )),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                'Amount Transferred',
                                fontweight: Weight.BOLD,
                              ),
                              CustomText(
                                Constant.RUPEE_SIGN + (transaction.amount - transaction.tds).toStringAsFixed(2),
                                fontweight: Weight.BOLD,
                              ),
                            ],
                          ).marginSymmetric(vertical: 30.sp),
                        ],
                      ),
                    ).marginAll(40.sp)
                  ]))));
    });
    Get.bottomSheet(bottomSheet, isScrollControlled: true);
  }

  Widget bottomSheetOnTaskPayout(LeadTransactions transaction) {
    return Card(
        color: ColorUtils.white,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: ColorUtils.white_bg,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60.sp),
                topRight: Radius.circular(60.sp))),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                "Payout Received",
                color: ColorUtils.black,
                customTextStyle: CustomTextStyle.MEDIUM,
              ),
              Icon(
                transaction.on_task_payout
                    .toDouble()! >
                    0
                    ? Icons
                    .check_circle_outline_outlined
                    : null,
                color: transaction.on_task_payout
                    .toDouble()! >
                    0?"#4caf50".hexToColor():"#e8d56b".hexToColor(),
                size: 64.sp,
              ).marginOnly(left: 30.sp),
              Spacer(),
              Container(
                height: 72.sp,
                width: 72.sp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.sp),
                    border: Border.all(width: 1, color: Colors.black)),
                child: Icon(
                  Icons.clear,
                  color: Colors.black,
                  size: 48.sp,
                ),
              ).onClick(() => Get.back())
            ],
          ).paddingOnly(left: 60.sp, top: 60.sp, right: 60.sp),
          Divider(
            height: 120.sp,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText('Account Opening Payout'),
              CustomText(
                Constant.RUPEE_SIGN + transaction.amount,
              )
            ],
          ).marginSymmetric(horizontal: 60.sp),
          CustomText(
            'Date : ${transaction.created_at.serverToDateTime().toFormat('dd MMM yyyy | hh:mm')}',
            color: Colors.grey.shade500,
            fontSize: 34.sp,fontweight: FontWeight.w400,
          ).marginSymmetric(horizontal: 60.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomText(transaction.on_task_title),
              Expanded(child:RichText(
                textAlign: TextAlign.start,
                text: TextSpan(children: [
                  TextSpan(
                    text: transaction.on_task_title + '',
                    style: StyleUtils.textStyleNormalPoppins(
                        fontSize: 42.sp,weight: FontWeight.w500),
                  ),
                  WidgetSpan(
                      child: Icon(
                        transaction.on_task_payout
                            .toDouble()! >
                            0
                            ? null :Icons
                            .info_outline,
                        color: transaction.on_task_payout
                            .toDouble()! >
                            0?"#4caf50".hexToColor():"#ffb129".hexToColor(),
                        size: 48.sp,
                      ).marginOnly(left: 20.sp)),
                  TextSpan(
                    text: transaction.on_task_payout.toDouble() != 0
                        ?'\nDate : ${transaction.created_at.serverToDateTime().toFormat('dd MMM yyyy | hh:mm')}'
                        :'\nGet extra payout when customer will do first trade.',
                    style: StyleUtils.textStyleNormalPoppins(color: Colors.grey.shade500,
                      fontSize: 34.sp,weight: FontWeight.w400),
                  ),
                ]),
              ).marginOnly(right: 10.sp)),
              transaction.on_task_payout.toDouble() != 0
                  ? CustomText(
                      Constant.RUPEE_SIGN + transaction.on_task_payout,
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: ColorUtils.orange_deep,
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      padding: EdgeInsets.fromLTRB(50.sp, 15.sp, 50.sp, 15.sp),
                      child: CustomText(
                        'Ping Customer',
                        color: Colors.white,
                        fontSize: 38.sp,
                      ),
                    ).onClick(() async {
                      String url =
                          "https://wa.me/91${transaction.mobile_no}/?text=${transaction.message}";
                      if (await canLaunch(Uri.encodeFull(url))) {
                        await launch(Uri.encodeFull(url));
                      }
                    })
            ],
          ).marginSymmetric(horizontal: 60.sp, vertical: 40.sp),
          Divider(
            height: 30.sp,
            thickness: 1,
          ).marginSymmetric(horizontal: 60.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText('Total Payout Received'),
              CustomText(
                Constant.RUPEE_SIGN +
                    "${(transaction.amount.toDouble()! + transaction.on_task_payout.toDouble()!).toString()}",
              )
            ],
          ).marginOnly(left: 60.sp, right: 60.sp, bottom: 60.sp, top: 40.sp),
        ])));
  }
}
