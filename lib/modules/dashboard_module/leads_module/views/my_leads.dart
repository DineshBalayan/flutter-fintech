import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/response/GetMyLeadsResponse.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/controllers/my_leads_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/views/dashboard.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_scaffold.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MyLeadScreen extends GetView<MyLeadsController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: MyLeads(
        isPage: true,
      ),
      title: leads.tr,
    );
  }
}

class MyLeads extends GetView<MyLeadsController> {
  final bool isPage;

  MyLeads({this.isPage = false});

  Widget _leadsWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(() => Container(
                  width: Get.width / 3.5,
                  height: Get.width / 4.3,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.sp),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: onGoingLeadController.selectedStatus ==
                                onGoingLeadController.statusList[3]
                            ? [
                                ColorUtils.orange_gr_light,
                                ColorUtils.orange_gr_light,
                                ColorUtils.orange_gr_dark,
                              ]
                            : [
                                ColorUtils.black_gr_dark,
                                ColorUtils.black_gr_light,
                              ]),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                          top: 0.sp,
                          left: 0.sp,
                          child: SizedBox(
                              width: Get.width / 3.5,
                              height: 80.sp,
                              child: SvgPicture.asset(
                                'assets/images/new_images/curve_team.svg',
                                fit: BoxFit.fill,
                                color: onGoingLeadController.selectedStatus ==
                                        onGoingLeadController.statusList[3]
                                    ? ColorUtils.orange_shadow
                                    : ColorUtils.black_shadow,
                              ))),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() => CustomText(
                                onGoingLeadController.total_leads.value,
                                fontSize: 65.sp,
                                color: ColorUtils.white,
                              )),
                          CustomText(
                            total_leads.tr.toUpperCase(),
                            color: ColorUtils.white_bg,
                            textAlign: TextAlign.center,
                            fontSize: 34.sp,
                          )
                        ],
                      ).paddingAll(Get.width / 65),
                    ],
                  )).onClick(() {
                onGoingLeadController.selectedProductsList = [];
                onGoingLeadController.isAnyMoreFilter.value = 0;
                onGoingLeadController.selectedTime = 0;
                onGoingLeadController.currentPage = 1;
                onGoingLeadController.selectedStatus =
                    onGoingLeadController.statusList[3];
                onGoingLeadController.fetchLeads();
              })),
          Obx(() => Container(
                  width: Get.width / 3.5,
                  height: Get.width / 4.3,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.sp),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: onGoingLeadController.selectedStatus ==
                                onGoingLeadController.statusList[0]
                            ? [
                                ColorUtils.orange_gr_light,
                                ColorUtils.orange_gr_light,
                                ColorUtils.orange_gr_dark,
                              ]
                            : [
                                ColorUtils.black_gr_dark,
                                ColorUtils.black_gr_light,
                              ]),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                          top: 0.sp,
                          left: 0.sp,
                          child: SizedBox(
                              width: Get.width / 3.5,
                              height: 80.sp,
                              child: SvgPicture.asset(
                                'assets/images/new_images/curve_team.svg',
                                fit: BoxFit.fill,
                                color: onGoingLeadController.selectedStatus ==
                                        onGoingLeadController.statusList[0]
                                    ? ColorUtils.orange_shadow
                                    : ColorUtils.black_shadow,
                              ))),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() => CustomText(
                                onGoingLeadController.inprocess_leads.value,
                                fontSize: 65.sp,
                                color: ColorUtils.white,
                              )),
                          CustomText(
                            leads_ongoing.tr.toUpperCase(),
                            color: ColorUtils.white_bg,
                            textAlign: TextAlign.center,
                            fontSize: 34.sp,
                          ).alignTo(Alignment.center)
                        ],
                      ).paddingAll(Get.width / 65),
                    ],
                  )).onClick(() {
                onGoingLeadController.selectedProductsList = [];
                onGoingLeadController.isAnyMoreFilter.value = 0;
                onGoingLeadController.selectedTime = 0;
                onGoingLeadController.currentPage = 1;
                onGoingLeadController.selectedStatus =
                    onGoingLeadController.statusList[0];
                onGoingLeadController.fetchLeads();
              })),
          Obx(() => Container(
                  width: Get.width / 3.5,
                  height: Get.width / 4.3,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.sp),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: onGoingLeadController.selectedStatus ==
                                onGoingLeadController.statusList[1]
                            ? [
                                ColorUtils.orange_gr_light,
                                ColorUtils.orange_gr_light,
                                ColorUtils.orange_gr_dark,
                              ]
                            : [
                                ColorUtils.black_gr_dark,
                                ColorUtils.black_gr_light,
                              ]),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                          top: 0.sp,
                          right: 0.sp,
                          child: SizedBox(
                              width: Get.width / 3.5,
                              height: 80.sp,
                              child: SvgPicture.asset(
                                'assets/images/new_images/curve_team.svg',
                                fit: BoxFit.fill,
                                color: onGoingLeadController.selectedStatus ==
                                        onGoingLeadController.statusList[1]
                                    ? ColorUtils.orange_shadow
                                    : ColorUtils.black_shadow,
                              ))),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() => CustomText(
                                onGoingLeadController.completed_leads.value,
                                fontSize: 65.sp,
                                color: ColorUtils.white,
                              )),
                          CustomText(
                            leads_completed.tr.toUpperCase(),
                            color: ColorUtils.white_bg,
                            textAlign: TextAlign.center,
                            fontSize: 34.sp,
                          ).alignTo(Alignment.center)
                        ],
                      ).paddingAll(Get.width / 65),
                    ],
                  )).onClick(() {
                onGoingLeadController.selectedProductsList = [];
                onGoingLeadController.isAnyMoreFilter.value = 0;
                onGoingLeadController.selectedTime = 0;
                onGoingLeadController.currentPage = 1;
                onGoingLeadController.selectedStatus =
                    onGoingLeadController.statusList[1];
                onGoingLeadController.fetchLeads();
              })),
        ],
      );

  OnGoingLeadController onGoingLeadController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          alignment: Alignment.topRight,
          child: SafeArea(
              child: SvgPicture.asset(
            'assets/images/new_images/top_curve.svg',
            color: ColorUtils.topCurveColor,
            width: Get.width * .8,
          )),
        ).visibility(!isPage),
        Column(children: [
          _leadsWidget().marginOnly(top: isPage ? 30.sp : 60.sp),
          Expanded(
              child: _onGoingTab(onGoingLeadController).marginOnly(top: 10.sp))
        ])
      ],
    ));
  }

  Widget _completedTab(CompletedLeadController completedLeadController) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.sp),
        child: _statusFilterRow(completedLeadController),
      ),
      body: BasePageView(
        controller: completedLeadController,
        idleWidget: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo is ScrollEndNotification &&
                  scrollInfo.metrics.extentAfter == 0) {
                completedLeadController.fetchLeads();
                return true;
              }
              return false;
            },
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Obx(() => completedLeadController.leadList == null ||
                            completedLeadController.leadList.length == 0
                        ? emptyWidget(completedLeadController)
                            .marginOnly(top: 20.sp)
                        : Obx(() => ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: completedLeadController.leadList == null
                                ? 0
                                : completedLeadController.leadList.length,
                            itemBuilder: (context, position) {
                              return position ==
                                      onGoingLeadController.leadList.length
                                  ? SizedBox(
                                      height: 200.sp,
                                    )
                                  : getLeadWidget(
                                      completedLeadController
                                          .leadList[position],
                                      false);
                            }).marginOnly(top: 1.sp)))),
                Obx(() => Visibility(
                      child: DefaultPageLoading(),
                      visible: completedLeadController.pageState ==
                          PageStates.PAGE_LOADING_MORE,
                    ))
              ],
            )),
        errorOrEmptyWidget: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                add_lead_earn.tr,
                fontweight: Weight.NORMAL,
                fontSize: 50.sp,
              ),
              CustomText(
                your_leads_will_shown.tr,
                fontweight: Weight.NORMAL,
                fontSize: 38.sp,
                textAlign: TextAlign.center,
                color: ColorUtils.grey,
              ).marginSymmetric(horizontal: 40.sp),
              Lottie.asset('assets/animation/trophy_man.json',
                      height: 500.sp, fit: BoxFit.fitWidth)
                  .marginSymmetric(vertical: 60.sp),
              /*   Image.asset(
                'assets/images/new_images/wallet/no_earning_pic.png',
                height: 500.sp,
              ).marginSymmetric(vertical: 60.sp),*/
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.sp),
                    border: Border.all(color: ColorUtils.textColor, width: 1)),
                child: CustomText(
                  add_lead_now.tr,
                  color: ColorUtils.textColor,
                  fontSize: 42.sp,
                ).paddingSymmetric(horizontal: 80.sp, vertical: 30.sp),
              ).marginOnly(top: 20.sp).onClick(() {
                WidgetUtil.addLeadView();
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _onGoingTab(OnGoingLeadController onGoingLeadController) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.sp),
        child: _statusFilterRow(onGoingLeadController),
      ),
      body: BasePageView(
        controller: onGoingLeadController,
        idleWidget: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo is ScrollEndNotification &&
                  scrollInfo.metrics.extentAfter == 0) {
                onGoingLeadController.fetchLeads();
                return true;
              }
              return false;
            },
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Expanded(
                    child: Obx(() => onGoingLeadController.leadList == null ||
                            onGoingLeadController.leadList.length == 0
                        ? emptyWidget(onGoingLeadController)
                            .marginOnly(top: 20.sp)
                        : Obx(() => ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: onGoingLeadController.leadList == null
                                ? 0
                                : onGoingLeadController.leadList.length + 1,
                            itemBuilder: (context, position) {
                              return position ==
                                      onGoingLeadController.leadList.length
                                  ? SizedBox(
                                      height: 200.sp,
                                    )
                                  : getLeadWidget(
                                      onGoingLeadController.leadList[position],
                                      true);
                            }).marginOnly(top: 1.sp)))),
                Obx(() => Visibility(
                      child: DefaultPageLoading(),
                      visible: onGoingLeadController.pageState ==
                          PageStates.PAGE_LOADING_MORE,
                    ))
              ],
            )),
        errorOrEmptyWidget: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                add_lead_earn.tr,
                fontweight: Weight.NORMAL,
                fontSize: 50.sp,
              ),
              CustomText(
                your_leads_will_shown.tr,
                fontweight: Weight.NORMAL,
                fontSize: 38.sp,
                textAlign: TextAlign.center,
                color: ColorUtils.grey,
              ).marginSymmetric(horizontal: 40.sp),
              Lottie.asset('assets/animation/trophy_man.json',
                  height: 600.sp, fit: BoxFit.fitWidth),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.sp),
                    border: Border.all(color: ColorUtils.textColor, width: 1)),
                child: CustomText(
                  add_lead_now.tr,
                  color: ColorUtils.textColor,
                  fontSize: 42.sp,
                ).paddingSymmetric(horizontal: 80.sp, vertical: 30.sp),
              ).marginOnly(top: 20.sp).onClick(() {
                WidgetUtil.addLeadView();
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusFilterRow(MyLeadsController con) {
    return Padding(
      padding: EdgeInsets.only(top: 50.sp),
      child: SizedBox(
        width: Get.width,
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(() => Row(
                      children: con.statusList
                          .map((e) => e.second != ""
                              ? ActionChip(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.sp),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: con.selectedStatus == e
                                              ? ColorUtils.orange
                                              : ColorUtils.black,
                                          width: .5),
                                      borderRadius:
                                          BorderRadius.circular(100.sp)),
                                  label: CustomText(
                                    e.second,
                                    fontweight: Weight.LIGHT,
                                    fontSize: 36.sp,
                                    color: con.selectedStatus != e
                                        ? ColorUtils.textColor
                                        : ColorUtils.orange,
                                  ),
                                  labelPadding:
                                      EdgeInsets.symmetric(horizontal: 30.sp),
                                  backgroundColor: ColorUtils.white,
                                  onPressed: () {
                                    con.selectedStatus = e;
                                    con.currentPage = 1;
                                    con.fetchLeads();
                                  },
                                ).marginSymmetric(horizontal: 8.sp)
                              : Container())
                          .toList(),
                    )),
              ),
            ),
            Container(
              width: 100.sp,
              height: 100.sp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.sp),
                  color: ColorUtils.orange),
              child: UnconstrainedBox(
                child: SvgPicture.asset(
                  'assets/images/new_images/wallet/filter.svg',
                  height: 45.sp,
                  color: Colors.white,
                ),
              ),
            )
                .onClick(() => Get.bottomSheet(filterDrawer(con),
                    ignoreSafeArea: false, isScrollControlled: true))
                .marginOnly(left: 40.sp),
          ],
        ).marginSymmetric(horizontal: 30.sp),
      ),
    );
  }

  Widget getLeadWidget(Lead lead, bool isOnGoing) {
    return Card(
      margin: EdgeInsets.all(30.sp),
      elevation: 30.sp,
      shadowColor: ColorUtils.lightShade.withAlpha(70),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.sp))),
      child: Stack(children: [
        Container(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomImage.network(lead.logo,
                              height: 150.sp,
                              width: 150.sp,
                              errorWidget: Container(
                                height: 150.sp,
                                width: 150.sp,
                                decoration: BoxDecoration(
                                    color: '#fcf1ed'.hexToColor(),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                padding: EdgeInsets.all(15),
                                child: SvgPicture.asset(
                                  'assets/images/new_images/bank.svg',
                                  height: 50.sp,
                                  width: 50.sp,
                                  color: ColorUtils.blackLightTrans,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              fit: BoxFit.fill),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                lead.customer_name.capitalizeFirst.toString(),
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                fontSize: 42.sp,
                                fontweight: Weight.BOLD,
                              ),
                              CustomText(
                                lead.mobile_no,
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                fontweight: Weight.LIGHT,
                                fontSize: 38.sp,
                              ),
                            ],
                          ).marginOnly(left: 45.sp),
                        ],
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: ColorUtils.white,
                              border: Border.all(
                                  color: '#6D6679'.hexToColor(), width: 0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                              child: CustomText(
                                lead.created_at.toDDMMMYYYY(),
                                fontSize: 30.sp,
                                color: '#6D6679'.hexToColor(),
                              ),
                            ),
                          )).marginOnly(left: 20.sp, right: 20.sp)
                    ]),
                SizedBox(height: 10),
                Container(
                  width: double.maxFinite,
                  padding: lead.lead_status.capitalize
                      .toString()== 'User Action Required'
                      ? EdgeInsets.all(0):EdgeInsets.all(5),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      color: lead.lead_status_parent_id == 64
                          ? Colors.red.shade50.withOpacity(0.5)
                          : lead.lead_status_parent_id == 62
                              ? '#fff8ed'.hexToColor()
                              : '#efffef'.hexToColor(),
                      /*  ? Colors.yellow.shade50.withOpacity(0.5)
                                  : Colors.green.shade50.withOpacity(0.5),*/
                      borderRadius: BorderRadius.circular(25.sp)),
                  child: lead.lead_status.capitalize
                      .toString()=='User Action Required'
                      ? Stack(
                          children: [
                            Shimmer.fromColors(
                              direction: ShimmerDirection.ltr,
                              enabled: true,
                              baseColor: '#fff8ed'.hexToColor(),
                              // highlightColor: '#f9efda'.hexToColor(),
                              highlightColor: '#fdd6be'.hexToColor(),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(25.sp)),
                                  width: double.maxFinite,
                                  height: 160.sp),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: CustomText(
                                        lead.lead_status.capitalize
                                            .toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          wordSpacing: 1,
                                          color: lead.lead_status_parent_id == 64
                                              ? Colors.red.shade700
                                              : lead.lead_status_parent_id == 62
                                                  ? '#ea9500'.hexToColor()
                                                  : '#12b00e'.hexToColor(),
                                          /*    ? Colors.yellow.shade700
                                              : Colors.green.shade700,*/
                                        ),
                                        fontSize: 65.sp,
                                      ),
                                    )
                                        .marginOnly(left: 10.sp, right: 10.sp)
                                        .paddingOnly(
                                            left: 20.sp,
                                            right: 0.sp,
                                            bottom: 5.sp,
                                            top: 5.sp),
                                    Container(
                                      child: lead.lead_status_parent_id == 64
                                          ? Icon(Icons.cancel_outlined,
                                              size: 15,
                                              color: Colors.red.shade700)
                                          : lead.lead_status_parent_id == 62
                                              ? Icon(Icons.info_outlined,
                                                  size: 15,
                                                  color: '#ea9500'.hexToColor())
                                              : Icon(
                                                  Icons.check_circle_outlined,
                                                  size: 15,
                                                  color:
                                                      '#12b00e'.hexToColor()),
                                    ),
                                  ],
                                ).paddingOnly(right: 30.sp, bottom: 0.sp,top:15.sp),
                                Container(
                                        child: CustomText(
                                  lead.lead_remark.capitalizeFirst.toString(),
                                  textAlign: TextAlign.justify,
                                  fontSize: 32.sp,
                                  color: '#3a3838'.hexToColor(),
                                ))
                                    .marginOnly(left: 10.sp, right: 20.sp)
                                    .paddingOnly(
                                    left: 20.sp, right: 30.sp, bottom: 15.sp),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: CustomText(
                                    lead.lead_status.capitalize.toString(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      wordSpacing: 1,
                                      color: lead.lead_status_parent_id == 64
                                          ? Colors.red.shade700
                                          : lead.lead_status_parent_id == 62
                                              ? '#ea9500'.hexToColor()
                                              : '#12b00e'.hexToColor(),
                                      /*    ? Colors.yellow.shade700
                                              : Colors.green.shade700,*/
                                    ),
                                    fontSize: 65.sp,
                                  ),
                                )
                                    .marginOnly(left: 10.sp, right: 10.sp)
                                    .paddingOnly(
                                        left: 20.sp,
                                        right: 0.sp,
                                        bottom: 5.sp,
                                        top: 5.sp),
                                Container(
                                  child: lead.lead_status_parent_id == 64
                                      ? Icon(Icons.cancel_outlined,
                                          size: 15, color: Colors.red.shade700)
                                      : lead.lead_status_parent_id == 62
                                          ? Icon(Icons.info_outlined,
                                              size: 15,
                                              color: '#ea9500'.hexToColor())
                                          : Icon(Icons.check_circle_outlined,
                                              size: 15,
                                              color: '#12b00e'.hexToColor()),
                                ),
                              ],
                            ),
                            Container(
                                    child: CustomText(
                              lead.lead_remark.capitalizeFirst.toString(),
                              textAlign: TextAlign.justify,
                              fontSize: 32.sp,
                              color: '#3a3838'.hexToColor(),
                            ))
                                .marginOnly(left: 10.sp, right: 20.sp)
                                .paddingOnly(
                                    left: 20.sp, right: 30.sp, bottom: 10.sp),
                          ],
                        ),
                ),
              ],
            )).marginAll(30.sp).onClick(() {
          String onClickRoute = Routes.DASHBOARD +
              Routes.MY_LEAD_DETAILS +
              "?lead_id=" +
              lead.lead_id.toString();
          Get.toNamed(onClickRoute)!
              .then((value) => bottomNavigationKey.currentState!.reAnimate());
        }),
      ]),
    );
  }

  Widget emptyWidget(MyLeadsController controller) {
    return Center(
        child: Obx(() => Visibility(
              child: CustomText(
                no_lead_msg.tr,
                textAlign: TextAlign.center,
                color: ColorUtils.blackLight,
                fontweight: Weight.LIGHT,
                customTextStyle: CustomTextStyle.MEDIUM,
              ).marginAll(10.0),
              visible: controller.apiCallDone,
            )));
  }

  Widget filterDrawer(MyLeadsController con) {
    final selectedFilter = category.tr.obs;
    RxList<int> selectedProductsList = con.selectedProductsList.obs;
    DateTime? fromDate = con.fromDateController.text.toDateTime();
    DateTime? toDate = con.toDateController.text.toDateTime();
    final _selectedTime = con.selectedTime.obs;
    final selectedStatus = con.selectedStatus.obs;
    DateRangePickerController dateController = DateRangePickerController();
    List filterType = [category.tr, time.tr, status.tr];
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
                              filter_leads.tr,
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
                                    flex: 9,
                                    child: Obx(() => ListView.builder(
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            Product product =
                                                con.productsList[index];
                                            return Obx(() =>
                                                    WidgetUtil.getRadio(
                                                        onTap: () {
                                                          if (selectedProductsList
                                                              .contains(
                                                                  product.id)) {
                                                            selectedProductsList
                                                                .removeWhere(
                                                                    (element) =>
                                                                        element ==
                                                                        product
                                                                            .id);
                                                          } else {
                                                            selectedProductsList
                                                                .add(
                                                                    product.id);
                                                          }
                                                        },
                                                        isSelected:
                                                            selectedProductsList
                                                                .contains(
                                                                    product.id),
                                                        label: product.title))
                                                .marginAll(30.sp);
                                          },
                                          itemCount: con.productsList.length,
                                        )),
                                  );
                                } else if (index == 1) {
                                  widget = Expanded(
                                      flex: 9,
                                      child: Column(
                                        children: [
                                          Obx(
                                            () => Wrap(
                                              alignment: WrapAlignment.start,
                                              direction: Axis.vertical,
                                              children: [
                                                ActionChip(
                                                  shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: _selectedTime
                                                                      .value ==
                                                                  1
                                                              ? ColorUtils
                                                                  .orange
                                                              : ColorUtils
                                                                  .greylight,
                                                          width: .5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60.sp)),
                                                  label: CustomText(
                                                    last_7_days.tr,
                                                    fontweight: Weight.LIGHT,
                                                    fontSize: 36.sp,
                                                    color:
                                                        _selectedTime.value == 1
                                                            ? ColorUtils.white
                                                            : ColorUtils
                                                                .textColor,
                                                  ),
                                                  labelPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 30.sp),
                                                  backgroundColor:
                                                      _selectedTime.value == 1
                                                          ? ColorUtils.orange
                                                          : Colors
                                                              .grey.shade200,
                                                  onPressed: () {
                                                    toDate = DateTime.now();
                                                    fromDate = DateTime.now();
                                                    fromDate = fromDate!
                                                        .subtract(6.days);

                                                    dateController
                                                            .selectedRange =
                                                        PickerDateRange(
                                                            fromDate, toDate);

                                                    print(fromDate!.toUiDate());
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
                                                              ? ColorUtils
                                                                  .orange
                                                              : ColorUtils
                                                                  .greylight,
                                                          width: .5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60.sp)),
                                                  label: CustomText(
                                                    last_30_days.tr,
                                                    fontweight: Weight.LIGHT,
                                                    fontSize: 36.sp,
                                                    color:
                                                        _selectedTime.value == 2
                                                            ? ColorUtils.white
                                                            : ColorUtils
                                                                .textColor,
                                                  ),
                                                  labelPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 30.sp),
                                                  backgroundColor:
                                                      _selectedTime.value == 2
                                                          ? ColorUtils.orange
                                                          : Colors
                                                              .grey.shade200,
                                                  onPressed: () {
                                                    _selectedTime.value = 2;
                                                    toDate = DateTime.now();
                                                    fromDate = DateTime.now();
                                                    fromDate = fromDate!
                                                        .subtract(29.days);
                                                    dateController
                                                            .selectedRange =
                                                        PickerDateRange(
                                                            fromDate, toDate);

                                                    print(fromDate!.toUiDate());
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
                                                            BorderRadius
                                                                .circular(
                                                                    60.sp)),
                                                    label: CustomText(
                                                      select_date.tr,
                                                      fontweight: Weight.LIGHT,
                                                      fontSize: 36.sp,
                                                      color:
                                                          _selectedTime.value ==
                                                                  3
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
                                                Obx(() => IgnorePointer(
                                                      ignoring:
                                                          _selectedTime.value !=
                                                              3,
                                                      child: Container(
                                                        width: constraints
                                                                .maxWidth *
                                                            .7,
                                                        child:
                                                            SfDateRangePicker(
                                                          controller:
                                                              dateController,
                                                          onSelectionChanged:
                                                              (args) {
                                                            fromDate = (args
                                                                        .value
                                                                    as PickerDateRange)
                                                                .startDate;
                                                            toDate = (args.value
                                                                    as PickerDateRange)
                                                                .endDate;
                                                          },
                                                          maxDate:
                                                              DateTime.now(),
                                                          selectionMode:
                                                              DateRangePickerSelectionMode
                                                                  .range,
                                                          initialSelectedRange:
                                                              PickerDateRange(
                                                                  fromDate,
                                                                  toDate),
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            ).marginSymmetric(
                                                horizontal: 20.sp,
                                                vertical: 40.sp),
                                          ),
                                        ],
                                      ));
                                } else {
                                  widget = Expanded(
                                      flex: 9,
                                      child: ListView.builder(
                                          itemCount: con.statusList.length - 1,
                                          shrinkWrap: true,
                                          itemBuilder: (_, pos) {
                                            return Obx(() =>
                                                WidgetUtil.getRadio(
                                                    onTap: () {
                                                      selectedStatus.value =
                                                          con.statusList[pos];
                                                    },
                                                    isSelected:
                                                        selectedStatus.value ==
                                                            con.statusList[pos],
                                                    label: con.statusList[pos]
                                                        .second)).marginAll(
                                                30.sp);
                                          }).alignTo(Alignment.topRight));
                                }
                                return widget;
                              }),
                              Expanded(
                                  flex: 1,
                                  child: Row(
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
                                            clear_all.tr,
                                            fontweight: Weight.LIGHT,
                                            color: Colors.grey.shade700,
                                          )
                                              .marginSymmetric(
                                                  horizontal: 40.sp,
                                                  vertical: 20.sp)
                                              .onClick(() {
                                            Get.back();
                                            con.selectedProductsList = [];
                                            con.isAnyMoreFilter.value = 0;
                                            con.selectedTime = 0;
                                            con.currentPage = 1;
                                            con.fetchLeads();
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
                                            '\t\t\t${filter.tr}\t\t\t',
                                            fontweight: Weight.LIGHT,
                                            color: Colors.white,
                                          )
                                              .marginSymmetric(
                                                  horizontal: 40.sp,
                                                  vertical: 20.sp)
                                              .onClick(() {
                                            Get.back();
                                            con.selectedProductsList =
                                                selectedProductsList;
                                            con.isAnyMoreFilter.value = 1;
                                            con.selectedTime =
                                                _selectedTime.value;
                                            con.selectedStatus =
                                                selectedStatus.value;

                                            con.fromDateController.text =
                                                fromDate == null
                                                    ? ""
                                                    : fromDate!.toUiDate()!;
                                            con.toDateController.text =
                                                toDate == null
                                                    ? ""
                                                    : toDate!.toUiDate()!;

                                            con.currentPage = 1;
                                            con.fetchLeads();
                                          }, showEffect: false),
                                        ).marginOnly(right: 40.sp).onClick(() {
                                          Get.back();
                                          con.selectedProductsList =
                                              selectedProductsList;
                                          con.isAnyMoreFilter.value = 1;
                                          con.selectedTime =
                                              _selectedTime.value;
                                          con.selectedStatus =
                                              selectedStatus.value;

                                          con.fromDateController.text =
                                              fromDate == null
                                                  ? ""
                                                  : fromDate!.toUiDate()!;
                                          con.toDateController.text =
                                              toDate == null
                                                  ? ""
                                                  : toDate!.toUiDate()!;

                                          con.currentPage = 1;
                                          con.fetchLeads();
                                        }, showEffect: false),
                                      ])
                                      .marginAll(40.sp)
                                      .alignTo(Alignment.bottomRight))
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
}
