import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/modules/credit_card_module/controllers/cc_income_details_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/views/non_salaried_form.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/views/salaried_form.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_scaffold.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class CC_IncomeDetails extends GetView<CC_incomeDetailsController> {
  final incomeDetailWidget = [SalariedForm(), NonSalariedForm()];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: income_details.tr,
        showAppIcon: true,
        body: Column(
          children: [
            CustomText(
              income_details_msg.tr,
            ).alignTo(Alignment.topLeft).marginOnly(top: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() => WidgetUtil.getRadio(
                    label: salaried.tr,
                    isSelected: controller.isSalaried,
                    onTap: () => controller.isSalaried = true)),
                Obx(() => WidgetUtil.getRadio(
                        label: non_salaried.tr,
                        isSelected: !controller.isSalaried,
                        onTap: () => controller.isSalaried = false))
                    .paddingOnly(left: 40),
              ],
            ).marginOnly(top: 10),
            Obx(() => Expanded(
                    child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: AnimatedContainer(
                      curve: Curves.bounceInOut,
                      duration: 5.seconds,
                      child: incomeDetailWidget[controller.isSalaried ? 0 : 1]),
                ).marginOnly(top: 10))),
          ],
        ).marginOnly(left: 15, right: 15, bottom: 15));
  }
}
