import 'package:bank_sathi/modules/auth_module/controllers/BankDetailsVerificationController.dart';
import 'package:bank_sathi/modules/auth_module/controllers/aadhar_verification_controller.dart';
import 'package:bank_sathi/modules/auth_module/controllers/login_controller.dart';
import 'package:bank_sathi/modules/auth_module/controllers/panVerificationController.dart';
import 'package:bank_sathi/modules/auth_module/views/Login.dart';
import 'package:bank_sathi/modules/auth_module/views/aadhar_verification.dart';
import 'package:bank_sathi/modules/auth_module/views/bank_details_verification.dart';
import 'package:bank_sathi/modules/auth_module/views/pan_verification.dart';
import 'package:bank_sathi/modules/credit_card_module/controllers/available_cards_controller.dart';
import 'package:bank_sathi/modules/credit_card_module/controllers/cc_income_details_controller.dart';
import 'package:bank_sathi/modules/credit_card_module/controllers/credit_card_application_controller.dart';
import 'package:bank_sathi/modules/credit_card_module/controllers/credit_card_lead_controller.dart';
import 'package:bank_sathi/modules/credit_card_module/controllers/credit_card_mobile_controller.dart';
import 'package:bank_sathi/modules/credit_card_module/views/available_cards_list.dart';
import 'package:bank_sathi/modules/credit_card_module/views/cc_income_details.dart';
import 'package:bank_sathi/modules/credit_card_module/views/cedit_card_application.dart';
import 'package:bank_sathi/modules/credit_card_module/views/cedit_card_lead.dart';
import 'package:bank_sathi/modules/credit_card_module/views/credit_card_mobile_screen.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/my_team_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/share_tab_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/controllers/help_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/controllers/my_leads_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/controllers/non_salried_form_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/controllers/salaried_form_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/controllers/webview_launcher_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/views/webview_launcher.dart';
import 'package:bank_sathi/modules/dashboard_module/views/dashboard.dart';
import 'package:bank_sathi/modules/dashboard_module/views/my_details.dart';
import 'package:bank_sathi/modules/loan_module/controllers/existing_loan_details_controller.dart';
import 'package:bank_sathi/modules/loan_module/controllers/loan_income_details_controller.dart';
import 'package:bank_sathi/modules/loan_module/controllers/personal_loan_lead_controller.dart';
import 'package:bank_sathi/modules/loan_module/controllers/personal_loan_mobile_controller.dart';
import 'package:bank_sathi/modules/loan_module/views/existing_loan_details.dart';
import 'package:bank_sathi/modules/loan_module/views/loan_income_details.dart';
import 'package:bank_sathi/modules/loan_module/views/personal_loan_lead.dart';
import 'package:bank_sathi/modules/loan_module/views/personal_loan_mobile.dart';
import 'package:bank_sathi/modules/register_module/controllers/register_controller.dart';
import 'package:bank_sathi/modules/register_module/views/Register.dart';
import 'package:bank_sathi/modules/splash/donwtime_screen.dart';
import 'package:bank_sathi/modules/splash/intro_screen.dart';
import 'package:bank_sathi/modules/splash/playground.dart';
import 'package:bank_sathi/modules/splash/select_language_screen.dart';
import 'package:bank_sathi/modules/splash/splash.dart';
import 'package:bank_sathi/modules/splash/unlock_controller.dart';
import 'package:bank_sathi/modules/splash/unlock_screen.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/routes/dashboard_pages.dart';
import 'package:bank_sathi/routes/my_details_pages.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.UNLOCK,
      page: () => UnlockScreen(),
      binding: BindingsBuilder(() {
        Get.put(UnlockController());
      }),
    ),
    GetPage(
      name: Routes.SELECT_LANGUAGE,
      page: () => SelectLanguageScreen(),
    ),
    GetPage(
      name: Routes.INTRO,
      page: () => IntroScreen(),
    ),
    GetPage(
        name: Routes.DOWNTIME_SCREEN,
        page: () => DownTimeScreen(),
        binding: BindingsBuilder(() {
          Get.put(DownTimeController());
        })),
    GetPage(
        name: Routes.LOGIN,
        page: () => Login(),
        binding: BindingsBuilder(() {
          Get.put(LoginController());
          Get.lazyPut(()=>DashboardController());
        }),
        children: [
          GetPage(
              name: Routes.REGISTER,
              page: () => Register(),
              binding: BindingsBuilder(() {
                Get.put(RegisterController());
              })),
          GetPage(
              name: Routes.AADHAR_VERIFICATION,
              page: () => AadharVerification(),
              binding: BindingsBuilder(() {
                Get.put(AAdharVerificationController());
              })),
          GetPage(
              name: Routes.PAN_VERIFICATION,
              page: () => PanVerification(),
              binding: BindingsBuilder(() {
                Get.put(PanVerificationController());
              })),
          GetPage(
              name: Routes.BANK_DETAIL_VERIFY,
              page: () => BankDetailsVerification(),
              binding: BindingsBuilder(() {
                Get.put(BankDetailsVerificationController());
              })),
        ]),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => Dashboard(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<DashboardController>()) {
          Get.put(DashboardController(), permanent: true);
        }
        Get.put(MyLeadsController());
        Get.put(OnGoingLeadController());
        Get.put(CompletedLeadController());
        Get.put(MyTeamController());
        Get.put(HelpController());
        Get.put(ShareTabController(), permanent: true);
      }),
      children: DASHBOARD_PAGES,
    ),
    GetPage(
        name: Routes.MY_DETAIL,
        page: () => MyDetail(), binding: BindingsBuilder(() {
      Get.lazyPut(()=>DashboardController());
    }),
        transition: Transition.leftToRight,
        children: MyDetailsPages),
    GetPage(
      name: Routes.PERSONAL_LOAN_LEAD,
      page: () => PersonalLoanLead(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PersonalLoanLeadController());
      }),
    ),
    GetPage(
        name: Routes.EXISTING_LOAN_DETAIL,
        page: () => ExistingLoanDetails(),
        binding: BindingsBuilder(
          () {
            Get.put(ExistingLoanDetailsController());
          },
        )),
    GetPage(
        name: Routes.CC_INCOME_DETAIL,
        page: () => CC_IncomeDetails(),
        binding: BindingsBuilder(
          () {
            Get.put(CC_incomeDetailsController());
            Get.lazyPut(() => SalariedFormController());
            Get.lazyPut(() => NonSalariedFormController());
          },
        )),
    GetPage(
        name: Routes.LOAN_INCOME_DETAIL,
        page: () => Loan_IncomeDetails(),
        binding: BindingsBuilder(
          () {
            Get.put(Loan_IncomeDetailsController());
            Get.lazyPut(() => SalariedFormController());
            Get.lazyPut(() => NonSalariedFormController());
          },
        )),
    GetPage(
        name: Routes.WEBVIEW_LAUNCHER,
        page: () => WebViewLauncher(),
        binding: BindingsBuilder(
          () {
            Get.put(WebviewLauncherController());
          },
        )),
    GetPage(
        name: Routes.CREDITCARDMOBILE,
        page: () => CreditCardMobileScreen(),
        binding: BindingsBuilder(
          () {
            Get.put(CreditCardMobileController());
          },
        )),
    GetPage(
        name: Routes.CREDITCARDLEAD,
        page: () => CreditCardLead(),
        binding: BindingsBuilder(
          () {
            Get.put(CreditCardLeadController());
          },
        )),
    GetPage(
        name: Routes.CREDITCARDApplication,
        page: () => CreditCardApplication(),
        binding: BindingsBuilder(
          () {
            Get.put(CreditCardApplicationController());
          },
        )),
    GetPage(
        name: Routes.CREDITCARDSLIST,
        page: () => AvailableCardsList(),
        binding: BindingsBuilder(
          () {
            Get.put(AvailableCardsController());
          },
        )),
    /*  GetPage(
        name: Routes.BIOMETRIC,
        page: () => BioMetric(),
        binding: BindingsBuilder(() {
          Get.put(BioMetricController());
        })),*/

    GetPage(
        name: Routes.PERSONAL_LOAN_LOGIN,
        page: () => PersonalLoanMobileScreen(),
        binding: BindingsBuilder(() {
          Get.put(PersonalLoanMobileController());
        })),
    GetPage(
      name: Routes.PLAYGROUND,
      page: () => Playground(),
    ),
  ];
}
