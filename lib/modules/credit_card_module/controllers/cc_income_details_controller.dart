import 'package:bank_sathi/Model/add_lead_arguments.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

class CC_incomeDetailsController extends BaseController {
  final RxBool _isSalaried = true.obs;

  bool get isSalaried => _isSalaried.value;

  set isSalaried(val) => _isSalaried.value = val;

  late AddLeadArguments arguments;

  @override
  void onInit() {
    super.onInit();
    arguments = Get.arguments;
    isSalaried =
        arguments.income == null || arguments.income.occupation_id == 1;
  }
}
