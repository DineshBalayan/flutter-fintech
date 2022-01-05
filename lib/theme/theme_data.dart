import 'dart:ui';

import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: Colors.grey,
  accentColor: Colors.deepOrangeAccent,
  splashColor: Colors.white,
  highlightColor: Colors.white,
  backgroundColor: ColorUtils.window_bg,
  brightness: Brightness.light,
  hintColor: "#caccd1".hexToColor(),
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    titleSpacing: 5.0,
    actionsIconTheme: IconThemeData(size: 24),

    systemOverlayStyle: SystemUiOverlayStyle.light
        .copyWith(statusBarColor: ColorUtils.black), // 2
  ),
  fontFamily: GoogleFonts.poppins(fontStyle: FontStyle.normal).fontFamily,
  textTheme: TextTheme(
    headline1: TextStyle(
        fontSize: 72.0,
        fontWeight: FontWeight.bold,
        color: ColorUtils.textColor),
  ),
);
