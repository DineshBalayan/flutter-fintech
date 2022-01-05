import 'dart:ui';

import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Model/response/parent_product_detail_response.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/product_list_controller.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_scaffold.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductListScreen extends GetView<ProductListController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: Obx(() => CustomText(
              controller.title,
              style: GoogleFonts.mulish(
                  color: ColorUtils.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 48.sp),
              textAlign: TextAlign.center,
            )),
        body: BasePageView(
          controller: controller,
          idleWidget: Obx(
            () => ListView.builder(
              itemCount: controller.productList.length,
              itemBuilder: (BuildContext context, int index) {
                ChildProduct product = controller.productList[index];
                return Container(
                        margin: EdgeInsets.all(15.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.sp),
                          boxShadow: [
                            BoxShadow(
                              color: "#F7F7F7".hexToColor(),
                              spreadRadius: 30.sp,
                              blurRadius: 30.sp,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                                height: 200.sp,
                                child: AspectRatio(
                                    aspectRatio: 1.16,
                                    child: CustomImage.network(
                                      product.product_logo,
                                    ))),
                            Expanded(
                              child: SizedBox(
                                height: 250.sp,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      product.product_title,
                                      textAlign: TextAlign.start,
                                      fontweight: FontWeight.w600,
                                      fontSize: 42.sp,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomText(
                                            product.product_sub_title,
                                            fontweight: FontWeight.w400,
                                            fontSize: 35.sp,
                                            textAlign: TextAlign.start,
                                            color: ColorUtils.grey,
                                          )
                                              .visibility(
                                                  product.product_sub_title !=
                                                          null &&
                                                      product.product_sub_title
                                                          .isNotEmpty)
                                              .marginOnly(bottom: 20.sp),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100.sp),
                                          border: Border.all(
                                              color: ColorUtils.orange,
                                              width: 1)),
                                      child: CustomText(
                                        product.message.trim(),
                                        color: ColorUtils.orange,
                                        fontSize: 34.sp,
                                      ).paddingSymmetric(
                                          horizontal: 20.sp, vertical: 5.sp),
                                    )
                                  ],
                                ),
                              ).marginOnly(left: 30.sp),
                            )
                          ],
                        ).marginSymmetric(horizontal: 30.sp, vertical: 10.sp))
                    .onClick(() {
                  Get.toNamed(Routes.DASHBOARD +
                      Routes.PRODUCT_DETAILS +
                      "?product_id=${product.id}");
                });
              },
            ).marginOnly(left: 30.sp, right: 30.sp),
          ),
        ));
  }
}
