import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sms_retriever/sms_retriever.dart';
import 'package:sqflite/sqflite.dart';

class UnlockController extends BaseController {
  @override
  void onInit() async {
    super.onInit();
  }

  unlockApp() {
    SmsRetriever.unlockApp().then((platformAuth) async {
      if (platformAuth == 'true') {
        Get.offAndToNamed(Routes.DASHBOARD);
      }
    }).catchError((e) async {
      if (e.code == "1") {
        Get.offAndToNamed(Routes.DASHBOARD);
      } else {}
    });
  }

  Future<String> openedByNotificationClick() async {
    return "";
    /*
    RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      print(jsonEncode(remoteMessage.data));
      String screen = remoteMessage.data['screen'];
      if (screen != null && screen.isNotEmpty) {
        return screen;
      } else if (remoteMessage.data['link'] != null &&
          GetUtils.isURL(remoteMessage.data['link'])) {
        if (await canLaunch(remoteMessage.data['link'])) {
          await launch(remoteMessage.data['link']);
        }
      }
    } else {
      return await _handleInitialUri() ?? Routes.DASHBOARD;
    }


    return Routes.DASHBOARD;*/
  }

  Future<String?> _handleInitialUri() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (data == null) return null;
    final Uri deepLink = data.link;
    if (deepLink == null || deepLink.toString().isEmpty) {
      return null;
    } else {
      return deepLink.toString().replaceAll(deepLink.origin, "");
    }
  }

  @override
  void onReady() async {
    super.onReady();
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'banksathi.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE pincode(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }
}
