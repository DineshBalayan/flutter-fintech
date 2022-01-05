import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/db/db_controller.dart';
import 'package:bank_sathi/db/pincode_helper.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

typedef void OnSuggestionSelected(PinCodeRow pinCode);

class PincodeSuggestion extends StatefulWidget {
  final focusNode = FocusNode();
  num verticalMargin = 10;
  final bool hideleftspace;
  String? hint;
  String? label;
  final clearButton;
  final iconClick;
  final suffixIcon;
  final double suffixIconSize;
  final prefixIcon;
  final textAlign;
  final double fontsize;
  final double prefixIconSize;
  final TextEditingController? controller;
  final OnSuggestionSelected? onSuggestionSelected;
  FloatingLabelBehavior? floatingLabelBehavior;

  PinCodeHelper pinCodeHelper;

  PincodeSuggestion({
    required this.pinCodeHelper,
    this.floatingLabelBehavior,
    this.textAlign,
    this.hideleftspace = false,
    this.verticalMargin = 5,
    this.label,
    this.hint,
    this.fontsize = 14,
    this.onSuggestionSelected,
    this.suffixIcon = '',
    this.suffixIconSize = 0,
    this.prefixIcon,
    this.prefixIconSize = 4,
    this.clearButton = false,
    this.iconClick,
    this.controller,
  }) : super();

  @override
  _SuggestionWidget createState() => _SuggestionWidget();
}

class _SuggestionWidget extends State<PincodeSuggestion> {
  var hasFocus = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
        focusNode: widget.focusNode,
        onFocusChange: (hasFocus) {
          setState(() {
            this.hasFocus = hasFocus;
          });
        },
        child: TypeAheadFormField<PinCodeRow>(
          autoFlipDirection: true,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return please_enter_pin_code.tr;
            } else if (val.length < 6) {
              return pin_code_should_have_6digits.tr;
            } else
              return null;
          },
          textFieldConfiguration: TextFieldConfiguration(
              style: StyleUtils.textStyleNormalPoppins(
                  color: ColorUtils.textColor, isBold: false,fontSize: widget.fontsize),
              textInputAction: TextInputAction.done,
              controller: widget.pinCodeHelper.pinCodeController,
              maxLength: 6,
              textAlign: widget.textAlign ?? TextAlign.start,
              keyboardType: TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              decoration: InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.only(top:10,bottom: 10),
                  floatingLabelBehavior: widget.floatingLabelBehavior ?? FloatingLabelBehavior.always,
                  hintText: widget.hint ?? enter_pin_code.tr,
                  labelText: widget.label??'',
                  hintStyle: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.greylight),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorUtils.orange)),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorUtils.greylight)),
                  focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorUtils.red)),
                  alignLabelWithHint: true,
                  prefixIconConstraints: widget.prefixIcon == null
                      ? BoxConstraints.tightFor(
                          width: widget.hideleftspace?0:30.sp, height: widget.prefixIconSize)
                      : BoxConstraints.tightFor(
                          width: widget.prefixIconSize + 15,
                          height: widget.prefixIconSize),
                  prefixIcon: widget.prefixIcon == null
                      ? Container()
                      : SvgPicture.asset(
                          widget.prefixIcon,
                          height: widget.prefixIconSize,
                          width: widget.prefixIconSize,
                          fit: BoxFit.scaleDown,
                        ).paddingSymmetric(horizontal: 10),
                  suffixIcon: widget.suffixIcon != null &&
                          widget.suffixIcon is String
                      ? widget.suffixIcon.toString().isEmpty
                          ? widget.clearButton
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (widget.controller != null) {
                                        widget.controller!.clear();
                                      }
                                    });
                                  },
                                  icon: Icon(Icons.clear),
                                )
                              : Container()
                          : widget.suffixIcon.toString().contains(".svg")
                              ? SvgPicture.asset(widget.suffixIcon,
                                      fit: BoxFit.cover)
                                  .onClick(widget.iconClick)
                              : Image.asset(widget.suffixIcon,
                                      fit: BoxFit.scaleDown)
                                  .onClick(widget.iconClick)
                      : widget.suffixIcon != null && widget.suffixIcon is Widget
                          ? widget.suffixIcon
                          : null,
                  suffixIconConstraints: BoxConstraints.tightFor(
                      width: widget.suffixIconSize,
                      height: widget.suffixIconSize),
                  labelStyle: StyleUtils.textStyleNormalPoppins(
                    fontSize: 42.sp,
                    color: hasFocus ? ColorUtils.orange : ColorUtils.greylight,
                  ))),
          suggestionsCallback: widget.pinCodeHelper.getSuggestions,
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: CustomText(suggestion.pincode.toString()),
            );
          },
          onSuggestionSelected: (suggestion) {
            widget.pinCodeHelper.onPinCodeSubmit(suggestion);
            if (widget.onSuggestionSelected != null)
              widget.onSuggestionSelected!(suggestion);
          },
        )
    ).marginSymmetric(vertical: widget.verticalMargin.toDouble());
  }
}
