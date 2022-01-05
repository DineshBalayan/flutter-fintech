import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DownTimeScreen extends GetView<DownTimeController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: LayoutBuilder(builder: (_, constraintSuper) {
      return Material(
        child: Stack(children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            alignment: Alignment.topRight,
            child: SafeArea(
                child: SvgPicture.asset(
              'assets/images/new_images/top_curve.svg',
              color: ColorUtils.topCurveColor,
              width: Get.width - (Get.width * .2),
            )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/new_images/downtime.png',
                width: Get.width * .7,
              ).marginOnly(top: 150.sp),
              CustomText(
                'A better experience is in process'.capitalize,
                fontweight: FontWeight.w500,
                fontSize: 48.sp,
              ).marginOnly(top: 100.sp),
              Obx(() => CustomText(
                    controller.messages == null || controller.messages.isEmpty
                        ? ""
                        : controller.messages[0],
                    color: ColorUtils.grey,
                    fontweight: FontWeight.w300,
                    textAlign: TextAlign.center,
                  )).marginSymmetric(horizontal: 100.sp, vertical: 20.sp),
              Obx(() => CustomText(
                    controller.messages == null || controller.messages.isEmpty
                        ? ""
                        : controller.messages[1],
                    color: ColorUtils.orange,
                    textAlign: TextAlign.center,
                    fontweight: FontWeight.w500,
                  )).marginOnly(top: 70.sp),
              SizedBox(
                width: 600.sp,
                child: WidgetUtil.getOrangeButton(() {
                  SystemNavigator.pop(animated: true);
                }, label: 'Okay, Great', fontSize: 46.sp),
              ).marginOnly(top: 60.sp)
            ],
          ).marginSymmetric(horizontal: 40.sp, vertical: 100.sp)
        ]),
      );
    }));
  }
}

class DownTimeController extends BaseController {
  final _messages = <String>[].obs;

  List<String> get messages => _messages.value;

  set messages(val) => _messages.value = val;

  @override
  void onInit() {
    super.onInit();
    messages = Get.arguments;
  }

  @override
  void onReady() async {
    super.onReady();
  }
}
