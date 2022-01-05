import 'package:bank_sathi/Helpers/DottedLine.dart';
import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/custom_paints/MyPainter.dart';
import 'package:bank_sathi/db/db_controller.dart';
import 'package:bank_sathi/modules/register_module/controllers/register_controller.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/ButtonState.dart';
import 'package:bank_sathi/widgets/IconedButton.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:bank_sathi/widgets/dotterd_border.dart';
import 'package:bank_sathi/widgets/image_picker_widget.dart';
import 'package:bank_sathi/widgets/pincode_suggestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:lottie/lottie.dart';

class Register extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(1080, 2280));
    var height = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            painter: MyPainter(),
            child: Container(
              width: Get.width,
              height: Get.width,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                AspectRatio(
                    aspectRatio: 485 / 626,
                    child: RepaintBoundary(
                        key: controller.cardKey,
                        child: Container(
                            child: Card(
                                margin: EdgeInsets.all(1.sp),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 6,
                                color: '#F2F3F8'.hexToColor(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.sp),
                                ),
                                child: LayoutBuilder(builder:
                                    (BuildContext context,
                                        BoxConstraints constraints) {
                                  return Stack(children: [
                                    Image.asset(
                                        'assets/images/new_images/visiting_card.jpg'),
                                    Positioned.fill(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Stack(children: [
                                              CircleAvatar(
                                                  radius:
                                                      constraints.maxHeight *
                                                          .19,
                                                  backgroundColor:
                                                      ColorUtils.white,
                                                  child: Card(
                                                    child: Obx(() =>
                                                        CustomImage.network(
                                                            controller.user
                                                                .profile_photo,
                                                            height: constraints
                                                                    .maxHeight *
                                                                .36,
                                                            width: constraints
                                                                    .maxHeight *
                                                                .36,
                                                            errorWidget:
                                                                UnconstrainedBox(
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/images/new_images/user.svg',
                                                                color: ColorUtils
                                                                    .greyshade,
                                                                height: 200.sp,
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                              ),
                                                            ),
                                                            fit: BoxFit.fill)),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    1000.sp)),
                                                    clipBehavior: Clip
                                                        .antiAliasWithSaveLayer,
                                                  )),
                                              Positioned(
                                                  right: 30.sp,
                                                  top: constraints.maxHeight *
                                                      .28,
                                                  child: ImagePickerWidget(
                                                    onFilePicked: (file) {
                                                      controller
                                                          .uploadProfilePic(
                                                              file);
                                                    },
                                                    cropRatio: [
                                                      CropAspectRatioPreset
                                                          .square
                                                    ],
                                                    showPreview: false,
                                                    child: Card(
                                                      color: ColorUtils.orange,
                                                      child: SvgPicture.asset(
                                                              'assets/images/new_images/profile_image/camera.svg',
                                                              color: ColorUtils
                                                                  .white_bg,
                                                              height: 30.sp)
                                                          .marginAll(25.sp),
                                                      shape: CircleBorder(),
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                    ),
                                                  ))
                                            ]),
                                            Obx(() => Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CustomText(
                                                          controller.name
                                                                  .toString()
                                                                  .isEmpty
                                                              ? your_full_name
                                                                  .tr
                                                                  .toUpperCase()
                                                              : controller.name
                                                                  .toString()
                                                                  .toUpperCase(),
                                                          fontSize: 56.sp,
                                                          color: ColorUtils
                                                              .textColor,
                                                          fontweight:
                                                              Weight.BOLD,
                                                          textAlign:
                                                              TextAlign.center),
                                                      Visibility(
                                                          visible: controller
                                                              .name
                                                              .toString()
                                                              .isNotEmpty,
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/images/new_images/verify.svg',
                                                            width: 50.sp,
                                                          ).marginOnly(
                                                                  left: 10.sp))
                                                    ]).marginOnly(
                                                    left: 20.sp,
                                                    right: 20.sp,
                                                    top: constraints.maxHeight *
                                                        .11)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CustomText(
                                                    '(${advisor_code.tr} - ',
                                                    fontSize: 34.sp,
                                                    color: ColorUtils.orange,
                                                    textAlign:
                                                        TextAlign.center),
                                                Obx(() => CustomText(
                                                    (controller.pincode
                                                            .toString()
                                                            .isEmpty
                                                        ? 'xxxxxx)'
                                                        : controller.pincode
                                                                .toString() +
                                                            '/XX)'),
                                                    fontSize: 34.sp,
                                                    color: controller.pincode
                                                            .toString()
                                                            .isEmpty
                                                        ? ColorUtils.silver
                                                        : ColorUtils.orange,
                                                    textAlign:
                                                        TextAlign.center)),
                                              ],
                                            ),
                                            Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                      width: 60.sp,
                                                      height: 60.sp,
                                                      child: UnconstrainedBox(
                                                          child:
                                                              SvgPicture.asset(
                                                        'assets/images/new_images/mail.svg',
                                                        width: 50.sp,
                                                        color: ColorUtils.black,
                                                        fit: BoxFit.scaleDown,
                                                      ))),
                                                  Container(
                                                    constraints: BoxConstraints(
                                                        maxWidth:
                                                            Get.width * .65),
                                                    child: Obx(() => CustomText(
                                                          controller
                                                                  .email.isEmpty
                                                              ? enter_email.tr
                                                              : controller
                                                                  .email,
                                                          softWrap: true,
                                                          color: controller
                                                                  .email.isEmpty
                                                              ? ColorUtils
                                                                  .silver
                                                              : ColorUtils
                                                                  .textColorLight,
                                                          fontSize: 40.sp,
                                                        )),
                                                  ).paddingOnly(left: 20.sp),
                                                ]).marginOnly(
                                                top: 40.sp,
                                                left: 160.sp,
                                                right: 40.sp),
                                            Row(children: <Widget>[
                                              Container(
                                                  width: 60.sp,
                                                  height: 60.sp,
                                                  child: UnconstrainedBox(
                                                      child: SvgPicture.asset(
                                                    'assets/images/new_images/call.svg',
                                                    width: 50.sp,
                                                    color: ColorUtils.black,
                                                    fit: BoxFit.scaleDown,
                                                  ))),
                                              Container(
                                                  constraints: BoxConstraints(
                                                      maxWidth: Get.width * .8),
                                                  child: CustomText(
                                                    '+91 ' +
                                                        controller.prefManager
                                                            .getMobile()
                                                            .toString(),
                                                    softWrap: true,
                                                    color: ColorUtils
                                                        .textColorLight,
                                                    fontSize: 40.sp,
                                                  )).paddingOnly(left: 20.sp)
                                            ]).marginOnly(
                                                top: 30.sp,
                                                left: 160.sp,
                                                right: 40.sp),
                                          ]),
                                      top: constraints.maxHeight * .1,
                                    )
                                  ]);
                                }))))),
                BasePageView(
                    controller: controller,
                    idleWidget: Obx(() => controller.currentStep < 3
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(() => DottedBorder(
                                      borderType: BorderType.Circle,
                                      color: controller.currentStep >= 0
                                          ? ColorUtils.greyshade
                                          : ColorUtils.white_dull,
                                      strokeWidth: 1.5,
                                      dashPattern: controller.currentStep == 0
                                          ? controller.dash_circle
                                          : <double>[3, 1],
                                      child: CircleAvatar(
                                          radius: 80.sp,
                                          backgroundColor:
                                              controller.currentStep >= 0
                                                  ? ColorUtils.orange
                                                  : '#F2F3F7'.hexToColor(),
                                          child: UnconstrainedBox(
                                              child: SizedBox(
                                                  width: 80.sp,
                                                  height: 80.sp,
                                                  child: SvgPicture.asset(
                                                    'assets/images/new_images/id.svg',
                                                    width: 80.sp,
                                                    height: 80.sp,
                                                    color: controller
                                                                .currentStep >=
                                                            0
                                                        ? ColorUtils.white
                                                        : '#888FB1'
                                                            .hexToColor(),
                                                    fit: BoxFit.scaleDown,
                                                  )))).marginAll(5.sp))),
                                  Expanded(
                                      child: Obx(() => DottedLine(
                                            dashColor:
                                                controller.currentStep >= 1
                                                    ? ColorUtils.greyshade
                                                    : ColorUtils.white_dull,
                                          ))),
                                  Obx(() => DottedBorder(
                                      borderType: BorderType.Circle,
                                      color: controller.currentStep >= 1
                                          ? ColorUtils.greyshade
                                          : ColorUtils.white_dull,
                                      strokeWidth: 1.5,
                                      dashPattern: controller.currentStep == 1
                                          ? controller.dash_circle
                                          : <double>[3, 1],
                                      child: CircleAvatar(
                                          radius: 80.sp,
                                          backgroundColor:
                                              controller.currentStep >= 1
                                                  ? ColorUtils.orange
                                                  : '#F2F3F7'.hexToColor(),
                                          child: UnconstrainedBox(
                                              child: SizedBox(
                                                  width: 80.sp,
                                                  height: 80.sp,
                                                  child: SvgPicture.asset(
                                                    'assets/images/new_images/referral_new.svg',
                                                    width: 80.sp,
                                                    height: 80.sp,
                                                    color: controller
                                                                .currentStep >=
                                                            1
                                                        ? ColorUtils.white
                                                        : '#888FB1'
                                                            .hexToColor(),
                                                    fit: BoxFit.scaleDown,
                                                  )))).marginAll(5.sp))),
                                  Expanded(
                                      child: Obx(() => DottedLine(
                                            dashColor:
                                                controller.currentStep >= 2
                                                    ? ColorUtils.greyshade
                                                    : ColorUtils.white_dull,
                                          ))),
                                  Obx(() => DottedBorder(
                                      borderType: BorderType.Circle,
                                      color: controller.currentStep >= 2
                                          ? ColorUtils.greyshade
                                          : ColorUtils.white_dull,
                                      strokeWidth: 1.5,
                                      dashPattern: controller.currentStep == 2
                                          ? controller.dash_circle
                                          : <double>[3, 1],
                                      child: CircleAvatar(
                                          radius: 80.sp,
                                          backgroundColor:
                                              controller.currentStep >= 2
                                                  ? ColorUtils.orange
                                                  : '#F2F3F7'.hexToColor(),
                                          child: UnconstrainedBox(
                                              child: SizedBox(
                                            width: 80.sp,
                                            height: 80.sp,
                                            child: SvgPicture.asset(
                                              'assets/images/new_images/location.svg',
                                              width: 80.sp,
                                              color: controller.currentStep >= 2
                                                  ? ColorUtils.white
                                                  : '#888FB1'.hexToColor(),
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ))).marginAll(5.sp))),
                                ],
                              ).marginSymmetric(
                                  horizontal: 15.sp, vertical: 60.sp),
                              Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(50.sp)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorUtils.greyshade
                                            .withOpacity(0.08),
                                        spreadRadius: 30.sp,
                                        blurRadius: 70.sp,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: AnimatedSwitcher(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      return FadeTransition(
                                        child: child,
                                        alwaysIncludeSemantics: true,
                                        opacity: animation,
                                      );
                                    },
                                    child: Container(
                                      key:
                                          ValueKey<int>(controller.currentStep),
                                      child: Form(
                                              key: controller.globalKey,
                                              child: controller.currentStep == 0
                                                  ? _step1()
                                                  : controller.currentStep == 1
                                                      ? _step3()
                                                      : _step2())
                                          .marginOnly(
                                              left: 60.sp,
                                              right: 60.sp,
                                              bottom: 60.sp),
                                    ),
                                  )),
                              Obx(() => ProgressButton.icon(
                                      radius: 200.sp,
                                      progressIndicator:
                                          CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                      iconedButtons: {
                                        ButtonState.idle: IconedButton(
                                            text: controller.currentStep <= 2
                                                ? next.tr
                                                : finish.tr,
                                            icon: controller.currentStep <= 2
                                                ? Icon(
                                                    Icons.arrow_right_alt_sharp,
                                                    color: ColorUtils.white)
                                                : Icon(Icons.done,
                                                    color: ColorUtils.white),
                                            color: ColorUtils.black),
                                        ButtonState.loading: IconedButton(
                                            text: updating.tr,
                                            color: ColorUtils.orange),
                                        ButtonState.fail: IconedButton(
                                            text: failed.tr,
                                            icon: Icon(Icons.cancel,
                                                color: Colors.white),
                                            color: Colors.red.shade300),
                                        ButtonState.success: IconedButton(
                                            text: success.tr,
                                            icon: Icon(
                                              Icons.check_circle,
                                              color: Colors.white,
                                            ),
                                            color: Colors.green.shade400)
                                      },
                                      textStyle:
                                          StyleUtils.textStyleMediumPoppins(
                                              color: ColorUtils.white,
                                              weight: FontWeight.w600),
                                      onPressed: () => controller.validation(),
                                      state: controller
                                          .pageState.getMatchingButtonState)
                                  .marginOnly(top: 40.sp)),
                            ],
                          )
                        : Container(
                            child: Stack(
                              children: [
                                Lottie.asset(
                                    'assets/animation/party_popper_animation.json'),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 150.sp,
                                      ),
                                      CustomText(
                                        congratulations.tr,
                                        color: ColorUtils.orange,
                                        fontweight: Weight.BOLD,
                                        fontSize: 76.sp,
                                      ).marginSymmetric(horizontal: 60.sp),
                                      SizedBox(
                                        height: 40.sp,
                                      ),
                                      CustomText(
                                        you_now_advisor.tr,
                                        color: ColorUtils.textColor,
                                        bold: true,
                                        fontSize: 46.sp,
                                      ).marginSymmetric(
                                          horizontal: 50.sp, vertical: 40.sp),
                                      CustomText(
                                        add_lead_start_earn.tr,
                                        fontweight: Weight.LIGHT,
                                        color: ColorUtils.textColorLight,
                                        textAlign: TextAlign.center,
                                        fontSize: 38.sp,
                                      ).marginSymmetric(horizontal: 50.sp),
                                      SizedBox(
                                        height: 100.sp,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                              child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ColorUtils.blackLight,
                                                  width: 3.sp),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(75.sp)),
                                            ),
                                            height: 150.sp,
                                            child: Center(
                                              child: CustomText(
                                                share_friends.tr,
                                                color:
                                                    ColorUtils.textColorLight,
                                                fontweight: Weight.NORMAL,
                                              ).onClick(controller.shareCard),
                                            ),
                                          )),
                                          SizedBox(
                                            width: 50.sp,
                                          ),
                                          Expanded(
                                              child: Container(
                                            height: 150.sp,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(75.sp)),
                                              color: ColorUtils.orange,
                                            ),
                                            child: Center(
                                              child: CustomText(
                                                start_earning.tr,
                                                color: ColorUtils.white,
                                                fontweight: Weight.NORMAL,
                                              ).onClick(() => Get.offAllNamed(
                                                  Routes.DASHBOARD)),
                                            ),
                                          ))
                                        ],
                                      ).marginSymmetric(horizontal: 20.sp)
                                    ])
                              ],
                            ),
                          ))),
              ],
            ).marginAll(50.sp),
          ).marginOnly(top: height)
        ],
      ),
    );
  }

  Widget _step1() {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      CustomTextField(
        controller: controller.firstNameController,
        hint: your_full_name.tr,
        isRequired: true,
        keyboardType: TextInputType.name,
        onChanged: (text) {
          if(text!.contains(RegExp("[0-9.!#@%&'*+-/,=?^_`{|<>}~;:]")) ){
            Fluttertoast.showToast(msg: 'Number not allowed.');
            controller.firstNameController.text = '';
          }
          controller.name = text;
        },
      ),
      PincodeSuggestion(
        label: enter_pin_code_register.tr,
        pinCodeHelper: controller.pinCodeHelper,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        verticalMargin: 0,
        onSuggestionSelected: (pin) async {
          CityRow cityRow = await controller.pinCodeHelper.dbController
              .getCityByCityId(pin.city_id!);
          StateRow stateRow = await controller.pinCodeHelper.dbController
              .getStateById(cityRow.state_id!);
          controller.pinAddress = cityRow.city_name.toString() +
              ', ' +
              stateRow.state_name.toString();
        },
      ).marginOnly(bottom: 20.sp)
    ]);
  }

  Widget _step2() {
    return CustomTextField(
      controller: controller.addressContoller,
      hint: enter_house_no.tr,
      isRequired: true,
      minLines: 3,
      onChanged: (text) {
        controller.address = text;
      },
    ).marginOnly(top: 30.sp);
  }

  Widget _step3() {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      CustomTextField(
        controller: controller.emailController,
        hint: enter_email.tr,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        isRequired: true,
        onChanged: (text) {
          controller.email = text;
        },
      ),
      CustomTextField(
        controller: controller.referralController,
        hint: referral_code.tr,
        keyboardType: TextInputType.number,
        isRequired: true,
        isEnabled: controller.enableReferralCode,
        validator: (value) {
          if ((value == null && value.isEmpty)) {
            return referral_without_slash.tr;
          }else if ((value != null && !value.isEmpty) &&
              !value.toString().isNumericOnly) {
            return referral_without_slash.tr;
          } else if ((value != null && !value.isEmpty) &&
              value.toString().length < 8) {
            return wrong_code.tr;
          }
          return null;
        },
        textInputAction: TextInputAction.done,
      ),
    ]);
  }
}
