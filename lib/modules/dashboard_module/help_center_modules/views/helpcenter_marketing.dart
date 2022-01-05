import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/share_tab_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/controllers/help_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/views/card_preview.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HelpMarketing extends GetView<ShareTabController> {
  final pageController = PageController(viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () => controller.social_cards.isEmpty
                  ? Container()
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8.sp,
                          mainAxisSpacing: 20.sp),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.social_cards.length > 4 ? 4 : controller.social_cards.length,
                      itemBuilder: (context, position) {
                        return getSocialCardWidget(position).onClick(() =>
                            showPreview(controller.social_cards
                                .firstWhere((element) =>
                                    element.cat_name == controller.selectedCat)
                                .card_arr[position]
                                .image));
                      },
                    ).marginOnly(top: 10.sp, left: 15.sp, right: 15.sp),
            ),
          ),
          SizedBox(
            height: 220.sp,
          )
        ],
      ),
    );
  }

  showPreview(String image) {
    Get.bottomSheet(
        Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: ColorUtils.white,
            ),
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        ScreenUtil().screenHeight / ScreenUtil().screenWidth <
                                1.30
                            ? ScreenUtil().screenWidth / 10
                            : 0),
                child: CardPreview(
                  imagePath: image,
                ))),
        isScrollControlled: true);
  }

  Widget getSocialCardWidget(int position) {
    return Card(
        color: ColorUtils.white,
        elevation: 1,
        margin: EdgeInsets.only(left: 15.sp,right: 15.sp,top: 15.sp,bottom: 25.sp),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: ColorUtils.white_bg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.sp),
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1.3,
                child: CustomImage.network(
                  controller.social_cards
                      .firstWhere((element) =>
                          element.cat_name == controller.selectedCat)
                      .card_arr[position]
                      .image,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                  child: Center(
                child: CustomText(
                  controller.social_cards
                      .firstWhere((element) =>
                          element.cat_name == controller.selectedCat)
                      .card_arr[position]
                      .title
                      .toUpperCase(),
                  fontSize: 42.sp,
                  textAlign: TextAlign.center,
                  fontweight: FontWeight.w400,
                  color: ColorUtils.textColorLight,
                  maxLines: 1,
                ).marginSymmetric(horizontal: 20.sp),
              )),
            ],
          ),
        ),);
  }
}
