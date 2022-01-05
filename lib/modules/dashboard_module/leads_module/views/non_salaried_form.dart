import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/db/db_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/controllers/non_salried_form_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/company_suggestion.dart';
import 'package:bank_sathi/widgets/custom_drop_down.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:bank_sathi/widgets/pincode_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NonSalariedForm extends GetView<NonSalariedFormController> {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Form(
          key: controller.globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: controller.latestITRController,
                textField: latest_itr_amount.tr,
                keyboardType: TextInputType.number,
                isRequired: true,
              ).marginAll(5),
              CustomTextField(
                controller: controller.gstController,
                textField: gst_number.tr,
                textCapitalization: true,
                validator: (String value) {
                  String pattern =
                      "^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}";
                  RegExp regex = new RegExp(pattern);
                  if (!value.isNullOrBlank! && !regex.hasMatch(value)) {
                    return correct_gst_msg.tr;
                  }
                  return null;
                },
                isRequired: true,
              ).marginAll(5),
              Obx(
                () => CustomDropDown(
                    hint: gst_vintage.tr,
                    value: controller.jobVintageType,
                    items: controller.jobVintageList
                        .map((e) => DropdownMenuItem<String>(
                              child: CustomText(
                                e,
                                fontweight: Weight.LIGHT,
                              ),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (val) => controller.jobVintageType = val),
              ).marginAll(5),
              CompanySuggestion(
                suggestionCallback: (company) {
                  controller.selectedCompany = company;
                },
                restClient: restClient,
                textEditingController: controller.nameController,
                label: business_name.tr,
              ).marginAll(5),
              CustomTextField(
                controller: controller.emailController,
                textField: office_email.tr,
                keyboardType: TextInputType.emailAddress,
                isRequired: true,
              ).marginAll(5),
              CustomTextField(
                controller: controller.addressController,
                textField: office_address.tr,
                keyboardType: TextInputType.streetAddress,
                isRequired: true,
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
        ).paddingOnly(left: 10, right: 10, bottom: 10));
  }
}
