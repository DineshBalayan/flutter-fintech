import 'package:bank_sathi/modules/splash/unlock_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Helpers/color_utils.dart';
import '../../Helpers/extensions.dart';
import '../../widgets/custom_text.dart';

class UnlockScreen extends GetView<UnlockController> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(1080, 2280));
    return SafeArea(child: LayoutBuilder(builder: (_, constraintSuper) {
      return Scaffold(
        body: Stack(overflow: Overflow.visible, children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            alignment: Alignment.topRight,
          ),
          Positioned(
            child: SvgPicture.asset(
              'assets/images/new_images/top_curve.svg',
              color: ColorUtils.topCurveColor,
              width: Get.width - (Get.width * .2),
            ),
            top: 0,
            right: 0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                'assets/images/new_images/intro/unlock.png',
                height: 600.sp,
              ).marginOnly(top: 240.sp),
              CustomText(
                unlock_banksathi.tr,
                fontSize: 56.sp,
                fontweight: Weight.BOLD,
              ).marginOnly(top: 40.sp),
              CustomText(
                lock_msg.tr,
                color: ColorUtils.greylight,
                textAlign: TextAlign.center,
                fontSize: 36.sp,
              ).alignTo(Alignment.center).marginOnly(top: 40.sp),
              Container(
                width: 500.sp,
                height: 140.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90.sp),
                  color: ColorUtils.orange_gr_light,
                ),
                child: CustomText(
                  back_unlock.tr,
                  color: ColorUtils.white,
                  textAlign: TextAlign.center,
                  fontSize: 40.sp,
                ).alignTo(Alignment.center).marginAll(15.sp),
              ).marginOnly(top: 130.sp).onClick(() => controller.unlockApp()),
              Container(
                width: 500.sp,
                height: 140.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    90.sp,
                  ),
                  color: ColorUtils.white,
                  border:
                      Border.all(width: 2.sp, color: ColorUtils.textColorLight),
                ),
                child: CustomText(
                  'Exit App Now',
                  color: ColorUtils.textColorLight,
                  textAlign: TextAlign.center,
                  fontSize: 40.sp,
                ).alignTo(Alignment.center).marginAll(15.sp),
              )
                  .marginOnly(top: 40.sp)
                  .onClick(() => SystemNavigator.pop(animated: true)),

              /* Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SlideAction(
                innerColor: ColorUtils.blue,
                textStyle: StyleUtils.textStyleNormalPoppins(
                    fontSize: 40.sp, weight: FontWeight.w400),
                text: slide_exit.tr,
                onSubmit: () {
                  SystemNavigator.pop(animated: true);
                },
              ),
            )*/
            ],
          ).marginAll(60.sp)
        ]),
      );
    }));
  }
}
