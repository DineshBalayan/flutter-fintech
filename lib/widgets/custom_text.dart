import 'package:bank_sathi/Helpers/Constant.dart';
import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatefulWidget {
  final customTextStyle;
  final textAlign;
  String? text;
  var bold;
  Color? color;
  TextStyle? style;
  final maxLines;
  var fontSize;
  var fontweight;
  final overflow;
  final fontType, softWrap;

  CustomText(this.text,
      {this.customTextStyle = CustomTextStyle.NORMAL,
      this.bold,
      this.color,
      this.style,
      this.fontweight,
      this.textAlign = TextAlign.start,
      this.fontSize,
      this.fontType = FontType.POPPINS,
      this.maxLines,
      this.softWrap,
      this.overflow}) {
    var weight = fontweight == null ? FontWeight.w500 : fontweight;
    if (fontweight == Weight.LIGHT)
      weight = FontWeight.w300;
    else if (fontweight == Weight.NORMAL)
      weight = FontWeight.w500;
    else if (fontweight == Weight.BOLD) weight = FontWeight.w600;

    if (color == null) color = ColorUtils.textColor;
    if (text == null) text = "";

    if (style == null) {
      if (bold == null && weight == null) {
        bold = customTextStyle == CustomTextStyle.MEDIUM ||
            customTextStyle == CustomTextStyle.BIG;
      }
      if (fontSize == null) {
        if (customTextStyle == null ||
            customTextStyle == CustomTextStyle.NORMAL) {
          fontSize = 42.sp;
        } else if (customTextStyle == CustomTextStyle.MEDIUM) {
          fontSize = 48.sp;
        } else if (customTextStyle == CustomTextStyle.BIG) {
          fontSize = 54.sp;
        } else if (customTextStyle == CustomTextStyle.BIGTITLE) {
          fontSize = 65.sp;
        }
      }

      if (fontType == FontType.OPEN_SANS ||
          text!.contains(Constant.RUPEE_SIGN)) {
        style = customTextStyle == CustomTextStyle.NORMAL
            ? StyleUtils.textStyleNormal(
                isBold: bold, color: color, fontSize: fontSize, weight: weight)
            : customTextStyle == CustomTextStyle.MEDIUM
                ? StyleUtils.textStyleMedium(
                    isBold: bold,
                    color: color,
                    fontSize: fontSize,
                    weight: weight)
                : StyleUtils.textStyleBig(
                    isBold: bold,
                    color: color,
                    fontSize: fontSize,
                    weight: weight);
      } else {
        style = customTextStyle == CustomTextStyle.NORMAL
            ? StyleUtils.textStyleNormalPoppins(
                isBold: bold, color: color, fontSize: fontSize, weight: weight)
            : customTextStyle == CustomTextStyle.MEDIUM
                ? StyleUtils.textStyleMediumPoppins(
                    isBold: bold,
                    color: color,
                    fontSize: fontSize,
                    weight: weight)
                : StyleUtils.textStyleBigPoppins(
                    isBold: bold,
                    color: color,
                    fontSize: fontSize,
                    weight: weight);
      }
    }
  }

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text == null ? "" : widget.text!.replaceAll("null", ""),
      softWrap: widget.softWrap,
      maxLines: widget.maxLines,
      textAlign: widget.textAlign,
      style: widget.style,
      overflow: widget.overflow,
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

enum FontType { OPEN_SANS, POPPINS }

enum Weight { LIGHT, NORMAL, BOLD }

enum CustomTextStyle { NORMAL, MEDIUM, BIG, BIGTITLE }
