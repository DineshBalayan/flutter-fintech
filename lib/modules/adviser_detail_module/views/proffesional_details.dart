import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/response/get_dropdown_data_response.dart';
import 'package:bank_sathi/modules/adviser_detail_module/controllers/professional_details_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_drop_down.dart';
import 'package:bank_sathi/widgets/custom_scaffold.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfessionalDetails extends GetView<ProfessionalDetailsController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: professional_details.tr,
        showAppIcon: true,
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.sp),
              child: Form(
                  key: controller.globalKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                          () => CustomDropDown(
                              hint: select_primary_income.tr,
                              value: controller.selectedPos,
                              outlinedBorder: true,
                              items: controller.posList
                                  .map((e) => DropdownMenuItem<PosIncome>(
                                        child: CustomText(
                                          e.title,
                                          fontweight: Weight.LIGHT,
                                        ),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (val) => controller.selectedPos = val),
                        ).marginOnly(top: 40.sp),
                        CustomText(financial_product_experience.tr,
                                color: ColorUtils.grey)
                            .alignTo(Alignment.topLeft)
                            .marginOnly(top: 75.sp),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Obx(
                              () => CustomDropDown(
                                  hint: select_year.tr,
                                  outlinedBorder: true,
                                  value: controller.yearExperience,
                                  items: [
                                    "0",
                                    "1",
                                    "2",
                                    "3",
                                    "4",
                                    "5",
                                    "6",
                                    "7",
                                    "8",
                                    "9",
                                    "10"
                                  ]
                                      .map((e) => DropdownMenuItem<String>(
                                            child: CustomText(
                                              e + " " + year.tr,
                                              fontweight: Weight.LIGHT,
                                            ),
                                            value: e,
                                          ))
                                      .toList(),
                                  onChanged: (val) =>
                                      controller.yearExperience = val),
                            ).marginOnly(top: 5)),
                            Expanded(
                                child: Obx(
                              () => CustomDropDown(
                                  hint: select_month.tr,
                                  outlinedBorder: true,
                                  value: controller.monthExperience,
                                  items: [
                                    "0",
                                    "1",
                                    "2",
                                    "3",
                                    "4",
                                    "5",
                                    "6",
                                    "7",
                                    "8",
                                    "9",
                                    "10",
                                    "11"
                                  ]
                                      .map((e) => DropdownMenuItem<String>(
                                            child: CustomText(
                                                e + " " + month.tr,
                                                fontweight: Weight.LIGHT),
                                            value: e,
                                          ))
                                      .toList(),
                                  onChanged: (val) =>
                                      controller.monthExperience = val),
                            ).marginOnly(top: 5, left: 5)),
                          ],
                        ),
                        CustomText(
                          have_office_space_que.tr,
                          color: ColorUtils.grey,
                        ).alignTo(Alignment.topLeft).marginOnly(top: 75.sp),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Obx(() => WidgetUtil.getRadio(
                                    label: yes_i_have.tr,
                                    border: true,
                                    isSelected:
                                        controller.haveOfficeSpace == yes.tr,
                                    onTap: () =>
                                        controller.haveOfficeSpace = yes.tr))),
                            SizedBox(
                              width: 30.sp,
                            ),
                            Expanded(
                                child: Obx(() => WidgetUtil.getRadio(
                                    label: no_i_dont.tr,
                                    border: true,
                                    isSelected:
                                        controller.haveOfficeSpace == no.tr,
                                    onTap: () =>
                                        controller.haveOfficeSpace = no.tr))),
                          ],
                        ).marginOnly(top: 30.sp),
                        CustomText(
                          product_sell_que.tr,
                          color: ColorUtils.grey,
                        ).alignTo(Alignment.topLeft).marginOnly(top: 75.sp),
                        SizedBox(
                          width: double.infinity,
                          child: Obx(() => Wrap(
                                alignment: WrapAlignment.start,
                                children: controller.financialProducts.map((e) {
                                  return ActionChip(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.sp),
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: "#caccd1".hexToColor(),
                                              width: .5),
                                          borderRadius:
                                              BorderRadius.circular(15.sp)),
                                      label: CustomText(
                                        e.product_name,
                                        fontweight: Weight.LIGHT,
                                        fontSize: 36.sp,
                                        color: !controller.selectedProducts
                                                .contains(e.id.toString())
                                            ? ColorUtils.textColor
                                            : ColorUtils.orange,
                                      ),
                                      labelPadding: EdgeInsets.symmetric(
                                          horizontal: 30.sp),
                                      backgroundColor: controller
                                              .selectedProducts
                                              .contains(e.id.toString())
                                          ? ColorUtils.white
                                          : Colors.white,
                                      onPressed: () =>
                                          controller.onProductTileClick(
                                            e.id.toString(),
                                          )).marginAll(10.sp);
                                }).toList(),
                              )),
                        ),
                        CustomText(
                          have_pos_license_que.tr,
                          color: ColorUtils.grey,
                        ).alignTo(Alignment.topLeft).marginOnly(top: 75.sp),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Obx(() => WidgetUtil.getRadio(
                                    label: yes_i_have.tr,
                                    border: true,
                                    isSelected:
                                        controller.haveLicense == yes.tr,
                                    onTap: () =>
                                        controller.haveLicense = yes.tr))),
                            SizedBox(
                              width: 30.sp,
                            ),
                            Expanded(
                                child: Obx(() => WidgetUtil.getRadio(
                                    label: no_i_dont.tr,
                                    border: true,
                                    isSelected: controller.haveLicense == no.tr,
                                    onTap: () =>
                                        controller.haveLicense = no.tr))),
                          ],
                        ).marginOnly(top: 30.sp, bottom: 30.sp),
                        WidgetUtil.getStateButton(
                                onPressed: () =>
                                    controller.saveProfessionalDetail(),
                                controller: controller,
                                width: 600.sp,
                                label: submit.tr)
                            .marginOnly(top: 20, bottom: 20.sp)
                      ]))),
        ));
  }
}
