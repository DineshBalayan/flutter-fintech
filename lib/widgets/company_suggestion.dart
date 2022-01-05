import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Model/response/company_response.dart';
import 'package:bank_sathi/network/rest_client.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class CompanySuggestion extends StatefulWidget {
  late TextEditingController textEditingController;
  late final suggestionCallback;
  late final RestClient restClient;
  final String? label;
  final String? hint;
  final textAlign;

  CompanySuggestion(
      {required this.restClient,
      required this.textEditingController,
      required this.suggestionCallback,
      this.label,
      this.textAlign,
      this.hint})
      : super();

  @override
  _SuggestionWidget createState() => _SuggestionWidget();
}

class _SuggestionWidget extends State<CompanySuggestion> {
  var hasFocus = false;
  CancelToken cancelToken = CancelToken();

  Future<List<CompanyData>> fetchSuggestion(String? pattern) async {
    if (pattern == null || pattern.isEmpty || pattern.length <= 2) {
      return <CompanyData>[];
    }

    if (!cancelToken.isCancelled) {
      print("Request cancelled");
      cancelToken.cancel();
      cancelToken = CancelToken();
    }

    try {
      final _result = await widget.restClient
          .searchCompanies(pattern, cancelToken: cancelToken);
      List<CompanyData> list = _result.data.cast<CompanyData>();
      return list.isEmpty ? <CompanyData>[] : list;
    } catch (e) {
      print(e);
      return <CompanyData>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            this.hasFocus = hasFocus;
          });
        },
        child: TypeAheadFormField<CompanyData>(
          autoFlipDirection: true,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return please_enter_company_name.tr;
            } else
              return null;
          },
          textFieldConfiguration: TextFieldConfiguration(
              style: StyleUtils.textStyleNormalPoppins(
                  color: ColorUtils.textColor, isBold: false),
              textInputAction: TextInputAction.done,
              textAlign: widget.textAlign ?? TextAlign.start,
              controller: widget.textEditingController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.only(top: 5.sp),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: widget.hint==null?'':widget.hint.toString(),
                  hintStyle: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.greylight),
                  prefixIconConstraints: BoxConstraints.tightFor(
                      width: 30.sp, height: 30.sp),
                  prefixIcon: Container().paddingSymmetric(horizontal: 10),

                  labelText: widget.label == null
                      ? ''
                      : widget.label.toString(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorUtils.orange),
                  ),
                  alignLabelWithHint: true,
                  labelStyle: StyleUtils.textStyleNormalPoppins(
                    fontSize: 42.sp,
                    color: hasFocus ? ColorUtils.orange : ColorUtils.grey,
                  ))),
          suggestionsCallback: (pattern) async {
            return fetchSuggestion(pattern);
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: CustomText(suggestion.company_name.toString()),
            );
          },
          onSuggestionSelected: (suggestion) {
            if (widget.suggestionCallback != null) {
              widget.suggestionCallback(suggestion);
            }
            widget.textEditingController.text =
                suggestion.company_name.toString();
            print(suggestion.company_name.toString());
          },
        )).marginOnly(top: 10, bottom: 10);
  }
}
