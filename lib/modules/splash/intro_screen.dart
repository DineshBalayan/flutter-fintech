import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/slider_model.dart';
import 'package:bank_sathi/data/pref_manager.dart';
import 'package:bank_sathi/widgets/intro_slider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class IntroScreen extends StatelessWidget {
  final imageList = [
    SliderModel(
        title: 'Start own business with\n‘Zero Investment’',
        desc:
            'Be Your Own Boss! Become a certified Banksathi Advisor, Earn More Than ₹1,00,000 Every Month  ',
        picAsset: 'assets/images/new_images/intro/one.png',
        onClick: () {}),
    SliderModel(
        title: 'Earn ‘Unlimited Money’ with\n‘Minimal Efforts’',
        desc: 'Earn unlimited by generating leads for financial products',
        picAsset: 'assets/images/new_images/intro/two.png',
        onClick: () {}),
    SliderModel(
        title: 'Refer to friends and earn\n‘Extra Income’!',
        desc:
            'Refer ‘BankSathi’ to your friends and earn up to 10% of the income earned by your friends ',
        picAsset: 'assets/images/new_images/intro/three.png',
        onClick: () {}),
    SliderModel(
        title: 'Withdraw your\n‘Payout’ Anytime',
        desc:
            'Withdraw your money quickly without waiting in your wallet or bank account',
        picAsset: 'assets/images/new_images/intro/four.png',
        onClick: () {})
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(1080, 2280));
    Get.find<PrefManager>().setFirstTimeFalse();
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/login/login_bg.jpg',
            width: Get.width,
            height: Get.height,
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'How '.toUpperCase(),
                                  style: StyleUtils.textStyleNormalPoppins(
                                      color: ColorUtils.white,
                                      weight: FontWeight.w200,
                                      fontSize: 60.sp)),
                              TextSpan(
                                  text: 'it works?'.toUpperCase(),
                                  style: StyleUtils.textStyleNormalPoppins(
                                      color: ColorUtils.white,
                                      weight: FontWeight.w700,
                                      fontSize: 60.sp)),
                            ],
                          )),
                      SizedBox(
                          width: 160.sp,
                          child: Divider(
                            color: ColorUtils.white_bg,
                            thickness: 5.sp,
                          )),
                    ],
                  ),
                  SvgPicture.asset(
                    'assets/images/new_images/play.svg',
                    width: 170.sp,
                  )
                ],
              ).marginOnly(top: 160.sp, left: 80.sp, right: 80.sp).onClick(() {
                Get.dialog(WidgetUtil.videoDialog("ehuWwHjXjz4"));
              }, showEffect: false),
              IntroSliderWidget(imageList).marginOnly(top: 300.sp),
            ],
          )
        ],
      ),
    );
  }
}
