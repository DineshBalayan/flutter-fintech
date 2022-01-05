import 'package:animations/animations.dart';
import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/response/get_dropdown_data_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/custom_paints/MyPainter.dart';
import 'package:bank_sathi/modules/credit_card_module/controllers/credit_card_lead_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/ButtonState.dart';
import 'package:bank_sathi/widgets/IconedButton.dart';
import 'package:bank_sathi/widgets/company_suggestion.dart';
import 'package:bank_sathi/widgets/custom_drop_down.dart';
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

class CreditCardLead extends GetView<CreditCardLeadController> {
  DashboardController dashController = Get.find<DashboardController>();
  SharedAxisTransitionType? _transitionType =
      SharedAxisTransitionType.horizontal;

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
            CustomPaint(
              painter: MyPainter(),
              child: Container(
                width: Get.width,
                height: Get.height * 0.37,
              ),
            ),
            Positioned(
              child: SvgPicture.asset(
                'assets/images/new_images/top_curve.svg',
                width: Get.width - (Get.width * .2),
                color: ColorUtils.black_shadow,
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
                    color: ColorUtils.white,
                  )).onClick(() => Get.back()),
                  title: CustomText(
                    customer_information.tr,
                    color: ColorUtils.white,
                  ),
                  actions: [
                    WidgetUtil.getNotificationIcon(),
                    WidgetUtil.getSupportIcon()
                  ],
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                      credit_card_title.tr,
                      fontSize: 36.sp,
                      color: ColorUtils.greylight,
                    ).marginOnly(
                        left: 60.sp, right: 60.sp, top: 80.sp, bottom: 20.sp),
                    SizedBox(
                      height: 150.sp,
                    ),
                    Expanded(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Visibility(
                              visible: controller.current_step < 5,
                              child: Expanded(
                                  flex: 1,
                                  child: SingleChildScrollView(
                                      physics: NeverScrollableScrollPhysics(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 15.sp,
                                          ),
                                          Obx(() => Container(
                                                  decoration: BoxDecoration(
                                                    color: controller
                                                                .current_step >=
                                                            1
                                                        ? ColorUtils
                                                            .black_gr_light
                                                        : ColorUtils.white_dull,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  width: 60.sp,
                                                  height: 60.sp,
                                                  child: CustomText(
                                                    '1',
                                                    textAlign: TextAlign.center,
                                                    color: ColorUtils.white,
                                                    fontSize: 35.sp,
                                                  ).alignTo(Alignment.center))
                                              .onClick(() =>
                                                  controller.current_step > 1
                                                      ? controller
                                                          .current_step = 1
                                                      : null)),
                                          Obx(() => SizedBox(
                                                height: 200.sp,
                                                child: VerticalDivider(
                                                  color: controller
                                                              .current_step >=
                                                          2
                                                      ? ColorUtils
                                                          .black_gr_light
                                                      : ColorUtils.white_dull,
                                                  width: 4,
                                                  thickness: 1,
                                                ),
                                              )),
                                          Obx(() => Container(
                                                  decoration: BoxDecoration(
                                                    color: controller
                                                                .current_step >=
                                                            2
                                                        ? ColorUtils
                                                            .black_gr_light
                                                        : ColorUtils.white_dull,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  width: 60.sp,
                                                  height: 60.sp,
                                                  child: CustomText(
                                                    '2',
                                                    textAlign: TextAlign.center,
                                                    color: ColorUtils.white,
                                                    fontSize: 35.sp,
                                                  ).alignTo(Alignment.center))
                                              .onClick(() =>
                                                  controller.current_step > 2
                                                      ? controller
                                                          .current_step = 2
                                                      : null)),
                                          Obx(() => SizedBox(
                                                height: 200.sp,
                                                child: VerticalDivider(
                                                  color: controller
                                                              .current_step >=
                                                          3
                                                      ? ColorUtils
                                                          .black_gr_light
                                                      : ColorUtils.white_dull,
                                                  width: 4,
                                                  thickness: 1,
                                                ),
                                              )),
                                          Obx(() => Container(
                                                  decoration: BoxDecoration(
                                                    color: controller
                                                                .current_step >=
                                                            3
                                                        ? ColorUtils
                                                            .black_gr_light
                                                        : ColorUtils.white_dull,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  width: 60.sp,
                                                  height: 60.sp,
                                                  child: CustomText(
                                                    '3',
                                                    textAlign: TextAlign.center,
                                                    color: ColorUtils.white,
                                                    fontSize: 35.sp,
                                                  ).alignTo(Alignment.center))
                                              .onClick(() =>
                                                  controller.current_step > 3
                                                      ? controller
                                                          .current_step = 3
                                                      : null)),
                                          Obx(() => SizedBox(
                                                height: 200.sp,
                                                child: VerticalDivider(
                                                  color: controller
                                                              .current_step >=
                                                          4
                                                      ? ColorUtils
                                                          .black_gr_light
                                                      : ColorUtils.white_dull,
                                                  width: 4,
                                                  thickness: 1,
                                                ),
                                              )),
                                          Obx(() => Container(
                                                  decoration: BoxDecoration(
                                                    color: controller
                                                                .current_step >=
                                                            4
                                                        ? ColorUtils
                                                            .black_gr_light
                                                        : ColorUtils.white_dull,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  width: 60.sp,
                                                  height: 60.sp,
                                                  child: CustomText(
                                                    '4',
                                                    textAlign: TextAlign.center,
                                                    color: ColorUtils.white,
                                                    fontSize: 35.sp,
                                                  ).alignTo(Alignment.center))
                                              .onClick(() =>
                                                  controller.current_step > 4
                                                      ? controller
                                                          .current_step = 4
                                                      : null)),
                                        ],
                                      )))),
                          Obx(() => Expanded(
                                flex: 5,
                                child: SingleChildScrollView(
                                  child: PageTransitionSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    reverse: true,
                                    transitionBuilder: (
                                      Widget child,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation,
                                    ) {
                                      return SharedAxisTransition(
                                        child: child,
                                        animation: animation,
                                        secondaryAnimation: secondaryAnimation,
                                        transitionType: _transitionType!,
                                      );
                                    },
                                    child: controller.current_step == 1
                                        ? step1()
                                        : controller.current_step == 2
                                            ? step2()
                                            : controller.current_step == 3
                                                ? step3()
                                                : controller.current_step == 4
                                                    ? step4()
                                                    : notEligible(),
                                  ),
                                ),
                              )),
                        ])),
                  ],
                )),
          ]);
        })),
        onWillPop: () async => controller.onwillpop());
  }

  Widget step1() {
    return Container(
      color: Colors.white,
      child: Form(
        key: controller.globalKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Enter Your ',
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.textColor,
                            weight: FontWeight.w600,
                            fontSize: 54.sp)),
                    TextSpan(
                        text: 'PAN Number\n',
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.orange_gr_light,
                            weight: FontWeight.w600,
                            fontSize: 54.sp)),
                    TextSpan(
                        text:
                            'Enter the 10 digit PAN Card Number to get your profile more stronger.',
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.grey,
                            weight: FontWeight.w300,
                            fontSize: 40.sp)),
                  ],
                )).alignTo(Alignment.topLeft),
            CustomTextField(
              maxLength: 10,
              isRequired: true,
              fontsize: 48.sp,
              validator: (String value) {
                Pattern pattern = "[A-Z]{5}[0-9]{4}[A-Z]{1}";
                RegExp regex = new RegExp(pattern.toString());
                if (!regex.hasMatch(value)) {
                  return correct_pan_msg.tr;
                }
                return null;
              },
              controller: controller.panNumberController,
              textField: pan_card_number.tr,
              textCapitalization: true,
            ).marginOnly(top: 50.sp),
            Obx(
              () => Visibility(
                  visible: controller.ispanCard,
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Your Name is  :  ',
                              style: StyleUtils.textStyleNormalPoppins(
                                  color: ColorUtils.greylight,
                                  weight: FontWeight.w400,
                                  fontSize: 40.sp)),
                          TextSpan(
                              text:
                                  '' + controller.nameOnCard.toString() + '  ',
                              style: StyleUtils.textStyleNormalPoppins(
                                  color: ColorUtils.grey,
                                  weight: FontWeight.w500,
                                  fontSize: 44.sp)),
                          WidgetSpan(
                              child: SvgPicture.asset(
                            'assets/images/new_images/verify.svg',
                            height: 50.sp,
                            width: 50.sp,
                          ))
                        ],
                      )).marginOnly(top: 60.sp, bottom: 40.sp)),
            ),
            Obx(() => Visibility(
                visible: controller.ispanCard,
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Your Residence ',
                            style: StyleUtils.textStyleNormalPoppins(
                                color: ColorUtils.textColor,
                                weight: FontWeight.w600,
                                fontSize: 54.sp)),
                        TextSpan(
                            text: 'Pincode:',
                            style: StyleUtils.textStyleNormalPoppins(
                                color: ColorUtils.orange_gr_light,
                                weight: FontWeight.w600,
                                fontSize: 54.sp)),
                      ],
                    )).marginOnly(top: 40.sp))),
            Obx(() => Visibility(
                  visible: controller.ispanCard,
                  child: PincodeSuggestion(
                    pinCodeHelper: controller.pinCodeHelper,
                    fontsize: 46.sp,
                  ),
                )),
            Obx(() => Visibility(
                visible: !controller.ispanCard,
                child: ProgressButton.icon(
                        radius: 100.sp,
                        progressIndicator: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        iconedButtons: {
                          ButtonState.idle: IconedButton(
                              text: verify.tr,
                              icon: Icon(
                                Icons.domain_verification,
                                color: ColorUtils.orange_gr_light,
                              ),
                              color: ColorUtils.textColorLight),
                          ButtonState.loading: IconedButton(
                              text: "Verifying", color: ColorUtils.orange),
                          ButtonState.fail: IconedButton(
                              text: "Verify Again",
                              icon: Icon(Icons.domain_verification,
                                  color: Colors.white),
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
                        onPressed: () => controller.verifyPancard(),
                        state: controller.pageState.getMatchingButtonState)
                    .marginOnly(top: 60.sp, bottom: 40.sp))),
            Obx(() => Visibility(
                visible: controller.ispanCard,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        color: ColorUtils.orange_gr_light,
                        child: CustomText(
                          'Re Enter',
                          fontSize: 40.sp,
                          color: ColorUtils.white,
                        ).marginAll(40.sp).alignTo(Alignment.center),
                      ).marginAll(3).onClick(() {
                        controller.pageState = PageStates.PAGE_IDLE;
                        controller.ispanCard = false;
                      })),
                      Expanded(
                              child: ProgressButton.icon(
                                      radius: 100.sp,
                                      progressIndicator:
                                          CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                      iconedButtons: {
                                        ButtonState.idle: IconedButton(
                                            text: ' Verify Area ',
                                            icon: Icon(
                                              Icons.domain_verification_sharp,
                                              color: ColorUtils.orange_gr_light,
                                            ),
                                            color: ColorUtils.textColorLight),
                                        ButtonState.loading: IconedButton(
                                            text: "Verifying",
                                            color: ColorUtils.orange),
                                        ButtonState.fail: IconedButton(
                                            text: "Verify Again",
                                            icon: Icon(
                                                Icons.domain_verification,
                                                color: Colors.white),
                                            color: Colors.red.shade300),
                                        ButtonState.success: IconedButton(
                                            text: "Success",
                                            icon: Icon(
                                              Icons.check_circle,
                                              color: Colors.white,
                                            ),
                                            color: Colors.green.shade400)
                                      },
                                      textStyle:
                                          StyleUtils.textStyleNormalPoppins(
                                              color: ColorUtils.white,
                                              fontSize: 40.sp,
                                              weight: FontWeight.w500),
                                      onPressed: () => controller.verifyArea(),
                                      state: controller
                                          .pageState.getMatchingButtonState)
                                  .marginAll(3))
                          .onClick(() => controller.verifyArea())
                    ]).marginOnly(top: 70.sp))),
            Obx(
              () => Visibility(
                  visible: controller.pageState == PageStates.PAGE_BUTTON_ERROR,
                  child: CustomText(
                    'Error: ' + controller.err_name,
                    color: ColorUtils.red,
                  ).marginOnly(top: 60.sp, bottom: 40.sp)),
            ),
          ],
        ).marginOnly(right: 30.sp),
      ),
    );
  }

  Widget step2() {
    return Container(
        color: Colors.white,
        child: Form(
          key: controller.globalKey2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'You are ',
                          style: StyleUtils.textStyleNormalPoppins(
                              color: ColorUtils.textColor,
                              weight: FontWeight.w600,
                              fontSize: 54.sp)),
                      TextSpan(
                          text: 'Working As:',
                          style: StyleUtils.textStyleNormalPoppins(
                              color: ColorUtils.orange_gr_light,
                              weight: FontWeight.w600,
                              fontSize: 54.sp)),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() => Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.sp),
                          border: Border.all(
                              width: 2.sp,
                              color: controller.isSalaried
                                  ? ColorUtils.orange_gr_light
                                  : ColorUtils.textColorLight),
                          color: ColorUtils.white,
                        ),
                        child: CustomText(
                          'Salaried',
                          color: controller.isSalaried
                              ? ColorUtils.orange_gr_light
                              : ColorUtils.greyshade,
                        ).alignTo(Alignment.center).marginAll(10.sp),
                      )
                          .marginOnly(right: 30.sp)
                          .onClick(() => controller.isSalaried = true))),
                  Obx(() => Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.sp),
                          border: Border.all(
                              width: 2.sp,
                              color: controller.isSalaried
                                  ? ColorUtils.greyshade
                                  : ColorUtils.orange_gr_light),
                          color: ColorUtils.white,
                        ),
                        child: CustomText(
                          'Non Salaried',
                          color: controller.isSalaried
                              ? ColorUtils.greylight
                              : ColorUtils.orange_gr_light,
                        ).alignTo(Alignment.center).marginAll(10.sp),
                      )
                          .marginOnly(left: 30.sp, right: 30.sp)
                          .onClick(() => controller.isSalaried = false))),
                ],
              ).marginOnly(top: 70.sp),
              Obx(
                () => RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: controller.isSalaried ? 'Monthly ' : 'ITR ',
                            style: StyleUtils.textStyleNormalPoppins(
                                color: ColorUtils.textColor,
                                weight: FontWeight.w600,
                                fontSize: 54.sp)),
                        TextSpan(
                            text: controller.isSalaried ? 'Salary ' : 'Amount',
                            style: StyleUtils.textStyleNormalPoppins(
                                color: ColorUtils.orange_gr_light,
                                weight: FontWeight.w600,
                                fontSize: 54.sp)),
                      ],
                    )).marginOnly(top: 70.sp),
              ),
              CustomTextField(
                controller: controller.monthlySalaryController,
                textField: controller.isSalaried
                    ? 'Enter current Salary'
                    : 'Enter latest ITR amount',
                isRequired: true,
                fontsize: 48.sp,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
              ).marginOnly(right: 30.sp, top: 15.sp),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: ColorUtils.black_gr_light,
                child: Icon(
                  Icons.navigate_next,
                  size: 100.sp,
                  color: ColorUtils.white,
                ).marginAll(20.sp),
              )
                  .onClick(() => controller.verifySalary())
                  .marginOnly(top: 50.sp, right: 30.sp)
                  .alignTo(Alignment.topRight),
            ],
          ),
        ));
  }

  Widget step3() {
    return Container(
        color: Colors.white,
        child: Form(
          key: controller.globalKey3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Name of your ',
                          style: StyleUtils.textStyleNormalPoppins(
                              color: ColorUtils.textColor,
                              weight: FontWeight.w600,
                              fontSize: 54.sp)),
                      TextSpan(
                          text: controller.isSalaried ? 'Company:' : 'Firm:',
                          style: StyleUtils.textStyleNormalPoppins(
                              color: ColorUtils.orange_gr_light,
                              weight: FontWeight.w600,
                              fontSize: 54.sp)),
                    ],
                  ))),
              CompanySuggestion(
                suggestionCallback: (company) {
                  controller.selectedCompany = company;
                },
                hint: company_name.tr,
                restClient: restClient,
                textEditingController: controller.companyController,
              ).marginOnly(right: 40.sp),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Office ',
                          style: StyleUtils.textStyleNormalPoppins(
                              color: ColorUtils.textColor,
                              weight: FontWeight.w600,
                              fontSize: 54.sp)),
                      TextSpan(
                          text: 'Pincode:',
                          style: StyleUtils.textStyleNormalPoppins(
                              color: ColorUtils.orange_gr_light,
                              weight: FontWeight.w600,
                              fontSize: 54.sp)),
                    ],
                  )).marginOnly(top: 70.sp),
              PincodeSuggestion(
                pinCodeHelper: controller.salariedCodeHelper,
                fontsize: 46.sp,
              ).marginOnly(right: 40.sp),
              Obx(
                () => Visibility(
                        visible: controller.current_step > 2,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: ColorUtils.black_gr_light,
                          child: Icon(
                            Icons.navigate_next,
                            size: 100.sp,
                            color: ColorUtils.white,
                          ).marginAll(20.sp),
                        ).onClick(() => controller.verifyOfficeArea()))
                    .marginOnly(top: 50.sp, right: 30.sp)
                    .alignTo(Alignment.topRight),
              ),
              Obx(
                () => Visibility(
                    visible:
                        controller.pageState == PageStates.PAGE_BUTTON_ERROR,
                    child: CustomText(
                      'Error: ' + controller.err_name1,
                      color: ColorUtils.red,
                    ).marginOnly(bottom: 40.sp)),
              ),
            ],
          ),
        ));
  }

  Widget step4() {
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Do You Have Any ',
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.textColor,
                            weight: FontWeight.w600,
                            fontSize: 54.sp)),
                    TextSpan(
                        text: 'Credit Card?',
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.orange_gr_light,
                            weight: FontWeight.w600,
                            fontSize: 54.sp)),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() => Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.sp),
                        border: Border.all(
                            width: 2.sp,
                            color: controller.isCardExist
                                ? ColorUtils.orange_gr_light
                                : ColorUtils.textColorLight),
                        color: ColorUtils.white,
                      ),
                      child: CustomText(
                        'Yes, I Have',
                        color: controller.isCardExist
                            ? ColorUtils.orange_gr_light
                            : ColorUtils.greyshade,
                      ).alignTo(Alignment.center).marginAll(10.sp),
                    )
                        .marginOnly(right: 30.sp)
                        .onClick(() => controller.isCardExist = true))),
                Obx(() => Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.sp),
                        border: Border.all(
                            width: 2.sp,
                            color: controller.isCardExist
                                ? ColorUtils.greyshade
                                : ColorUtils.orange_gr_light),
                        color: ColorUtils.white,
                      ),
                      child: CustomText(
                        'No, I Don\'t Have',
                        color: controller.isCardExist
                            ? ColorUtils.greylight
                            : ColorUtils.orange_gr_light,
                      ).alignTo(Alignment.center).marginAll(10.sp),
                    )
                        .marginOnly(left: 30.sp, right: 30.sp)
                        .onClick(() => controller.isCardExist = false))),
              ],
            ).marginOnly(top: 70.sp),
            Obx(
              () => Visibility(
                  visible: controller.isCardExist,
                  child: Form(
                    key: controller.cardglobalKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Details of ',
                                    style: StyleUtils.textStyleNormalPoppins(
                                        color: ColorUtils.textColor,
                                        weight: FontWeight.w600,
                                        fontSize: 44.sp)),
                                TextSpan(
                                    text: 'Highest Limit ',
                                    style: StyleUtils.textStyleNormalPoppins(
                                        color: ColorUtils.orange_gr_light,
                                        weight: FontWeight.w600,
                                        fontSize: 46.sp)),
                                TextSpan(
                                    text: 'Credit card.',
                                    style: StyleUtils.textStyleNormalPoppins(
                                        color: ColorUtils.textColor,
                                        weight: FontWeight.w600,
                                        fontSize: 44.sp)),
                              ],
                            )).alignTo(Alignment.topLeft),
                        Obx(
                          () => CustomDropDown(
                              hint: select_bank.tr,
                              verticalMargin: 30.sp,
                              value: controller.selectedBank,
                              items: controller.bankList
                                  .map((e) => DropdownMenuItem<Bank>(
                                        child: CustomText(e.bank_title),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                controller.selectedBank = val;
                              }),
                        ),
                        RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'What is ',
                                        style:
                                            StyleUtils.textStyleNormalPoppins(
                                                color: ColorUtils.textColor,
                                                weight: FontWeight.w600,
                                                fontSize: 42.sp)),
                                    TextSpan(
                                        text: 'Available limit?',
                                        style:
                                            StyleUtils.textStyleNormalPoppins(
                                                color:
                                                    ColorUtils.orange_gr_light,
                                                weight: FontWeight.w600,
                                                fontSize: 42.sp)),
                                  ],
                                ))
                            .alignTo(Alignment.topLeft)
                            .marginOnly(top: 30.sp),
                        CustomTextField(
                          isRequired: true,
                          controller: controller.ava_limitController,
                          textField: available_limit.tr,
                          fontsize: 44.sp,
                          keyboardType: TextInputType.number,
                        ),
                        RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'What is ',
                                        style:
                                            StyleUtils.textStyleNormalPoppins(
                                                color: ColorUtils.textColor,
                                                weight: FontWeight.w600,
                                                fontSize: 42.sp)),
                                    TextSpan(
                                        text: 'Total limit?',
                                        style:
                                            StyleUtils.textStyleNormalPoppins(
                                                color:
                                                    ColorUtils.orange_gr_light,
                                                weight: FontWeight.w600,
                                                fontSize: 42.sp)),
                                  ],
                                ))
                            .alignTo(Alignment.topLeft)
                            .marginOnly(top: 30.sp),
                        CustomTextField(
                          isRequired: true,
                          controller: controller.total_limitController,
                          textField: limit.tr,
                          fontsize: 44.sp,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                        ),
                        RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'What is your ',
                                        style:
                                            StyleUtils.textStyleNormalPoppins(
                                                color: ColorUtils.textColor,
                                                weight: FontWeight.w600,
                                                fontSize: 42.sp)),
                                    TextSpan(
                                        text: 'Card vintage?',
                                        style:
                                            StyleUtils.textStyleNormalPoppins(
                                                color:
                                                    ColorUtils.orange_gr_light,
                                                weight: FontWeight.w600,
                                                fontSize: 42.sp)),
                                  ],
                                ))
                            .alignTo(Alignment.topLeft)
                            .marginOnly(top: 30.sp),
                        Obx(
                          () => CustomDropDown(
                              hint: card_vintage.tr,
                              value: controller.vintageType,
                              items: controller.vintageList
                                  .map((e) => DropdownMenuItem<String>(
                                        child: CustomText(
                                          e,
                                        ),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (val) => controller.vintageType = val),
                        ),
                      ],
                    ).marginOnly(top: 50.sp),
                  ).marginOnly(top: 30.sp, right: 30.sp)),
            ),
            Obx(() => ProgressButton.icon(
                    radius: 100.sp,
                    maxWidth: 250.0,
                    progressIndicator: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    iconedButtons: {
                      ButtonState.idle: IconedButton(
                          text: ' Find Credit Cards ',
                          icon: Icon(
                            Icons.search_outlined,
                            color: ColorUtils.orange_gr_light,
                          ),
                          color: ColorUtils.textColorLight),
                      ButtonState.loading: IconedButton(
                          text: "Finding", color: ColorUtils.orange),
                      ButtonState.fail: IconedButton(
                          text: " Check Eligibility ",
                          icon: Icon(Icons.domain_verification,
                              color: Colors.white),
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
                        fontSize: 40.sp,
                        weight: FontWeight.w500),
                    onPressed: () => controller.checkEligibility(),
                    state: controller.pageState.getMatchingButtonState)
                .alignTo(Alignment.center)
                .marginOnly(
                  top: controller.isCardExist ? 50.sp : 150.sp,
                ))
          ],
        ));
  }

  Widget notEligible() {
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/new_images/error_card.png',
            ),
            Obx(() => RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'OOPS,\n',
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.orange_gr_light,
                            weight: FontWeight.w600,
                            fontSize: 54.sp)),
                    TextSpan(
                        text: controller.eligilble_err_title
                            .toString()
                            .toUpperCase(),
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.textColor,
                            weight: FontWeight.w600,
                            fontSize: 48.sp)),
                  ],
                ))).marginOnly(top: 30.sp),
            Obx(() => CustomText(
                  controller.eligilble_err_msg,
                  fontSize: 40.sp,
                  color: ColorUtils.grey,
                ).marginOnly(top: 40.sp)),
            SizedBox(
                width: Get.width * 0.6,
                child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80)),
                        color: ColorUtils.orange_gr_light,
                        child: CustomText(
                          'Return to DashBoard',
                          fontSize: 48.sp,
                          color: ColorUtils.white,
                        ).marginOnly(top: 100.sp))
                    .onClick(() => Get.offAllNamed(Routes.DASHBOARD)))
          ],
        ).marginAll(50.sp));
  }
}
