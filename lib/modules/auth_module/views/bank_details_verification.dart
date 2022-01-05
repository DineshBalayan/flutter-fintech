import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Model/response/get_dropdown_data_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/auth_module/controllers/BankDetailsVerificationController.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/widgets/ButtonState.dart';
import 'package:bank_sathi/widgets/IconedButton.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:search_choices/search_choices.dart';

class BankDetailsVerification
    extends GetView<BankDetailsVerificationController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(overflow: Overflow.visible, children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        alignment: Alignment.topRight,
        child: SafeArea(
            child: SvgPicture.asset(
          'assets/images/new_images/top_curve.svg',
          color: ColorUtils.topCurveColor,
          width: Get.width - (Get.width * .2),
        )),
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Form(
                key: controller.globalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 100.sp,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Hi, ',
                              style: StyleUtils.textStyleNormalPoppins(
                                  color: ColorUtils.textColor,
                                  weight: FontWeight.w600,
                                  fontSize: 65.sp)),
                          TextSpan(
                              text: controller.getUserFullName() + ' ',
                              style: StyleUtils.textStyleNormalPoppins(
                                  color: ColorUtils.orange_gr_light,
                                  weight: FontWeight.w600,
                                  fontSize: 65.sp)),
                          WidgetSpan(
                            child: SvgPicture.asset(
                              'assets/images/new_images/verify.svg',
                              width: 55.sp,
                            ),
                          ),
                          TextSpan(
                              text: '\nCongratulations, ',
                              style: StyleUtils.textStyleNormalPoppins(
                                  color: ColorUtils.textColor,
                                  weight: FontWeight.w500,
                                  fontSize: 36.sp)),
                          TextSpan(
                              text:
                                  'You have successfully completed our KYC process. Provide below details in which you would like to receive your payments.',
                              style: StyleUtils.textStyleNormalPoppins(
                                  color: ColorUtils.grey,
                                  weight: FontWeight.w500,
                                  fontSize: 34.sp)),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                  width: 1.0, color: ColorUtils.white_dull),
                              bottom: BorderSide(
                                  width: 1.0, color: ColorUtils.white_dull),
                            ),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  'AADHAR KYC',
                                  fontSize: 40.sp,
                                ),
                                Obx(() =>
                                    controller.user.is_adhar_verified == "1"
                                        ? SvgPicture.asset(
                                            'assets/images/new_images/check.svg',
                                            height: 46.sp,
                                          ).marginOnly(left: 30.sp)
                                        : Icon(
                                            Icons.info_outline,
                                            color: ColorUtils.insta_color3,
                                            size: 56.sp,
                                          ).marginOnly(left: 30.sp)),
                              ],
                            ).marginOnly(
                                top: 30.sp,
                                bottom: 30.sp,
                                left: 50.sp,
                                right: 50.sp),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                  width: 3.sp, color: ColorUtils.white_dull),
                              bottom: BorderSide(
                                  width: 3.sp, color: ColorUtils.white_dull),
                            ),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  'PAN Card KYC',
                                  fontSize: 40.sp,
                                ),
                                Obx(() => controller.user.is_pan_verified == "1"
                                    ? SvgPicture.asset(
                                        'assets/images/new_images/check.svg',
                                        height: 46.sp,
                                      ).marginOnly(left: 30.sp)
                                    : Icon(
                                        Icons.info_outline,
                                        color: ColorUtils.insta_color3,
                                        size: 56.sp,
                                      ).marginOnly(left: 30.sp)),
                              ],
                            ).marginOnly(
                                top: 30.sp,
                                bottom: 30.sp,
                                left: 40.sp,
                                right: 40.sp),
                          ),
                        ),
                      ],
                    ).marginOnly(top: 80.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          'Bank Details Verification',
                          fontSize: 40.sp,
                        ),
                        Icon(
                          Icons.info_outline,
                          color: ColorUtils.insta_color3,
                          size: 60.sp,
                        ).marginOnly(left: 30.sp)
                      ],
                    ).marginOnly(top: 70.sp, left: 15.sp, right: 35.sp),
                    Obx(() => SearchChoices.single(
                        hint: select_bank.tr,
                        value: controller.selectedBank,
                        isExpanded: true,
                        displayClearIcon: false,
                        items: controller.bankList
                            .map((e) => DropdownMenuItem<Bank>(
                                  child: CustomText(
                                    e.bank_title,
                                    fontweight: Weight.LIGHT,
                                  ),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (val) {
                          print(val);
                          controller.selectedBank = val;
                        })),
                    Obx(() => CustomTextField(
                          isEnabled: !controller.isVerified,
                          controller: controller.accountNumber,
                          textField: account_number.tr,
                          isRequired: true,
                          keyboardType: TextInputType.number,
                        )),
                    Obx(() => CustomTextField(
                          isEnabled: !controller.isVerified,
                          controller: controller.ifscCode,
                          textField: ifsc_code.tr,
                          textCapitalization: true,
                          isRequired: true,
                          keyboardType: TextInputType.text,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          'Paytm Number Details',
                          fontSize: 40.sp,
                        ),
                        Icon(
                          Icons.info_outline,
                          color: ColorUtils.insta_color3,
                          size: 60.sp,
                        ).marginOnly(left: 30.sp)
                      ],
                    ).marginOnly(top: 60.sp, left: 15.sp, right: 35.sp),
                    CustomTextField(
                      controller: controller.payTmController,
                      hint: 'Enter PayTM Number',
                      maxLength: 10,
                      textInputAction: TextInputAction.done,
                      textStyle: StyleUtils.textStyleNormalPoppins()
                          .copyWith(letterSpacing: 2, fontSize: 56.sp),
                      keyboardType: TextInputType.phone,
                    ),
                    Obx(() => ProgressButton.icon(
                            radius: 200.sp,
                            minWidth: 500.sp,
                            progressIndicator: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            iconedButtons: {
                              ButtonState.idle: IconedButton(
                                  text: "Submit Details",
                                  icon: Icon(Icons.arrow_right_alt_sharp,
                                      color: ColorUtils.white),
                                  color: ColorUtils.orange),
                              ButtonState.loading: IconedButton(
                                  text: "Updating", color: ColorUtils.orange),
                              ButtonState.fail: IconedButton(
                                  text: "Failed",
                                  icon: Icon(Icons.cancel, color: Colors.white),
                                  color: Colors.red.shade300),
                              ButtonState.success: IconedButton(
                                  text: "Success",
                                  icon: Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                  ),
                                  color: Colors.green.shade400)
                            },
                            textStyle: StyleUtils.textStyleMediumPoppins(
                                color: ColorUtils.white,
                                fontSize: 48.sp,
                                weight: FontWeight.w500),
                            onPressed: () => controller.upload(),
                            state: controller.pageState.getMatchingButtonState)
                        .marginOnly(top: 60.sp)),
                    CustomText(
                      ' DO IT LATER ',
                      fontweight: FontWeight.w400,
                      fontSize: 42.sp,
                    )
                        .marginOnly(top: 80.sp)
                        .onClick(() => Get.offAllNamed(Routes.DASHBOARD)),
                  ],
                )).marginAll(50.sp),
          )),
    ]));
  }
}
