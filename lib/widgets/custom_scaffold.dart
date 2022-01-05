import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomScaffold extends StatefulWidget {
  final Widget body;
  final Widget? bottombar;
  var title;
  var actions;
  final bool showAppIcon, showBackButton;
  final floatingActionButton;
  final showEleavation;
  final appBarColor;
  final titleIconColor;
  final onBackClick;
  final showNotification;
  final logoutButton;
  final showCustomerSupport;

  CustomScaffold(
      {required this.body,
      this.bottombar,
      this.actions,
      this.title = '',
      this.showAppIcon = false,
      this.floatingActionButton,
      this.showEleavation = true,
      this.appBarColor,
      this.titleIconColor = ColorUtils.textColor,
      this.showBackButton = true,
      this.onBackClick,
      this.showNotification = true,
      this.logoutButton = false,
      this.showCustomerSupport = true});

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: LayoutBuilder(builder: (_, constraintSuper) {
      return Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: ColorUtils.window_bg,
          alignment: Alignment.topRight,
          child: SafeArea(
              child: SvgPicture.asset(
            'assets/images/new_images/top_curve.svg',
            color: ColorUtils.topCurveColor,
            width: Get.width - (Get.width * .2),
          )),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: widget.showBackButton,
              actions: widget.actions ??
                  [
                    WidgetUtil.getNotificationIcon()
                        .visibility(widget.showNotification),
                    //WhatsApp Icon
                    /*
                    WidgetUtil.getSupportIcon()
                        .visibility(widget.showCustomerSupport),
                  */
                    SvgPicture.asset(
                      'assets/images/new_images/profile_image/logout.svg',
                      fit: BoxFit.scaleDown,
                      color: ColorUtils.black,
                      height: 64.sp,
                    )
                        .marginOnly(left: 15)
                        .onClick(() => Get.find<DashboardController>().Logout())
                        .visibility(widget.logoutButton),
                    Container(
                      width: 15,
                    ),
                  ],
              backgroundColor: Colors.transparent,
              leading: widget.showBackButton
                  ? SvgPicture.asset(
                      'assets/images/ic_back_arrow.svg',
                      width: 75.sp,
                      fit: BoxFit.scaleDown,
                    ).onClick(() {
                      Get.back();
                    })
                  : Container(),
              title: Transform.translate(
                offset: Offset(widget.showBackButton ? 0 : -135.sp, 0),
                child: (widget.title is Widget)
                    ? widget.title
                    : CustomText(
                        widget.title,
                        style: GoogleFonts.mulish(
                            color: ColorUtils.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 48.sp),
                        textAlign: TextAlign.center,
                      ),
              ),
              elevation: 0,
            ),
            body: GestureDetector(
              onTap: () => context.hideKeyboard(),
              child: this.widget.body.adjustForTablet(),
            ),
            bottomNavigationBar: this.widget.bottombar,
            floatingActionButton: widget.floatingActionButton)
      ]);
    }));
  }
}
