import 'package:bank_sathi/modules/dashboard_module/leads_module/views/non_salaried_form.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/views/salaried_form.dart';
import 'package:bank_sathi/modules/loan_module/controllers/loan_income_details_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class Loan_IncomeDetails extends GetView<Loan_IncomeDetailsController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: income_details.tr,
      showAppIcon: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: (controller.arguments!.leadCategoryId == 4 ||
                    controller.arguments!.leadCategoryId == 12
                ? SalariedForm()
                : NonSalariedForm())
            .marginOnly(left: 15, right: 15, bottom: 15, top: 10),
      ),
    );
  }
}
