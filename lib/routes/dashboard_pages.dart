import 'package:bank_sathi/modules/dashboard_module/controllers/ProductDetailController.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/customer_query_detail_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/knowledge_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/leaderboard_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/my_team_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/notification_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/product_list_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/wallet_tab_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/controllers/help_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/help_center.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/views/helpcenter_faq_category.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/views/helpcenter_faq_subcategory.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/views/helpcenter_products.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/views/helpcenter_training.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/views/query_dialogue.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/controllers/my_lead_detail_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/controllers/my_leads_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/views/my_leads.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/views/my_leads_detail.dart';
import 'package:bank_sathi/modules/dashboard_module/views/announcement_detail_screen.dart';
import 'package:bank_sathi/modules/dashboard_module/views/customer_query_detail.dart';
import 'package:bank_sathi/modules/dashboard_module/views/customer_query_screen.dart';
import 'package:bank_sathi/modules/dashboard_module/views/knowledge_screen.dart';
import 'package:bank_sathi/modules/dashboard_module/views/leaderboard.dart';
import 'package:bank_sathi/modules/dashboard_module/views/my_team.dart';
import 'package:bank_sathi/modules/dashboard_module/views/notification_screen.dart';
import 'package:bank_sathi/modules/dashboard_module/views/product_detail_screen.dart';
import 'package:bank_sathi/modules/dashboard_module/views/product_list_screen.dart';
import 'package:bank_sathi/modules/dashboard_module/views/wallet_tab.dart';
import 'package:bank_sathi/modules/insurance_module/controllers/kotak_insurance_controller.dart';
import 'package:bank_sathi/modules/insurance_module/controllers/kotak_insurance_mobile_controller.dart';
import 'package:bank_sathi/modules/insurance_module/views/kotak_insurance_mobile_screen.dart';
import 'package:bank_sathi/modules/insurance_module/views/kotak_insurance_screen.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

// ignore: non_constant_identifier_names
// ignore: top_level_function_literal_block

var DASHBOARD_PAGES = [
  GetPage(
      name: Routes.MY_TEAM,
      page: () => MyTeam(),
      binding: BindingsBuilder(() {
        Get.put(MyTeamController());
      })),
  GetPage(
      name: Routes.MY_LEADS,
      page: () => MyLeadScreen(),
      binding: BindingsBuilder(() {
        Get.put(MyLeadsController());
      })),
  GetPage(
      name: Routes.HELP_CENTER,
      page: () => HelpCenter(),
      binding: BindingsBuilder(() {
        Get.put(HelpController());
      })),
  GetPage(
      name: Routes.HELP_FAQ_CAT,
      page: () => HelpFaqCategory(),
      binding: BindingsBuilder(() {
        Get.put(HelpController());
      })),
  GetPage(
      name: Routes.HELP_FAQ_PRODUCTS,
      page: () => HelpCenterProducts(),
      binding: BindingsBuilder(() {
        Get.put(HelpController());
      })),
  GetPage(
      name: Routes.HELP_FAQ_SUB_CAT,
      page: () => HelpFaqSubCategory(),
      binding: BindingsBuilder(() {
        Get.put(HelpController());
      })),
  GetPage(
      name: Routes.HELP_FAQ_QUERY,
      page: () => QueryDialogue(),
      binding: BindingsBuilder(() {
        Get.put(HelpController());
      })),
  GetPage(
      name: Routes.HELP_TRAINING,
      page: () => HelpTraining(),
      binding: BindingsBuilder(() {
        Get.put(HelpController());
      })),
  GetPage(
      name: Routes.MY_LEAD_DETAILS,
      page: () => MyLeadDetail(),
      binding: BindingsBuilder(() {
        Get.put(MyLeadDetailsController());
      })),
  GetPage(
      name: Routes.NOTIFICATION,
      page: () => NotificationScreen(),
      binding: BindingsBuilder(() {
        Get.put(NotificationController());
      })),
  GetPage(
      name: Routes.LEADERBOARD,
      page: () => LeaderBoard(),
      binding: BindingsBuilder(() {
        Get.put(LeaderBoardController());
      })),
  GetPage(
      name: Routes.KNOWLEDGE,
      page: () => KnowledgeScreen(),
      binding: BindingsBuilder(() {
        Get.put(KnowledgeController());
      })),
  GetPage(
      name: Routes.PRODUCT_DETAILS,
      page: () => ProductDetailScreen(),
      binding: BindingsBuilder(() {
        Get.put(ProductDetailController());
      })),
  GetPage(
    name: Routes.ANNOUNCEMENT_DETAIL_SCREEN,
    page: () => AnnouncementDetailScreen(),
  ),
  GetPage(
      name: Routes.CUSTOMER_QUERY_SCREEN,
      page: () => CustomerQueryScreen(),
      binding: BindingsBuilder(() {
        Get.put(CustomerQueryController());
      })),
  GetPage(
      name: Routes.CUSTOMER_QUERY_DETAIL,
      page: () => CustomerQueryDetail(),
      binding: BindingsBuilder(() {
        Get.put(CustomerQueryDetailsController());
      })),
  GetPage(
      name: Routes.PRODUCT_LIST_SCREEN,
      page: () => ProductListScreen(),
      binding: BindingsBuilder(() {
        Get.put(ProductListController());
      })),
  GetPage(
      name: Routes.WALLET_SCREEN,
      page: () => WalletTab(),
      binding: BindingsBuilder(() {
        Get.put(WalletTabController());
        Get.put(PayoutTransactionsController());
        Get.put(ReferralController());
        Get.put(WithdrawalController());
      })),
  GetPage(
      name: Routes.KOTAK_INSURANCE,
      page: () => KotakMobileScreen(),
      binding: BindingsBuilder(() {
        Get.put(KotakInsuranceMobileController());
      })),
  GetPage(
      name: Routes.KOTAK_INSURANCE_LEAD,
      page: () => KotakInsuranceLead(),
      binding: BindingsBuilder(() {
        Get.put(KotakInsuranceLeadController());
      }))
];
