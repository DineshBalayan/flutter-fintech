import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/data/pref_manager.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/help_center.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/views/my_leads.dart';
import 'package:bank_sathi/modules/dashboard_module/views/home_tab.dart';
import 'package:bank_sathi/modules/dashboard_module/views/my_team.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_bottom_navigation.dart';
import 'package:bank_sathi/widgets/tab_container.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

PersistentBottomSheetController? addLeadBottomSheetController;
GlobalKey<ScaffoldState> dashboardScaffoldKey = GlobalKey();
GlobalKey<IconSwitcherWidgetState> iconSwitchKey = GlobalKey();
GlobalKey<CustomBottomNavigationState> bottomNavigationKey =
    GlobalKey<CustomBottomNavigationState>();

class Dashboard extends GetView<DashboardController> {
  static FirebaseInAppMessaging fiam = FirebaseInAppMessaging();

  // Check CustomBottomNavigation
/*  final List<Pair> bottomNavigationList = [
    Pair(home.tr, 'assets/images/new_images/dashboard/home.svg'),
    Pair(leads.tr, 'assets/images/new_images/dashboard/leads.svg'),
    Pair(referral.tr, 'assets/images/new_images/dashboard/ic_team.svg'),
    Pair(marketing.tr, 'assets/images/new_images/dashboard/marketing.svg'),
  ];
  ];*/

  List<Widget> widgetList = [
    HomeTab(),
    MyLeads(),
    MyTeam(),
    HelpCenter(),
  ];

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
        onFinish: () {
          Get.find<PrefManager>().setShowcaseFalse();
        },
        onStart: (index, key) {},
        onComplete: (index, key) {
          // print('onComplete: $index, $key');
        },
        autoPlay: false,
        autoPlayDelay: Duration(seconds: 3),
        autoPlayLockEnable: false,
        builder: Builder(builder: (context) {
          controller.showCaseContext = context;
          return WillPopScope(
              child: Stack(
                children: [
                  Scaffold(
                    key: dashboardScaffoldKey,
                    body: TabContainer(
                      key: controller.tabKey,
                      children: widgetList,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Obx(() => controller.activeProducts == null
                          ? Container()
                          : CustomBottomNavigation(
                              key: bottomNavigationKey,
                              onIndexChange: (int newIndex) {
                                controller.currentTab = newIndex;
                              },
                              onFabClick: (bool show) {
                                if (show) {
                                  WidgetUtil.addLeadView(fromFabButton: true);
                                } else {
                                  if (addLeadBottomSheetController != null) {
                                    addLeadBottomSheetController!.close();
                                  }
                                }
                              },
                              switcherKey: iconSwitchKey,
                            )),
                    ),
                  )
                ],
              ),
              onWillPop: onWillPop);
        }));
  }

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() async {
    if (iconSwitchKey.currentState!.isBottomSheetOpen) {
      if (addLeadBottomSheetController != null) {
        addLeadBottomSheetController!.close();
      }
      return Future.value(false);
    }

    if (controller.currentTab != 0) {
      controller.currentTab = 0;
      bottomNavigationKey.currentState!.changeIndex(0);
      return Future.value(false);
    }
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;

      Fluttertoast.showToast(msg: tap_exit_msg.tr);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
