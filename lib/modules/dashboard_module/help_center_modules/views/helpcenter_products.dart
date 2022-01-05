import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/controllers/help_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/views/dashboard.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HelpCenterProducts extends GetView<HelpController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorUtils.topCurveColor,
        appBar: new AppBar(
          backgroundColor: ColorUtils.orange_shadow,
          elevation: 0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: ColorUtils.white),
            onPressed: () {
              controller.pageState = PageStates.PAGE_IDLE;
              Get.back();
            },
          ),
          // title: new Text('${controller.faq[controller.faqIndex].title}',
          title: CustomText(
            'FAQ',
            fontweight: Weight.NORMAL,
            fontSize: 50.sp,
            color: ColorUtils.white,
          ),
        ),
        body: BasePageView(
          controller: controller,
          idleWidget: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: productsListView(),
          ),
        ),
      ),
    );
  }

  Widget productsListView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(45.sp),
          child: Obx(
            () => ListView.separated(
              itemCount: controller.faqProducts.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return
                  (controller.faqProducts[index].queAns.length == 0 && controller.faqProducts[index].subcatt.length == 0)
                      ? controller.faqProducts[index].title == 'Sell & Earn'
                      ? listView(context, controller, index)
                      : Container()
                      : listView(context, controller, index);

              },
              separatorBuilder: (BuildContext context, int index) {
                return  (controller.faqProducts[index].queAns.length == 0 &&
                    controller.faqProducts[index].subcatt.length == 0)
                    ? controller.faqProducts[index].title == 'Sell & Earn'
                    ? Divider(height: 30.sp, color: ColorUtils.newLightDivider)
                    : Container()
                    : Divider(height: 30.sp, color: ColorUtils.newLightDivider);

              },
            ),
          ),
        ),
      ],
    );
  }
}

Widget listView(BuildContext context, HelpController controller, int index){
  return Theme(
    data: Theme.of(context)
        .copyWith(dividerColor: Colors.transparent),
    child: ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      tileColor: Colors.white,
      contentPadding: EdgeInsets.only(top:20.sp,bottom: 20.sp,right: 20.sp),
      trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          controller.faqArrayUpdate(
              controller.faqProducts[index].queAns,
              controller.faqProducts[index].subcatt,
              index,
              controller.faqProducts);

          Get.toNamed(Routes.DASHBOARD + Routes.HELP_FAQ_CAT)!.then(
                  (value) =>
                  bottomNavigationKey.currentState!.reAnimate());
        },
      title: Padding(
        padding: EdgeInsets.fromLTRB(75.sp, 20.sp, 75.sp, 40.sp),
        child: Container(
          transform: Matrix4.translationValues(0.0, 3.0, 0.0),
          child: CustomText(
            '${(controller.faqProducts[index].title).toUpperCase()}',
            fontweight: Weight.NORMAL,
            style: TextStyle(
              color: ColorUtils.blackLight,
              wordSpacing: 0.001,
              letterSpacing: 0.01,
            ),
            fontSize: 40.sp,
          ),
        ),
      ),
    ),
  );
}

