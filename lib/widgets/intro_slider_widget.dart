import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Model/slider_model.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class IntroSliderWidget extends StatefulWidget {
  final List<SliderModel> cardsList;
  late List<Widget> imageSliders;

  IntroSliderWidget(this.cardsList) {
    if (cardsList.length > 0) {
      imageSliders = cardsList
          .map((item) => LayoutBuilder(
                builder: (_, constraint) => Card(
                    margin: EdgeInsets.all(1),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 1,
                    color: ColorUtils.white.withAlpha(250),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.sp),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /*AspectRatio(aspectRatio: 218/271,child: */ Image
                                .asset(
                              item.picAsset,
                              width: 450.sp,
                              height: 450.sp,
                              fit: BoxFit.fill,
                            ) /*)*/ .marginAll(80.sp),
                            CustomText(item.title,
                                    fontSize: 50.sp,
                                    fontweight: Weight.BOLD,
                                    textAlign: TextAlign.center)
                                .marginOnly(left: 20.sp, right: 20.sp),
                            CustomText(item.desc,
                                    fontweight: Weight.LIGHT,
                                    fontSize: 38.sp,
                                    color: ColorUtils.grey,
                                    textAlign: TextAlign.center)
                                .marginAll(20.sp),
                          ],
                        ),
                        Positioned(
                            left: -15,
                            top: 0,
                            child: SvgPicture.asset(
                              'assets/images/new_images/curve_top.svg',
                              height: 210.sp,
                            )),
                        Positioned(
                            right: 0,
                            top: 400.sp,
                            child: SvgPicture.asset(
                              'assets/images/new_images/curve_right.svg',
                              height: 380.sp,
                            ))
                      ],
                    )),
              ).marginOnly(
                left: 25.sp,
                right: 25.sp,
              ))
          .toList(growable: true);
    }
  }

  @override
  _IntroSliderWidgetState createState() => _IntroSliderWidgetState();
}

class _IntroSliderWidgetState extends State<IntroSliderWidget> {
  int _current = 0;
  bool autoPlay = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: widget.imageSliders,
        options: CarouselOptions(
            viewportFraction: .9,
            enableInfiniteScroll: false,
            autoPlay: autoPlay,
            aspectRatio: 30 / 32,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      widget.imageSliders.length > 1
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imageSliders.map((url) {
                int index = widget.imageSliders.indexOf(url);
                return Container(
                  width: _current == index ? 130.sp : 65.sp,
                  height: 25.sp,
                  margin:
                      EdgeInsets.symmetric(vertical: 30.sp, horizontal: 10.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(50.sp),
                    color: _current == index
                        ? ColorUtils.orange
                        : ColorUtils.white,
                  ),
                );
              }).toList(),
            ).marginOnly(top: 70.sp)
          : Container(),
      widget.imageSliders.length > 1 && _current > 0
          ? GestureDetector(
              onTap: () => Get.offAllNamed(Routes.LOGIN),
              child: Container(
                  height: 90.sp,
                  width: 400.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.sp),
                    border:
                        Border.all(width: 3.sp, color: ColorUtils.greylight),
                  ),
                  child: Center(
                    child: CustomText(
                      'SKIP NOW',
                      color: ColorUtils.greylight,
                      fontweight: FontWeight.w500,
                    ),
                  ))).marginOnly(top: 70.sp)
          : Container(),
    ]);
  }
}
