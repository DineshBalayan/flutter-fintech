import 'package:bank_sathi/Helpers/Constant.dart';
import 'package:bank_sathi/Helpers/notification_helper.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/request/check_update_request.dart';
import 'package:bank_sathi/Model/request/fcm_token_request.dart';
import 'package:bank_sathi/Model/response/base_response.dart';
import 'package:bank_sathi/Model/response/check_update_data.dart';
import 'package:bank_sathi/Model/response/get_user_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/mixin/state_city_mixin.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/share_tab_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/controllers/help_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/controllers/my_leads_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/views/webview_launcher.dart';
import 'package:bank_sathi/modules/dashboard_module/views/dashboard.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/tab_container.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:package_info/package_info.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:steel_crypt/steel_crypt.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

class DashboardController extends BaseController
    with WidgetsBindingObserver, SingleGetTickerProviderMixin, StateCityMixin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  NotificationHelper notificationHelper = NotificationHelper();

  BuildContext? showCaseContext;

  GlobalKey<TabContainerState> tabKey = GlobalKey();

  GlobalKey showKey1 = GlobalKey();
  GlobalKey showKey2 = GlobalKey();
  GlobalKey showKey3 = GlobalKey();
  GlobalKey showKey4 = GlobalKey();
  GlobalKey showKey5 = GlobalKey();

  final _testimonialPage = 0.obs;

  get testimonialPage => _testimonialPage.value;

  set testimonialPage(val) => _testimonialPage.value = val;

  RxInt _currentTab = 0.obs;

  int get currentTab => _currentTab.value;

  set currentTab(int val) {
    try {
      _currentTab.value = val;
    } catch (e) {
      print(e);
      _currentTab = RxInt(val);
      currentTab = val;
    }
    if (tabKey.currentState != null && WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        tabKey.currentState!.changeIndex(currentTab);
      });
    }
    if (addLeadBottomSheetController != null) {
      addLeadBottomSheetController!.close();
    }
    if(val == 3){
      Future.delayed(500.milliseconds, () {
        Get.find<HelpController>().updateSelectedValue(0);
      });
    }
  }

  final _notifCount = 0.obs;

  int get notifCount => _notifCount.value;

  set notifCount(val) => _notifCount.value = val;

  var wifiIP = '';

  bool exception = false;

  final RxBool _showcaseAutoPlay = false.obs;

  get showcaseAutoPlay => _showcaseAutoPlay.value;

  set showcaseAutoPlay(val) => _showcaseAutoPlay.value = val;

  final _announcementList = <Announcement>[].obs;

  List<Announcement> get announcementList => _announcementList.value;

  set announcementList(List<Announcement> val) => _announcementList.value = val;

  final _topLeaders = <LeadBoard>[].obs;

  List<LeadBoard> get topLeaders => _topLeaders.value;

  set topLeaders(val) => _topLeaders.value = val;

  final _knowledgeVideo = <Knowladge>[].obs;

  List<Knowladge> get knowledgeVideo => _knowledgeVideo.value;

  set knowledgeVideo(val) => _knowledgeVideo.value = val;
  final _featuredVideo = <String>[].obs;

  List<String> get featuredVideo => _featuredVideo.value;

  set featuredVideo(val) => _featuredVideo.value = val;
  final _relFins = <RelFin>[].obs;

  List<RelFin> get relFins => _relFins.value;

  set relFins(List<RelFin> val) => _relFins.value = val;

  final _bannerList = <PrBanner>[].obs;

  List<PrBanner> get bannerList => _bannerList.value;

  set bannerList(val) => _bannerList.value = val;

  final _toolbarTitle = ''.obs;

  get toolbarTitle => _toolbarTitle.value;

  set toolbarTitle(val) => _toolbarTitle.value = val;

  final _activeProducts = <Products>[].obs;

  List<Products> get activeProducts => _activeProducts.value;

  set activeProducts(val) => _activeProducts.value = val;

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.onClose();
  }

  @override
  void onReady() async {
    super.onReady();


    try {
      if (prefManager.getDashboardData() == null) {
        pageState = PageStates.PAGE_LOADING;
      }
      await dashboardApi();
      if (pageState != PageStates.PAGE_IDLE) {
        pageState = PageStates.PAGE_IDLE;
      }
      await _handleInitialUri();
      List<Products> products = prefManager.getProductsStatus() ?? [];
      activeProducts =
          products.where((element) => element.status == "1").toList();

      if (prefManager.isShowCase() &&
          showCaseContext != null &&
          Get.currentRoute == Routes.DASHBOARD &&
          currentTab == 0) {
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
          if (currentTab == 0 && Get.currentRoute == Routes.DASHBOARD) {
            await WidgetsBinding.instance!.endOfFrame;
            ShowCaseWidget.of(showCaseContext!)!.startShowCase([
              showKey5,
              showKey4,
              showKey3,
              showKey2,
              showKey1,
            ]);
          }
        });
      }

      await setUpFirebase();
      await locationServiceCall();
      await fetchData();
       FirebaseInAppMessaging.instance.triggerEvent("dashboard_ready");
    } catch (e) {
      e.printInfo();
    }
  }

  Future<void> dashboardApi() async {
    try {
      GetUserResponse? getUserResponse = prefManager.getDashboardData();
      if (getUserResponse != null) {
        bannerList = getUserResponse.data.pr_banners;
        announcementList = getUserResponse.data.announcement;
        topLeaders = getUserResponse.data.lead_board;
        knowledgeVideo = getUserResponse.data.knowladge;
        featuredVideo = getUserResponse.data.featuredVideo;
        totalAmount = getUserResponse.data.transection.total_amount;
        totalWithdrawAmount =
            getUserResponse.data.transection.total_withdrawal_amount;
      }
      getUserResponse = await restClient.dashboardApi(
          prefManager.getUserId()!, prefManager.getNotificationTime()!);
      if (getUserResponse.success) {
        prefManager.saveDashboardResponse(getUserResponse);
        prefManager.saveUsersData(getUserResponse.data.users);
        prefManager.saveProductsStatus(getUserResponse.data.products);
        prefManager.saveProductsColor(getUserResponse.data.category_colors);

        List<Products> products = prefManager.getProductsStatus() ?? [];
        activeProducts =
            products.where((element) => element.status == "1").toList();

        user = prefManager.getUserData();
        if (getUserResponse.data.rel_fins != null) {
          prefManager.saveFinProducts(getUserResponse.data.rel_fins);
        }
        finProducts = prefManager.getProducts();
        notifCount = getUserResponse.data.noti_count;
        bannerList = getUserResponse.data.pr_banners;
        announcementList = getUserResponse.data.announcement;
        topLeaders = getUserResponse.data.lead_board;
        knowledgeVideo = getUserResponse.data.knowladge;
        featuredVideo = getUserResponse.data.featuredVideo;
        totalAmount = getUserResponse.data.transection.total_amount;
        totalWithdrawAmount =
            getUserResponse.data.transection.total_withdrawal_amount;
      }
    } catch (e) {
      print(e);
      e.printInfo();
    }
  }

  final _totalAmount = "0".obs;

  String get totalAmount => _totalAmount.value;

  set totalAmount(val) => _totalAmount.value = val;

  final _totalWithdrawAmount = '0'.obs;

  String get totalWithdrawAmount => _totalWithdrawAmount.value;

  set totalWithdrawAmount(val) => _totalWithdrawAmount.value = val;

  Future<void> locationServiceCall() async {
    wifiIP = await WifiInfo().getWifiIP() ?? '';
    late LocationPermission permissionResult;
    try {
      permissionResult = await Geolocator.checkPermission();
    } catch (e) {
      print(e);
    }

    if (permissionResult != LocationPermission.deniedForever) {
      if (permissionResult == LocationPermission.denied) {
        LocationPermission _permissionGranted =
            await Geolocator.requestPermission();
        if (_permissionGranted == LocationPermission.denied ||
            _permissionGranted == LocationPermission.deniedForever) {
          await checkAppVersion();
          return;
        }
      }
    } else {
      await checkAppVersion();
      return;
    }

/*    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      await Geolocator.openLocationSettings();
      _serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!_serviceEnabled) {
        print("Service Disable");
        await checkAppVersion();
        return;
      }
    }*/
    try {
      print("Permission and Service Enable");
      Position _locationData = await Geolocator.getCurrentPosition();
      await checkAppVersion(locationData: _locationData);
    } catch (e) {
      if (e is LocationServiceDisabledException) {
        await checkAppVersion();
      }
    }

    return;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed &&
        checkUpdateData != null &&
        checkUpdateData!.force_update == 'n') {
      handleUpdate();
    }
  }

  Future<void> checkAppVersion({Position? locationData}) async {
    if (GetPlatform.isAndroid && Get.currentRoute == Routes.DASHBOARD) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String versionCode = packageInfo.buildNumber;
      try {
        CheckUpdateRequest checkUpdateRequest = CheckUpdateRequest(
          user_id: getUserId(),
          ip: wifiIP,
          mobile_no: prefManager.getMobile(),
          lags_longs: locationData == null
              ? ""
              : '' +
                  locationData.longitude.toString() +
                  ',' +
                  locationData.latitude.toString(),
          device_id: prefManager.getFcmToken(),
          app_version: versionCode,
          mobile_type: 'Android',
        );
        final response = await restClient.checkUpdate(checkUpdateRequest);
        checkUpdateData = CheckUpdateData.fromJson(response.data);
        handleUpdate();
      } on Exception {}
      return;
    }
  }

  Future<void> handleUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionCode = packageInfo.buildNumber;
    if (int.parse(checkUpdateData!.and_version) > int.parse(versionCode)) {
      Get.dialog(
        WillPopScope(
          child: WidgetUtil.showDialog(
            () {
              launchURL(Constant.APP_PLAY_STORE_LINK);
            },
            dialogType: DialogType.INFO,
            title: app_update.tr,
            message: checkUpdateData!.message != null &&
                    checkUpdateData!.message.isNotEmpty
                ? app_update_msg.tr + "\n" + checkUpdateData!.message
                : app_update_msg.tr,
            button: "Update Now",
          ),
          onWillPop: () async => checkUpdateData!.force_update == 'n',
        ),
        barrierDismissible: checkUpdateData!.force_update == 'n',
      );
    }
  }

  CheckUpdateData? checkUpdateData;

  Future<void> _handleInitialUri() async {
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (data) async {
        handleDynamicLinkData(data);
        return;
      },
    );

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    handleDynamicLinkData(data);
  }

  Future<void> setUpFirebase() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance
        .requestPermission(sound: true, badge: true, alert: true);
    FirebaseMessaging.instance.getToken().then((String? token) {
      if (token != null) sendFcmTokenToServer(token);
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      if (prefManager.getFcmToken() != null &&
          prefManager.getFcmToken()!.isNotEmpty &&
          prefManager.getFcmToken() != newToken) {
        sendFcmTokenToServer(newToken);
      }
    });
    FirebaseCrashlytics.instance.setUserIdentifier(getUserId().toString());
    setUpNotifications();
  }

  sendFcmTokenToServer(fcmToken) {
    restClient
        .fcmToken(FcmTokenRequest(user_id: getUserId(), fcm_token: fcmToken))
        .then((value) {
      if (value.success) {
        prefManager.saveFcmToken(fcmToken);
      }
    });
  }

  void handleDynamicLinkData(PendingDynamicLinkData? data) {
    if (data != null) {
      final Uri uri = data.link;
      String payload = uri.toString().replaceAll(uri.origin, "");
      print("payload : " + payload);
      print("uri.path : " + uri.path);
      if (uri.toString().isNotEmpty) {
        if (uri.path == Routes.DASHBOARD &&
            Get.currentRoute == Routes.DASHBOARD) {
          currentTab = int.parse(uri.queryParameters['index'] ?? "0");
          if (Get.parameters['page'] != null) {
            int page = int.parse(Get.parameters['page'] ?? "0");
            if (currentTab == 1) {
              Future.delayed(500.milliseconds, () {
                Get.find<MyLeadsController>().changeIndex(page);
              });
            }
            if (currentTab == 3) {
              Future.delayed(500.milliseconds, () {
                Get.find<ShareTabController>().changeIndex(page);
              });
            }
          }
        } else {
          if (Uri.parse(Get.currentRoute).path == uri.path) {
            Get.offAndToNamed(payload);
          } else {
            Get.toNamed(payload);
          }
        }
      }
    }
  }

  void setUpNotifications() async {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleNotifications(event);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage? event) {
      if (event != null) {
        if (event.data != null) {
          if (event.data.containsKey('image')) {
            notificationHelper.showNotificationImage(
                event.data['title'], event.data['body'], event.data['image'],
                payload: event.data['screen'] ?? event.data['link']);
          } else {
            notificationHelper.showNotification(
                event.data['title'], event.data['body'],
                payload: event.data['screen'] ?? event.data['link']);
          }
        }
      }
    });

    RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    handleNotifications(remoteMessage);
  }

  void handleNotifications(RemoteMessage? data,
      {String? screen, String? link}) {
    if (data != null || screen != null || link != null) {
      String? payload = data != null ? data.data['screen'] : screen;
      if (payload != null && payload.isNotEmpty) {
        Uri uri = Uri.parse(payload);
        if (uri.toString().isNotEmpty) {
          if (uri.path == Routes.DASHBOARD &&
              Get.currentRoute == Routes.DASHBOARD) {
            currentTab = int.parse(uri.queryParameters['index'] ?? "0");
            print("tab : " + currentTab.toString());
            if (uri.queryParameters['page'] != null) {
              int page = int.parse(uri.queryParameters['page'] ?? "0");
              print("page : " + page.toString());
              if (currentTab == 1) {
                Future.delayed(500.milliseconds, () {
                  Get.find<MyLeadsController>().changeIndex(page);
                });
              } else if (currentTab == 3) {
                Future.delayed(500.milliseconds, () {
                  Get.find<ShareTabController>().changeIndex(page);
                });
              }
            }
          } else {
            if (Uri.parse(Get.currentRoute).path == uri.path) {
              Get.offAndToNamed(payload);
            } else {
              Get.toNamed(payload);
            }
          }
        }
      } else {
        String url = data != null ? data.data['link'] : link ?? "";
        print("URL URL : " + url);
        if (url.videoId != null) {
          Get.dialog(WidgetUtil.videoDialog(url.videoId!));
        } else if (GetUtils.isURL(url)) {
          Get.to(WebViewLauncher(
            url: url,
            title: 'BankSathi',
          ));
        }
      }
    }
  }

  withDrawToWallet(String mobileNo) async {
    showLoadingDialog();
    try {
      BaseResponse response =
          await restClient.withdrawRequest(getUserId().toString(), mobileNo);
      await dashboardApi();
      hideDialog();
      if (response.success) {
        Get.back();
        Get.dialog(WidgetUtil.showDialog(() {
          Get.back();
        },
            title: response.message == 'Unauthorizede Access'? "Error" :response.message.contains('under maintenance')? "Hold On!": "Success",
            dialogType:response.message =='Unauthorizede Access'? DialogType.ERROR : DialogType.INFO,
            message: response.message));
      }
    } catch (e) {
      hideDialog();
      Get.back();
    }
  }

  withDrawToBank() async {
    showLoadingDialog();
    try {
      BaseResponse response =
          await restClient.withdrawRequestBank(getUserId().toString());
      await dashboardApi();
      hideDialog();
      if (response.success) {
        Get.back();
        Get.dialog(WidgetUtil.showDialog(() {
          Get.back();
        },
            title: response.message == 'Unauthorizede Access'? "Error" : "Success",
            dialogType:response.message =='Unauthorizede Access'? DialogType.ERROR : DialogType.INFO,
            message: response.message));
      }
    } catch (e) {
      hideDialog();
      Get.back();
    }
  }
}
