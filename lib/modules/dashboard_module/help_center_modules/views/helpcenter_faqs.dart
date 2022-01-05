import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/controllers/help_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/views/dashboard.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HelpTopFaq extends GetView<HelpController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorUtils.topCurveColor,
        body: BasePageView(
          controller: controller,
          idleWidget: faqListView(),
        ),
      ),
    );
  }

  Widget faqListView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(60.sp, 10.0, 60.sp, 15.sp),
          color: ColorUtils.white,
          child: Align(
            alignment: Alignment.topLeft,
            child: CustomText(
              'NEED A SUPPORT?',
              fontweight: Weight.BOLD,
              fontSize: 50.sp,
              color: ColorUtils.blackDark,
            ),
          ),
        ),
        Stack(
          children: [
            Container(
              color: ColorUtils.white,
              height: 4.sp,
              width: double.maxFinite,
            ),
            Container(
                margin: EdgeInsets.only(left: 60.sp),
                height: 4.sp,
                width: 200.sp,
                color: ColorUtils.orange_shadow),
          ],
        ),
        Container(
          padding: EdgeInsets.fromLTRB(60.sp, 30.sp, 100.sp, 90.sp),
          color: ColorUtils.white,
          child: Align(
            alignment: Alignment.topLeft,
            child: CustomText(
              'Get query answered quickly with our support',
              fontweight: Weight.NORMAL,
              fontSize: 40.sp,
              style: TextStyle(height: 1.7),
              color: ColorUtils.blackLight,
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(45.sp),
            child: Obx(
              () => ListView.separated(
                itemCount: controller.faq.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  // if section is other than "Sell & Earn" and don't have data(i.e Question & Answers and SubCategory )
                  // then don't show it
                  return (controller.faq[index].queAns.length == 0 &&
                          controller.faq[index].subcatt.length == 0)
                      ? controller.faq[index].title == 'Sell & Earn'
                          ? listView(context, controller, index)
                          : Container()
                      : listView(context, controller, index);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return (controller.faq[index].queAns.length == 0 &&
                          controller.faq[index].subcatt.length == 0)
                      ? controller.faq[index].title == 'Sell & Earn'
                          ? Divider(color: ColorUtils.newLightDivider)
                          : Container()
                      : Divider(color: ColorUtils.newLightDivider);
                  Divider(color: ColorUtils.newLightDivider);
                },
              ),
            ),
          ).paddingOnly(bottom: 200.sp),
        ),
      ],
    );
  }
}

Widget listView(BuildContext context, HelpController controller, int index) {
  return Theme(
    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
    child: ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      tileColor: Colors.white,
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        if (controller.faq[index].title == 'Sell & Earn') {
          Get.toNamed(Routes.DASHBOARD + Routes.HELP_FAQ_PRODUCTS)!
              .then((value) => bottomNavigationKey.currentState!.reAnimate());
        } else {
          controller.faqArrayUpdate(controller.faq[index].queAns,
              controller.faq[index].subcatt, index, controller.faq);
          Get.toNamed(Routes.DASHBOARD + Routes.HELP_FAQ_CAT)!
              .then((value) => bottomNavigationKey.currentState!.reAnimate());
        }
      },
      title: Padding(
        padding: EdgeInsets.fromLTRB(75.sp, 30.sp, 75.sp, 30.sp),
        child: Container(
          transform: Matrix4.translationValues(0.0, 3.0, 0.0),
          child: CustomText(
            '${(controller.faq[index].title).toUpperCase()}',
            fontweight: Weight.NORMAL,
            fontSize: 45.sp,
            color: ColorUtils.blackLight,
          ),
        ),
      ),
    ),
  );
}
