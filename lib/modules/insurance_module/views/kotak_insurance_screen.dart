import 'package:bank_sathi/Helpers/Constant.dart';
import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/modules/insurance_module/controllers/kotak_insurance_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/ButtonState.dart';
import 'package:bank_sathi/widgets/IconedButton.dart';
import 'package:bank_sathi/widgets/custom_drop_down.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:bank_sathi/widgets/date_widget.dart';
import 'package:bank_sathi/widgets/pincode_suggestion.dart';
import 'package:bank_sathi/widgets/simple_rich_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class KotakInsuranceLead extends GetView<KotakInsuranceLeadController> {
  DashboardController dashController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: SafeArea(child: LayoutBuilder(builder: (_, constraintSuper) {
          return Stack(overflow: Overflow.visible, children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: ColorUtils.window_bg,
              alignment: Alignment.topRight,
            ),
            Positioned(
              child: SvgPicture.asset(
                'assets/images/new_images/top_curve.svg',
                color: ColorUtils.topCurveColor,
                width: Get.width - (Get.width * .2),
              ),
              top: 0,
              right: 0,
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                titleSpacing: 0,
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: UnconstrainedBox(
                    child: SvgPicture.asset(
                  'assets/images/ic_back_arrow.svg',
                  width: 60.sp,
                  height: 60.sp,
                  color: ColorUtils.black_gr_light,
                )).onClick(() async => _onBackPress()),
                title: Obx(() => CustomText(
                      controller.currentStep == 1
                          ? basic_info.tr
                          : controller.currentStep == 2
                              ? add_member.tr
                              : make_nominee.tr,
                      color: ColorUtils.black_gr_light,
                    )),
                actions: [
                  WidgetUtil.getNotificationIcon(),
                  WidgetUtil.getSupportIcon()
                ],
              ),
              body: Obx(() => controller.currentStep == 1
                  ? step1()
                  : controller.currentStep == 2
                      ? step2()
                      : step3()),
            ),
          ]);
        })),
        onWillPop: () async => _onBackPress());
  }

  Widget step1() {
    return SingleChildScrollView(
      child: BasePageView(
        idleWidget: Form(
                key: controller.globalKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                        aspectRatio: 3,
                        child: Card(
                          margin: EdgeInsets.all(1),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 0.5,
                          color: ColorUtils.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.sp),
                          ),
                          child: CustomImage.network(
                            controller.arguments.kiData.banner_image,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ).onClick(() {})),
                    Row(children: [
                      Column(
                        children: [
                          CircleAvatar(
                              radius: 70.sp,
                              backgroundColor: controller.gender == male.tr
                                  ? ColorUtils.orange
                                  : '#F2F3F7'.hexToColor(),
                              child: SvgPicture.asset(
                                'assets/images/new_images/insurance/male.svg',
                                width: 70.sp,
                                color: controller.gender == male.tr
                                    ? ColorUtils.white
                                    : '#888FB1'.hexToColor(),
                                fit: BoxFit.fitWidth,
                              )),
                          CustomText(
                            male.tr,
                            color: ColorUtils.grey,
                            fontSize: 36.sp,
                          )
                        ],
                      )
                          .marginOnly(right: 60.sp)
                          .onClick(() => controller.gender = male.tr),
                      Column(
                        children: [
                          CircleAvatar(
                              radius: 70.sp,
                              backgroundColor: controller.gender == female.tr
                                  ? ColorUtils.orange
                                  : '#F2F3F7'.hexToColor(),
                              child: UnconstrainedBox(
                                  child: SvgPicture.asset(
                                'assets/images/new_images/insurance/female.svg',
                                width: 70.sp,
                                color: controller.gender == female.tr
                                    ? ColorUtils.white
                                    : '#888FB1'.hexToColor(),
                                fit: BoxFit.scaleDown,
                              ))),
                          CustomText(
                            female.tr,
                            color: ColorUtils.grey,
                            fontSize: 36.sp,
                          )
                        ],
                      )
                          .marginOnly(left: 60.sp, right: 60.sp)
                          .onClick(() => controller.gender = female.tr),
                      Column(
                        children: [
                          CircleAvatar(
                              radius: 70.sp,
                              backgroundColor: controller.gender == other.tr
                                  ? ColorUtils.orange
                                  : '#F2F3F7'.hexToColor(),
                              child: UnconstrainedBox(
                                  child: SvgPicture.asset(
                                'assets/images/new_images/insurance/other.svg',
                                width: 70.sp,
                                color: controller.gender == other.tr
                                    ? ColorUtils.white
                                    : '#888FB1'.hexToColor(),
                                fit: BoxFit.scaleDown,
                              ))),
                          CustomText(
                            other.tr,
                            color: ColorUtils.grey,
                            fontSize: 36.sp,
                          )
                        ],
                      )
                          .marginOnly(left: 60.sp)
                          .onClick(() => controller.gender = other.tr),
                    ]).marginOnly(top: 60.sp),
                    CustomTextField(
                      controller: controller.firstNameController,
                      textField: full_name.tr,
                      hint: full_name.tr,
                      verticalMargin: 5,
                      isRequired: true,
                    ).marginOnly(top: 30.sp),
                    CustomText(
                      dob.tr,
                      color: ColorUtils.greylight,
                      fontSize: 30.sp,
                    ).marginOnly(left: 30.sp, top: 30.sp),
                    DateWidget(
                      controller: controller.dobController,
                    ),
                    CustomTextField(
                      controller: controller.emailController,
                      hint: enter_email.tr,
                      textField: email.tr,
                      verticalMargin: 0,
                      keyboardType: TextInputType.emailAddress,
                      isRequired: true,
                    ).marginOnly(top: 30.sp),
                    CustomTextField(
                      controller: controller.currentResidentialAddress,
                      textField: current_regi_address.tr,
                      keyboardType: TextInputType.streetAddress,
                      verticalMargin: 5,
                      textInputAction: TextInputAction.next,
                      isRequired: true,
                    ).marginOnly(top: 40.sp),
                    PincodeSuggestion(
                      pinCodeHelper: controller.pinCodeHelper,
                      verticalMargin: 5,
                      label: pincode.tr,
                    ).marginOnly(top: 20.sp),
                    Obx(() => ProgressButton.icon(
                            radius: 100.sp,
                            minWidth: 500.sp,
                            progressIndicator: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            iconedButtons: {
                              ButtonState.idle: IconedButton(
                                  text: next.tr,
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    size: 0,
                                    color: ColorUtils.white,
                                  ),
                                  color: ColorUtils.orange_gr_dark),
                              ButtonState.loading: IconedButton(
                                  text: verifying.tr, color: ColorUtils.orange),
                              ButtonState.fail: IconedButton(
                                  text: next.tr,
                                  icon: Icon(Icons.arrow_forward,
                                      size: 0, color: Colors.red),
                                  color: Colors.red.shade300),
                              ButtonState.success: IconedButton(
                                  text: success.tr,
                                  icon: Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                  ),
                                  color: Colors.green.shade400)
                            },
                            textStyle: StyleUtils.textStyleNormalPoppins(
                                color: ColorUtils.white,
                                fontSize: 50.sp,
                                weight: FontWeight.w500),
                            onPressed: () => controller.askForAddMembers(),
                            state: controller.pageState.getMatchingButtonState)
                        .alignTo(Alignment.center)
                        .marginOnly(top: 60.sp, bottom: 20.sp)),
                  ],
                ).marginOnly(left: 35.sp, right: 35.sp, bottom: 35.sp))
            .marginAll(10.sp),
        controller: controller,
      ),
    );
  }

  Widget step2() {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: BasePageView(
            controller: controller,
            idleWidget:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, position) {
                    if (position == 0)
                      return _childInfoList();
                    else
                      return ChildInfoServer();
                  }),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                          backgroundColor: ColorUtils.black_gr_light,
                          child: Center(
                              child: SvgPicture.asset(
                            'assets/images/new_images/add.svg',
                            width: 40.sp,
                            height: 40.sp,
                            color: ColorUtils.white,
                            fit: BoxFit.scaleDown,
                          ).marginAll(10.sp)))
                      .marginAll(5.sp),
                  CustomText(
                    click_to_add_member.tr,
                    color: ColorUtils.silver,
                    fontweight: FontWeight.w400,
                  ).marginOnly(left: 15.sp)
                ],
              )
                  .marginOnly(
                    left: 30.sp,
                    right: 60.sp,
                    top: 20.sp,
                  )
                  .alignTo(Alignment.centerLeft)
                  .onClick(() => controller.addChild(1)),
              Obx(() => SizedBox(
                    width: Get.width * .5,
                    child: ProgressButton.icon(
                        radius: 100.sp,
                        maxWidth: 100.sp,
                        progressIndicator: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        iconedButtons: {
                          ButtonState.idle: IconedButton(
                              text: continue_label.tr,
                              icon: Icon(
                                Icons.arrow_forward,
                                size: 0,
                                color: ColorUtils.white,
                              ),
                              color: ColorUtils.orange_gr_dark),
                          ButtonState.loading: IconedButton(
                              text: verifying.tr, color: ColorUtils.orange),
                          ButtonState.fail: IconedButton(
                              text: retry.tr,
                              icon: Icon(Icons.arrow_forward,
                                  size: 0, color: Colors.red),
                              color: Colors.red.shade300),
                          ButtonState.success: IconedButton(
                              text: success.tr,
                              icon: Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                              color: Colors.green.shade400)
                        },
                        textStyle: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.white,
                            fontSize: 50.sp,
                            weight: FontWeight.w500),
                        onPressed: () => controller.addChildwithcontinue(),
                        state: controller.pageState.getMatchingButtonState),
                  ).alignTo(Alignment.center).marginOnly(top: 100.sp))
            ]).marginOnly(top: 20.sp)),
      ),
    );
  }

  Widget step3() {
    return SingleChildScrollView(
        child: BasePageView(
            controller: controller,
            idleWidget: Column(
              children: [
                SizedBox(
                  height: 20.sp,
                ),
                Card(
                    margin: EdgeInsets.all(30.sp),
                    elevation: 40.sp,
                    shadowColor: ColorUtils.lightShade,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.sp),
                    ),
                    child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.sp),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  ColorUtils.grey_blue
                                                      .withAlpha(190),
                                                  ColorUtils.grey_blue
                                                      .withAlpha(180),
                                                  ColorUtils.grey_blue
                                                      .withAlpha(170),
                                                ]),
                                          ),
                                          height: 160.sp,
                                          width: 180.sp,
                                          child: Image.asset(
                                            'assets/images/new_images/insurance/kotak.png',
                                            width: 120.sp,
                                          ))
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        covid_policy.tr,
                                        color: ColorUtils.orange_gr_dark,
                                      ),
                                      CustomText(
                                          controller.kotakMemberDetailResponse
                                              .data.insurance_name,
                                          color: ColorUtils.greylight,
                                          fontSize: 32.sp),
                                    ],
                                  ).marginOnly(left: 30.sp),
                                ],
                              ),
                              Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.sp),
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              '#FFFCF7'.hexToColor(),
                                              '#FFFCF7'.hexToColor(),
                                              '#FFFCF7'.hexToColor(),
                                            ]),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                                    textAlign: TextAlign.start,
                                                    text: TextSpan(
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text: 'CI ' +
                                                                  cover.tr
                                                                      .toUpperCase(),
                                                              style: StyleUtils.textStyleNormalPoppins(
                                                                  color:
                                                                      ColorUtils
                                                                          .silver,
                                                                  weight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      40.sp)),
                                                          TextSpan(
                                                              text:
                                                                  '\n${Constant.RUPEE_SIGN}',
                                                              style: StyleUtils.textStyleNormal(
                                                                  color: ColorUtils
                                                                      .black_gr_light,
                                                                  weight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      50.sp)),
                                                          TextSpan(
                                                              text:
                                                                  '${controller.kotakMemberDetailResponse.data.sum_assored_amount}',
                                                              style: StyleUtils.textStyleNormal(
                                                                  color:
                                                                      ColorUtils
                                                                          .black,
                                                                  weight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      50.sp)),
                                                          TextSpan(
                                                              text: '/' +
                                                                  person.tr,
                                                              style: StyleUtils.textStyleNormalPoppins(
                                                                  color: ColorUtils
                                                                      .textColor,
                                                                  weight:
                                                                      FontWeight
                                                                          .w300,
                                                                  fontSize:
                                                                      34.sp)),
                                                        ]))
                                                .marginSymmetric(
                                                    horizontal: 40.sp,
                                                    vertical: 20.sp),
                                            RichText(
                                                    textAlign: TextAlign.start,
                                                    text: TextSpan(
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text: covid.tr +
                                                                  cover.tr
                                                                      .toUpperCase(),
                                                              style: StyleUtils.textStyleNormalPoppins(
                                                                  color:
                                                                      ColorUtils
                                                                          .silver,
                                                                  weight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      40.sp)),
                                                          TextSpan(
                                                              text:
                                                                  '\n${Constant.RUPEE_SIGN}',
                                                              style: StyleUtils.textStyleNormal(
                                                                  color:
                                                                      ColorUtils
                                                                          .black,
                                                                  weight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      50.sp)),
                                                          TextSpan(
                                                              text:
                                                                  '${controller.kotakMemberDetailResponse.data.covid_sum_assored_amount}',
                                                              style: StyleUtils.textStyleNormal(
                                                                  color:
                                                                      ColorUtils
                                                                          .black,
                                                                  weight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      50.sp)),
                                                          TextSpan(
                                                              text: '/' +
                                                                  person.tr,
                                                              style: StyleUtils.textStyleNormalPoppins(
                                                                  color:
                                                                      ColorUtils
                                                                          .black,
                                                                  weight:
                                                                      FontWeight
                                                                          .w300,
                                                                  fontSize:
                                                                      34.sp)),
                                                        ]))
                                                .marginSymmetric(
                                                    horizontal: 40.sp,
                                                    vertical: 20.sp),
                                          ]).marginOnly(
                                          top: 30.sp, bottom: 30.sp))
                                  .marginOnly(top: 30.sp),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    net_premium.tr + ':',
                                    color: ColorUtils.textColor,
                                    fontweight: FontWeight.w400,
                                  ),
                                  CustomText(
                                    '${Constant.RUPEE_SIGN}${controller.kotakMemberDetailResponse.data.premium_amount * controller.kotakMemberDetailResponse.data.no_of_person}',
                                    color: ColorUtils.orange,
                                    fontSize: 52.sp,
                                    fontweight: FontWeight.w600,
                                  ),
                                ],
                              ).marginOnly(top: 50.sp),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    gst_included.tr,
                                    color: ColorUtils.grey,
                                    fontSize: 30.sp,
                                  ),
                                  CustomText(
                                    '(${controller.kotakMemberDetailResponse.data.no_of_person} ${person_s.tr})',
                                    color: ColorUtils.grey,
                                    fontSize: 30.sp,
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: controller
                                    .spouseNameController.text.isNotEmpty,
                                child: CustomText(
                                  family_members.tr,
                                  fontSize: 42.sp,
                                  color: ColorUtils.black,
                                ).marginOnly(top: 45.sp),
                              ),
                              Visibility(
                                  visible: controller
                                      .spouseNameController.text.isNotEmpty,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    leading: CustomText("1"),
                                    horizontalTitleGap: 0,
                                    title: CustomText(
                                      controller.spouseNameController.text,
                                      color: ColorUtils.black,
                                    ),
                                    subtitle: CustomText(
                                      (controller.spouseGender == male.tr
                                              ? husband.tr
                                              : wife.tr) +
                                          " | "
                                      /*  controller.dobKeySpouse.currentState!
                                      .getServerDate()
                                      .toString()
                                      .calculateAge()
                                      .toString() +
                                  " ${year.tr}"*/
                                      ,
                                      color: ColorUtils.grey,
                                      fontweight: Weight.LIGHT,
                                    ),
                                    trailing: CustomText(
                                        controller.spouseGender.substring(0, 1),
                                        color: ColorUtils.grey,
                                        fontweight: Weight.LIGHT),
                                  )).marginOnly(top: 20.sp)
                            ]..addAll(controller.childList
                                .map((e) => ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      dense: true,
                                      leading: CustomText(controller
                                              .spouseNameController
                                              .text
                                              .isNotEmpty
                                          ? "${controller.childList.indexOf(e) + 2}"
                                          : "${controller.childList.indexOf(e) + 1}"),
                                      horizontalTitleGap: 0,
                                      title: CustomText(
                                        e.child_name,
                                        color: ColorUtils.black,
                                      ),
                                      subtitle: CustomText(
                                        (e.child_gender == male.tr
                                                ? son.tr
                                                : daughter.tr) +
                                            " | " +
                                            e.child_dob
                                                .serverToDateTime()!
                                                .calculateAge()
                                                .toString() +
                                            " ${year.tr}",
                                        color: ColorUtils.grey,
                                        fontweight: Weight.LIGHT,
                                      ),
                                      trailing: CustomText(
                                          e.child_gender.substring(0, 1),
                                          color: ColorUtils.grey,
                                          fontweight: Weight.LIGHT),
                                    ))
                                .toList()))
                        .marginAll(45.sp)),
                nomineeInfo()
              ],
            )));
  }

  Future<bool> _onBackPress() async {
    if (controller.currentStep == 1) {
      return true;
    } else if (controller.currentStep == 2) {
      controller.currentStep = controller.currentStep - 1;
      return false;
    } else {
      if (controller.addFamilyDetail == 1) {
        controller.currentStep = controller.currentStep - 1;
        return false;
      } else {
        controller.currentStep = controller.currentStep - 2;
        return false;
      }
    }
  }

  Widget _childInfoList() {
    return Obx(() => controller.membersList.length == 0
        ? Container()
        : SizedBox(
            height: 200.sp,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.membersList.length,
                itemBuilder: (_, pos) {
                  return Card(
                      elevation: 20.sp,
                      shadowColor: ColorUtils.lightShade,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.sp),
                      ),
                      child: UnconstrainedBox(
                          child: SizedBox(
                              height: 160.sp,
                              width: 160,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: CustomText(
                                        controller.membersList[pos].name,
                                        fontweight: Weight.BOLD,
                                        maxLines: 1,
                                      )),
                                      GestureDetector(
                                        onTap: () {
                                          controller.removeChild(pos);
                                        },
                                        child: Icon(
                                          Icons.remove_circle_outline,
                                          color: ColorUtils.orange,
                                          size: 60.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                  IntrinsicHeight(
                                      child: Row(children: [
                                    CustomText(
                                      '' + controller.membersList[pos].gender,
                                      color: ColorUtils.greylight,
                                      fontSize: 36.sp,
                                    ),
                                    VerticalDivider(
                                      thickness: 3.sp,
                                      color: ColorUtils.greylight,
                                    ),
                                    CustomText(
                                      '' +
                                          controller.membersList[pos].dob
                                              .serverToUIDate(),
                                      fontSize: 36.sp,
                                      color: ColorUtils.greylight,
                                    ),
                                  ]))
                                ],
                              ))).marginOnly(left: 15.sp, right: 15.sp));
                })).marginOnly(left: 15.sp, right: 15.sp));
  }

  Widget ChildInfoServer() {
    return Align(
      alignment: Alignment.topLeft,
      child: Card(
          margin: EdgeInsets.all(30.sp),
          shadowColor: ColorUtils.lightShade,
          elevation: 30.sp,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.sp),
          ),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(children: [
                  Column(
                    children: [
                      Obx(() => CircleAvatar(
                          radius: controller.gender == male.tr ? 73.sp : 70.sp,
                          backgroundColor: ColorUtils.orange,
                          child: CircleAvatar(
                              radius: 70.sp,
                              backgroundColor: controller.gender == male.tr
                                  ? ColorUtils.white
                                  : '#F2F3F7'.hexToColor(),
                              child: SvgPicture.asset(
                                'assets/images/new_images/insurance/male.svg',
                                width: 70.sp,
                                color: controller.gender == male.tr
                                    ? ColorUtils.orange
                                    : ColorUtils.greyshade,
                                fit: BoxFit.fitWidth,
                              )))),
                      CustomText(
                        'Male',
                        color: ColorUtils.grey,
                        fontSize: 36.sp,
                      )
                    ],
                  )
                      .marginOnly(right: 60.sp)
                      .onClick(() => controller.gender = male.tr),
                  Column(
                    children: [
                      Obx(() => CircleAvatar(
                          radius:
                              controller.gender == female.tr ? 73.sp : 70.sp,
                          backgroundColor: ColorUtils.orange,
                          child: CircleAvatar(
                              radius: 70.sp,
                              backgroundColor: controller.gender == female.tr
                                  ? ColorUtils.white
                                  : '#F2F3F7'.hexToColor(),
                              child: UnconstrainedBox(
                                  child: SvgPicture.asset(
                                'assets/images/new_images/insurance/female.svg',
                                width: 70.sp,
                                color: controller.gender == female.tr
                                    ? ColorUtils.orange
                                    : ColorUtils.greyshade,
                                fit: BoxFit.scaleDown,
                              ))))),
                      CustomText(
                        'Female',
                        color: ColorUtils.grey,
                        fontSize: 36.sp,
                      )
                    ],
                  )
                      .marginOnly(left: 60.sp, right: 60.sp)
                      .onClick(() => controller.gender = female.tr),
                  Column(
                    children: [
                      Obx(() => CircleAvatar(
                          radius: controller.gender == other.tr ? 73.sp : 70.sp,
                          backgroundColor: ColorUtils.orange,
                          child: CircleAvatar(
                              radius: 70.sp,
                              backgroundColor: controller.gender == other.tr
                                  ? ColorUtils.white
                                  : '#F2F3F7'.hexToColor(),
                              child: UnconstrainedBox(
                                  child: SvgPicture.asset(
                                'assets/images/new_images/insurance/other.svg',
                                width: 70.sp,
                                color: controller.gender == other.tr
                                    ? ColorUtils.orange
                                    : ColorUtils.greyshade,
                                fit: BoxFit.scaleDown,
                              ))))),
                      CustomText(
                        other.tr,
                        color: ColorUtils.grey,
                        fontSize: 36.sp,
                      )
                    ],
                  )
                      .marginOnly(left: 60.sp)
                      .onClick(() => controller.gender = other.tr),
                ]).marginOnly(top: 60.sp),
                CustomTextField(
                  controller: controller.childNameController,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  textField: name.tr,
                  verticalMargin: 5,
                  isRequired: true,
                ),
                CustomText(
                  dob.tr,
                  color: ColorUtils.greylight,
                  fontSize: 30.sp,
                ).marginOnly(top: 30.sp),
                Obx(() => DateWidget(
                      controller: controller.isSpouse
                          ? controller.spousedobController
                          : controller.childdobController,
                    )),
                CustomText(
                  relation.tr,
                  fontSize: 36.sp,
                  fontweight: FontWeight.w500,
                  color: ColorUtils.grey,
                ).marginOnly(top: 30.sp),
                Row(
                  children: [
                    Obx(() => Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90.sp),
                            border: Border.all(
                                width: 2.sp, color: ColorUtils.textColorLight),
                            color: controller.isSpouse
                                ? ColorUtils.textColorLight.withAlpha(210)
                                : ColorUtils.white,
                          ),
                          child: CustomText(
                            spouse.tr,
                            color: controller.isSpouse
                                ? ColorUtils.white
                                : ColorUtils.textColorLight,
                          ).alignTo(Alignment.center).marginAll(15.sp),
                        ).marginOnly(right: 30.sp).onClick(() {
                          controller.isSpouse = true;
                        }))),
                    Obx(() => Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90.sp),
                            border: Border.all(
                                width: 2.sp, color: ColorUtils.textColorLight),
                            color: !controller.isSpouse
                                ? ColorUtils.textColorLight.withAlpha(210)
                                : ColorUtils.white,
                          ),
                          child: CustomText(
                            child.tr,
                            color: !controller.isSpouse
                                ? ColorUtils.white
                                : ColorUtils.textColorLight,
                          ).alignTo(Alignment.center).marginAll(15.sp),
                        ).marginOnly(right: 30.sp).onClick(() {
                          controller.isSpouse = false;
                        }))),
                  ],
                ).marginOnly(top: 40.sp),
                CustomText(
                  pre_health_condition.tr,
                  fontSize: 36.sp,
                  fontweight: FontWeight.w500,
                  color: ColorUtils.grey,
                ).marginOnly(top: 50.sp),
                Row(
                  children: [
                    Obx(() => Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90.sp),
                            border: Border.all(
                                width: 2.sp, color: ColorUtils.textColorLight),
                            color: controller.childCondition
                                ? ColorUtils.textColorLight.withAlpha(210)
                                : ColorUtils.white,
                          ),
                          child: CustomText(
                            yes_i_have.tr,
                            color: controller.childCondition
                                ? ColorUtils.white
                                : ColorUtils.textColorLight,
                          ).alignTo(Alignment.center).marginAll(15.sp),
                        ).marginOnly(right: 30.sp).onClick(() {
                          controller.childCondition = true;
                        }))),
                    Obx(() => Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90.sp),
                            border: Border.all(
                                width: 2.sp, color: ColorUtils.textColorLight),
                            color: !controller.childCondition
                                ? ColorUtils.textColorLight.withAlpha(210)
                                : ColorUtils.white,
                          ),
                          child: CustomText(
                            dont_have.tr,
                            color: !controller.childCondition
                                ? ColorUtils.white
                                : ColorUtils.textColorLight,
                          ).alignTo(Alignment.center).marginAll(15.sp),
                        ).marginOnly(right: 30.sp).onClick(() {
                          controller.childCondition = false;
                        }))),
                  ],
                ).marginOnly(top: 40.sp),
              ],
            ),
            key: controller.childGlobalKey,
          ).marginOnly(left: 15, right: 15, bottom: 15)),
    );
  }

  Widget nomineeInfo() {
    return Align(
      alignment: Alignment.topLeft,
      child: Card(
          margin: EdgeInsets.all(30.sp),
          shadowColor: ColorUtils.lightShade,
          elevation: 30.sp,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.sp),
          ),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  nominee_info.tr,
                  fontSize: 42.sp,
                  color: ColorUtils.greylight,
                ).marginOnly(top: 10),
                Row(children: [
                  Column(
                    children: [
                      Obx(() => CircleAvatar(
                          radius: controller.nomineeGender == male.tr
                              ? 73.sp
                              : 70.sp,
                          backgroundColor: ColorUtils.orange,
                          child: CircleAvatar(
                              radius: 70.sp,
                              backgroundColor:
                                  controller.nomineeGender == male.tr
                                      ? ColorUtils.white
                                      : '#F2F3F7'.hexToColor(),
                              child: SvgPicture.asset(
                                'assets/images/new_images/insurance/male.svg',
                                width: 70.sp,
                                color: controller.nomineeGender == male.tr
                                    ? ColorUtils.orange
                                    : ColorUtils.greyshade,
                                fit: BoxFit.fitWidth,
                              )))),
                      CustomText(
                        male.tr,
                        color: ColorUtils.grey,
                        fontSize: 36.sp,
                      )
                    ],
                  )
                      .marginOnly(right: 60.sp)
                      .onClick(() => controller.nomineeGender = male.tr),
                  Column(
                    children: [
                      CircleAvatar(
                          radius: controller.nomineeGender == female.tr
                              ? 73.sp
                              : 70.sp,
                          backgroundColor: ColorUtils.orange,
                          child: CircleAvatar(
                              radius: 70.sp,
                              backgroundColor:
                                  controller.nomineeGender == female.tr
                                      ? ColorUtils.white
                                      : '#F2F3F7'.hexToColor(),
                              child: UnconstrainedBox(
                                  child: SvgPicture.asset(
                                'assets/images/new_images/insurance/female.svg',
                                width: 70.sp,
                                color: controller.nomineeGender == female.tr
                                    ? ColorUtils.orange
                                    : ColorUtils.greyshade,
                                fit: BoxFit.scaleDown,
                              )))),
                      CustomText(
                        female.tr,
                        color: ColorUtils.grey,
                        fontSize: 36.sp,
                      )
                    ],
                  )
                      .marginOnly(left: 60.sp, right: 60.sp)
                      .onClick(() => controller.nomineeGender = female.tr),
                  Column(
                    children: [
                      Obx(() => CircleAvatar(
                          radius: controller.nomineeGender == other.tr
                              ? 73.sp
                              : 70.sp,
                          backgroundColor: ColorUtils.orange,
                          child: CircleAvatar(
                              radius: 70.sp,
                              backgroundColor:
                                  controller.nomineeGender == other.tr
                                      ? ColorUtils.white
                                      : '#F2F3F7'.hexToColor(),
                              child: UnconstrainedBox(
                                  child: SvgPicture.asset(
                                'assets/images/new_images/insurance/other.svg',
                                width: 70.sp,
                                color: controller.nomineeGender == other.tr
                                    ? ColorUtils.orange
                                    : ColorUtils.greyshade,
                                fit: BoxFit.scaleDown,
                              ))))),
                      CustomText(
                        'Other',
                        color: ColorUtils.grey,
                        fontSize: 36.sp,
                      )
                    ],
                  )
                      .marginOnly(left: 60.sp)
                      .onClick(() => controller.nomineeGender = other.tr),
                ]).marginOnly(top: 20.sp),
                CustomTextField(
                  controller: controller.nomineeNameController,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  textField: name.tr,
                  verticalMargin: 5,
                  isRequired: true,
                ),
                CustomText(
                  dob.tr,
                  color: ColorUtils.greylight,
                  fontSize: 30.sp,
                ).marginOnly(top: 30.sp),
                DateWidget(
                  controller: controller.nomineedobController,
                ),
                Obx(() => CustomDropDown<String>(
                      items: controller.relationList
                          .map((e) => DropdownMenuItem<String>(
                                child: CustomText(e),
                                value: e,
                              ))
                          .toList(),
                      value: controller.nomineeRelation,
                      onChanged: (e) {
                        controller.nomineeRelation = e;
                      },
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      verticalMargin: 5,
                    )),
                RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: click_agree.tr,
                          style: StyleUtils.textStyleNormalPoppins(
                              color: ColorUtils.grey,
                              weight: FontWeight.w300,
                              fontSize: 36.sp)),
                      TextSpan(
                          text: terms_conditions.tr,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.dialog(
                                Dialog(
                                    insetPadding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomText(
                                          specific_conditions.tr,
                                          color: ColorUtils.black,
                                          fontweight: Weight.BOLD,
                                          fontType: FontType.OPEN_SANS,
                                          fontSize: 46.sp,
                                        ).marginOnly(top: 10, left: 10),
                                        SizedBox(
                                          height: Get.height * .6,
                                          width: Get.width * .8,
                                          child: SingleChildScrollView(
                                            child: SimpleRichText(
                                              key: UniqueKey(),
                                              text: controller.kotakTerms,
                                            ),
                                          ),
                                        ),
                                        WidgetUtil.getOrangeButton(
                                                () => Get.back(),
                                                label: ok.tr)
                                            .marginSymmetric(
                                                horizontal: 20, vertical: 10)
                                      ],
                                    )),
                              );
                            },
                          style: StyleUtils.textStyleNormalPoppins(
                              color: ColorUtils.blue_dark,
                              weight: FontWeight.w500,
                              fontSize: 36.sp)),
                      TextSpan(
                          text: ' ${regarding_product.tr}',
                          style: StyleUtils.textStyleNormalPoppins(
                              color: ColorUtils.grey,
                              weight: FontWeight.w300,
                              fontSize: 36.sp)),
                    ])).marginAll(15.sp),
                ProgressButton.icon(
                        radius: 100.sp,
                        maxWidth: 200.0,
                        progressIndicator: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(left: 10, right: 20),
                        iconedButtons: {
                          ButtonState.idle: IconedButton(
                              text: get_pay_link.tr,
                              icon: Icon(
                                Icons.arrow_forward,
                                size: 0,
                                color: ColorUtils.white,
                              ),
                              color: ColorUtils.orange_gr_dark),
                          ButtonState.loading: IconedButton(
                              text: verifying.tr, color: ColorUtils.orange),
                          ButtonState.fail: IconedButton(
                              text: retry.tr,
                              icon: Icon(Icons.arrow_forward,
                                  size: 0, color: Colors.red),
                              color: Colors.red.shade300),
                          ButtonState.success: IconedButton(
                              text: success.tr,
                              icon: Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                              color: Colors.green.shade400)
                        },
                        textStyle: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.white,
                            fontSize: 50.sp,
                            weight: FontWeight.w500),
                        onPressed: () => controller.addNomineeDetail(),
                        state: controller.pageState.getMatchingButtonState)
                    .marginAll(30.sp)
                    .alignTo(Alignment.center),
              ],
            ),
            key: controller.nomineeKey,
          ).marginOnly(left: 15, right: 15, bottom: 15)),
    );
  }
}
