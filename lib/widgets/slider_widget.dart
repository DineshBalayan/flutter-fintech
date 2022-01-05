import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Model/slider_model.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SliderWidget extends StatefulWidget {
  final YoutubePlayerController controller;

  const SliderWidget({required this.controller}) : super();

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  late List<Widget> imageSliders;

  bool isPlaying = true;

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: imageSliders,
        options: CarouselOptions(
            autoPlayAnimationDuration: Duration(seconds: 1),
            viewportFraction: 1.0,
            autoPlay: !isPlaying,
            height: 0.49.sh,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageSliders.map((url) {
          int index = imageSliders.indexOf(url);
          return Container(
            width: 25.0.h,
            height: 25.0.h,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index
                  ? ColorUtils.blue
                  : Color.fromRGBO(0, 0, 0, 0.4),
            ),
          );
        }).toList(),
      ),
    ]);
  }

  @override
  void initState() {
    imageSliders = [
      YoutubePlayer(
        controller: widget.controller,
        showVideoProgressIndicator: true,
        bottomActions: [
          const SizedBox(width: 14.0),
          CurrentPosition(),
          const SizedBox(width: 8.0),
          ProgressBar(
            isExpanded: true,
          ),
          RemainingDuration(),
        ],
        progressColors: ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
      )
    ]..addAll(imgList
        .map((item) => Column(
              children: [
                SizedBox(
                  height: .39.sh,
                  child: SvgPicture.asset(
                    item.picAsset,
                    height: .39.sh,
                    fit: BoxFit.contain,
                  ),
                ),
                CustomText(
                  item.title,
                  fontweight: Weight.BOLD,
                  fontSize: 42.sp,
                  textAlign: TextAlign.center,
                ).marginOnly(left: 15, right: 15),
                CustomText(
                  item.desc,
                  fontweight: Weight.LIGHT,
                  textAlign: TextAlign.center,
                )
                    .marginOnly(left: 15, right: 15)
                    .marginOnly(left: 15, right: 15)
              ],
            ))
        .toList());

    widget.controller.addListener(() {
      if (widget.controller.value.playerState == PlayerState.paused ||
          widget.controller.value.playerState == PlayerState.ended) {
        setState(() {
          isPlaying = false;
        });
      } else {
        setState(() {
          isPlaying = true;
        });
      }
    });
    super.initState();
  }
}

final List<SliderModel> imgList = [
  SliderModel(
      picAsset: 'assets/images/intro_sell_earn.svg',
      title: 'Earn For yourself/Be your own Boss',
      desc:
          'Just generate leads for credit cards, Insurance and Loans to earn unlimited!'),
  SliderModel(
      picAsset: 'assets/images/intro_brand_yourself.svg',
      title: 'Helping Hands',
      desc:
          'Banksathi serves you as a helping hand, Earn with Zero difficulties'),
  SliderModel(
      picAsset: 'assets/images/intro_learn.svg',
      title: 'Knowledge',
      desc:
          'Keep yourself updated with the financial products through regular trainings'),
  SliderModel(
      picAsset: 'assets/images/intro_trust.svg',
      title: 'You are Banksathi!',
      desc: 'You and we both together are Team Banksathi'),
];
