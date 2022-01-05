import 'dart:ui';

import 'package:bank_sathi/Helpers/Constant.dart';
import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/widgets/ButtonState.dart';
import 'package:bank_sathi/widgets/coming_soon_widget.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String {
  int calculateAge() {
    if (this.toDateTime() == null) return 0;
    return this.toDateTime()!.calculateAge();
  }

  String toDDMMYYYY() {
    DateTime dateTime;
    try {
      dateTime = DateTime.parse(this);
      return DateFormat("dd/MM/yyyy").format(dateTime);
    } catch (e) {
      print(e);
    }
    return this;
  }

  String toDDMM() {
    DateTime dateTime;
    try {
      dateTime = DateTime.parse(this);
      return DateFormat("dd MMM").format(dateTime);
    } catch (e) {
      print(e);
    }
    return this;
  }

  String toTime() {
    DateTime dateTime;
    try {
      dateTime = DateTime.parse(this);
      return DateFormat("hh:mm a").format(dateTime);
    } catch (e) {
      print(e);
    }
    return this;
  }

  String toDDMMMYYYY() {
    DateTime dateTime;
    try {
      dateTime = DateTime.parse(this);
      return DateFormat("dd-MMM-yyyy").format(dateTime);
    } catch (e) {
      print(e);
    }
    return this;
  }

  String toDDMMYYYYHHMM() {
    DateTime dateTime;
    try {
      dateTime = DateTime.parse(this);
      return DateFormat("dd/MMM/yyyy hh:mm a").format(dateTime);
    } catch (e) {
      print(e);
    }
    return this;
  }

  String serverToUIDate() {
    try {
      DateFormat format = new DateFormat("yyyy-MM-dd");
      DateTime parsedDate = format.parse(this);
      return DateFormat("dd/MM/yyyy").format(parsedDate);
    } catch (e) {
      print(e);
    }
    return this;
  }

  String toServerDate() {
    try {
      DateFormat format = new DateFormat("dd/MM/yyyy");
      DateTime parsedDate = format.parse(this);
      return DateFormat("yyyy-MM-dd").format(parsedDate);
    } catch (e) {
      try {
        DateFormat format = new DateFormat("dd-MMM-yyyy");
        DateTime parsedDate = format.parse(this);
        return DateFormat("yyyy-MM-dd").format(parsedDate);
      } catch (e) {
        print(e);
        return this;
      }
    }
  }

  String toTimeUi() {
    try {
      print(this);
      DateFormat format = new DateFormat("yyyy-MM-dd HH:mm:ss");
      DateTime parsedDate = format.parse(this);
      return DateFormat("hh:mm a").format(parsedDate);
    } catch (e) {
      print(e);
      return this;
    }
  }

  String toTimeServerToTimeUi() {
    try {
      print(this);
      DateFormat format = new DateFormat("hh:mm:ss");
      DateTime parsedDate = format.parse(this);
      return DateFormat("hh:mm a").format(parsedDate);
    } catch (e) {
      print(e);
      return this;
    }
  }

  bool isCurrentTimeInTimeRange(String otherDate) {
    try {
      DateFormat format = new DateFormat("hh:mm:ss");
      DateTime parsedFrom = format.parse(this);
      DateTime parsedTo = format.parse(otherDate);
      DateTime tempDate = DateTime.now();
      DateTime currentTime =
          DateTime(1970, 1, 1, tempDate.hour, tempDate.minute, tempDate.second);
      // DateTime currentTime = DateTime(1970, 1, 1, 18, 30);

      print("parsedFrom : " + parsedFrom.toString());
      print("parsedTo : " + parsedTo.toString());
      print("currentTime : " + currentTime.toString());

      return currentTime.isBefore(parsedTo) && currentTime.isAfter(parsedFrom);
    } catch (e) {
      return false;
    }
  }

  DateTime? toDateTime() {
    try {
      DateFormat format = new DateFormat("dd/MM/yyyy");
      print(this);
      print(format.parse(this));
      DateTime? dateTime = format.parse(this);
      return (dateTime);
    } on FormatException {
      return null;
    }
  }

  DateTime? serverToDateTime() {
    try {
      DateFormat format = new DateFormat("yyyy-MM-dd");
      print(this);
      print(format.parse(this));
      DateTime? dateTime = format.parse(this);
      return (dateTime);
    } on FormatException {
      return null;
    }
  }

  Color hexToColor() {
    return new Color(int.parse(this.substring(1, 7), radix: 16) + 0xFF000000);
  }

  int toInt() {
    return int.parse(this);
  }

  double? toDouble() {
    return double.tryParse(this.replaceAll(",", "")) ?? 0.00;
  }

  String? get videoId {
    bool _isValidId(String? id) =>
        RegExp(r'^[_\-a-zA-Z0-9]{11}$').hasMatch(id!);

    Uri uri;
    try {
      uri = Uri.parse(this);
    } catch (e) {
      return null;
    }
    if (!['https', 'http'].contains(uri.scheme)) {
      return null;
    }

    if (['youtube.com', 'www.youtube.com', 'm.youtube.com']
            .contains(uri.host) &&
        uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == 'watch' &&
        uri.queryParameters.containsKey('v')) {
      final videoId = uri.queryParameters['v'];
      return _isValidId(videoId) ? videoId : null;
    }

    // youtu.be/xxxxxxxxxxx
    if (uri.host == 'youtu.be' && uri.pathSegments.isNotEmpty) {
      final videoId = uri.pathSegments.first;
      return _isValidId(videoId) ? videoId : null;
    }

    return null;
  }

  String get thumbnail {
    return 'https://img.youtube.com/vi/$videoId/mqdefault.jpg';
  }

  DateTime? formatDateTimeFromUtc() {
    try {
      return DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(this);
    } catch (e) {
      print("DateFormat : " + e.toString());
      return null;
    }
  }

  Future printShortUrl() async {
    String link = "https://banksathi.app" + this;

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: Constant.APP_PAGE_LINK,
      link: Uri.parse(link),
      androidParameters: AndroidParameters(
        packageName: 'com.app.banksathi',
        minimumVersion: 0,
      ),
      iosParameters: IosParameters(bundleId: 'com.example.myappname'),
    );
    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();

    print(this + " : " + shortDynamicLink.shortUrl.toString());
  }

  String get genderForServer {
    return this.toLowerCase() == male.tr.toLowerCase()
        ? 'male'.toLowerCase()
        : this.toLowerCase() == female.tr.toLowerCase()
            ? 'female'.toLowerCase()
            : 'other'.toLowerCase();
  }

  String get genderFromServer {
    return this.toLowerCase() == "male".toLowerCase()
        ? male.tr.toLowerCase()
        : this.toLowerCase() == "female".toLowerCase()
            ? female.tr.toLowerCase()
            : other.tr.toLowerCase();
  }
}

extension ContextExtensions on BuildContext {
  hideKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }

  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (
        FocusScope.of(this).focusedChild!.context!.widget is! EditableText);
  }

  void previousEditableTextFocus() {
    do {
      FocusScope.of(this).previousFocus();
    } while (
        FocusScope.of(this).focusedChild!.context!.widget is! EditableText);
  }
}

extension NumberExtension on num {
  Widget get margin {
    return Padding(padding: EdgeInsets.all(this.toDouble()));
  }

  String currencyFormat() {
    NumberFormat numberFormat =
        NumberFormat.currency(locale: 'hi_In', symbol: "₹ ");
    return numberFormat.format(this);
  }
}

extension WidgetExtension on Widget {
  Widget visibility(bool visibility) {
    return Visibility(
      child: this,
      visible: visibility,
    );
  }

  Widget get addContainer {
    return Container(
      color: Colors.yellow,
      child: this,
    );
  }

  Widget get addBorder {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: ColorUtils.greylight, width: 1)),
      child: this,
    );
  }

  Widget get addContainerRed {
    return Container(
      color: Colors.red,
      child: this,
    );
  }

  Widget get obx {
    return Obx(() => this);
  }

  Widget alignTo(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  Widget adjustForTablet() => Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isLargeTablet ? ScreenUtil().screenWidth / 7 : 0),
      child: this);

  Widget onClick(_onClick, {onTouch, bool showEffect = false}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: showEffect ? new CircleBorder() : null,
        splashColor: showEffect ? ColorUtils.bluebutton : null,
        onTapDown: (tapDownDetail) {
          if (onTouch != null) onTouch();
        },
        onTap:
            _onClick != null ? _onClick : () => Get.dialog(ComingSoonWidget()),
        child: this,
      ),
    );
  }
}

extension TextEditingControllerExtension on TextEditingController {
  String get string => this.text.trim();
}

extension DateTimeExtension on DateTime? {
  int calculateAge() {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - this!.year;
    int month1 = currentDate.month;
    int month2 = this!.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = this!.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  bool isInRange(DateTime firstDay, DateTime lastDay) {
    firstDay = firstDay.removeTime();
    lastDay = lastDay.removeTime();

    return this.removeTime().isSameDate(firstDay) ||
        this.removeTime().isSameDate(lastDay) ||
        (this.removeTime().isAfter(firstDay) &&
            this.removeTime().isBefore(lastDay));
  }

  DateTime removeTime() {
    return DateTime(this!.year, this!.month, this!.day);
  }

  bool isSameDate(DateTime other) {
    return this!.year == other.year &&
        this!.month == other.month &&
        this!.day == other.day;
  }

  String? toUiDate() {
    try {
      return DateFormat("dd-MMM-yyyy").format(this!);
    } catch (e) {
      print(e);
      return null;
    }
  }

  String? toUiDateTime() {
    try {
      return DateFormat("dd-MMM-yyyy hh:mm a").format(this!);
    } catch (e) {
      print(e);
      return null;
    }
  }

  String? toServerDate() {
    try {
      return DateFormat("yyyy-MM-dd").format(this!);
    } catch (e) {
      print(e);
      return null;
    }
  }

  String? toServerDateTime() {
    try {
      return DateFormat("yyyy-MM-dd HH:mm:ss").format(this!);
    } catch (e) {
      print(e);
      return null;
    }
  }

  String? toFormat(String format) {
    try {
      return DateFormat(format).format(this!);
    } catch (e) {
      print(e);
      return null;
    }
  }
}

extension ColorExtension on Color {
  Color darken({double amount = .4}) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten({double amount = .1}) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  Color darker() {
    const int darkness = 10;
    int r = (red - darkness).clamp(0, 255);
    int g = (green - darkness).clamp(0, 255);
    int b = (blue - darkness).clamp(0, 255);
    return Color.fromRGBO(r, g, b, 1);
  }

  bool isDark() {
    return this.computeLuminance() < 0.25;
  }
}

extension ListExtention on List? {
  bool get isNullEmpty => this == null || this!.isEmpty;
}

extension PageStateExtension on PageStates {
  ButtonState get getMatchingButtonState {
    if (this == PageStates.PAGE_BUTTON_LOADING)
      return ButtonState.loading;
    else if (this == PageStates.PAGE_BUTTON_ERROR)
      return ButtonState.fail;
    else if (this == PageStates.PAGE_BUTTON_SUCCESS)
      return ButtonState.success;
    else if (this == PageStates.PAGE_BUTTON_FAIL)
      return ButtonState.fail;
    else
      return ButtonState.idle;
  }
}

extension AnimationControllerExtension on AnimationController {
  void repeatEx({required int times, int count = 0}) {
    if (count < times) {
      forward().then((value) =>
          reverse().then((value) => repeatEx(times: times, count: ++count)));
    }
  }
}
