import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/request/add_customer_request.dart';
import 'package:bank_sathi/Model/response/CustomerQuery.dart';
import 'package:bank_sathi/Model/response/SupportQueryListResponse.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/widgets/custom_scaffold.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'add_request_dialog.dart';

class CustomerQueryScreen extends GetView<CustomerQueryController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: "Support Query",
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: BasePageView(
              controller: controller,
              idleWidget: Obx(() => ListView.builder(
                    itemBuilder: (_, position) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.sp)),
                          boxShadow: [
                            BoxShadow(
                              color: ColorUtils.greyshade.withOpacity(0.08),
                              spreadRadius: 30.sp,
                              blurRadius: 70.sp,
                              offset:
                                  Offset(0, 3), // changes position of shadowF
                            ),
                          ],
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                controller.queryList[position].title,
                                fontweight: Weight.BOLD,
                                fontSize: 50.sp,
                              ),
                              CustomText(
                                controller.queryList[position].description,
                                fontSize: 36.sp,
                                color: Colors.grey.shade500,
                              ).marginSymmetric(vertical: 20.sp),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/new_images/profile_image/calendar.svg',
                                    color: Colors.grey.shade500,
                                    height: 36.sp,
                                  ),
                                  CustomText(
                                    controller.queryList[position].updated_at
                                                .formatDateTimeFromUtc() ==
                                            null
                                        ? ""
                                        : controller
                                            .queryList[position].updated_at
                                            .formatDateTimeFromUtc()
                                            .toUiDateTime(),
                                    color: ColorUtils.textColor,
                                    fontSize: 36.sp,
                                  ).marginOnly(left: 30.sp),
                                  Container(
                                    width: 50.sp,
                                  ),
                                  CustomText(
                                    'Status - ',
                                    color: Colors.grey.shade500,
                                    fontSize: 36.sp,
                                  ).marginOnly(left: 30.sp),
                                  CustomText(
                                    controller.queryList[position].status == "0"
                                        ? "Open"
                                        : "Close",
                                    color: ColorUtils.textColor,
                                    fontSize: 36.sp,
                                  ).marginOnly(left: 30.sp)
                                ],
                              )
                            ]).marginSymmetric(
                            horizontal: 45.sp, vertical: 45.sp),
                      ).onClick(() {
                        Get.toNamed(Routes.DASHBOARD +
                            Routes.CUSTOMER_QUERY_DETAIL +
                            "?support_id=${controller.queryList[position].id}");
                      }).marginOnly(
                          top: 40.sp, bottom: 20.sp, left: 50.sp, right: 50.sp);
                    },
                    shrinkWrap: true,
                    itemCount: controller.queryList.length,
                  )),
            )),
            Center(
              child: WidgetUtil.getSecondaryButton(() {
                Get.dialog(AddRequestDialog(
                  controller: controller,
                ));
              },
                      color: false,
                      width: 600.sp,
                      height: 150.sp,
                      label: 'Add New Query')
                  .marginAll(40.sp),
            )
          ],
        ));
  }
}

class CustomerQueryController extends BaseController {
  final _queryList = <CustomerQuery>[].obs;
  GlobalKey<FormState> formKey = GlobalKey();
  List<CustomerQuery> get queryList => _queryList.value;

  set queryList(val) => _queryList.value = val;

  TextEditingController queryTitleController = TextEditingController();
  TextEditingController queryDetailController = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    getAllQueries();
  }

  submitRequest() {
    if (queryTitleController.text.trim().isNotEmpty &&
        queryTitleController.text.trim().isNotEmpty) {
      pageState = PageStates.PAGE_BUTTON_LOADING;
      AddCustomerRequest request = AddCustomerRequest(
          user_id: getUserId(),
          title: queryTitleController.text,
          description: queryDetailController.text);
      restClient.addSupportRequest(request).then((response) {
        hideDialog();
        pageState = PageStates.PAGE_IDLE;
        if (response.success) {
          queryTitleController.text = "";
          queryDetailController.text = "";
          getAllQueries();
        } else {
          handleError(msg: response.message);
        }
      }).catchError((onError) {
        pageState = PageStates.PAGE_IDLE;
        print(onError);
      });
    } else
      Get.snackbar(app_alert.tr, 'Please fill all blank field.',
          snackPosition: SnackPosition.BOTTOM, duration: 3.seconds);
  }

  getAllQueries() async {
    pageState = PageStates.PAGE_LOADING;
    SupportQueryListResponse response =
        await restClient.getSupportList(getUserId());
    if (response.success) {
      if (response.data == null || response.data.isEmpty) {
        pageState = PageStates.PAGE_EMPTY_DATA;
      } else {
        pageState = PageStates.PAGE_IDLE;
        queryList = response.data;
      }
    }
  }
}
