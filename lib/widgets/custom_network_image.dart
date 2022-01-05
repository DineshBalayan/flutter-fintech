import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class CustomImage {
  static Widget network(
    String? url, {
    BoxFit? fit,
    double? width,
    double? height,
    Widget? errorWidget,
    Key? key,
  }) {
    return CachedNetworkImage(
      key: key,
      imageUrl: url ?? "",
      fit: fit,
      width: width,
      height: height,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: SizedBox(
        height: 25,
        width: 25,
        child: Center(
          child: Lottie.asset('assets/animation/loading.json',
              width: 20, fit: BoxFit.fitWidth),
        ),
      )),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Container(
              color: ColorUtils.white,
              width: width != null ? width / 2 : 30,
              height: height != null ? height / 2 : 30,
              child: UnconstrainedBox(
                child: SvgPicture.asset(
                  'assets/images/no_image.svg',
                  color: ColorUtils.black,
                  height: 20,
                  fit: BoxFit.scaleDown,
                ),
              )),
    );
  }

  static Widget networkSVG(
    String url, {
    BoxFit? fit,
    double? width,
    double? height,
    Widget? errorWidget,
    Key? key,
  }) {
    return SvgPicture.network(
      url,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      placeholderBuilder: (_) => Center(
          child: SizedBox(
        height: height,
        width: width,
        child: Center(
          child: Lottie.asset('assets/animation/loading.json',
              width: 20, fit: BoxFit.fitWidth),
        ),
      )),
    );
  }
}
