import 'package:bank_sathi/Helpers/Constant.dart';
import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/my_team_controller.dart';
import 'package:bank_sathi/network/rest_client.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MyTeam extends GetView<MyTeamController> {
  DashboardController dashController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        alignment: Alignment.topRight,
      ),
      NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo is ScrollEndNotification &&
                scrollInfo.metrics.extentAfter == 0) {
              controller.fetchTeam();
            }
            return true;
          },
          child: Scaffold(
            appBar: null,
            floatingActionButton: Card(
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
              ),
            )
                .onClick(() => Get.bottomSheet(filterDrawer(),
                    ignoreSafeArea: false, isScrollControlled: true))
                .marginOnly(left: 40.sp, bottom: 160.sp),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
            body: Column(
              children: [
                Container(
                  height: 430.sp,
                  margin: EdgeInsets.only(
                      left: 30.sp, right: 30.sp, top: 60.sp, bottom: 40.sp),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      color: '#f3f1f5'.hexToColor(),
                      borderRadius: BorderRadius.circular(40.sp)),
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: Align(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  'Refer & Earn 10% Lifetime',
                                  color: "#F7691F".hexToColor(),
                                  fontweight: FontWeight.w600,
                                  textAlign: TextAlign.start,
                                  fontSize: 46.sp,
                                ),
                                SvgPicture.asset(
                                  'assets/images/new_images/profile_image/information.svg',
                                  height: 50.sp,
                                ).marginOnly(right: 20.sp).onClick(() {
                                  controller.showSectionInfoById(7);
                                })
                              ],
                            ),
                            CustomText(
                              'Refer BankSathi app to your friends or family and earn extra 10% of their earnings',
                              textAlign: TextAlign.start,
                              color: "#8D8988".hexToColor(),
                              fontSize: 38.sp,
                            ).marginOnly(right: 30.sp, top: 15.sp),
                            SizedBox(height: 20.sp,),
                            Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      'Referral Code :',
                                      color: "#6C6C6C".hexToColor(),
                                      fontSize: 40.sp,
                                      fontweight: FontWeight.w600,
                                    ),
                                    Obx(
                                      () => CustomText(
                                        controller.user.user_code != null
                                            ? controller.user.user_code
                                            : '',
                                        style:
                                            StyleUtils.textStyleNormalPoppins(
                                                    fontSize: 52.sp,
                                                    weight: FontWeight.w500)
                                                .copyWith(letterSpacing: 1),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 110.sp,
                                  height: 95.sp,
                                  padding: EdgeInsets.only(
                                      left: 25.sp,
                                      right: 25.sp,
                                      top: 15.sp,
                                      bottom: 15.sp),
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                          color: "#B2ACB8".hexToColor(),
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(30.sp)),
                                  child: SvgPicture.asset(
                                    'assets/images/new_images/copy.svg',
                                    color: "#B2ACB8".hexToColor(),
                                  ),
                                ).onClick(() async {
                                  await Clipboard.setData(ClipboardData(
                                      text: controller.referContent.first));
                                  Fluttertoast.showToast(msg: refer_copy.tr);
                                }),
                                SizedBox(
                                  width: 350.sp,
                                  child: WidgetUtil.getSecondaryButton(() {
                                    controller.shareReferralLink();
                                  },
                                      color: false,
                                      label: 'Refer Now'.toUpperCase()),
                                )
                              ],
                            ).marginAll(0.sp)
                          ],
                        ).marginSymmetric(horizontal: 40.sp, vertical: 30.sp),
                        alignment: Alignment.center,
                      ))
                    ],
                  ),
                ),
                Expanded(
                    child: BasePageView(
                  controller: controller,
                  idleWidget: Obx(() => ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: controller.teamList.length + 2,
                        itemBuilder: (context, pos) {
                          int position = pos - 1;
                          return pos == 0
                              ? IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 40.sp,
                                      ),
                                      Expanded(
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                left: 35.sp,
                                                right: 35.sp,
                                                top: 25.sp,
                                                bottom: 25.sp),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        '#E8E8E8'.hexToColor(),
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.sp)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                CustomText(
                                                  'My Referrals ',
                                                  fontSize: 38.sp,
                                                  color: ColorUtils.orange,
                                                ),
                                                Obx(() => CustomText(
                                                      controller.totalReferrals
                                                          .toString()
                                                          .padLeft(2, "0"),
                                                      fontweight: Weight.BOLD,
                                                      fontSize: 50.sp,
                                                    )),
                                              ],
                                            )),
                                      ),
                                      Container(
                                        width: 40.sp,
                                      ),
                                      Expanded(
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                left: 35.sp,
                                                right: 35.sp,
                                                top: 25.sp,
                                                bottom: 25.sp),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        '#E8E8E8'.hexToColor(),
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.sp)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                  'Referral Income',
                                                  fontSize: 38.sp,
                                                  color: ColorUtils.grey,
                                                ),
                                                Obx(() => CustomText(
                                                      Constant.RUPEE_SIGN +
                                                          controller
                                                              .referralEarning
                                                              .toString(),
                                                      fontweight: Weight.BOLD,
                                                      fontSize: 50.sp,
                                                    )),
                                              ],
                                            )),
                                      ),
                                      Container(
                                        width: 40.sp,
                                      ),
                                    ],
                                  ),
                                ).marginOnly(bottom: 40.sp)
                              : pos == controller.teamList.length + 1
                                  ? SizedBox(
                                      height: 200.sp,
                                    )
                                  : Container(
                                      width: double.infinity,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        leading: Card(
                                          margin: EdgeInsets.zero,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100.sp),
                                              side: BorderSide(
                                                  color: Colors.grey.shade100,
                                                  width: 1)),
                                          child: CustomImage.network(
                                            controller.teamList[position]
                                                        .profile_photo ==
                                                    null
                                                ? ''
                                                : (kDebugMode
                                                            ? RestClient.DEV_URL
                                                            : RestClient
                                                                .CRM_URL)
                                                        .replaceAll(
                                                            '\api', "") +
                                                    controller
                                                        .teamList[position]
                                                        .profile_photo,
                                            height: 130.sp,
                                            width: 130.sp,
                                            errorWidget: UnconstrainedBox(
                                              child: SvgPicture.asset(
                                                'assets/images/ic_cc_user.svg',
                                                color: ColorUtils.black,
                                                height: 20,
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        "${controller.teamList[position].first_name.capitalizeFirst} ${controller.teamList[position].last_name.capitalizeFirst}",
                                                        style: StyleUtils
                                                            .textStyleNormalPoppins(
                                                                color:
                                                                    ColorUtils
                                                                        .black,
                                                                weight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    42.sp))),
                                                Text(
                                                    controller
                                                                .teamList[
                                                                    position]
                                                                .referral_earning ==
                                                            null
                                                        ? Constant.RUPEE_SIGN +
                                                            "0"
                                                        : Constant.RUPEE_SIGN +
                                                            controller
                                                                .teamList[
                                                                    position]
                                                                .referral_earning,
                                                    style: StyleUtils
                                                        .textStyleNormal(
                                                            color: ColorUtils
                                                                .orange,
                                                            weight:
                                                                FontWeight.w500,
                                                            fontSize: 42.sp))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                    "Earning : ${controller.teamList[position].member_earning == null ? Constant.RUPEE_SIGN + "0" : Constant.RUPEE_SIGN + controller.teamList[position].member_earning}",
                                                    style: StyleUtils
                                                        .textStyleNormal(
                                                            color:
                                                                ColorUtils.grey,
                                                            weight:
                                                                FontWeight.w500,
                                                            fontSize: 36.sp)),
                                                Spacer(),
                                                Text('Received',
                                                    style: StyleUtils
                                                        .textStyleNormalPoppins(
                                                            color:
                                                                ColorUtils.grey,
                                                            weight:
                                                                FontWeight.w500,
                                                            fontSize: 36.sp)),
                                              ],
                                            ),
                                            Visibility(
                                                visible:
                                                    controller.inactive_user ==
                                                        1,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        controller
                                                                    .teamList[
                                                                        position]
                                                                    .member_earning ==
                                                                null
                                                            ? ""
                                                            : "Mobile No. : ",
                                                        style: StyleUtils
                                                            .textStyleNormal(
                                                                color:
                                                                    ColorUtils
                                                                        .grey,
                                                                weight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    34.sp)),
                                                    Text(
                                                        controller
                                                                    .teamList[
                                                                        position]
                                                                    .member_earning ==
                                                                null
                                                            ? ""
                                                            : "${controller.teamList[position].mobile_no}",
                                                        style: StyleUtils
                                                            .textStyleNormal(
                                                                color: ColorUtils
                                                                    .textColorLight,
                                                                weight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    34.sp)),
                                                  ],
                                                ).marginOnly(top: 10.sp))
                                          ],
                                        ),
                                      ),
                                    ).marginOnly(
                                      left: 50.sp,
                                      right: 50.sp,
                                    );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return index == 0
                              ? Container()
                              : Divider(
                                  color: "#ECECEC".hexToColor(),
                                  thickness: 1,
                                  height: 50.sp,
                                ).marginSymmetric(horizontal: 40.sp);
                        },
                      )),
                  errorOrEmptyWidget: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          refer_now.tr,
                          fontweight: Weight.NORMAL,
                          fontSize: 50.sp,
                        ),
                        CustomText(
                          'Refer Bank Sathi now to add member in your team and Earn more.',
                          fontweight: Weight.NORMAL,
                          fontSize: 38.sp,
                          textAlign: TextAlign.center,
                          color: ColorUtils.grey,
                        ).marginSymmetric(horizontal: 150.sp),
                        Lottie.asset('assets/animation/thinking_man.json',
                            height: 600.sp, fit: BoxFit.fitWidth),
                      ],
                    ),
                  ),
                )),
                Obx(() => Visibility(
                      child: DefaultPageLoading(),
                      visible:
                          controller.pageState == PageStates.PAGE_LOADING_MORE,
                    ))
              ],
            ),
          ))
    ]));
  }

  Widget filterDrawer() {
    final selectedFilter = 'Sort'.obs;
    DateTime? fromDate = controller.fromDateController.text.toDateTime();
    DateTime? toDate = controller.toDateController.text.toDateTime();
    final _selectedTime = controller.selectedTime.obs;

    RxBool isSortByDate = controller.isSortByDate.obs;

    DateRangePickerController dateController = DateRangePickerController();
    List filterType = ["Sort", "Time", "User"];
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
                                                  toDate = DateTime.now();
                                                  fromDate = DateTime.now();
                                                  fromDate = fromDate!
                                                      .subtract(6.days);

                                                  dateController.selectedRange =
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
                                                  toDate = DateTime.now();
                                                  fromDate = DateTime.now();
                                                  fromDate = fromDate!
                                                      .subtract(29.days);
                                                  dateController.selectedRange =
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
                                              Obx(() => IgnorePointer(
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
                                                  ))
                                            ],
                                          ).marginSymmetric(
                                              horizontal: 20.sp,
                                              vertical: 40.sp),
                                        ),
                                      ],
                                    ),
                                  ));
                                } else if (index == 2) {
                                  widget = Expanded(
                                    child: Column(
                                      children: [
                                        Obx(() => WidgetUtil.getRadio(
                                                onTap: () {
                                                  controller.inactive_user = 0;
                                                  controller.active_user == 1
                                                      ? controller.active_user =
                                                          0
                                                      : controller.active_user =
                                                          1;
                                                },
                                                isSelected:
                                                    controller.active_user == 1,
                                                label: "Active Users"))
                                            .marginAll(30.sp),
                                        Obx(() => WidgetUtil.getRadio(
                                            onTap: () {
                                              controller.active_user = 0;
                                              controller.inactive_user == 1
                                                  ? controller.inactive_user = 0
                                                  : controller.inactive_user =
                                                      1;
                                            },
                                            isSelected:
                                                controller.inactive_user == 1,
                                            label:
                                                "InActive Users")).marginAll(
                                            30.sp),
                                      ],
                                    ),
                                  );
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

                                        controller.toDateController.text = "";
                                        controller.fromDateController.text = "";
                                        controller.isSortByDate = true;
                                        controller.selectedTime = 0;
                                        controller.currentPage = 1;
                                        controller.active_user = 0;
                                        controller.inactive_user = 0;
                                        controller.fetchTeam();
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

                                          controller.toDateController.text =
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

}
