import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Model/add_lead_arguments.dart';
import 'package:bank_sathi/Model/request/add_existing_loan_request.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

class ExistingLoanDetailsController extends BaseController {
  GlobalKey<FormState> globalKey = GlobalKey();

  late TextEditingController remainingLoanController, monthlyEmiController;

  AddLeadArguments? arguments;

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    remainingLoanController = TextEditingController();
    monthlyEmiController = TextEditingController();
    arguments = Get.arguments;
  }

  goToNextScreen() {
    showLoadingDialog();
    AddExistingLoanRequest addExistingLoanRequest = AddExistingLoanRequest(
        lead_id: arguments!.leadIdData.lead_id,
        profile_id: arguments!.leadIdData.profile_id,
        monthly_emi: monthlyEmiController.string.isEmpty
            ? 0
            : monthlyEmiController.string,
        total_rem_loan: remainingLoanController.string.isEmpty
            ? 0
            : remainingLoanController.string);

    String url =
        arguments!.leadCategoryId == 4 || arguments!.leadCategoryId == 12
            ? 'besath_addpl_is_loanb'
            : 'besath_addbl_is_loanb';

    restClient.addPLIsLoan(addExistingLoanRequest, url).then((value) {
      hideDialog();
      if (value.success) {
        arguments!.income = value.data.income;
        Get.toNamed(Routes.LOAN_INCOME_DETAIL, arguments: arguments);
      } else {
        handleError(msg: value.message);
      }
    }).catchError((onError) {});
  }
}
