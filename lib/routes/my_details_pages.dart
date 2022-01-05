import 'package:bank_sathi/modules/adviser_detail_module/controllers/bank_details_controller.dart';
import 'package:bank_sathi/modules/adviser_detail_module/controllers/kyc_controller.dart';
import 'package:bank_sathi/modules/adviser_detail_module/controllers/personal_details_controller.dart';
import 'package:bank_sathi/modules/adviser_detail_module/controllers/professional_details_controller.dart';
import 'package:bank_sathi/modules/adviser_detail_module/views/bank_details.dart';
import 'package:bank_sathi/modules/adviser_detail_module/views/kyc_details.dart';
import 'package:bank_sathi/modules/adviser_detail_module/views/nominee_details.dart';
import 'package:bank_sathi/modules/adviser_detail_module/views/personal_details.dart';
import 'package:bank_sathi/modules/adviser_detail_module/views/proffesional_details.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/tds_info_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/views/tds_info.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

var MyDetailsPages = [
  GetPage(
      name: Routes.PERSONAL_DETAILS,
      page: () => PersonalDetails(),
      binding: BindingsBuilder(() {
        Get.put(PersonalDetailsController());
      })),

 GetPage(
      name: Routes.NOMINEE_DETAILS,
      page: () => NomineeDetails(),
      binding: BindingsBuilder(() {
        Get.put(PersonalDetailsController());
      })),
  GetPage(
      name: Routes.BANK_DETAILS,
      page: () => BankDetails(),
      binding: BindingsBuilder(() {
        Get.put(BankDetailController());
      })),
  GetPage(
      name: Routes.KYC_DETAILS,
      page: () => KYCDetails(),
      binding: BindingsBuilder(() {
        Get.put(KYCController());
      })),
  GetPage(
      name: Routes.PROFESSIONAL_DETAILS,
      page: () => ProfessionalDetails(),
      binding: BindingsBuilder(() {
        Get.put(ProfessionalDetailsController());
      })),
  GetPage(
      name: Routes.TDS_INFO,
      page: () => TDSInfoScreen(),
      binding: BindingsBuilder(() {
        Get.put(TDSInfoController());
      }))
];
