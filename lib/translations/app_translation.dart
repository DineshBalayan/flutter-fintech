import 'package:bank_sathi/translations/en_Us/en_us_translations.dart';
import 'package:bank_sathi/translations/hi_In/hi_in_translations.dart';
import 'package:flutter/material.dart';

abstract class AppTranslation {
  static const HINDI_LOCALE = Locale('hi', 'IN');
  static const ENGLISH_LOCALE = Locale('en', 'US');
  static const MARATHI_LOCALE = Locale('mr', 'IN');

  static const ENGLISH_LOCALE_LABEL = 'english';
  static const HINDI_LOCALE_LABEL = 'hindi';
  static const MARATHI_LOCALE_LABEL = 'marathi';

  static Map<String, Map<String, String>> translations = {
    'en_US': enUs,
    'hi_IN': hiIn,
  };
}
