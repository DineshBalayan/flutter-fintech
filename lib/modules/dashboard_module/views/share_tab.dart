import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/share_tab_controller.dart';
import 'package:bank_sathi/modules/share_module/views/social_cards.dart';
import 'package:bank_sathi/modules/share_module/views/visiting_cards.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ShareTab extends GetView<ShareTabController> {
  late List<Tab> myTabs;

  List<String> tabNames = [
    social_card.tr,
    visiting_card.tr.replaceFirst("\n", " ")
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorUtils.window_bg,
        alignment: Alignment.topRight,
        child: SafeArea(
            child: SvgPicture.asset(
          'assets/images/new_images/top_curve.svg',
          color: ColorUtils.topCurveColor,
          width: Get.width * .8,
        )),
      ),
      DefaultTabController(
          length: 2,
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  flexibleSpace: Stack(children: [
                    Positioned.fill(
                        child: Align(
                      child: Divider(
                        height: 2,
                        thickness: 1,
                        color: Colors.grey.shade300,
                      ),
                      alignment: Alignment.bottomRight,
                    )),
                    TabBar(
                        controller: controller.pageController,
                        labelColor: ColorUtils.orange,
                        unselectedLabelColor: Colors.black,
                        indicatorColor: Colors.black,
                        tabs: tabNames.map((e) => Tab(text: e)).toList()),
                  ]).marginSymmetric(horizontal: 40.sp)),
              body: TabBarView(
                controller: controller.pageController,
                children: [SocialCards(), VisitingCards()],
              )))
    ]));
  }
}
