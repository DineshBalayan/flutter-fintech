import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Model/response/get_section_help_response.dart';
import 'package:bank_sathi/Model/response/get_user_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/data/pref_manager.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/views/dashboard.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/translations/app_translation.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/BlinkWidget.dart';
import 'package:bank_sathi/widgets/ButtonState.dart';
import 'package:bank_sathi/widgets/IconedButton.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'Constant.dart';
import 'color_utils.dart';

class WidgetUtil {
  static Widget getNamedIcon(String label, String asset,
      {bool isNew = false,
      bool isColor = false,
      bool showTopLabel = true,
      bool isLargeicon = false,
      onclick}) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showTopLabel)
          Visibility(
            child: Container(
              padding: EdgeInsets.fromLTRB(30.sp, 5.sp, 30.sp, 5.sp),
              margin: EdgeInsets.only(bottom: 20.sp),
              child: CustomText(
                new_.tr,
                color: ColorUtils.white,
                fontSize: 36.sp,
              ),
              decoration: BoxDecoration(
                color: ColorUtils.orange,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            visible: isNew,
          ),
        Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          height: 140.sp,
          width: 140.sp,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                ColorUtils.black,
                ColorUtils.black.lighten(amount: .4)
              ], transform: GradientRotation(45))),
          child: UnconstrainedBox(
            child: SvgPicture.asset(
              asset,
              color: isColor ? ColorUtils.white : ColorUtils.white,
              height: isLargeicon ? 65.sp : 65.sp,
              fit: BoxFit.scaleDown,
            ),
          ),
        ).marginOnly(bottom: 20.sp),
        CustomText(
          label,
          fontSize: 36.sp,
          fontweight: Weight.LIGHT,
          customTextStyle: CustomTextStyle.NORMAL,
          textAlign: TextAlign.center,
        )
      ],
    ).onClick(onclick));
  }

  static Widget getPrimaryButton(onClick, {String? label}) {
    return SizedBox(
      width: double.infinity,
      height: 140.h,
      child: RaisedButton(
        elevation: 0,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(100.w),
        ),
        highlightColor: ColorUtils.orange,
        onPressed: onClick,
        color: ColorUtils.blackLight,
        child: CustomText(
          label == null ? continue_label.tr : label,
          style: TextStyle(
              color: ColorUtils.white,
              fontWeight: FontWeight.w300,
              fontSize: 54.sp),
        ),
      ),
    );
  }

  static Widget getOrangeButton(onClick,
      {String label = continue_label, double? fontSize}) {
    return SizedBox(
      width: double.infinity,
      height: 140.h,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.w),
        ),
        highlightColor: ColorUtils.orange,
        onPressed: onClick,
        color: ColorUtils.orange,
        child: CustomText(
          label.tr,
          style: TextStyle(
              color: ColorUtils.white,
              fontWeight: FontWeight.w300,
              fontSize: fontSize ?? 54.sp),
        ),
      ),
    );
  }

  static Widget getSecondaryButton(onClick,
      {String label = continue_label,
      bool color = true,
      double? width,
      double? height}) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 100.h,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(height == null ? 50.h : height / 2),
        ),
        highlightColor: ColorUtils.orange,
        onPressed: onClick,
        color: color ? ColorUtils.black : ColorUtils.orange,
        child: CustomText(
          label.tr,
          color: ColorUtils.white,
        ),
      ),
    );
  }

  static Widget showDialog(onClick,
      {var dialogType = DialogType.ERROR,
      String title = Constant.app_message,
      bool backPressDismiss = true,
      String message = "",
      String? button}) {
    button = button == null ? 'Okay, Got It'.toUpperCase() : button;
    return dialogType == DialogType.ERROR
        ? Dialog(
            backgroundColor: Colors.transparent,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.sp)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/images/new_images/error.svg',
                    width: 200.sp,
                  ).marginOnly(top: 40.sp),
                  CustomText(
                    title,
                    fontSize: 48.sp,
                  ).marginOnly(top: 40.sp),
                  CustomText(
                    message,
                    textAlign: TextAlign.center,
                    color: Colors.grey,
                    fontweight: FontWeight.w300,
                  ).marginOnly(top: 10.sp),
                  SizedBox(
                    height: 100.sp,
                    child: RaisedButton(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.w),
                      ),
                      highlightColor: ColorUtils.orange,
                      onPressed: onClick,
                      color: ColorUtils.textColorLight,
                      child: CustomText(
                        button,
                        style: TextStyle(
                            color: ColorUtils.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 42.sp),
                      ),
                    ),
                  ).marginOnly(top: 50.sp)
                ],
              ).marginAll(60.sp),
            ),
          )
        : AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.all(30.sp),
            content: WillPopScope(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SvgPicture.asset(
                        dialogType == DialogType.ALERT
                            ? 'assets/images/new_images/session.svg'
                            : dialogType == DialogType.INFO
                                ? 'assets/images/new_images/session.svg'
                                : 'assets/images/error.svg',
                        height: 120.sp,
                      ).marginAll(50.sp),
                      CustomText(
                        "" + title,
                        customTextStyle: CustomTextStyle.BIG,
                        fontweight: Weight.NORMAL,
                      ).alignTo(Alignment.center),
                      Container(
                          constraints: BoxConstraints(maxHeight: 530.h),
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              child: CustomText(
                                "" + message,
                                color: ColorUtils.black,
                                fontweight: Weight.NORMAL,
                                fontType: FontType.OPEN_SANS,
                                textAlign: TextAlign.center,
                              ).alignTo(Alignment.center).marginOnly(
                                  left: 15, top: 10, right: 15, bottom: 10),
                            ),
                          )),
                      WidgetUtil.getSecondaryButton(onClick,
                              label: button.tr, color: true)
                          .marginOnly(left: 30, bottom: 10, top: 10, right: 30)
                    ],
                  ),
                ),
                onWillPop: () async => backPressDismiss),
          ).alignTo(Alignment.center);
  }

  static Widget logoutDialog(onCancel, onClick,
      {required String title,
      String message = "",
      cancelLabel,
      required String button}) {
    button = button == null ? dismiss.tr : button;
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      contentPadding: EdgeInsets.only(top: 0.0),
      content: Container(
        padding: EdgeInsets.only(
            top: 30.sp, bottom: 25.sp, left: 10.sp, right: 10.sp),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomText(
              title,
              customTextStyle: CustomTextStyle.BIG,
              fontweight: Weight.NORMAL,
            ).alignTo(Alignment.center).marginOnly(top: 5),
            Container(
                constraints: BoxConstraints(maxHeight: 150),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: CustomText(
                      "" + message,
                      color: ColorUtils.grey,
                      fontweight: Weight.NORMAL,
                      textAlign: TextAlign.center,
                    ).alignTo(Alignment.center).marginAll(10),
                  ),
                )),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                  child: WidgetUtil.getSecondaryButton(onCancel,
                          label: cancelLabel ?? cancel.tr, color: false)
                      .marginAll(3)),
              Expanded(
                  child: WidgetUtil.getSecondaryButton(onClick,
                          label: button.tr, color: true)
                      .marginAll(3))
            ]).marginAll(10)
          ],
        ),
      ),
    ).alignTo(Alignment.center);
  }

  static Widget RequestSubmitDialog({var requestNumber, var requesttype}) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      contentPadding: EdgeInsets.only(top: 0.0),
      content: WillPopScope(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.cancel_presentation_rounded,
                color: ColorUtils.white,
                size: 100.sp,
              ).alignTo(Alignment.topRight),
              SvgPicture.asset(
                'assets/images/ic_submit_success.svg',
                height: 200.sp,
              ).marginAll(10),
              CustomText(
                request_successfully_submitted.tr,
                customTextStyle: CustomTextStyle.BIG,
                color: ColorUtils.black,
              ).alignTo(Alignment.center).marginOnly(top: 10.sp),
              CustomText(
                your_request_number.tr + ' ' + requestNumber,
                color: ColorUtils.orange,
              ).alignTo(Alignment.center).marginOnly(top: 100.sp),
              Row(
                children: [
                  CustomText(
                    support_contact_msg.tr,
                    color: ColorUtils.blackLight,
                    fontweight: Weight.LIGHT,
                  ).alignTo(Alignment.center),
                  CustomText(
                    ' ' + requesttype,
                    color: ColorUtils.darkGreen,
                  ).alignTo(Alignment.center),
                ],
              ).marginOnly(top: 30.sp)
            ],
          )),
          onWillPop: () async => true),
    ).alignTo(Alignment.center);
  }

  static Widget showLanguageDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      contentPadding: EdgeInsets.only(top: 0.0),
      content: Container(
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              decoration: BoxDecoration(
                color: ColorUtils.bluebutton,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: CustomText(
                select_language.tr,
                color: ColorUtils.white,
                customTextStyle: CustomTextStyle.MEDIUM,
                fontweight: Weight.NORMAL,
              ).alignTo(Alignment.center),
            ),
            Column(
              children: [
                getRadio(
                    label: "English",
                    isSelected: Get.locale == AppTranslation.ENGLISH_LOCALE,
                    onTap: () {
                      PrefManager prefManager = Get.find();
                      prefManager
                          .setLocale(AppTranslation.ENGLISH_LOCALE_LABEL);
                      Get.updateLocale(AppTranslation.ENGLISH_LOCALE);
                      Get.back();
                    }).paddingOnly(bottom: 20),
                getRadio(
                    label: "Hindi",
                    isSelected: Get.locale == AppTranslation.HINDI_LOCALE,
                    onTap: () async {
                      PrefManager prefManager = Get.find();
                      prefManager.setLocale(AppTranslation.HINDI_LOCALE_LABEL);
                      Get.updateLocale(AppTranslation.HINDI_LOCALE);
                      Get.back();
                    })
                /*  getRadio(
                    label: "Marathi",
                    isSelected: Get.locale == AppTranslation.MARATHI_LOCALE,
                    onTap: () async {
                      PrefManager prefManager = Get.find();
                      prefManager
                          .setLocale(AppTranslation.MARATHI_LOCALE_LABEL);
                      Get.updateLocale(AppTranslation.MARATHI_LOCALE);
                      Get.back();
                    })*/
              ],
            ).paddingAll(20),
            Divider(
              color: Colors.grey,
              thickness: 1.0,
              height: 1,
            ),
            FlatButton(
                onPressed: () => Get.back(),
                child: CustomText(
                  cancel.tr,
                  color: ColorUtils.bluebutton,
                  customTextStyle: CustomTextStyle.MEDIUM,
                  fontweight: Weight.NORMAL,
                )).alignTo(Alignment.center)
          ],
        ),
      ),
    ).alignTo(Alignment.center);
  }

  static Widget getRadio(
      {onTap,
      isSelected,
      label,
      fontSize,
      bool border = false,
      bool bold = false}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30.sp, horizontal: 30.sp),
          margin: EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.sp)),
              border: Border.all(
                  width: 0.6,
                  color: border ? "#caccd1".hexToColor() : Colors.transparent)),
          child: Row(
            children: [
              Container(
                height: 60.sp,
                width: 60.sp,
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                    color: isSelected ? ColorUtils.orange : ColorUtils.white,
                    border: Border.all(
                        width: 0.6,
                        color:
                            isSelected ? ColorUtils.orange : ColorUtils.black)),
                child: isSelected
                    ? Icon(
                        Icons.done,
                        color: ColorUtils.white,
                        size: 40.sp,
                      )
                    : Container(),
              ),
              CustomText(
                label,
                fontweight: bold ? Weight.BOLD : Weight.LIGHT,
                fontSize: fontSize ?? 42.sp,
              ).marginOnly(left: 20.sp)
            ],
          ),
        ));
  }

  static Widget getCheckbox({onTap, isSelected}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.sp,
        width: 60.sp,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.all(
                width: 2,
                color: isSelected ? ColorUtils.orange : ColorUtils.black)),
        child: isSelected
            ? SvgPicture.asset('assets/images/ic_checked.svg')
            : Container(),
      ),
    );
  }

  static Widget getListTile(
      {title,
      subtitle,
      isSelected,
      onTap,
      leadingIcon,
      onTouch,
      titleColor = ColorUtils.textColor,
      trailingWidget,
      subTitleSize,
      subTitleColor = ColorUtils.grey}) {
    return ListTile(
      leading: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        leadingIcon is String
            ? SvgPicture.asset(
                leadingIcon,
                height: 24,
                fit: BoxFit.scaleDown,
                color: isSelected ? ColorUtils.orange : ColorUtils.greyDark,
              )
            : leadingIcon
      ]),
      title: CustomText(
        title,
        color: isSelected ? ColorUtils.orange : titleColor,
        fontweight: Weight.LIGHT,
      ),
      subtitle: subtitle == null
          ? null
          : CustomText(
              subtitle,
              color: isSelected ? ColorUtils.blue : subTitleColor,
              fontweight: Weight.LIGHT,
              fontSize: subTitleSize == null ? 42.sp : subTitleSize,
            ),
      trailing:
          trailingWidget == null ? Icon(Icons.chevron_right) : trailingWidget,
    ).onClick(onTap, onTouch: onTouch).marginOnly(top: 15.sp, bottom: 15.sp);
  }

  static Widget getSlider(Widget child) {
    return SliderTheme(
        data: SliderTheme.of(Get.context!).copyWith(
          activeTrackColor: ColorUtils.black_gr_light.withAlpha(200),
          inactiveTrackColor: ColorUtils.black_gr_light.withAlpha(32),
          trackShape: RoundedRectSliderTrackShape(),
          trackHeight: 6.0,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
          thumbColor: ColorUtils.orange_gr_light.withAlpha(230),
          overlayColor: ColorUtils.orange_gr_light.withAlpha(32),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 10.0),
          tickMarkShape: RoundSliderTickMarkShape(),
          activeTickMarkColor: ColorUtils.black_gr_light,
          inactiveTickMarkColor: ColorUtils.black_gr_light.withAlpha(20),
          valueIndicatorShape: PaddleSliderValueIndicatorShape(),
          valueIndicatorColor: ColorUtils.black_gr_light,
          valueIndicatorTextStyle: StyleUtils.textStyleMedium(
            color: Colors.white,
          ),
        ),
        child: child);
  }

  static void addLeadView({bool fromFabButton = false}) {
    List<Products> products = Get.find<PrefManager>().getProductsStatus() ?? [];
    List<CategoryColor> colorsNew =
        Get.find<PrefManager>().getProductsColor() ?? [];
    List<Products> activeProducts =
        products.where((element) => element.status == "1").toList();

    addLeadBottomSheetController =
        dashboardScaffoldKey.currentState!.showBottomSheet(
            (context) => LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    iconSwitchKey.currentState!.setBottomSheetTrue();
                    return Container(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        alignment: Alignment.bottomRight,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withAlpha(150),
                                  Colors.black.withAlpha(160),
                                  Colors.black.withAlpha(170),
                                  Colors.black.withAlpha(180),
                                ]),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.sp),
                            topRight: Radius.circular(50.sp),
                          ),
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().screenHeight /
                                            ScreenUtil().screenWidth <
                                        1.30
                                    ? ScreenUtil().screenWidth / 10
                                    : 0),
                            child: Card(
                                color: ColorUtils.white,
                                margin: EdgeInsets.zero,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shadowColor: ColorUtils.white_bg,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(60.sp),
                                        topRight: Radius.circular(60.sp))),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            select_and_add_lead.tr,
                                            color: ColorUtils.black,
                                            customTextStyle:
                                                CustomTextStyle.MEDIUM,
                                          ),
                                          Container(
                                            height: 72.sp,
                                            width: 72.sp,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        40.sp),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.black)),
                                            child: Icon(
                                              Icons.clear,
                                              color: Colors.black,
                                              size: 48.sp,
                                            ),
                                          ).onClick(() => Get.back())
                                        ],
                                      ).paddingOnly(
                                          left: 60.sp,
                                          top: 60.sp,
                                          right: 60.sp),
                                      Divider(
                                        height: 60.sp,
                                        thickness: 1,
                                      ),
                                      GridView.count(
                                        physics: NeverScrollableScrollPhysics(),
                                        crossAxisCount: 2,
                                        childAspectRatio: 1,
                                        shrinkWrap: true,
                                        children: activeProducts.map((e) {
                                          String? bgColor = (colorsNew ==
                                                      null ||
                                                  !colorsNew.any((element) =>
                                                      element.category_id ==
                                                      e.id))
                                              ? null
                                              : colorsNew
                                                  .firstWhere((element) =>
                                                      element.category_id ==
                                                      e.id)
                                                  .bg;

                                          String? iconColor = (colorsNew ==
                                                      null ||
                                                  !colorsNew.any((element) =>
                                                      element.category_id ==
                                                      e.id))
                                              ? null
                                              : colorsNew
                                                  .firstWhere((element) =>
                                                      element.category_id ==
                                                      e.id)
                                                  .icon;
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15.sp,
                                                vertical: 15.sp),
                                            child: Card(
                                                elevation: 0,
                                                color: (bgColor ?? "#F3F1F6")
                                                    .hexToColor(),
                                                margin: EdgeInsets.zero,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.sp),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 150.sp,
                                                      width: 150.sp,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: UnconstrainedBox(
                                                        child: SizedBox(
                                                          child: SvgPicture
                                                              .network(
                                                            e.icon,
                                                            color: (iconColor ??
                                                                    "#968E9F")
                                                                .hexToColor(),
                                                            height: 85.sp,
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            placeholderBuilder:
                                                                (_) => Center(
                                                                    child:
                                                                        SizedBox(
                                                              height: 60.sp,
                                                              width: 60.sp,
                                                              child: Center(
                                                                child: Lottie.asset(
                                                                    'assets/animation/loading.json',
                                                                    width:
                                                                        40.sp,
                                                                    fit: BoxFit
                                                                        .fitWidth),
                                                              ),
                                                            )),
                                                          ),
                                                          height: 85.sp,
                                                          width: 85.sp,
                                                        ),
                                                      ),
                                                    ),
                                                    CustomText(
                                                      e.title,
                                                      fontSize: 42.sp,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ).marginOnly(top: 15.sp),
                                                    getContainer(e.message)
                                                  ],
                                                ).marginSymmetric(
                                                    vertical: 60.sp,
                                                    horizontal: 40.sp)),
                                          ).onClick(() {
                                            Get.back();
                                            Get.toNamed(Routes.DASHBOARD +
                                                Routes.PRODUCT_LIST_SCREEN +
                                                "?product_id=" +
                                                e.id.toString());
                                          });
                                        }).toList(),
                                      ).marginOnly(bottom: 220.sp).paddingOnly(
                                          left: 40.sp, right: 40.sp)
                                    ],
                                  ),
                                ))));
                  },
                ),
            backgroundColor: Colors.grey.withOpacity(.5));

    if (!fromFabButton) iconSwitchKey.currentState!.onBottomSheetShow();

    addLeadBottomSheetController!.closed.whenComplete(() {
      iconSwitchKey.currentState!.onBottomSheetHide();
    });
  }

  static Widget getContainer(String? string, {Color? color}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.sp),
          border: Border.all(color: color ?? ColorUtils.orange, width: 0.8)),
      child: CustomText(
        (string ?? "").toUpperCase(),
        color: color ?? ColorUtils.orange,
        fontSize: 32.sp,
        textAlign: TextAlign.center,
      ).paddingSymmetric(horizontal: 30.sp, vertical: 4.sp),
    ).marginOnly(top: 20.sp);
  }

  static Widget getProfileCard({bool isEditable = true}) {
    DashboardController controller = Get.find<DashboardController>();

    return AspectRatio(
      aspectRatio: 16 / 9.5,
      child: LayoutBuilder(builder: (_, constraint) {
        return Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          width: constraint.maxWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: ["#323438".hexToColor(), "#171a21".hexToColor()]),
            borderRadius: BorderRadius.all(Radius.circular(60.sp)),
          ),
          child: Stack(
            children: [
              Align(
                child: SvgPicture.asset(
                  'assets/images/new_images/language_curve_blac.svg',
                  width: constraint.maxWidth * .8,
                  color: "#32353c".hexToColor(),
                ),
                alignment: Alignment.topRight,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Obx(() => Container(
                                decoration: BoxDecoration(
                                    color: controller
                                        .getUserStatusColor()
                                        .withAlpha(15),
                                    border: Border.all(
                                        color: controller.getUserStatusColor(),
                                        width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40))),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                                  child: Obx(() => CustomText(
                                        controller.getUserStatus(),
                                        color: controller.getUserStatusColor(),
                                        fontSize: 28.sp,
                                      )),
                                ),
                              )),
                          Row(
                            children: [
                              Obx(() => CustomText(
                                    controller.getUserFullName(),
                                    color: ColorUtils.white,
                                    fontSize: 45.sp,
                                    maxLines: 2,
                                    customTextStyle: CustomTextStyle.NORMAL,
                                  )),
                              Obx(() => SvgPicture.asset(
                                    'assets/images/new_images/verify.svg',
                                    height: 20,
                                    width: 20,
                                  )
                                      .marginOnly(
                                          left: 20.sp,
                                          top: 20.sp,
                                          bottom: 30.sp)
                                      .visibility(
                                          controller.user.user_status == "3")),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: SvgPicture.asset(
                                    'assets/images/new_images/profile_image/telephone.svg',
                                    height: 16,
                                    width: 16,
                                    color: "#838998".hexToColor(),
                                  )),
                              Container(
                                width: 30.sp,
                              ),
                              Obx(() => CustomText(
                                    controller.user.mobile_no,
                                    fontweight: Weight.NORMAL,
                                    color: "#838998".hexToColor(),
                                    fontSize: 36.sp,
                                  ))
                            ],
                          ).marginOnly(top: 30.sp),
                          Obx(() => Row(
                                children: [
                                  SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: SvgPicture.asset(
                                      'assets/images/new_images/profile_image/mail.svg',
                                      height: 16,
                                      width: 16,
                                      fit: BoxFit.contain,
                                      color: "#838998".hexToColor(),
                                    ),
                                  ),
                                  Container(
                                    width: 30.sp,
                                  ),
                                  Obx(() => CustomText(
                                        controller.user.email,
                                        fontweight: Weight.NORMAL,
                                        color: "#838998".hexToColor(),
                                        fontSize: 36.sp,
                                      ))
                                ],
                              ).marginOnly(top: 30.sp).visibility(
                                  controller.user.email != null &&
                                      controller.user.email
                                          .toString()
                                          .isNotEmpty)),
                        ],
                      ).marginOnly(left: 10, right: 10, top: 10)),
                      Stack(children: <Widget>[
                        Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                                width: constraint.maxWidth * .25,
                                height: constraint.maxWidth * .25,
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                        radius: constraint.maxWidth * .5,
                                        backgroundColor: Colors.white,
                                        child: Card(
                                          elevation: 1,
                                          margin: EdgeInsets.all(5.sp),
                                          color: Colors.white,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                constraint.maxWidth * .5),
                                          ),
                                          child: Obx(() => CustomImage.network(
                                              controller.user.profile_photo,
                                              height: constraint.maxWidth * .25,
                                              errorWidget: UnconstrainedBox(
                                                child: SvgPicture.asset(
                                                  'assets/images/ic_cc_user.svg',
                                                  color: ColorUtils.black,
                                                  height: 100.sp,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                              width: constraint.maxWidth * .25,
                                              fit: BoxFit.fill)),
                                        )),
                                    Positioned(
                                        right: 0.sp,
                                        top: 150.sp,
                                        child: ImagePickerWidget(
                                          onFilePicked: (file) {
                                            controller.uploadProfilePic(file);
                                          },
                                          cropRatio: [
                                            CropAspectRatioPreset.square
                                          ],
                                          showPreview: false,
                                          child: Card(
                                            color: ColorUtils.orange,
                                            child: SvgPicture.asset(
                                                    'assets/images/new_images/profile_image/camera.svg',
                                                    color: ColorUtils.white_bg,
                                                    height: 30.sp)
                                                .marginAll(25.sp),
                                            shape: CircleBorder(),
                                            clipBehavior: Clip.antiAlias,
                                          ).visibility(isEditable),
                                        )),
                                  ],
                                )))
                      ]).marginOnly(left: 10, top: 10, right: 10),
                    ],
                  ).marginOnly(left: 5.0, top: 15.sp),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 16,
                          width: 16,
                          child: SvgPicture.asset(
                            'assets/images/new_images/profile_image/location.svg',
                            height: 16,
                            width: 16,
                            color: "#838998".hexToColor(),
                          )).marginOnly(left: 5),
                      Container(
                        width: 30.sp,
                      ),
                      Expanded(
                        child: Obx(() => CustomText(
                              controller.user.full_address + "\n\n",
                              fontweight: Weight.NORMAL,
                              maxLines: 2,
                              color: "#838998".hexToColor(),
                              fontSize: 36.sp,
                            )),
                      )
                    ],
                  ).marginOnly(left: 10, right: 10, bottom: 10, top: 30.sp),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  static Widget getStateButton(
      {required BaseController controller,
      required var onPressed,
      String? label,
      Color? color,
      ButtonState? state,
      TextStyle? textStyle,
      width}) {
    return Obx(() => Center(
          child: ProgressButton.icon(
              elevation: 0,
              radius: 100.0,
              minWidth: width ?? 100.0,
              maxWidth: width,
              minWidthStates: [ButtonState.idle],
              progressIndicator: CircularProgressIndicator(
                color: Colors.white,
              ),
              iconedButtons: {
                ButtonState.idle: IconedButton(
                    text: label ?? submit.tr,
                    icon: Icon(Icons.arrow_forward, color: Colors.white),
                    color: color ?? ColorUtils.blackLight),
                ButtonState.loading:
                    IconedButton(text: "Verifying", color: ColorUtils.orange),
                ButtonState.fail: IconedButton(
                    text: "Failed",
                    icon: Icon(Icons.cancel, color: Colors.white),
                    color: Colors.red.shade300),
                ButtonState.success: IconedButton(
                    text: "Success",
                    icon: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    color: Colors.green.shade400)
              },
              textStyle: textStyle ??
                  StyleUtils.textStyleMediumPoppins(
                      color: ColorUtils.white, weight: FontWeight.w400),
              onPressed: onPressed,
              state: state ?? controller.pageState.getMatchingButtonState),
        ));
  }

  static Widget getSupportIcon() {
    return SvgPicture.asset(
      'assets/images/ic_support.svg',
      fit: BoxFit.scaleDown,
      height: 64.sp,
    ).marginOnly(right: 10, left: 15).onClick(() {
      launch("https://api.whatsapp.com/send?phone=917412933933");
    });
  }

  static Widget getLiveTrainingWidget() {
    return Container(height:145.sp,width: 145.sp,child:Stack(
      children: [
        Image.asset(
          'assets/images/new_images/live_training.png',
          fit: BoxFit.fill,
        ).alignTo(Alignment.center),
        Positioned(
            left: 10.sp,
            top: 57.sp,
            child: Center(
                child: Transform.scale(
                  scale: 10.0,
                  child:  BlinkWidget(
                      children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                              color: '#f8554b'.hexToColor(),
                              shape: BoxShape.circle,
                            ),
                            width: 2.sp,
                            height: 2.sp,),
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            width: 2.sp,
                            height: 2.sp,)
                      ],
                      interval: 1000,
                  ),
                )))
      ],
    ));
  }

  static Widget getNotificationIcon() {
    DashboardController controller = Get.find<DashboardController>();
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/images/new_images/notification.svg',
          fit: BoxFit.scaleDown,
          color: ColorUtils.black,
          height: 64.sp,
        ).marginOnly(right: 12.sp).alignTo(Alignment.center),
        Obx(
          () => controller.notifCount == 0
              ? Container()
              : Positioned(
                  right: 0,
                  top: 10,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent.shade400.withOpacity(.9),
                        shape: BoxShape.circle,
                      ),
                      width: 16,
                      height: 16,
                      child: CustomText(
                        controller.notifCount > 9
                            ? "9+"
                            : controller.notifCount.toString(),
                        textAlign: TextAlign.center,
                        color: ColorUtils.white,
                        fontSize: 25.sp,
                      ).alignTo(Alignment.center)),
                ),
        )
      ],
    ).onClick(() => Get.toNamed(Routes.DASHBOARD + Routes.NOTIFICATION));
  }

  static Widget sectionHelpWidget(SectionHelpData data) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal:
                ScreenUtil().screenHeight / ScreenUtil().screenWidth < 1.30
                    ? ScreenUtil().screenWidth / 10
                    : 0),
        child: Card(
            color: ColorUtils.white,
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: ColorUtils.white_bg,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60.sp),
                    topRight: Radius.circular(60.sp))),
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              CustomText(
                data.title.toUpperCase(),
                fontSize: 55.sp,
                fontweight: Weight.NORMAL,
                color: ColorUtils.orange,
              ).marginOnly(top: 80.sp, bottom: 10.sp),
              data.description == ''
                  ? Container().marginOnly(bottom: 50.sp)
                  : CustomText(
                      data.description,
                      fontweight: Weight.LIGHT,
                      fontSize: 40.sp,
                      color: '#595856'.hexToColor(),
                    ).marginOnly(bottom: 80.sp),
              Container(
                color: Colors.grey.shade200,
                height: 1,
                width: double.infinity,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, position) {
                  YoutubePlayerController? youtubePlayerController =
                      data.que_ans[position].video_url == null
                          ? null
                          : setVideoController(
                              data.que_ans[position].video_url!.videoId,
                              autoPlay: false);

                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: CustomText(
                            data.que_ans[position].question,
                            style: TextStyle(
                                color: ColorUtils.blackDark,
                                wordSpacing: 0.02,
                                letterSpacing: 0.02,
                                fontSize: 45.sp,
                                fontWeight: FontWeight.w300),
                          ).marginOnly(top: 10.sp, left: 20.sp, right: 20.sp)),
                          Obx(() => data.que_ans[position].isExpanded.value
                              ? Icon(
                                  Icons.remove,
                                  size: 48.sp,
                                  color: ColorUtils.textColor,
                                ).marginOnly(left: 40.sp, right: 20.sp)
                              : Icon(
                                  Icons.add,
                                  size: 48.sp,
                                  color: ColorUtils.textColor,
                                )).marginOnly(left: 40.sp, right: 20.sp),
                        ],
                      ),
                      Obx(() => data.que_ans[position].isExpanded.value &&
                              data.que_ans[position].answer != null &&
                              data.que_ans[position].answer.isNotEmpty
                          ? Align(
                              child: Html(
                                data: data.que_ans[position].answer,
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(42.sp),
                                    color: ColorUtils.textColor,
                                  )
                                },
                              ).marginOnly(bottom: 20.sp),
                            )
                          : Container()),
                      Obx(() => data.que_ans[position].isExpanded.value &&
                              data.que_ans[position].video_url != null &&
                              data.que_ans[position].video_url.isNotEmpty
                          ? Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.sp),
                                    child: YoutubePlayer(
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
                                          handleColor: Colors.amberAccent),
                                      controller: youtubePlayerController!,
                                    ),
                                  ))
                              .paddingOnly(
                                  top: 20.sp,
                                  bottom: 20.sp,
                                  left: 10.sp,
                                  right: 20.sp)
                          : Container()),
                      /*  Obx(() => Container(
                            color: Colors.grey.shade200,
                            height:
                                data.que_ans[position].isExpanded.value ? 1 : 0,
                            width: double.infinity,
                          )),*/
                    ],
                  )
                      .paddingOnly(
                          top: 15.sp, bottom: 15.sp, left: 20.sp, right: 20.sp)
                      .onClick(() {
                    data.que_ans.forEach((element) {
                      if (data.que_ans.indexOf(element) != position) {
                        element.isExpanded.value = false;
                      }
                    });
                    data.que_ans[position].isExpanded.value =
                        !data.que_ans[position].isExpanded.value;
                  });
                },
                shrinkWrap: true,
                itemCount: data.que_ans.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    thickness: 2,
                    color: ColorUtils.lightDivider.withOpacity(.2),
                  );
                },
              ).marginSymmetric(horizontal: 60.sp).paddingOnly(bottom: 100.sp)
            ]))));
  }

  static Widget videoDialog(String videoId,
      {String? description,
      onEnded,
      bool autoPlay = true,
      bool disableTouch = false,
      bool showFullScreen = false}) {
    return UnconstrainedBox(
      child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          width: (Get.width * .95),
          height: ((Get.width * .95) / 16) * 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40.sp),
            child: YoutubePlayer(
              onEnded: onEnded,
              bottomActions: [
                const SizedBox(width: 14.0),
                CurrentPosition(),
                const SizedBox(width: 8.0),
                IgnorePointer(
                  child: ProgressBar(
                    isExpanded: true,
                  ),
                  ignoring: disableTouch,
                ),
                RemainingDuration(),
              ],
              progressColors: ProgressBarColors(
                  playedColor: Colors.amber, handleColor: Colors.amberAccent),
              controller: setVideoController(videoId, autoPlay: autoPlay),
            ),
          )),
    );
  }

  static Widget needHelpButton(int id, {BaseController? controller}) {
    return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60.sp),
                border: Border.all(color: ColorUtils.black)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/images/new_images/profile_image/information.svg',
                  width: 50.sp,
                ),
                CustomText(
                  'NEED HELP?',
                  fontSize: 38.sp,
                ).marginOnly(left: 30.sp)
              ],
            ).marginSymmetric(horizontal: 40.sp, vertical: 20.sp))
        .onClick(() {
      if (controller == null) {
        Get.find<DashboardController>().showSectionInfoById(id);
      } else {
        controller.showSectionInfoById(id);
      }
    });
  }
}

late YoutubePlayerController videoController;

YoutubePlayerController setVideoController(videoID, {bool autoPlay = true}) {
  return YoutubePlayerController(
    initialVideoId: videoID,
    flags: YoutubePlayerFlags(
      autoPlay: autoPlay,
      disableDragSeek: true,
      controlsVisibleAtStart: false,
      mute: false,
    ),
  );
}

enum DialogType { INFO, ALERT, ERROR }
