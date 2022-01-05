import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

typedef OnChanged = Function(String? value);

class CustomTextField extends StatefulWidget {
  final bool previousOnBackSpace;
  final bool hideleftspace;
  final textField;
  final TextInputType keyboardType;
  final maxLength;
  final textAlignVertical;
  final suffixIcon;
  final double suffixIconSize;
  final prefixIcon;
  final double prefixIconSize;
  final validator;
  final String hint;
  final String? prefixText;
  List<TextInputFormatter>? inputFormatter;
  final clearButton;
  final double fontsize;
  final TextEditingController? controller;
  final bool isRequired;
  final bool textCapitalization;
  final bool autoFocus;
  final TextInputAction textInputAction;
  final isEnabled;
  final iconClick;
  final isDense;
  final OnChanged? onChanged;
  final minLines;
  final textAlign;
  num verticalMargin = 10;
  final bool hideUnderLine;
  final bool outlinedBorder;
  final FloatingLabelBehavior? floatingLabelBehavior;
  TextStyle? textStyle;
  final FocusNode focusNode = FocusNode();
  final onFocusChange;

  CustomTextField({
    this.textField,
    this.autoFocus = false,
    this.textStyle,
    this.textAlign,
    this.previousOnBackSpace = false,
    this.hint = '',
    this.hideleftspace = false,
    this.verticalMargin = 8,
    this.fontsize = 14,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.inputFormatter,
    this.validator,
    this.controller,
    this.isRequired = false,
    this.outlinedBorder = false,
    this.textCapitalization = false,
    this.textInputAction = TextInputAction.next,
    this.isEnabled = true,
    this.onChanged,
    this.clearButton = false,
    this.iconClick,
    this.suffixIcon = '',
    this.suffixIconSize = 0,
    this.prefixIcon,
    this.prefixIconSize = 24,
    this.minLines = 1,
    this.hideUnderLine = false,
    this.floatingLabelBehavior,
    this.prefixText,
    this.onFocusChange,
    this.textAlignVertical = TextAlignVertical.top,
    this.isDense = false,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  var hasFocus = false;

  @override
  void initState() {
    super.initState();
    if (widget.keyboardType == TextInputType.number) {
      if (widget.inputFormatter == null) {
        widget.inputFormatter = [
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          FilteringTextInputFormatter.deny(RegExp("[a-zA-Z.!#@%&'*+-/,=?^_`{|<>}~;:]")),
        ];
      } else {
        widget.inputFormatter!
            .add(FilteringTextInputFormatter.allow(RegExp('[0-9]')),);
      }
    }else if (widget.keyboardType == TextInputType.name) {
      widget.inputFormatter = [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
        FilteringTextInputFormatter.deny(RegExp("[0-9.!#@%&'*+-/,=?^_`{|<>}~;:]")), ];
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: widget.focusNode,
      onFocusChange: (hasFocus) {
        setState(() {
          this.hasFocus = hasFocus;
        });
        if (widget.onFocusChange != null) widget.onFocusChange(hasFocus);
      },
      child: TextFormField(
          autofocus: widget.autoFocus,
          enabled: widget.isEnabled,
          scrollPadding: EdgeInsets.zero,
          minLines: widget.minLines,
          autocorrect: false,
          textAlign: widget.textAlign ?? TextAlign.start,
          maxLines: 10,
          textCapitalization: widget.textCapitalization
              ? TextCapitalization.characters
              : TextCapitalization.words,
          maxLength: widget.maxLength,
          onFieldSubmitted: (_) {
            if (widget.textInputAction == TextInputAction.next)
              context.nextEditableTextFocus();
            else if (widget.textInputAction == TextInputAction.done)
              context.hideKeyboard();
          },
          inputFormatters: widget.inputFormatter,
          textInputAction: widget.textInputAction,
          style: widget.textStyle ??
              StyleUtils.textStyleNormalPoppins(
                  color: ColorUtils.textColor,
                  isBold: false,
                  fontSize: widget.fontsize),
          validator: widget.validator == null
              ? (String? value) {
                  String? errorMsg;
                  if (value!.isEmpty && widget.isRequired) {
                    errorMsg = 'Please Enter ${widget.textField ?? 'Input'}';
                  } else if (widget.keyboardType == TextInputType.phone &&
                      value.isNotEmpty &&
                      value.length < 10) {
                    errorMsg = 'Please Enter Correct Phone Number';
                  } else if (widget.keyboardType ==
                          TextInputType.emailAddress &&
                      value.isNotEmpty &&
                      !GetUtils.isEmail(value)) {
                    errorMsg = 'Please Enter Correct Email Address';
                    Fluttertoast.showToast(msg: errorMsg);
                  } else if (widget.keyboardType == TextInputType.datetime &&
                      value.isNotEmpty) {
                    final components = value.split("/");
                    if (components.length == 3) {
                      final day = int.tryParse(components[0]);
                      final month = int.tryParse(components[1]);
                      final year = int.tryParse(components[2]);
                      if (day != null && month != null && year != null) {
                        final date = DateTime(year, month, day);
                        if (date.year == year &&
                            date.month == month &&
                            date.day == day) {
                          return null;
                        } else
                          errorMsg = "Please Enter Correct Date ";
                      }
                    }
                    errorMsg = "Please Enter Correct Date ";
                  }
                  if (errorMsg == null &&
                      FocusScope.of(context).canRequestFocus) {
                    FocusScope.of(context).requestFocus(widget.focusNode);
                  }
                  return errorMsg;
                }
              : widget.validator,
          controller: widget.controller,
          onChanged: (string) {
            if (widget.maxLength != null &&
                int.parse(widget.maxLength.toString()) == string.length) {
              if (widget.textInputAction == TextInputAction.next)
                context.nextEditableTextFocus();
              else
                context.hideKeyboard();
            }
            if (widget.onChanged != null) widget.onChanged!(string);
          },
          textAlignVertical: widget.textAlignVertical,
          decoration: InputDecoration(
              hintText: widget.hint,
              prefixText: widget.prefixText,
              isDense: widget.isDense,
              prefixStyle: widget.textStyle,
              floatingLabelBehavior:
                  widget.floatingLabelBehavior ?? FloatingLabelBehavior.auto,
              contentPadding: EdgeInsets.only(top: 8.sp),
              counterText: '',
              focusedBorder: widget.hideUnderLine
                  ? InputBorder.none
                  : widget.outlinedBorder ? OutlineInputBorder(
                  borderSide: BorderSide(color: "#caccd1".hexToColor(),width: 0.6)): UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorUtils.orange)),
              border: widget.hideUnderLine
                  ? InputBorder.none
                  :  widget.outlinedBorder ? OutlineInputBorder(
                  borderSide: BorderSide(color: "#caccd1".hexToColor(),width: 0.6)): UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorUtils.greylight)),
              enabledBorder: widget.hideUnderLine
                  ? InputBorder.none
                  :  widget.outlinedBorder ? OutlineInputBorder(
                  borderSide: BorderSide(color: "#caccd1".hexToColor(),width: 0.6)): UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorUtils.greylight)),
              disabledBorder: widget.hideUnderLine
                  ? InputBorder.none
                  :  widget.outlinedBorder ? OutlineInputBorder(
                  borderSide: BorderSide(color: "#caccd1".hexToColor(),width: 0.6)): UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorUtils.greylight)),
              focusedErrorBorder: widget.hideUnderLine
                  ? InputBorder.none
                  : OutlineInputBorder(
                      borderSide: BorderSide(color: ColorUtils.red)),
              errorBorder:  widget.hideUnderLine
                  ? InputBorder.none
                  : OutlineInputBorder(
                  borderSide: BorderSide(color: ColorUtils.red)),
              hintStyle: StyleUtils.textStyleNormalPoppins(
                  color: ColorUtils.greylight, fontSize: widget.fontsize),
              errorStyle:
                  StyleUtils.textStyleNormalPoppins(color: Colors.transparent, fontSize: 1.sp)
                      .copyWith(height: 0.0),
              prefixIconConstraints: widget.prefixIcon == null
                  ? BoxConstraints.tightFor(
                      width: widget.hideleftspace ? 0 : 30.sp,
                      height: widget.prefixIconSize)
                  : BoxConstraints.tightFor(
                      width: widget.prefixIconSize + 15,
                      height: widget.prefixIconSize),
              prefixIcon: widget.prefixIcon == null
                  ? Container()
                  : widget.prefixIcon is Widget
                      ? widget.prefixIcon
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
                                  if (widget.controller != null &&
                                      widget.isEnabled) {
                                    widget.controller!.clear();
                                  }
                                });
                              },
                              icon: Icon(Icons.clear),
                            )
                          : Container()
                      : widget.suffixIcon.toString().contains(".svg")
                          ? SvgPicture.asset(widget.suffixIcon, fit: BoxFit.cover)
                              .onClick(widget.iconClick)
                          : Image.asset(widget.suffixIcon, fit: BoxFit.scaleDown)
                              .onClick(widget.iconClick)
                  : widget.suffixIcon != null && widget.suffixIcon is Widget
                      ? widget.suffixIcon
                      : null,
              suffixIconConstraints: BoxConstraints.tightFor(
                  width: widget.suffixIconSize, height: widget.suffixIconSize),
              labelText: widget.textField,
              alignLabelWithHint: true,
              labelStyle: widget.textStyle != null
                  ? widget.textStyle!.copyWith(
                      color: hasFocus ? ColorUtils.orange : ColorUtils.greylight)
                  : StyleUtils.textStyleNormalPoppins(color: hasFocus ? ColorUtils.orange : ColorUtils.greylight)),
          keyboardType: widget.textCapitalization ? TextInputType.text : widget.keyboardType),
    ).marginSymmetric(vertical: widget.verticalMargin.toDouble());
  }
}



class CustomRangeTextInputFormatter extends TextInputFormatter {
  final min, max;

  CustomRangeTextInputFormatter(this.min, this.max);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '')
      return TextEditingValue();
    else if (int.parse(newValue.text) < min)
      return TextEditingValue().copyWith(text: min.toString());

    return int.parse(newValue.text) > max
        ? TextEditingValue().copyWith(text: max.toString())
        : newValue;
  }
}
