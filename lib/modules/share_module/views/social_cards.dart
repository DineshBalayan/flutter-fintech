import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Model/response/SocialCardsListResponse.dart'
    hide Card;
import 'package:bank_sathi/modules/dashboard_module/controllers/share_tab_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/views/card_preview.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SocialCards extends GetView<ShareTabController> {
  final pageController = PageController(viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.topCurveColor,
      body: Obx(
        () => controller.social_cards == null || controller.social_cards.isEmpty
            ? Container()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.social_cards.length,
                      itemBuilder: (BuildContext context, int index) {
                        Cardscatlist cardCat = controller.social_cards[index];
                        return cardCat.card_arr == null ||
                                cardCat.card_arr.length == 0
                            ? Container()
                            : Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        CustomText(
                                          cardCat.cat_name,
                                          color: ColorUtils.blackDark,
                                          fontweight: Weight.NORMAL,
                                          fontSize: 45.sp,
                                        ).marginOnly(left: 40.sp),
                                        Obx(() => CustomText(
                                                  cardCat.isExpanded
                                                      ? view_less.tr
                                                      : view_all.tr,
                                                  fontSize: 35.sp,
                                                  color: ColorUtils.grey,
                                                ).marginOnly(right: 40.sp))
                                            .visibility(
                                                cardCat.card_arr.length > 2),
                                      ],
                                    ).onClick(() {
                                      cardCat.isExpanded = !cardCat.isExpanded;
                                    }).marginOnly(top: 40.sp),
                                    Obx(() => GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 1,
                                                  crossAxisSpacing: 8.sp,
                                                  mainAxisSpacing: 20.sp),
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: cardCat.isExpanded ||
                                                  cardCat.card_arr.length <= 2
                                              ? cardCat.card_arr.length
                                              : 2,
                                          itemBuilder: (context, position) {
                                            return getSocialCardWidget(
                                                    cardCat, position)
                                                .onClick(() => showPreview(
                                                    cardCat.card_arr[position]
                                                        .image));
                                          },
                                        ).marginOnly(
                                            top: 10.sp,
                                            left: 15.sp,
                                            right: 15.sp)),
                                  ],
                                ).marginOnly(bottom: 20.sp),
                              ).marginOnly(bottom: 10);
                      },
                    ),
                    Container(
                      height: 200.sp,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
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

  Widget getSocialCardWidget(Cardscatlist cardCatList, int position) {
    return Card(
        color: ColorUtils.white,
        elevation: 1,
        margin: EdgeInsets.only(left: 15.sp,right: 15.sp,top: 15.sp,bottom: 35.sp),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: ColorUtils.white_bg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.sp),
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1.3,
                child: CustomImage.network(
                  cardCatList.card_arr[position].image,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                  child: Center(
                child: CustomText(
                  cardCatList.card_arr[position].title.toUpperCase(),
                  fontSize: 42.sp,
                  textAlign: TextAlign.center,
                  fontweight: FontWeight.w400,
                  color: ColorUtils.textColorLight,
                  maxLines: 1,
                ).marginSymmetric(horizontal: 20.sp),
              )),
            ],
          ),
        ));
  }
}
