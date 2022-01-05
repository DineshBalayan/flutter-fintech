import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/controllers/help_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/views/helpcenter_faqs.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/views/helpcenter_training.dart';
import 'package:bank_sathi/modules/share_module/views/social_cards.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HelpCenter extends GetView<HelpController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: ColorUtils.white,
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                'assets/images/new_images/top_curve.svg',
                color: ColorUtils.topCurveColor,
                width: Get.width * .8,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 40.sp,
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      upperTabs(0),
                      upperTabs(1),
                      upperTabs(2),
                    ],
                  ),
                ),
              ],
            ),
        Container(
          padding: EdgeInsets.only(top: 200.sp),
          child:   PageView(
              controller: controller.pageController,
              children: [
                HelpTopFaq(),
                HelpTraining(),
                SocialCards(),
              ],
            onPageChanged: (val){
              controller.updateSelectedValue(val);
            },
            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget upperTabs(int index) {
    return ActionChip(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: controller.selectedTab == index
                    ? ColorUtils.orange
                    : ColorUtils.black,
                width: 1),
            borderRadius: BorderRadius.circular(100.sp)),
        label: CustomText(
          controller.tabItems[index].toString(),
          fontweight: Weight.NORMAL,
          fontSize: 40.sp,
          color: controller.selectedTab != index
              ? ColorUtils.textColor
              : ColorUtils.white,
        ),
          pressElevation: 0,
        labelPadding: EdgeInsets.symmetric(horizontal: 30.sp),
        backgroundColor: controller.selectedTab == index
            ? ColorUtils.orange
            : ColorUtils.white,
        onPressed: () {
          controller.updateSelectedValue(index);
        }).marginSymmetric(horizontal: 8.sp);
  }
}
