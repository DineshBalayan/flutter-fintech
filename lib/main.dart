// @dart=2.10
import 'dart:async';

import 'package:bank_sathi/Helpers/notification_helper.dart';
import 'package:bank_sathi/data/pref_manager.dart';
import 'package:bank_sathi/db/db_controller.dart';
import 'package:bank_sathi/routes/app_pages.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/theme/theme_data.dart';
import 'package:bank_sathi/translations/app_translation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage event) async {}

NotificationHelper notificationHelper = NotificationHelper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PrefManager prefManager = Get.put(PrefManager(), permanent: true);
  Get.put(DBController(), permanent: true);
  await Firebase.initializeApp();
  notificationHelper.setUpLocalNotifications();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FlutterError.onError = (FlutterErrorDetails details) async {
    ErrorLogger.logError(details);
  };

  runZonedGuarded(() async {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .whenComplete(() async {
      runApp(MyApp());
    });
  }, (Object error, StackTrace stackTrace) async {
    ErrorLogger.log(error, stackTrace);
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PrefManager prefManager = Get.find();
    return GetMaterialApp(
      builder: (context, child) {
        ScreenUtil.init(
            BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
                maxHeight: MediaQuery.of(context).size.height),
            designSize: Size(1080, 2280));
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: child);
      },
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.downToUp,
      initialRoute: Routes.INITIAL,
      transitionDuration: Duration(milliseconds: 200),
      getPages: AppPages.pages,
      theme: appThemeData,
      enableLog: true,
      navigatorObservers: [],
      locale: prefManager.getLocale() ?? AppTranslation.ENGLISH_LOCALE,
      fallbackLocale: AppTranslation.ENGLISH_LOCALE,
      translationsKeys: AppTranslation.translations,
    );
  }

  @override
  void initState() {
    super.initState();
    // changeStatusColor(ColorUtils.orange_shadow);
  }

/*  changeStatusColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }*/

}

class ErrorLogger {
  static void logError(FlutterErrorDetails details) async {
    _sendToServerFlutter(details);
  }

  static void log(Object data, StackTrace stackTrace) async {
    FirebaseCrashlytics.instance.recordError(data, stackTrace);
  }

  static void _sendToServerFlutter(FlutterErrorDetails errorDetails) async {
    await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  }
}
