import 'package:bank_sathi/base/base_controller.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

class KYCController extends BaseController {
  final RxBool _showCheckIconAadhar = false.obs;

  get showCheckIconAadhar => _showCheckIconAadhar.value;

  set showCheckIconAadhar(val) => _showCheckIconAadhar.value = val;

  final RxBool _showCheckIconPan = false.obs;

  bool get showCheckIconPan => _showCheckIconPan.value;

  set showCheckIconPan(val) => _showCheckIconPan.value = val;

  TextEditingController aadharNumberController = TextEditingController(),
      panController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    if (user.adhar_no != null && user.adhar_no.isNotEmpty) {
      aadharNumberController.text =
          MagicMask.buildMask('9999 9999 9999').getMaskedString(user.adhar_no);
    }

    if (user.pan_no != null && user.pan_no.isNotEmpty) {
      panController.text = MagicMask.buildMask('AAAAA 9999 A')
          .getMaskedString(user.pan_no.toString().toUpperCase());
    }

    if (user.is_adhar_verified == "1") {
      showCheckIconAadhar = true;
    }

    if (user.is_pan_verified == "1") {
      showCheckIconPan = true;
    }
  }

  @override
  void onUserChange() {
    super.onUserChange();
    if (user.adhar_no != null && user.adhar_no.isNotEmpty) {
      aadharNumberController.text =
          MagicMask.buildMask('9999 9999 9999').getMaskedString(user.adhar_no);
    }

    if (user.pan_no != null && user.pan_no.isNotEmpty) {
      panController.text = MagicMask.buildMask('AAAAA 9999 A')
          .getMaskedString(user.pan_no.toString().toUpperCase());
    }

    if (user.is_adhar_verified == "1") {
      showCheckIconAadhar = true;
    }

    if (user.is_pan_verified == "1") {
      showCheckIconPan = true;
    }
  }
}
