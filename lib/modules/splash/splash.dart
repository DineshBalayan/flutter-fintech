import 'package:bank_sathi/data/pref_manager.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sms_retriever/sms_retriever.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<SplashScreen> {
  VideoPlayerController? _controller;
  bool isInitialized = false;
  bool goToNextScreen = true;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      Future.delayed(1.seconds, () {
        _goToNextScreen();
      });
    } else {
      _controller = VideoPlayerController.asset('assets/splash.mp4')
        ..initialize().then((value) {
          setState(() {
            isInitialized = true;
          });
        });
      _controller!.addListener(() {
        if (isInitialized &&
            goToNextScreen &&
            _controller!.value.position == _controller!.value.duration) {
          goToNextScreen = false;
          _goToNextScreen();
        }
      });
      _controller!.setLooping(false).then((value) => _controller!.play());
    }
  }

  @override
  void dispose() {
    if (_controller != null) _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(1080, 2280));

    return SafeArea(child: LayoutBuilder(builder: (_, constraintSuper) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: isInitialized && kReleaseMode
                ? AspectRatio(
                    aspectRatio: 1080 / 1920,
                    child: VideoPlayer(_controller!),
                  )
                : Container(),
          ));
    }));
  }

  void _goToNextScreen() async {
    PrefManager prefManager = Get.find();
    var route = prefManager.isFirstTime() ? Routes.INTRO : Routes.LOGIN;
    if (prefManager.getUserData() != null &&
        prefManager.getUserData()!.user_code != null) {
      if (await SmsRetriever.isDeviceLocked() && kReleaseMode) {
        try {
          String platformAuth = await SmsRetriever.unlockApp();
          if (platformAuth == 'true') {
            route = Routes.DASHBOARD;
          }
        } catch (e) {
          print(e);
          if ((e as PlatformException).code == "1") {
            Get.put(DashboardController(), permanent: true);
            route = Routes.DASHBOARD;
          } else {
            route = Routes.UNLOCK;
          }
        }
      } else {
        Get.put(DashboardController(), permanent: true);
        route = Routes.DASHBOARD;
      }
    }
    if (mounted) {
      Get.offAndToNamed(route);
    }
  }
}
