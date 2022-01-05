import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomDropDown<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final String? hint;
  final onChanged;
  final isEnabled;
  final value;
  final bool outlinedBorder;

  num verticalMargin = 10;
  FloatingLabelBehavior? floatingLabelBehavior;

  CustomDropDown(
      {required this.items,
      this.hint,
      this.verticalMargin = 10,
      this.onChanged,
      this.outlinedBorder = false,
      this.floatingLabelBehavior,
      this.isEnabled = true,
      this.value})
      : super();

  @override
  _CustomDropDown createState() => _CustomDropDown<T>();
}

class _CustomDropDown<T> extends State<CustomDropDown> {
  var hasFocus = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
        ignoring: !widget.isEnabled,
        child: Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                this.hasFocus = hasFocus;
              });
            },
            child: DropdownButtonFormField<T>(
              onChanged: widget.onChanged,
              items: (widget.items as List<DropdownMenuItem<T>>),
              value: widget.value,
              decoration: InputDecoration(
                  hintText: widget.hint,
                  floatingLabelBehavior: widget.floatingLabelBehavior ??
                      FloatingLabelBehavior.auto,
                  contentPadding: EdgeInsets.zero,
                  focusedBorder: widget.outlinedBorder
                      ? OutlineInputBorder(
                          borderSide: BorderSide(color: "#caccd1".hexToColor()))
                      : UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorUtils.orange)),
                  border: widget.outlinedBorder
                      ? OutlineInputBorder(
                          borderSide: BorderSide(color: "#caccd1".hexToColor()))
                      : UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorUtils.grey)),
                  focusedErrorBorder: widget.outlinedBorder
                      ? OutlineInputBorder(
                          borderSide: BorderSide(color: ColorUtils.red))
                      : UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorUtils.red)),
                  hintStyle: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.greylight),
                  errorStyle:
                      StyleUtils.textStyleNormalPoppins(color: ColorUtils.red),
                  prefixIconConstraints: BoxConstraints.tightFor(width: 30.sp),
                  prefixIcon: Container(),
                  labelText: widget.hint,
                  alignLabelWithHint: true,
                  labelStyle: StyleUtils.textStyleNormalPoppins(
                      color: hasFocus ? ColorUtils.orange : ColorUtils.grey)),
              isExpanded: true,
            )).marginSymmetric(vertical: widget.verticalMargin.toDouble()));
  }
}
