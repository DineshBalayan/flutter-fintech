import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Model/add_lead_arguments.dart';
import 'package:bank_sathi/Model/request/add_income_detail_request.dart';
import 'package:bank_sathi/Model/response/company_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/db/pincode_helper.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalariedFormController extends BaseController {
  List<String> jobVintageList = [
    'Less Then 1 Year',
    '1 Year',
    '2 Years',
    '3 Years',
    'More Then 3 Years'
  ];
  final _jobVintageType = 'Less Then 1 Year'.obs;

  get jobVintageType => _jobVintageType.value;

  set jobVintageType(val) => _jobVintageType.value = val;

  final globalKey = GlobalKey<FormState>();

  CancelToken cancelToken = CancelToken();

  late AddLeadArguments arguments;

  TextEditingController monthlySalaryController = TextEditingController(),
      nameController = TextEditingController(),
      designationController = TextEditingController(),
      emailController = TextEditingController(),
      addressController = TextEditingController();

  CompanyData? selectedCompany;

  @override
  void onClose() {
    monthlySalaryController.dispose();
    nameController.dispose();
    designationController.dispose();
    emailController.dispose();
    addressController.dispose();
    pinCodeHelper.dispose();
    super.onClose();
  }

  @override
  void onReady() async {
    super.onReady();

    arguments = Get.arguments;

    if (arguments.income != null && arguments.income.occupation_id == 1) {
      monthlySalaryController.text = arguments.income.monthly_salary;
      nameController.text = arguments.income.company_name;
      designationController.text = arguments.income.designation;
      emailController.text = arguments.income.office_email;
      addressController.text = arguments.income.company_address;
      jobVintageType = arguments.income.company_vintage;
      if (nameController.text.isNotEmpty) {
        selectedCompany = CompanyData(id: arguments.income.company_id, company_name: arguments.income.company_name);
      }
      pinCodeHelper.init(pinCodeId: arguments.income.pincode_id);
    } else {
      pinCodeHelper.init();
    }
  }

  PinCodeHelper pinCodeHelper = PinCodeHelper();

  addIncomeDetail(pincodeId) {
    showLoadingDialog();
    String url = arguments.leadCategoryId == 3
        ? 'besath_addcard_incomeb'
        : 'besath_addpl_incomeb';
    AddIncomeDetailRequest addIncomeDetailRequest = AddIncomeDetailRequest(
      occupation_id: '1',
      monthly_salary: monthlySalaryController.string,
      company_id: selectedCompany == null
          ? 0
          : selectedCompany!.company_name == nameController.string
              ? selectedCompany!.id.toString()
              : 0,
      company_name: nameController.string,
      designation: designationController.string,
      company_vintage: jobVintageType,
      office_email: emailController.string,
      company_address: addressController.string,
      pincode_id: pincodeId,
      city_id: pinCodeHelper.selectedCity!.id.toString(),
      state_id: pinCodeHelper.selectedState!.id.toString(),
      profile_id: arguments.leadIdData.profile_id.toString(),
      lead_id: arguments.leadIdData.lead_id.toString(),
    );

    restClient.addIncomeDetail(addIncomeDetailRequest, url).then((value) {
      hideDialog();
      if (value.success) {
        Get.offNamedUntil(Routes.DASHBOARD + Routes.MY_LEADS,
            (route) => route.settings.name == Routes.DASHBOARD);
      } else {
        handleError(msg: value.message);
      }
    }).catchError((error) {});
  }

  verifyPincode() async {
    if (globalKey.currentState!.validate()) {
      if (await pinCodeHelper.isValidPinCode() == -1) {
        handleError(msg: enter_correct_pin_code.tr);
      } else {
        addIncomeDetail(await pinCodeHelper.isValidPinCode());
      }
    }
  }
}
