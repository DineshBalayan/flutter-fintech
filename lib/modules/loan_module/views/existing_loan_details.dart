import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/modules/loan_module/controllers/existing_loan_details_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_scaffold.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ExistingLoanDetails extends GetView<ExistingLoanDetailsController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: '',
        showAppIcon: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/logo_loan.svg',
                height: 150,
              ).marginAll(10),
              CustomText(
                existing_loan_detail.tr,
                fontweight: Weight.BOLD,
                customTextStyle: CustomTextStyle.BIGTITLE,
              ),
              Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: controller.remainingLoanController,
                            textField: remaining_loan_amount.tr,
                            keyboardType: TextInputType.number,
                            hint: 'ex. 30000',
                          ).marginOnly(top: 5),
                          CustomTextField(
                            controller: controller.monthlyEmiController,
                            textField: total_monthly_emi.tr,
                            keyboardType: TextInputType.number,
                          ).marginOnly(top: 5),
                          SizedBox(
                            height: 80.h,
                          ),
                          WidgetUtil.getPrimaryButton(
                              () => controller.goToNextScreen(),
                              label: continue_label.tr),
                          SizedBox(
                            height: 60.h,
                          ),
                        ],
                      ).marginAll(15.0))
                  .marginAll(15.0),
            ],
          ),
        ));
  }
}
