import 'package:bank_sathi/Model/add_lead_arguments.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

class Loan_IncomeDetailsController extends BaseController {
  AddLeadArguments? arguments;

  @override
  void onInit() {
    super.onInit();
    arguments = Get.arguments;
  }
}
