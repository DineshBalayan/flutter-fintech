import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/response/get_faqs_response.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/customer_support_controller.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_scaffold.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerSupport extends GetView<CustomerSupportController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showAppIcon: true,
      title: customer_support.tr,
      showEleavation: false,
      appBarColor: ColorUtils.blue,
      showCustomerSupport: false,
      titleIconColor: ColorUtils.white,
      body: BasePageView(
          controller: controller,
          idleWidget: Obx(() => DefaultTabController(
              length: controller.faqsList.length,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    leading: Container(),
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
                          labelColor: ColorUtils.orange,
                          unselectedLabelColor: Colors.black,
                          isScrollable: true,
                          indicatorColor: Colors.black,
                          tabs: controller.faqsList
                              .map((e) => Tab(
                                    text: e.category,
                                  ))
                              .toList()),
                    ]).marginOnly(left: 60.sp)),
                body: Column(
                  children: <Widget>[
                    Expanded(
                        child: Obx(() => TabBarView(
                              children: controller.faqsList
                                  .map((e) => getFaqPage(e.faq))
                                  .toList(),
                            ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 400.sp,
                          height: 1,
                          color: Colors.grey.shade400,
                        ),
                        CustomText(
                          'OR',
                          color: Colors.grey.shade400,
                        ).marginSymmetric(horizontal: 30.sp),
                        Container(
                          width: 400.sp,
                          height: 1,
                          color: Colors.grey.shade400,
                        )
                      ],
                    ).marginSymmetric(vertical: 60.sp),
                    WidgetUtil.getSecondaryButton(() {
                      Get.toNamed(
                          Routes.DASHBOARD + Routes.CUSTOMER_QUERY_SCREEN);
                    },
                            color: false,
                            width: 600.sp,
                            height: 150.sp,
                            label: 'Add or View Query')
                        .marginAll(20.sp),
                    CustomText(
                      'Add a query, We will revert you back shortly',
                      textAlign: TextAlign.center,
                      fontSize: 36.sp,
                      color: Colors.grey.shade400,
                    ).marginSymmetric(horizontal: 30.sp, vertical: 60.sp),
                  ],
                ),
              )))),
    );
  }

  Widget getFaqPage(List<Faq> faqList) {
    return ListView.builder(
      itemBuilder: (_, position) {
        return Obx(() => ExpansionTile(
              childrenPadding: EdgeInsets.only(left: 0),
              tilePadding: EdgeInsets.zero,
              trailing: faqList[position].isExpanded.value
                  ? Icon(
                      Icons.remove,
                      size: 48.sp,
                      color: ColorUtils.textColor,
                    )
                  : Icon(
                      Icons.add,
                      size: 48.sp,
                      color: ColorUtils.textColor,
                    ),
              title: CustomText(faqList[position].question),
              maintainState: true,
              onExpansionChanged: (isExpanded) {
                faqList[position].isExpanded.value = isExpanded;
              },
              children: [
                Html(
                  data: faqList[position].answer,
                  style: {
                    "body": Style(
                      fontSize: FontSize(42.sp),
                      color: ColorUtils.textColor,
                    )
                  },
                ).marginOnly(bottom: 35.sp)
              ],
            ));
      },
      shrinkWrap: true,
      itemCount: faqList.length,
    ).marginSymmetric(horizontal: 60.sp);
  }
}
