import 'dart:convert';
import 'dart:io';

import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Model/response/base_response.dart';
import 'package:bank_sathi/Model/response/down_time_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/data/pref_manager.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/home_tab_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/share_tab_controller.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:crypto/crypto.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Response;

class HeaderInterceptors extends Interceptor {
  final Dio dio;
  HeaderInterceptors(this.dio);
  PrefManager prefManager = Get.find<PrefManager>();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    bool hasInternet = await DataConnectionChecker().hasConnection;
    if (hasInternet) {
      String? header = prefManager.getToken();
      if (header == null ||
          header.isEmpty ||
          options.path == '/besath_loginb' ||
          options.path == '/besath_true_loginb') {
        String key = 'FAJAdtVMtB6FxmsOhuxkzzRvTQMKUZon';
        DateTime now = DateTime.now();
        var millis = now.millisecondsSinceEpoch.toString();
        String input =
            millis + key + millis + prefManager.getMobile()! + millis;
        String md5_input = md5.convert(utf8.encode(input)).toString();
        String signature =
            md5.convert(utf8.encode(md5_input)).toString() + md5_input;

        options.headers.addAll({
          "Accept": "application/json",
          "mobile": prefManager.getMobile(),
          "signature": signature,
          "time": millis,
        });
      } else {
        options.headers.addAll({
          "authorization": "Bearer $header",
          "Accept": "application/json",
        });
      }

      if (kDebugMode) {
        options.headers.forEach((k, v) => print('$k: $v'));
      }
      handler.next(options);
    } else {
      handler.reject(
          DioError(
              requestOptions: options, error: SocketException(no_internet.tr)),
          true);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (Get.isDialogOpen!) {
      Get.back();
    }
    if (err.response != null && err.response!.statusCode == 401) {
      await prefManager.sharedPreferences!.clear();
      Get.dialog(
        WillPopScope(
            child: Dialog(
              backgroundColor: Colors.transparent,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.sp)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/images/new_images/session.svg',
                      width: 200.sp,
                    ).marginOnly(top: 40.sp),
                    CustomText(
                      'Session Expired',
                      fontSize: 48.sp,
                    ).marginOnly(top: 40.sp),
                    CustomText(
                      'Your session has expired, Please login to your account again.',
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
                          Locale? locale = prefManager.getLocale();
                          prefManager.sharedPreferences!.clear().then((value) {
                            Get.delete<DashboardController>(force: true);
                            Get.delete<HomeTabController>(force: true);
                            Get.delete<ShareTabController>(force: true);
                            Get.offAllNamed(Routes.LOGIN);
                          });
                        },
                        color: ColorUtils.textColorLight,
                        child: CustomText(
                          'Login Now'.toUpperCase(),
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
            ),
            onWillPop: () async {
              return false;
            }),
        barrierDismissible: false,
      );
    } else if (err.response != null && err.response!.statusCode == 405) {
      DownTimeResponse response = DownTimeResponse.fromJson(err.response!.data);
      Get.offAndToNamed(Routes.DOWNTIME_SCREEN,
          arguments: response.data.err_msg);
    } else if (err.error is SocketException) {
      if (!Get.isSnackbarOpen!)
        Get.snackbar('App Message', 'Internet Not Available in Device',
            duration: const Duration(seconds: 3),
            snackPosition: SnackPosition.BOTTOM);
    } else if (err.response != null) {
      BaseResponse baseResponse = BaseResponse.fromJson(err.response!.data);
      if (baseResponse.success == null) {
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
                  baseResponse.message,
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
      } else if (!baseResponse.success) {
        String msg = '';
        if (baseResponse.data != null && baseResponse.data is Map) {
          final jsonData = baseResponse.data as Map;
          jsonData.forEach((key, value) {
            if (value != null && value is List && value.isNotEmpty) {
              msg = msg +
                  key
                      .toString()
                      .replaceAll("_", " ")
                      .split(' ')
                      .map((word) => word[0].toUpperCase() + word.substring(1))
                      .join(' ') +
                  ": " +
                  value[0] +
                  " \n";
            } else if (value != null && value is String) {
              msg = msg +
                  key
                      .toString()
                      .capitalizeFirst!
                      .replaceAll("_", " ")
                      .split(' ')
                      .map((word) => word[0].toUpperCase() + word.substring(1))
                      .join(' ') +
                  ": " +
                  value +
                  " \n";
            }
          });
        } else if (baseResponse.data != null && baseResponse.data is String) {
          msg = baseResponse.data.toString();
        }
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
        // Get.dialog(WidgetUtil.showDialog(
        //   () {
        //     Get.back();
        //   },
        //   dialogType: DialogType.ALERT,
        //   title: baseResponse.message,
        //   message: msg,
        // ));
      }
    }
    handler.resolve(Response(requestOptions: err.requestOptions));
  }
}
