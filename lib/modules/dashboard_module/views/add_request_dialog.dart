import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'customer_query_screen.dart';

class AddRequestDialog extends StatelessWidget {
  final CustomerQueryController controller;

  AddRequestDialog({Key? key, required this.controller}) : super(key: key);
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: SizedBox(
        width: Get.width * .93,
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.sp)),
            child: Form(key:controller.formKey,child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  "Add A Query",
                  fontSize: 50.sp,
                ),
                Container(
                  width: 180.sp,
                  height: 2,
                  color: ColorUtils.orange,
                ).marginSymmetric(vertical: 30.sp),
                CustomTextField(
                  controller: controller.queryTitleController,
                  textField: "Query Title",
                ),
                CustomTextField(
                  controller: controller.queryDetailController,
                  textField: "Query in Detail",
                  minLines: 5,
                  textInputAction: TextInputAction.done,
                ),
                WidgetUtil.getStateButton(
                  controller: controller,
                  color: ColorUtils.orange,
                  onPressed: () {
                    controller.submitRequest();
                  },
                  textStyle: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.white,
                      weight: FontWeight.w400,
                      fontSize: 42.sp),
                  width: 700.sp,
                  label: 'Submit Query Now',
                ).marginOnly(top: 60.sp)
              ],
            ).marginAll(70.sp))),
      ),
    ).adjustForTablet();
  }
}
