import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/ProductDetailController.dart';
import 'package:bank_sathi/widgets/custom_scaffold.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'AccountProductDetailScreen.dart';

class ProductDetailScreen extends GetView<ProductDetailController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: Obx(() => CustomText(controller.productDetailItem == null
            ? ""
            : controller.productDetailItem!.title)),
        showNotification: false,
        body: BasePageView(
            controller: controller,
            idleWidget: Obx(() => controller.productDetailItem == null
                ? Container()
                : AccountProductDetailScreen(
                    productDetail: controller.productDetailItem!,
                    prductUrl: controller.productURL!))));
  }
}
