import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/data/pref_manager.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/translations/app_translation.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SelectLanguageScreen extends GetView<PrefManager> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/new_images/top_curve.svg',
            color: ColorUtils.topCurveColor,
            width: Get.width,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/new_images/language_bg.png',
                width: Get.width,
              ).marginOnly(top: 250.sp),
              CustomText(
                select_language.tr,
                fontweight: Weight.BOLD,
                customTextStyle: CustomTextStyle.BIGTITLE,
              ).marginOnly(top: 90.sp),
              CustomText(
                language_desc.tr,
                fontweight: Weight.LIGHT,
                color: ColorUtils.greylight,
                customTextStyle: CustomTextStyle.NORMAL,
                textAlign: TextAlign.center,
                fontSize: 38.sp,
              ).marginOnly(top: 30.sp, left: 100.sp, right: 100.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(75.sp),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          ColorUtils.orange_gr_light,
                                          ColorUtils.orange_gr_light,
                                          ColorUtils.orange_gr_dark,
                                        ]),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top: 0,
                                          right: 0,
                                          child: SizedBox(
                                              width: Get.width / 2.5,
                                              height: 80.sp,
                                              child: SvgPicture.asset(
                                                'assets/images/new_images/curve_team.svg',
                                                fit: BoxFit.fill,
                                                color: ColorUtils.orange_shadow,
                                              ))),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              CustomText(
                                                'A',
                                                fontSize: 100.sp,
                                                color: ColorUtils.white,
                                              ),
                                              CustomText(
                                                'a',
                                                fontSize: 100.sp,
                                                color: ColorUtils.white,
                                              )
                                            ],
                                          ).alignTo(Alignment.centerLeft),
                                          CustomText(
                                            'Select English as\npreferred language',
                                            fontweight: Weight.LIGHT,
                                            color: ColorUtils.white_bg,
                                            customTextStyle:
                                                CustomTextStyle.NORMAL,
                                            fontSize: 34.sp,
                                          ).alignTo(Alignment.centerLeft),
                                        ],
                                      ).marginOnly(left: 50.sp, right: 30.sp),
                                    ],
                                  ))
                              .marginAll(40.sp)
                              .onClick(() => setLanguage(
                                  locale: AppTranslation.ENGLISH_LOCALE,
                                  label:
                                      AppTranslation.ENGLISH_LOCALE_LABEL)))),
                  Expanded(
                      child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(75.sp),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          ColorUtils.black_gr_light,
                                          ColorUtils.black_gr_light,
                                          ColorUtils.black_gr_dark,
                                        ]),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top: 0,
                                          right: 0,
                                          child: SizedBox(
                                              width: Get.width / 3.5,
                                              height: 80.sp,
                                              child: SvgPicture.asset(
                                                'assets/images/new_images/curve_team.svg',
                                                width: Get.width / 3.5,
                                                fit: BoxFit.fill,
                                                color: ColorUtils.black_shadow,
                                              ))),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              CustomText(
                                                'अ',
                                                fontSize: 100.sp,
                                                color: ColorUtils.white,
                                              ),
                                              Transform.translate(
                                                offset: Offset(-2, 0),
                                                child: CustomText(
                                                  'अ',
                                                  fontSize: 85.sp,
                                                  fontType: FontType.OPEN_SANS,
                                                  color: ColorUtils.white,
                                                ),
                                              ).marginOnly(bottom: 9.sp)
                                            ],
                                          ).alignTo(Alignment.centerLeft),
                                          CustomText(
                                            'अपनी पसंदीदा भाषा हिंदी का चयन करें',
                                            fontweight: Weight.LIGHT,
                                            color: ColorUtils.white_bg,
                                            customTextStyle:
                                                CustomTextStyle.NORMAL,
                                            fontSize: 34.sp,
                                          ).alignTo(Alignment.centerLeft),
                                        ],
                                      ).marginOnly(left: 50.sp, right: 30.sp),
                                    ],
                                  ))
                              .marginAll(40.sp)
                              .onClick(() => setLanguage(
                                  locale: AppTranslation.HINDI_LOCALE,
                                  label: AppTranslation.HINDI_LOCALE_LABEL)))),
                ],
              ).marginOnly(top: 140.sp, left: 30.sp, right: 30.sp),
            ],
          )
        ],
      ),
    ));
  }

  setLanguage({required Locale locale, required String label}) async {
    await controller.setLocale(label);
    Get.updateLocale(locale);
    if (Get.previousRoute != null && Get.previousRoute.isNotEmpty) {
      Get.back();
    } else {
      Get.offAndToNamed(Routes.INTRO);
    }
  }
}
