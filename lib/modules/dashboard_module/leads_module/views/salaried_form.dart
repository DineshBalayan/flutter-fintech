import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/db/db_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/controllers/salaried_form_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/company_suggestion.dart';
import 'package:bank_sathi/widgets/custom_drop_down.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:bank_sathi/widgets/pincode_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalariedForm extends GetView<SalariedFormController> {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: controller.monthlySalaryController,
                textField: monthly_salary.tr,
                isRequired: true,
                keyboardType: TextInputType.number,
              ).marginAll(5),
              CompanySuggestion(
                suggestionCallback: (company) {
                  controller.selectedCompany = company;
                },
                restClient: restClient,
                textEditingController: controller.nameController,
              ).marginAll(5),
              CustomTextField(
                controller: controller.designationController,
                textField: designation.tr,
                isRequired: true,
              ).marginAll(5),
              Obx(
                () => CustomDropDown(
                    hint: current_company_job_vintage.tr,
                    value: controller.jobVintageType,
                    items: controller.jobVintageList.map((e) => DropdownMenuItem(
                              child: CustomText(
                                e.toString(),
                                fontweight: Weight.LIGHT,
                              ),
                              value: e,
                            )).toList(),
                    onChanged: (val) => controller.jobVintageType = val),
              ).marginAll(5),
              CustomTextField(
                controller: controller.emailController,
                textField: office_email.tr,
                keyboardType: TextInputType.emailAddress,
              ).marginAll(5),
              CustomTextField(
                controller: controller.addressController,
                textField: office_address.tr,
                keyboardType: TextInputType.streetAddress,
              ).marginAll(5),
              PincodeSuggestion(
                pinCodeHelper: controller.pinCodeHelper,
              ).marginAll(5),
              Obx(
                () => CustomDropDown(
                    hint: office_state.tr,
                    value: controller.pinCodeHelper.selectedState,
                    items: controller.pinCodeHelper.stateList
                        .map((e) => DropdownMenuItem<StateRow>(
                              child: CustomText(e.state_name,
                                  fontweight: Weight.LIGHT),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (val) {
                      print(val);
                      controller.pinCodeHelper.selectedState = val;
                      controller.pinCodeHelper.updateCityList();
                    }),
              ).marginAll(5),
              Obx(
                () => CustomDropDown(
                    hint: office_city.tr,
                    value: controller.pinCodeHelper.selectedCity,
                    items: controller.pinCodeHelper.cityList
                        .map((e) => DropdownMenuItem<CityRow>(
                              child: CustomText(e.city_name,
                                  fontweight: Weight.LIGHT),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (val) {
                      print(val);
                      controller.pinCodeHelper.selectedCity = val;
                    }),
              ).marginAll(5),
              WidgetUtil.getPrimaryButton(() => controller.verifyPincode(),
                      label: submit.tr)
                  .marginOnly(top: 20)
            ],
          ),
          key: controller.globalKey,
        ).paddingOnly(left: 10, right: 10, bottom: 10));
  }
}
