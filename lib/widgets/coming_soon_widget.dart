import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ComingSoonWidget extends StatelessWidget {
  final bool showCloseButton;

  const ComingSoonWidget({this.showCloseButton = true}) : super();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(
        children: [
          Container(
            color: ColorUtils.white,
            padding: EdgeInsets.all(40),
            child: CustomText(
              "Coming Soon",
              fontSize: 80.sp,
              color: ColorUtils.blue,
              textAlign: TextAlign.center,
            ),
          ),
          Visibility(
              visible: showCloseButton,
              child: Positioned(
                right: 10,
                top: 10,
                child: Icon(
                  Icons.clear,
                  color: ColorUtils.red,
                  size: 24,
                ).paddingAll(10).onClick(() => Get.back()),
              ))
        ],
      ).addContainer,
    ));
  }
}
