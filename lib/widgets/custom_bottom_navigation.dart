import 'dart:async';

import 'package:animate_icons/animate_icons.dart';
import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Model/pair.dart';
import 'package:bank_sathi/Model/response/get_user_response.dart';
import 'package:bank_sathi/data/pref_manager.dart';
import 'package:bank_sathi/modules/dashboard_module/views/dashboard.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'custom_text.dart';

typedef OnIndexChange = Function(int newIndex);
typedef OnFabClick = Function(bool show);

class CustomBottomNavigation extends StatefulWidget {
  final OnIndexChange onIndexChange;
  final OnFabClick onFabClick;
  final GlobalKey<IconSwitcherWidgetState> switcherKey;

  const CustomBottomNavigation(
      {Key? key,
      required this.onIndexChange,
      required this.onFabClick,
      required this.switcherKey})
      : super(key: key);

  @override
  State createState() {
    return CustomBottomNavigationState();
  }
}

class CustomBottomNavigationState extends State<CustomBottomNavigation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  int currentIndex = 0;

  void reAnimate() {
    setState(() {
      controller.repeatEx(times: 2);
      iconSwitchKey.currentState!.startTimer();
    });
  }

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Pair> bottomNavigationList = [
    Pair(home.tr, 'assets/images/new_images/dashboard/home.svg'),
    Pair(leads.tr, 'assets/images/new_images/dashboard/leads.svg'),
    Pair(leads.tr, ''),
    Pair(referral.tr, 'assets/images/new_images/dashboard/referals.svg'),
    Pair(help.tr, 'assets/images/new_images/dashboard/help.svg'),
  ];

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: Duration(milliseconds: 500), vsync: this)
      ..addListener(() => setState(() {}));
    animation = Tween(begin: -2.0, end: -20.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.bounceInOut));
    controller.repeatEx(times: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          UnconstrainedBox(
              child: CustomPaint(
            size: Size(
                MediaQuery.of(context).size.width,
                (MediaQuery.of(context).size.width * 0.16319444444444445)
                    .toDouble()),
            painter: CustomBottomNavigationPainter(),
            child: SizedBox.fromSize(
              size: Size(
                  MediaQuery.of(context).size.width,
                  (MediaQuery.of(context).size.width * 0.16319444444444445)
                      .toDouble()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: bottomNavigationList.map((e) {
                  int index = bottomNavigationList.indexOf(e);
                  bool isActive =
                      currentIndex == (index < 2 ? index : index - 1);
                  return index == 2
                      ? Container(
                          width: 200.sp,
                        )
                      : Expanded(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            UnconstrainedBox(
                              child: SvgPicture.asset(
                                e.second,
                                color: isActive
                                    ? ColorUtils.orange
                                    : ColorUtils.black,
                                height: 60.sp,
                                fit: BoxFit.scaleDown,
                              ),
                            ).marginOnly(bottom: 10.sp),
                            CustomText(
                              e.first,
                              fontSize: 36.sp,
                              fontweight: Weight.LIGHT,
                              customTextStyle: CustomTextStyle.NORMAL,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ).onClick(() {
                          setState(() {
                            currentIndex = index < 2 ? index : index - 1;
                            widget.onIndexChange(currentIndex);
                          });
                        }));
                }).toList(),
              ),
            ),
          )),
          Positioned.fill(
              key: UniqueKey(),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                    height: 160.sp,
                    width: 160.sp,
                    child: Transform.translate(
                      child: FloatingActionButton(
                        onPressed: () {},
                        elevation: 0,
                        child: IconSwitcherWidget(
                            key: widget.switcherKey,
                            onFabClick: widget.onFabClick),
                      ),
                      offset: Offset(0.0, animation.value),
                    )).marginOnly(bottom: 32.sp),
              ))
        ],
      ),
    );
  }
}

class IconSwitcherWidget extends StatefulWidget {
  final OnFabClick onFabClick;

  const IconSwitcherWidget({required Key key, required this.onFabClick})
      : super(key: key);

  @override
  IconSwitcherWidgetState createState() => IconSwitcherWidgetState();
}

class IconSwitcherWidgetState extends State<IconSwitcherWidget>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late Timer _timer;
  bool enableIconSwitch = false;
  List<String> _icons = [];

  bool isPlaying = false;

  bool isBottomSheetOpen = false;

  late AnimateIconController controller;

  IconSwitcherWidgetState() {
    List<Products>? productList = Get.find<PrefManager>().getProductsStatus();
    if (productList != null) {
      _icons = productList.map((e) => e.icon).toList();
    }
  }

  void startTimer() {
    List<Products>? productList = Get.find<PrefManager>().getProductsStatus();
    if (productList != null) {
      _icons = productList.map((e) => e.icon).toList();
      _currentIndex = 0;
      enableIconSwitch = true;
    } else {
      enableIconSwitch = false;
      return;
    }

    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) async {
      if (mounted) {
        setState(() {
          if (_currentIndex + 1 == _icons.length) {
            _currentIndex = 0;
            setState(() {
              enableIconSwitch = false;
              _timer.cancel();
            });
          } else {
            _currentIndex = _currentIndex + 1;
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controller = AnimateIconController();
    if (_icons.isNotEmpty) {
      startTimer();
    } else {
      enableIconSwitch = false;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: enableIconSwitch
          ? AnimatedSwitcher(
              duration: Duration(milliseconds: 1600),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(child: child, opacity: animation);
              },
              child: UnconstrainedBox(
                  child: SizedBox(
                width: 65.sp,
                height: 65.sp,
                child: SvgPicture.network(
                  _icons[_currentIndex],
                  color: Colors.white,
                  key: ValueKey<int>(_currentIndex),
                  width: 65.sp,
                  height: 65.sp,
                  fit: BoxFit.scaleDown,
                ),
              )).onClick(() => widget.onFabClick(true)),
            )
          : AnimateIcons(
              startIcon: Icons.add,
              endIcon: Icons.close,
              size: 75.sp,
              controller: controller,
              onStartIconPress: () {
                widget.onFabClick(true);
                return true;
              },
              onEndIconPress: () {
                widget.onFabClick(false);
                return true;
              },
              startIconColor: Colors.white,
              endIconColor: Colors.white,
              duration: Duration(milliseconds: 700),
              clockwise: false,
            ),
    );
  }

  void onBottomSheetHide() {
    if (mounted) {
      controller.animateToStart();
      isBottomSheetOpen = false;
    }
  }

  void onBottomSheetShow() {
    if (mounted) {
      controller.animateToEnd();
      isBottomSheetOpen = true;
    }
  }

  void setBottomSheetTrue() {
    if (mounted) {
      isBottomSheetOpen = true;
    }
  }
}

class CustomBottomNavigationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path pathMain = Path();
    pathMain.moveTo(0, size.height);
    pathMain.lineTo(size.width, size.height);
    pathMain.lineTo(size.width, 0);
    pathMain.lineTo(size.width * 0.6408958, 0);
    pathMain.cubicTo(
        size.width * 0.6114236,
        size.height * 0.005617021,
        size.width * 0.5871944,
        size.height * 0.1744681,
        size.width * 0.5816528,
        size.height * 0.3599149);
    pathMain.cubicTo(
        size.width * 0.5779653,
        size.height * 0.4830638,
        size.width * 0.5724931,
        size.height * 0.6152340,
        size.width * 0.5598333,
        size.height * 0.7113191);
    pathMain.cubicTo(
        size.width * 0.5353125,
        size.height * 0.8972340,
        size.width * 0.4537778,
        size.height * 0.8815319,
        size.width * 0.4312847,
        size.height * 0.6508936);
    pathMain.cubicTo(
        size.width * 0.4193542,
        size.height * 0.5285957,
        size.width * 0.4206597,
        size.height * 0.4872766,
        size.width * 0.4172778,
        size.height * 0.3665106);
    pathMain.cubicTo(
        size.width * 0.4139236,
        size.height * 0.2469362,
        size.width * 0.4031806,
        size.height * 0.1321702,
        size.width * 0.3865208,
        size.height * 0.06987234);
    pathMain.cubicTo(
        size.width * 0.3784514,
        size.height * 0.03970213,
        size.width * 0.3693403,
        size.height * 0.01029787,
        size.width * 0.3576597,
        size.height * 0.004127660);
    pathMain.cubicTo(
        size.width * 0.3527569,
        size.height * 0.001659574,
        size.width * 0.3475000,
        size.height * 0.0005106383,
        size.width * 0.3421042,
        size.height * -0.0001276596);
    pathMain.lineTo(0, size.height * -0.0001276596);
    pathMain.lineTo(0, size.height * 0.9998723);
    pathMain.lineTo(0, size.height * 1.000000);
    pathMain.close();

    Path pathBorder = Path();

    pathBorder.moveTo(size.width, 0);
    pathBorder.lineTo(size.width * 0.6408958, 0);

    pathBorder.cubicTo(
        size.width * 0.6114236,
        size.height * 0.005617021,
        size.width * 0.5871944,
        size.height * 0.1744681,
        size.width * 0.5816528,
        size.height * 0.3599149);
    pathBorder.cubicTo(
        size.width * 0.5779653,
        size.height * 0.4830638,
        size.width * 0.5724931,
        size.height * 0.6152340,
        size.width * 0.5598333,
        size.height * 0.7113191);
    pathBorder.cubicTo(
        size.width * 0.5353125,
        size.height * 0.8972340,
        size.width * 0.4537778,
        size.height * 0.8815319,
        size.width * 0.4312847,
        size.height * 0.6508936);
    pathBorder.cubicTo(
        size.width * 0.4193542,
        size.height * 0.5285957,
        size.width * 0.4206597,
        size.height * 0.4872766,
        size.width * 0.4172778,
        size.height * 0.3665106);
    pathBorder.cubicTo(
        size.width * 0.4139236,
        size.height * 0.2469362,
        size.width * 0.4031806,
        size.height * 0.1321702,
        size.width * 0.3865208,
        size.height * 0.06987234);
    pathBorder.cubicTo(
        size.width * 0.3784514,
        size.height * 0.03970213,
        size.width * 0.3693403,
        size.height * 0.01029787,
        size.width * 0.3576597,
        size.height * 0.004127660);
    pathBorder.cubicTo(
        size.width * 0.3527569,
        size.height * 0.001659574,
        size.width * 0.3475000,
        size.height * 0.0005106383,
        size.width * 0.3421042,
        size.height * -0.0001276596);
    pathBorder.lineTo(0, 0);

    Paint paintMain = Paint()..style = PaintingStyle.fill;
    paintMain.color = Colors.white.withOpacity(1.0);

    Paint paintBorder = Paint()..style = PaintingStyle.stroke;
    paintBorder.color = Colors.grey.shade300.withOpacity(1.0);
    paintBorder.strokeWidth = 1.0;

    canvas.drawPath(pathMain, paintMain);
    canvas.drawPath(pathBorder, paintBorder);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
