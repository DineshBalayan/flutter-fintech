import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleUtils {
  static TextStyle textStyleNormal(
          {color = ColorUtils.black, isBold = false, fontSize, weight}) =>
      GoogleFonts.montserrat(
          textStyle: TextStyle(
            color: color,
            letterSpacing: 0.0,
            wordSpacing: 1.0,
            fontWeight: weight != null
                ? weight
                : isBold
                    ? FontWeight.bold
                    : FontWeight.normal,
          ),
          fontSize: fontSize == null ? 42.sp : fontSize);

  static TextStyle textStyleMedium(
          {color = ColorUtils.black, isBold = false, fontSize, weight}) =>
      GoogleFonts.montserrat(
          textStyle: TextStyle(
            color: color,
            letterSpacing: 0.0,
            wordSpacing: 1.0,
            fontWeight: weight != null
                ? weight
                : isBold
                    ? FontWeight.bold
                    : FontWeight.normal,
          ),
          fontSize: fontSize == null ? 48.sp : fontSize);

  static TextStyle textStyleBig(
          {color = ColorUtils.black, isBold = true, fontSize, weight}) =>
      GoogleFonts.montserrat(
          textStyle: TextStyle(
            color: color,
            letterSpacing: 0.0,
            wordSpacing: 1.0,
            fontWeight: weight != null
                ? weight
                : isBold
                    ? FontWeight.bold
                    : FontWeight.normal,
          ),
          fontSize: fontSize == null ? 54.sp : fontSize);

  static TextStyle textStyleNormalPoppins(
          {color = ColorUtils.black,
          isBold = false,
          fontSize,
          weight,
          isunderline = false}) =>
      GoogleFonts.poppins(
          textStyle: TextStyle(
            color: color,
            letterSpacing: 0.0,
            decoration: isunderline ? TextDecoration.underline : null,
            wordSpacing: 1.0,
            fontWeight: weight != null
                ? weight
                : isBold
                    ? FontWeight.bold
                    : FontWeight.normal,
          ),
          fontSize: fontSize == null ? 42.sp : fontSize);

  static TextStyle textStyleMediumPoppins(
          {color = ColorUtils.black, isBold = true, fontSize, weight}) =>
      GoogleFonts.poppins(
          textStyle: TextStyle(
            color: color,
            letterSpacing: 0.0,
            wordSpacing: 1.0,
            fontWeight: weight != null
                ? weight
                : isBold
                    ? FontWeight.bold
                    : FontWeight.normal,
          ),
          fontSize: fontSize == null ? 48.sp : fontSize);

  static TextStyle textStyleBigPoppins(
          {color = ColorUtils.black, isBold = true, fontSize, weight}) =>
      GoogleFonts.poppins(
          textStyle: TextStyle(
            color: color,
            letterSpacing: 0.0,
            wordSpacing: 1.0,
            fontWeight: weight != null
                ? weight
                : isBold
                    ? FontWeight.bold
                    : FontWeight.normal,
          ),
          fontSize: fontSize == null ? 54.sp : fontSize);
}
