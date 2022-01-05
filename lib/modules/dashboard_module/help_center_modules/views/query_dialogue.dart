import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/controllers/help_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class QueryDialogue extends GetView<HelpController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
        backgroundColor: ColorUtils.topCurveColor,
        appBar: new AppBar(
          backgroundColor: ColorUtils.orange_shadow,
          elevation: 0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: ColorUtils.white),
            onPressed: () {
              Get.back();
            },
          ),
           title: CustomText(
            'Submit Query',
            fontweight: Weight.NORMAL,
            fontSize: 48.sp,
            color: ColorUtils.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Wrap(
           children: [
             Center(
               child: Lottie.asset('assets/animation/thinking_man.json',
                   width: 500.sp,
                   fit: BoxFit.fitWidth),
             ),
             Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.sp)),
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     CustomText(
                      'What\'s Your Query?',
                      fontSize: 48.sp,
                    ),
                    Container(
                      width: 250.sp,
                      height: 2,
                      color: ColorUtils.orange,
                    ).marginSymmetric(vertical: 30.sp),
                    CustomTextField(
                      controller: controller.emailTitleController,
                      textField: 'Title',
                      textInputAction: TextInputAction.next,
                       keyboardType: TextInputType.text,
                      isRequired: true,
                      onChanged: (text) {
                        text = controller.title;
                      },
                    ),
                    CustomTextField(
                      minLines: 5,
                      controller: controller.emailBodyController,
                      textField: 'Query',
                       keyboardType: TextInputType.text,
                      isRequired: true,
                      onChanged: (text) {
                        text = controller.emailBody;
                      },
                      onFocusChange: () => FocusScope.of(context).nextFocus(),
                      textInputAction: TextInputAction.done,
                    ),
                    controller.isValid != ''
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                              '${controller.isValid}',
                              fontSize: 30.sp,
                              color: Colors.red,
                            ),
                          )
                        : Container(),

                   WidgetUtil.getSecondaryButton(() => controller.verifyForm(),
                            color: true,
                            width: 200,height: 50,
                            label: submit.tr)
                        .marginOnly(top: 20)
                  ],
                ).paddingAll(50.sp),
              ),
            ).marginAll(50.sp),]
          ),
        ),
      ),
    );
  }
}
