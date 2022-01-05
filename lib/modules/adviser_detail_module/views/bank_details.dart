import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/response/get_dropdown_data_response.dart';
import 'package:bank_sathi/modules/adviser_detail_module/controllers/bank_details_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_scaffold.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:search_choices/search_choices.dart';

import '../../../widgets/custom_text.dart';

class BankDetails extends GetView<BankDetailController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: banking.tr,
      showAppIcon: true,
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Stack(children: [
              Positioned.fill(
                  child: Align(
                child: Divider(
                  height: 2,
                  thickness: 1,
                  color: Colors.grey.shade300,
                ),
                alignment: Alignment.bottomRight,
              )),
              TabBar(
                  controller: controller.pageController,
                  labelColor: ColorUtils.orange,
                  unselectedLabelColor: Colors.black,
                  indicatorColor: Colors.black,
                  tabs: [
                    Tab(text: bank_account.tr),
                    Tab(text: paytm_account.tr)
                  ]).marginSymmetric(horizontal: 40.sp),
            ]).marginSymmetric(vertical: 0.sp),
            Expanded(
                child: Stack(
              children: [
                TabBarView(
                    controller: controller.pageController,
                    children: [bankTab(), payTmTab()]),
                Positioned.fill(
                    child: Align(
                  child: WidgetUtil.needHelpButton(6).marginAll(40.sp),
                  alignment: Alignment.bottomRight,
                ))
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget bankTab() {
    return SingleChildScrollView(
      child: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                select_bank.tr,
                color: ColorUtils.grey,
              ).marginOnly(top: 40.sp),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.sp),
                  margin: EdgeInsets.only(top: 30.sp),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                      border: Border.all(width: 0.6, color: ColorUtils.grey)),
                  child: Obx(
                    () => IgnorePointer(
                      ignoring: controller.isVerified,
                      child: SearchChoices.single(
                          hint: select_bank.tr,
                          value: controller.selectedBank,
                          isExpanded: true,
                          padding: controller.selectedBank == null ? 12 :0,
                          underline: Container(),
                          displayClearIcon: false,
                          items: controller.bankList
                              .map((e) => DropdownMenuItem<Bank>(
                                    child: CustomText(
                                      e.bank_title,
                                      fontweight: Weight.LIGHT,
                                    ),
                                    value: e,
                                  )).toList(),
                          onChanged: (val) {
                            print(val);
                            controller.selectedBank = val;
                            controller.accountNumber.text = '';
                            controller.ifscCode.text = '';
                          }),
                    ),
                  )).marginOnly(top: 20.sp),
              CustomText(
                account_number.tr,
                color: ColorUtils.grey,
              ).marginOnly(top: 40.sp),
              Obx(() => CustomTextField(
                    isEnabled: !controller.isVerified,
                    controller: controller.accountNumber,
                    isRequired: true,
                    textAlignVertical: TextAlignVertical.center,
                    prefixIcon:
                        'assets/images/new_images/profile_image/password.svg',
                    outlinedBorder: true,
                    suffixIconSize: controller.isVerified ? 100.sp : 0,
                    suffixIcon: SvgPicture.asset(
                      'assets/images/new_images/profile_image/verify.svg',
                      height: 52.sp,
                    ).marginOnly(right: 48.sp),
                    keyboardType: TextInputType.number,
                  ).marginOnly(top: 20.sp)),
              CustomText(
                ifsc_code.tr,
                color: ColorUtils.grey,
              ).marginOnly(top: 40.sp),
              Obx(() => CustomTextField(
                    isEnabled: !controller.isVerified,
                    controller: controller.ifscCode,
                textAlignVertical: TextAlignVertical.center,
                isRequired: true,
                    outlinedBorder: true,
                    prefixIcon:
                        'assets/images/new_images/profile_image/ifsc.svg',
                    textCapitalization: true,
                    keyboardType: TextInputType.text,
                  ).marginOnly(top: 20.sp)),
              Obx(
                () => Visibility(
                    visible: !controller.isVerified,
                    child: WidgetUtil.getStateButton(
                            onPressed: () => controller.upload(),
                            label: submit.tr,
                        width: 600.sp,
                            controller: controller)
                        .marginOnly(top: 60.sp, bottom: 60.sp)),
              ),
            ],
          ),
        ),
        key: controller.globalKey,
      ),
    );
  }

  Widget payTmTab() {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.sp)),
          color: "#F5F6F8".hexToColor(),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: ColorUtils.greylight,
              ),
              Expanded(
                  child: CustomText(
                enter_paytm_number_msg.tr,
                color: '#838998'.hexToColor(),
                fontSize: 36.sp,
              ).marginSymmetric(horizontal: 40.sp))
            ],
          ).marginAll(30.sp),
        ).marginOnly(top: 20.sp),
        Obx(
          () => CustomTextField(
            controller: controller.payTmController,
            outlinedBorder: true,
            maxLength: 10,
            suffixIconSize: controller.user.paytm_no_status == "1" ? 50.sp : 0,
            prefixIcon:
            'assets/images/new_images/profile_image/password.svg',
            suffixIcon: SvgPicture.asset(
              'assets/images/new_images/profile_image/verify.svg',
              height: 45.sp,
            ),
            textInputAction: TextInputAction.done,
            textStyle: StyleUtils.textStyleNormalPoppins()
                .copyWith(letterSpacing: 1, fontSize: 45.sp),
            keyboardType: TextInputType.phone,
          ),
        ),
        WidgetUtil.getStateButton(
                onPressed: () => controller.submitPayTmNumber(),
                label: submit.tr,
            width: 600.sp,
                controller: controller)
            .marginOnly(top: 60.sp, bottom: 60.sp),
      ],
    ).marginSymmetric(horizontal: 40.sp);
  }
}
