import 'dart:convert';

import 'package:bank_sathi/Model/response/get_user_response.dart';
import 'package:bank_sathi/translations/app_translation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager extends GetxController {
  static const IS_LOGIN = "IS_LOGIN";
  static const ACCESS_TOKEN = "ACCESS_TOKEN";
  static const FCM_TOKEN = "FCM_TOKEN";
  static const USER_DATA = "USER_DATA";
  static const DASHBOARD_DATA = "DASHBOARD_DATA";
  static const USER_ID = "USER_ID";
  static const MOBILE = "MOBILE";
  static const FIN_PRODUCTS = "PRODUCTS";
  static const PRODUCTS_STATUS = "PRODUCTS_STATUS";
  static const CATEGORY_COLOR = "CATEGORY_COLOR";
  static const SELECTED_LOCALE = "SELECTED_LOCALE";
  static const NOTIFICATION_TIME = "NOTIFICATION_TIME";
  static const CAN_ASK_CONTACT_PERMISSION = "CAN_ASK_CONTACT_PERMISSION";
  static const SAVING_ACCOUNT_CONTENT_LANG = "SAVING_ACCOUNT_CONTENT_LANG";
  static const IS_FIRST_TIME = "IS_FIRST_TIME";
  static const ISSHOWCASE = "IS_SHOWCASE";

  SharedPreferences? sharedPreferences;

  @override
  void onInit() async {
    super.onInit();
    await initPrefManager();
  }

  /*Future<void> setLogin({bool isLogin = true}) async {
    await sharedPreferences?.setBool(IS_LOGIN, isLogin);
    return;
  }*/

  bool isLogin() {
    return sharedPreferences?.getBool(IS_LOGIN) ?? false;
  }

  bool isFirstTime() {
    return sharedPreferences?.getBool(IS_FIRST_TIME) ?? true;
  }

  setFirstTimeFalse() {
    sharedPreferences?.setBool(IS_FIRST_TIME, false);
  }

  bool isShowCase() {
    return sharedPreferences?.getBool(ISSHOWCASE) ?? true;
  }

  setShowcaseFalse() {
    sharedPreferences?.setBool(ISSHOWCASE, false);
  }

  Future<void> initPrefManager() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  saveToken(value) {
    sharedPreferences?.setString(ACCESS_TOKEN, value);
  }

  String? getToken() {
    return sharedPreferences?.getString(ACCESS_TOKEN);
  }

  Future<void> saveUsersData(Users user) async {
    await sharedPreferences?.setString(USER_DATA, json.encode(user));
  }

  Users? getUserData() {
    if (sharedPreferences?.getString(USER_DATA) == null) {
      return null;
    }
    return Users.fromJson(
        json.decode(sharedPreferences?.getString(USER_DATA) ?? ""));
  }

  saveUserId(int id) {
    sharedPreferences?.setInt(USER_ID, id);
  }

  int? getUserId() {
    return sharedPreferences?.getInt(USER_ID)!;
  }

  saveMobile(String id) {
    sharedPreferences?.setString(MOBILE, id);
  }

  String? getMobile() {
    return sharedPreferences?.getString(MOBILE);
  }

  saveFinProducts(List<RelFin> finProducts) {
    sharedPreferences?.setString(
        FIN_PRODUCTS,
        json.encode(
          finProducts
              .map<Map<String, dynamic>>((product) => product.toJson())
              .toList(),
        ));
  }

  List<RelFin>? getProducts() {
    if (sharedPreferences?.getString(FIN_PRODUCTS) != null) {
      return (json.decode(sharedPreferences?.getString(FIN_PRODUCTS) ?? "")
              as List<dynamic>)
          .map<RelFin>((item) => RelFin.fromJson(item))
          .toList();
    } else {
      return null;
    }
  }

  Future<void> setLocale(String locale) async {
    await sharedPreferences?.setString(SELECTED_LOCALE, locale);
    return;
  }

  Locale? getLocale() {
    final locale = sharedPreferences?.getString(SELECTED_LOCALE);
    if (locale == null) {
      return null;
    }
    return locale == AppTranslation.ENGLISH_LOCALE_LABEL
        ? AppTranslation.ENGLISH_LOCALE
        : AppTranslation.HINDI_LOCALE;
  }

  saveFcmToken(String token) {
    sharedPreferences?.setString(FCM_TOKEN, token);
  }

  String? getNotificationTime() {
    if (sharedPreferences == null ||
        !sharedPreferences!.containsKey(NOTIFICATION_TIME)) {
      return "";
    }
    return sharedPreferences?.getString(NOTIFICATION_TIME);
  }

  setNotificationTime(String time) {
    sharedPreferences?.setString(NOTIFICATION_TIME, time);
  }

  String? getContentLanguage() {
    if (sharedPreferences == null ||
        !sharedPreferences!.containsKey(SAVING_ACCOUNT_CONTENT_LANG)) {
      return "English";
    }
    return sharedPreferences?.getString(SAVING_ACCOUNT_CONTENT_LANG);
  }

  setContentLanguage(String lang) {
    sharedPreferences?.setString(SAVING_ACCOUNT_CONTENT_LANG, lang);
  }

  String? getFcmToken() {
    return sharedPreferences?.getString(FCM_TOKEN);
  }

  bool? canAskContactPermission() {
    if (sharedPreferences == null ||
        !sharedPreferences!.containsKey(CAN_ASK_CONTACT_PERMISSION)) {
      return true;
    }
    return sharedPreferences!.getBool(CAN_ASK_CONTACT_PERMISSION);
  }

  Future setCanAskContactPermission(bool yesOrNo) async {
    await sharedPreferences?.setBool(CAN_ASK_CONTACT_PERMISSION, yesOrNo);
  }

  saveProductsStatus(List<Products> finProducts) {
    sharedPreferences?.setString(
        PRODUCTS_STATUS,
        json.encode(
          finProducts
              .map<Map<String, dynamic>>((product) => product.toJson())
              .toList(),
        ));
  }

  List<Products>? getProductsStatus() {
    if (sharedPreferences?.getString(PRODUCTS_STATUS) != null) {
      return (json.decode(sharedPreferences?.getString(PRODUCTS_STATUS) ?? "")
              as List<dynamic>)
          .map<Products>((item) => Products.fromJson(item))
          .toList();
    } else {
      return null;
    }
  }

  saveProductsColor(List<CategoryColor> categoryColors) {
    sharedPreferences?.setString(
        CATEGORY_COLOR,
        json.encode(
          categoryColors
              .map<Map<String, dynamic>>((product) => product.toJson())
              .toList(),
        ));
  }

  List<CategoryColor>? getProductsColor() {
    if (sharedPreferences?.getString(CATEGORY_COLOR) != null) {
      return (json.decode(sharedPreferences?.getString(CATEGORY_COLOR) ?? "")
              as List<dynamic>)
          .map<CategoryColor>((item) => CategoryColor.fromJson(item))
          .toList();
    } else {
      return null;
    }
  }

  Future<void> saveDashboardResponse(GetUserResponse response) async {
    await sharedPreferences?.setString(DASHBOARD_DATA, json.encode(response));
  }

  GetUserResponse? getDashboardData() {
    if (sharedPreferences?.getString(DASHBOARD_DATA) == null ||
        sharedPreferences!.getString(DASHBOARD_DATA)!.isEmpty) {
      return null;
    }
    return GetUserResponse.fromJson(
        json.decode(sharedPreferences?.getString(DASHBOARD_DATA) ?? ""));
  }
}
