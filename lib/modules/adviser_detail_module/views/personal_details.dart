import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/adviser_detail_module/controllers/personal_details_controller.dart';
import 'package:bank_sathi/modules/adviser_detail_module/views/nominee_details.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_scaffold.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PersonalDetails extends GetView<PersonalDetailsController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: personal_details.tr,
      showAppIcon: true,
      body: BasePageView(
          controller: controller,
          idleWidget: SingleChildScrollView(
            child: Form(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 60.sp, horizontal: 40.sp),
                      margin: EdgeInsets.only(top: 30.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(50.sp),
                          color: "#f3f1f6".hexToColor()),
                      child: Obx(() => controller.user.nominee_name == null ||
                          controller.user.nominee_name.isEmpty
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(add_nominee.tr,
                                  fontweight: Weight.BOLD,
                                  fontSize: 48.sp),
                              CustomText(
                                who_become_nominee.tr,
                                fontweight: Weight.LIGHT,
                                fontSize: 36.sp,
                              ),
                            ],
                          ),
                          Container(
                              alignment: Alignment.bottomRight,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(50.sp)),
                                  border: Border.all(
                                      width: 3.sp,
                                      color: ColorUtils.orange)),
                              child: CustomText(
                                add_now.tr.toUpperCase(),
                                color: ColorUtils.orange,
                                fontSize: 40.sp,
                              ).marginOnly(
                                  left: 30.sp,
                                  right: 30.sp,
                                  top: 10.sp,
                                  bottom: 10.sp))
                              .marginOnly(
                              left: 10.sp,
                              right: 30.sp,
                              top: 10.sp,
                              bottom: 10.sp)
                              .onClick(() {
                            // Get.dialog(nomineeDialog());
                            Get.dialog(NomineeDetails());
                          }),
                        ],
                      )
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CustomText(
                                nominee_details.tr,
                                color: ColorUtils.orange,
                                fontSize: 48.sp,
                              ),
                              SvgPicture.asset(
                                'assets/images/new_images/profile_image/edit.svg',
                                width: 60.sp,
                                height: 60.sp,
                                color: "#746f7c".hexToColor(),
                              )
                            ],
                          ).onClick(() async {
                            // Get.dialog(nomineeDialog());
                            Get.dialog(NomineeDetails());
                          }),
                          CustomText(
                            '${name.tr} : ${controller.user.nominee_name.toString().capitalizeFirst}',
                            color: '#5b5c60'.hexToColor(),
                            fontweight: Weight.NORMAL,
                          ).paddingOnly(top: 30.sp),
                          CustomText(
                            '${relation.tr} : ${controller.user.nominee_relation.toString().capitalizeFirst}',
                            color: '#5b5c60'.hexToColor(),
                            fontweight: Weight.NORMAL,
                          ).paddingOnly(top: 30.sp),
                          CustomText(
                            '${dob.tr} : ${(controller.user.nominee_dob.toString().toDDMMYYYY() == '01/01/1970' ||
                                controller.user.nominee_dob.toString().toDDMMYYYY() == '') ? ' - ' :controller.user.nominee_dob.toString().toDDMMYYYY()}',
                            color: '#5b5c60'.hexToColor(),
                            fontweight: Weight.NORMAL,
                          ).paddingOnly(top: 30.sp)
                        ],
                      )),
                    ),
                    CustomText(
                      enter_email.tr,
                      color: ColorUtils.grey,
                    ).marginOnly(top: 40.sp),
                    CustomTextField(
                      controller: controller.emailController,
                      hint: enter_email.tr,
                      outlinedBorder: true,
                      prefixIcon:
                      'assets/images/new_images/profile_image/email.svg',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    CustomText(
                      enter_dob.tr,
                      color: ColorUtils.grey,
                    ).marginOnly(top: 60.sp),
                    Container(
                      child: IgnorePointer(
                        child: CustomTextField(
                          controller: controller.dobController,
                          hint: 'Select Date of Birth',
                          outlinedBorder: true,
                          isEnabled: false,
                          prefixIcon:
                          'assets/images/new_images/profile_image/calendar.svg',
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ).onClick(() {
                      if(controller.dobController.text=="")controller.selectDate(false);
                    }),
                    CustomText(
                      select_gender.tr,
                      color: ColorUtils.grey,
                      customTextStyle: CustomTextStyle.NORMAL,
                    ).marginOnly(top: 60.sp),
                    Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [0, 1, 2]
                          .map((e) => WidgetUtil.getRadio(
                          onTap: () => controller.genderSelected = e,
                          isSelected: controller.genderSelected == e,
                          border: true,
                          label: e == 0
                              ? male.tr
                              : e == 1
                              ? female.tr
                              : other.tr))
                          .toList(),
                    )).marginOnly(top: 30.sp),
                    CustomText(
                      are_you_working_as.tr,
                      color: ColorUtils.grey,
                    ).marginOnly(top: 60.sp),
                    Obx(
                          () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: controller.userTypeList
                            .map((e) => Expanded(
                            child: WidgetUtil.getRadio(
                                label: e,
                                border: true,
                                onTap: () => controller.userType = e,
                                isSelected: controller.userType == e)))
                            .toList(),
                      ).marginOnly(top: 30.sp),
                    ),
                    Obx(() => Visibility(
                        visible:
                        controller.userType != controller.userTypeList[0],
                        child: CustomTextField(
                          controller: controller.firmNameController,
                          textField: firm_name.tr,
                          outlinedBorder: true,
                          isRequired: true,
                        ).marginOnly(top: 20.sp))),
                    WidgetUtil.getStateButton(
                        onPressed: () => controller.verify(),
                        controller: controller,
                        width: 600.sp,
                        label: submit.tr)
                        .marginOnly(top: 30, bottom: 30)
                  ],
                ),
              ),
            ),
            key: controller.globalKey,
          )),
    );
  }

  /*Widget nomineeDialog() {
    return UnconstrainedBox(
      child: SizedBox(
        height: Get.height * .50,
        width: Get.width * .9,
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.sp)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  add_nominee.tr,
                  fontSize: 48.sp,
                ),
                Container(
                  width: 180.sp,
                  height: 2,
                  color: ColorUtils.orange,
                ).marginSymmetric(vertical: 30.sp),
                CustomTextField(
                  controller: controller.nomineeNameController,
                  textField: nominee_name.tr,
                  outlinedBorder: true,
                ).paddingOnly(top:20.sp),
                CustomTextField(
                  controller: controller.nomineeRelationController,
                  textField: nominee_relation.tr,
                  outlinedBorder: true,
                ),
                CustomText(
                  enter_dob.tr,
                  fontSize: 32.sp,
                ).marginOnly(top: 50.sp).alignTo(Alignment.topLeft),
                Container(
                  child: IgnorePointer(
                    child: CustomTextField(
                      controller: controller.nomineeController,
                      hint: 'Select Nominee Date of Birth',
                      outlinedBorder: true,
                      isEnabled: false,
                      prefixIcon:
                      'assets/images/new_images/profile_image/calendar.svg',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ).onClick(() {
                  controller.selectDate(true);
                }),
                WidgetUtil.getStateButton(
                  controller: controller,
                  color: ColorUtils.orange,
                  onPressed: () {
                    controller.savePersonalDetails();
                  },
                  textStyle: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.white,
                      weight: FontWeight.w400,
                      fontSize: 36.sp),
                  width: 600.sp,
                  label: add_nominee_now.tr,
                ).marginOnly(top: 60.sp)
              ],
            ).marginOnly(left: 50.sp,right: 50.sp,top:20.sp,bottom: 20.sp)),
      ),
    );
  }*/
}
