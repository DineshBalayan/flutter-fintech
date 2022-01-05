import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:bank_sathi/Helpers/Constant.dart';
import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/response/get_section_help_response.dart';
import 'package:bank_sathi/Model/response/get_user_response.dart';
import 'package:bank_sathi/data/pref_manager.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/home_tab_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/share_tab_controller.dart';
import 'package:bank_sathi/network/rest_client.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/loading_widget.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart'; // import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

export 'package:bank_sathi/Helpers/extensions.dart';
export 'package:bank_sathi/translations/string_keys.dart';

RestClient restClient = RestClient();

class BaseController extends GetxController {
  final _pageState = PageStates.PAGE_IDLE.obs;

  PageStates get pageState => _pageState.value;

  set pageState(val) => _pageState.value = val;

  PrefManager prefManager = Get.find();

  static final _user = Users().obs;

  set user(val) => _user.value = val;

  Users get user => _user.value;

  static final _finProducts = <RelFin>[].obs;

  List<RelFin> get finProducts => _finProducts.value;

  set finProducts(val) => _finProducts.value = val;

  static final _versionName = ''.obs;

  String get versionName => _versionName.value;

  set versionName(val) => _versionName.value = val;

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(val) => _isLoading.value = val;

  @override
  void onInit() async {
    super.onInit();
    if (versionName.isBlank ?? true) {
      versionName = (await PackageInfo.fromPlatform()).version;
    }

    _user.listen((user) {
      onUserChange();
    });
  }

  void onUserChange() {}

  @override
  void onReady() {
    super.onReady();
    try {
      if (prefManager.getUserData() != null) {
        user = prefManager.getUserData();
      } else {
        getUser();
      }
      if (prefManager.getProducts() != null) {
        finProducts = prefManager.getProducts();
      }
    } catch (e) {}
  }

  @override
  void onClose() {
    super.onClose();
  }

  handleError({String msg = ""}) async {
    if (msg.isEmpty) {
      msg = something_went_wrong.tr;
    }

    try {
      Get.dialog(Dialog(
        backgroundColor: Colors.transparent,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.sp)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/new_images/error.svg',
                width: 200.sp,
              ).marginOnly(top: 40.sp),
              CustomText(
                'Oops, Error Found',
                fontSize: 48.sp,
              ).marginOnly(top: 40.sp),
              CustomText(
                msg,
                textAlign: TextAlign.center,
                color: Colors.grey,
                fontweight: FontWeight.w300,
              ).marginOnly(top: 10.sp),
              SizedBox(
                height: 100.sp,
                child: RaisedButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.w),
                  ),
                  highlightColor: ColorUtils.orange,
                  onPressed: () async {
                    Get.back();
                  },
                  color: ColorUtils.textColorLight,
                  child: CustomText(
                    'Okay, Got It'.toUpperCase(),
                    style: TextStyle(
                        color: ColorUtils.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 42.sp),
                  ),
                ),
              ).marginOnly(top: 50.sp)
            ],
          ).marginAll(60.sp),
        ),
      ));
    } catch (e) {
      print(e);
    }
  }

  showLoadingDialog() {
    isLoading = true;
    Get.dialog(LoadingWidget(), barrierDismissible: false);
  }

  hideDialog() {
    isLoading = false;
    if (Get.isDialogOpen ?? false) Get.back();
  }

  Future<void> writeToFile(ByteData? data, String path) {
    final buffer = data!.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  openAppSetting(String message) {
    Get.dialog(WidgetUtil.logoutDialog(() => Get.back(), () async {
      Get.back();
      AndroidIntent intent = AndroidIntent(
        action: "android.settings.APPLICATION_DETAILS_SETTINGS",
        package: "com.app.banksathi",
        data: "package:com.app.banksathi",
      );
      try {
        await intent.launch();
      } catch (e) {
        handleError();
      }
    }, title: 'Grant Permission', button: 'Proceed', message: message));
  }

  shareReferralLink() async {
    showLoadingDialog();
    try {
      final assetname = 'assets/images/sharing_image.jpg';
      final filename = 'sharing_image.jpg';
      var bytes = await rootBundle.load(assetname);
      String dir = (await getApplicationDocumentsDirectory()).path;
      var filepath = '$dir/$filename';
      if (await File(filepath).exists()) File(filepath).delete();
      await writeToFile(bytes, filepath);

      String link =
          Constant.REFERENCE_BASE_URL + prefManager.getUserData()!.user_code;
      final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: Constant.APP_PAGE_LINK,
        link: Uri.parse(link),
        androidParameters: AndroidParameters(
          packageName: 'com.app.banksathi',
          minimumVersion: 0,
        ),
        iosParameters: IosParameters(bundleId: 'com.example.myappname'),
      );
      final ShortDynamicLink shortDynamicLink =
          await parameters.buildShortLink();
      hideDialog();
      Share.shareFiles(
        [filepath],
        text:
            "Hi! Join Banksathi & earn more than 1,00,000 from home. It is trusted by 2 Lakh+ people across the country. Banksathi is the most reliable and highly paying source of income. Download Banksathi app now. Tap the link ${shortDynamicLink.shortUrl.toString()}\nUse my referral code for signup: ${getUserCode()}"

        /*"Hi! Sign up on Bank Sathi using this link:\n" +
          shortDynamicLink.shortUrl.toString() +
          "\n use my Referral Code : " +
          prefManager.getUserData().user_code*/
        ,
      );
    } finally {
      hideDialog();
    }
  }

  shareLinkText(var text) async {
    showLoadingDialog();
    try {
      String link =
          Constant.REFERENCE_BASE_URL + prefManager.getUserData()!.user_code;
      final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: Constant.APP_PAGE_LINK,
        link: Uri.parse(link),
        androidParameters: AndroidParameters(
          packageName: 'com.app.banksathi',
          minimumVersion: 0,
        ),
        iosParameters: IosParameters(bundleId: 'com.example.myappname'),
      );
      final ShortDynamicLink shortDynamicLink =
          await parameters.buildShortLink();
      hideDialog();
      Share.share(
        text +
            "\n" +
            'Use my Referral Code : ' +
            prefManager.getUserData()!.user_code +
            "\nClick and Download the APP now to earn unlimited money.\n" +
            shortDynamicLink.shortUrl.toString() +'\n\n*Banksathi Advisor*',
      );
    } finally {
      hideDialog();
    }
  }

  Future<GetUserResponse?> getUser() async {
    GetUserResponse? getUserResponse;
    try {
      getUserResponse = await restClient.dashboardApi(
          prefManager.getUserId()!, prefManager.getNotificationTime()!);
      if (getUserResponse.success) {
        await prefManager.saveUsersData(getUserResponse.data.users);
        user = prefManager.getUserData();
        if (getUserResponse.data.rel_fins != null) {
          prefManager.saveFinProducts(getUserResponse.data.rel_fins);
        }
        finProducts = prefManager.getProducts();
      }
    } catch (e) {
      print(e);
    }
    return getUserResponse;
  }

  String getUserFullName() {
    if (user.isEmpty()) {
      return "";
    } else {
      String middleName =
          user.middle_name != null && user.middle_name.toString().isNotEmpty
              ? " " + user.middle_name
              : "";
      String lastName =
          user.last_name != null && user.last_name.toString().isNotEmpty
              ? " " + user.last_name
              : "";
      return user.first_name.capitalizeFirst! +
          middleName.capitalizeFirst! +
          lastName.capitalizeFirst!;
    }
  }

  String getUserFirstName() {
    if (user == null) {
      return "";
    } else {
      return user.first_name.toString().capitalizeFirst!;
    }
  }

  String getUserLastName() {
    if (user == null) {
      return "";
    } else {
      return user.last_name.toString().capitalizeFirst!;
    }
  }

  String getUserAddress() {
    if (user == null) {
      return "";
    } else if (user.address == null ||
        user.address.add1 == null ||
        user.address.add1.isBlank!) {
      return "";
    } else {
      return user.address.add1.toString().capitalizeFirst! +
          " " +
          user.address.add2.toString().capitalizeFirst!;
    }
  }

  String getUserType() {
    if (user.user_type == null) {
      return "";
    } else {
      return user.user_type.toString().capitalizeFirst!;
    }
  }

  String getUserJoinDate() {
    if (user.created_at == null) {
      return "";
    } else {
      return user.created_at.toString().toDDMMYYYY();
    }
  }

  String getUserStatus() {
    if (user.user_status == null) {
      return "Unverified";
    } else {
      return user.user_status == "1"
          ? "Unverified"
          : user.user_status == "2"
              ? "Partially Verified"
              : user.user_status == "3"
                  ? "Verified"
                  : "Inactive";
    }
  }

  Color getUserStatusColor() {
    if (user.user_status == null) {
      return ColorUtils.orange;
    } else {
      return user.user_status == "1"
          ? ColorUtils.orange
          : user.user_status == "2"
              ? Colors.blue.shade700
              : user.user_status == "3"
                  ? "#5ed27f".hexToColor()
                  : Colors.grey.shade600;
    }
  }

  String getUserMpin() {
    if (user.is_mpin == null || user.is_mpin == 'n') {
      return "Not Available";
    } else {
      return "Available";
    }
  }

  String getUserCode() {
    if (user.user_code == null) {
      return "";
    } else {
      return user.user_code;
    }
  }

  String getUserProfileUrl() {
    if (user.profile_photo == null) {
      return "";
    } else {
      return user.profile_photo;
    }
  }

  int getUserId() {
    return prefManager.getUserId()!;
  }

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      handleError(msg: could_not_launch.tr);
    }
  }

  bool isDetailAvailableForEKYC() {
    if (user.address == null) {
      return false;
    } else if (user.address.add1 == null || user.address.add1.isEmpty) {
      return false;
    } else if (user.address.add_proof_no == null ||
        user.address.add_proof_no.isEmpty) {
      return false;
    } else if (user.pan_no == null || user.pan_no.isEmpty) {
      return false;
    }
    return true;
  }

  Logout() {
    Get.dialog(
      WidgetUtil.logoutDialog(() {
        Get.back();
      }, () {
        showLoadingDialog();
        Locale? locale = prefManager.getLocale();
        prefManager.sharedPreferences!.clear().then((value) {
          Get.find<DashboardController>().user = Users();
          Get.delete<HomeTabController>(force: true);
          Get.delete<ShareTabController>(force: true);
          Get.delete<DashboardController>(force: true);
          hideDialog();
          Get.offAllNamed(Routes.LOGIN);
        }).catchError((e) {
          print("Logout ERROR" + e.toString());
        });
      },
          title: logout.tr,
          message: are_you_sure_you_want_to_logout.tr,
          button: confirm.tr),
    );
  }

  void uploadProfilePic(File photoFile) {
    restClient
        .profilePic(user.id.toString(), photoFile: photoFile)
        .then((value) async {
      var res = await getUser();
      user = res!.data.users;
    }).catchError((onError) {});
  }

  void showSectionInfoById(int id) async {
    showLoadingDialog();
    try {
      GetSectionHelpResponse response = await restClient.getSectionHelp(id);
      hideDialog();
      if (response.success) {
        Get.bottomSheet(WidgetUtil.sectionHelpWidget(response.data[0]),
            isScrollControlled: true);
      }
    } catch (e) {
      hideDialog();
      print(e);
    }
  }
}

enum PageStates {
  PAGE_IDLE,
  PAGE_LOADING,
  PAGE_BUTTON_LOADING,
  PAGE_BUTTON_FAIL,
  PAGE_BUTTON_ERROR,
  PAGE_BUTTON_SUCCESS,
  PAGE_LOADING_MORE,
  PAGE_ERROR,
  PAGE_EMPTY_DATA
}
