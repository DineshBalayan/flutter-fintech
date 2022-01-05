import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/modules/loan_module/controllers/personal_loan_lead_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/ButtonState.dart';
import 'package:bank_sathi/widgets/IconedButton.dart';
import 'package:bank_sathi/widgets/company_suggestion.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:bank_sathi/widgets/pincode_suggestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class PersonalLoanLead extends GetView<PersonalLoanLeadController> {
  DashboardController dashController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: SafeArea(child: LayoutBuilder(builder: (_, constraintSuper) {
          return Stack(overflow: Overflow.visible, children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
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
                    'assets/images/new_images/back.svg',
                    width: 60.sp,
                    height: 60.sp,
                    color: ColorUtils.black_gr_light,
                  )).onClick(() => Get.back()),
                  title: CustomText(
                    'Personal Detail',
                    color: ColorUtils.black_gr_light,
                  ),
                  actions: [
                    WidgetUtil.getNotificationIcon(),
                    WidgetUtil.getSupportIcon()
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 5.sp,
                        shadowColor: ColorUtils.lightShade,
                        clipBehavior: Clip.antiAlias,
                        color: ColorUtils.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.sp)),
                        child: Stack(
                          children: [
                            Positioned(
                              child: SvgPicture.asset(
                                'assets/images/new_images/top_curve.svg',
                                color: ColorUtils.topCurveColor,
                                width: Get.width - (Get.width * .3),
                              ),
                              top: 0,
                              right: 0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: controller.nameOnCard
                                                    .toString() +
                                                '  ',
                                            style: StyleUtils
                                                .textStyleNormalPoppins(
                                                    color: ColorUtils.white,
                                                    weight: FontWeight.w500,
                                                    fontSize: 44.sp)),
                                        WidgetSpan(
                                            child: SvgPicture.asset(
                                          'assets/images/new_images/verify.svg',
                                          height: 50.sp,
                                          width: 50.sp,
                                        ).visibility(controller
                                                .nameOnCard.isNotEmpty))
                                      ],
                                    )).alignTo(Alignment.topLeft)),
                                Obx(
                                  () => CustomText(
                                    'Date of Birth: ' + controller.dob,
                                    color: ColorUtils.lightShade,
                                    fontSize: 34.sp,
                                  ),
                                ),
                                Obx(() => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          controller.ispanCard
                                              ? controller
                                                  .panNumberController.text
                                              : 'PAN Number',
                                          color: ColorUtils.white,
                                          fontSize: 44.sp,
                                        ),
                                        Visibility(
                                            visible: controller.ispanCard,
                                            child: Text(
                                              'Change PAN',
                                              style: StyleUtils
                                                  .textStyleNormalPoppins(
                                                      color: ColorUtils.orange,
                                                      fontSize: 34.sp,
                                                      isunderline: true),
                                            ).onClick(() {
                                              controller.ispanCard = false;
                                              controller.openPanCardView();
                                            }))
                                      ],
                                    ).marginOnly(top: 50.sp)),
                              ],
                            )
                                .marginOnly(
                                    left: 50.sp,
                                    right: 50.sp,
                                    top: 50.sp,
                                    bottom: 30.sp)
                                .alignTo(Alignment.center),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Obx(() => CustomText(
                                'Personal Detail',
                                color: controller.currentStep >= 0
                                    ? ColorUtils.orange
                                    : controller.currentStep >= 0
                                        ? ColorUtils.textColorLight
                                        : ColorUtils.greylight,
                              )),
                          Obx(() => CustomText(
                                'Income Detail',
                                color: controller.currentStep > 1
                                    ? ColorUtils.orange
                                    : ColorUtils.greylight,
                              ))
                        ],
                      ).marginOnly(top: 50.sp, left: 20.sp, right: 30.sp),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => CircleAvatar(
                                radius: 20.sp,
                                backgroundColor: controller.currentStep > 0
                                    ? ColorUtils.orange
                                    : ColorUtils.lightDivider,
                              )),
                          Expanded(
                              child: Obx(() => Divider(
                                    thickness: 5.sp,
                                    color: controller.currentStep > 0
                                        ? ColorUtils.black_gr_light
                                        : ColorUtils.lightDivider,
                                  ))),
                          Obx(() => CircleAvatar(
                                radius: 20.sp,
                                backgroundColor: controller.currentStep > 1
                                    ? ColorUtils.orange
                                    : ColorUtils.lightDivider,
                              )),
                          Obx(() => Expanded(
                                  child: Divider(
                                thickness: 5.sp,
                                color: controller.currentStep > 1
                                    ? ColorUtils.black_gr_light
                                    : ColorUtils.lightDivider,
                              ))),
                          Obx(() => CircleAvatar(
                                radius: 20.sp,
                                backgroundColor: controller.currentStep > 2
                                    ? ColorUtils.orange
                                    : ColorUtils.lightDivider,
                              )),
                        ],
                      ).marginOnly(left: 20.sp, right: 20.sp),
                      Obx(() =>
                          controller.currentStep == 1 ? step1() : step2()),
                    ],
                  ).marginAll(30.sp),
                )),
          ]);
        })),
        onWillPop: () async => controller.onwillpop());
  }

  Widget step1() {
    return Form(
        key: controller.globalKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: controller.emailController,
                textField: 'E-mail Address',
                isRequired: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
              ).marginOnly(top: 20.sp),
              /*   CustomText(
                'Date Of Birth',
                color: ColorUtils.greylight,
                fontSize: 30.sp,
              ).marginOnly(left: 20.sp, top: 20.sp),
              CustomTextField(
                controller: controller.dobController,
                keyboardType: TextInputType.datetime,
                suffixIcon: 'assets/images/ic_calender.svg',
                hint: "31/12/2020",
                isRequired: true,
                inputFormatter: [MaskTextInputFormatter(mask: "##/##/####")],
              ).marginAll(5),*/
              PincodeSuggestion(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                label: 'Residential PinCode',
                pinCodeHelper: controller.pinCodeHelper,
                fontsize: 46.sp,
              ),
              CustomTextField(
                controller: controller.addressContoller,
                textField: 'Address',
                hint: 'Enter House No., Landmark \& area',
                isRequired: true,
                textInputAction: TextInputAction.done,
                minLines: 2,
              ).marginOnly(top: 30.sp),
              ProgressButton.icon(
                      radius: 100.sp,
                      minWidth: 500.sp,
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
                            color: ColorUtils.orange_gr_light),
                        ButtonState.loading: IconedButton(
                            text: "Verifying", color: ColorUtils.orange),
                        ButtonState.fail: IconedButton(
                            text: "Continue",
                            icon: Icon(Icons.arrow_forward, color: Colors.red),
                            color: Colors.red.shade300),
                        ButtonState.success: IconedButton(
                            text: "Success",
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
                      onPressed: () => controller.checkPersonalInfo(),
                      state: controller.pageState.getMatchingButtonState)
                  .alignTo(Alignment.center)
                  .marginOnly(top: 60.sp, bottom: 20.sp)
            ]).marginAll(20.sp));
  }

  Widget step2() {
    return Form(
        key: controller.globalKey4,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText('Monthly Income',
                      color: ColorUtils.textColorLight, fontSize: 34.sp)
                  .marginOnly(top: 50.sp),
              WidgetUtil.getSlider(
                Obx(() => Slider(
                      value: controller.earning.toDouble(),
                      //inactiveColor: Colors.purple,
                      onChanged: (double newValue) {
                        controller.monthlySalaryController.text =
                            newValue.toInt().toString();
                        controller.earning = newValue;
                      },
                      min: 10000.0,
                      max: 500000.0,
                      divisions: 980,
                      semanticFormatterCallback: (value) =>
                          " ${value < 10000 ? 10000.0.toInt().toString() : value.toInt().toString()}",
                      label: controller.earning.toInt().toString(),
                    )),
              ).marginOnly(
                top: 50.sp,
              ),
              CustomTextField(
                keyboardType: TextInputType.number,
                controller: controller.monthlySalaryController,
                fontsize: 54.sp,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  controller.earning = value.toString().toDouble()! < 10000.0
                      ? 10000.0
                      : value.toString().toDouble()! > 500000.0
                          ? 500000.0
                          : value.toString().toDouble();
                },
              ),
              CompanySuggestion(
                suggestionCallback: (company) {
                  controller.selectedCompany = company;
                },
                hint: 'Current Company Name',
                restClient: restClient,
                textEditingController: controller.companyController,
              ),
              CustomTextField(
                controller: controller.designationController,
                textField: 'Designation in Current Company',
                textInputAction: TextInputAction.next,
                isRequired: true,
              ),
              Row(
                children: [
                  CustomText('Job Vintage in Current Company',
                      color: ColorUtils.textColorLight, fontSize: 34.sp),
                  CustomText(' (in years)',
                      color: ColorUtils.greylight, fontSize: 28.sp),
                ],
              ).marginOnly(top: 50.sp),
              Obx(() => Wrap(
                    alignment: WrapAlignment.start,
                    children: controller.jobVintages
                        .map(
                          (e) => ActionChip(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: controller.selected_vintage == e
                                        ? ColorUtils.orange
                                        : ColorUtils.greylight,
                                    width: 3.sp),
                                borderRadius: BorderRadius.circular(60.sp)),
                            label: CustomText(
                              e,
                              fontSize: 38.sp,
                              color: controller.selected_vintage == e
                                  ? ColorUtils.orange
                                  : ColorUtils.greylight,
                            ),
                            backgroundColor: ColorUtils.white,
                            labelPadding:
                                EdgeInsets.symmetric(horizontal: 30.sp),
                            onPressed: () => controller.selected_vintage = e,
                          ).marginSymmetric(
                            horizontal: 30.sp,
                          ),
                        )
                        .toList(),
                  )),
              CustomTextField(
                controller: controller.officeemailController,
                textField: office_email.tr,
                isRequired: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
              ),
              PincodeSuggestion(
                pinCodeHelper: controller.ofcPincodeHelper,
                label: 'Office PinCode',
                fontsize: 46.sp,
              ),
              ProgressButton.icon(
                      radius: 100.sp,
                      minWidth: 500.sp,
                      progressIndicator: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      iconedButtons: {
                        ButtonState.idle: IconedButton(
                            text: submit.tr,
                            icon: Icon(
                              Icons.save,
                              size: 0,
                              color: ColorUtils.white,
                            ),
                            color: ColorUtils.textColorLight),
                        ButtonState.loading: IconedButton(
                            text: "Verifying", color: ColorUtils.orange),
                        ButtonState.fail: IconedButton(
                            text: submit.tr,
                            icon: Icon(Icons.save, size: 0, color: Colors.red),
                            color: Colors.red.shade300),
                        ButtonState.success: IconedButton(
                            text: "Success",
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
                      onPressed: () => controller.checkIncomeInfo(),
                      state: controller.pageState.getMatchingButtonState)
                  .alignTo(Alignment.center)
                  .marginOnly(top: 60.sp, bottom: 20.sp)
            ]).marginOnly(left: 20.sp, right: 20.sp));
  }
}
