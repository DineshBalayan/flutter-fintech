import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/services.dart';

class CustomTextInputMask extends TextInputFormatter {
  dynamic mask;
  String placeholder;
  bool reverse;
  int maxLength;
  int maxPlaceHolders;
  late MagicMask magicMask;

  CustomTextInputMask(
      {this.mask,
      this.reverse = false,
      this.maxLength = -1,
      this.placeholder = '',
      this.maxPlaceHolders = -1}) {
    magicMask = MagicMask.buildMask(mask);
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    try {
      String newString =
          MagicMask.buildMask(mask).getMaskedString(newValue.text);
      final int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } catch (e) {
      print(e);
    }
    return newValue;
  }
}
