import 'package:bank_sathi/Model/request/pan_varify_request.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PanVerificationController extends BaseController {
  final globalKey = GlobalKey<FormState>();

  final _enableReferralCode = true.obs;

  get enableReferralCode => _enableReferralCode.value;

  set enableReferralCode(val) => _enableReferralCode.value = val;

  final RxString _nameOnCard = ''.obs;

  String get nameOnCard => _nameOnCard.value;

  set nameOnCard(val) => _nameOnCard.value = val;

  final RxBool _showCheckIconP = false.obs;

  get showCheckIconP => _showCheckIconP.value;

  set showCheckIconP(val) => _showCheckIconP.value = val;

  final RxBool _showCheckIconR = false.obs;

  get showCheckIconR => _showCheckIconR.value;

  set showCheckIconR(val) => _showCheckIconR.value = val;

  final RxBool _ispanCard = false.obs;

  bool get ispanCard => _ispanCard.value;

  set ispanCard(val) => _ispanCard.value = val;

  bool isVerifying = false;

  final RxBool _isRefferalSubmit = false.obs;

  bool get isRefferalSubmit => _isRefferalSubmit.value;

  set isRefferalSubmit(val) => _isRefferalSubmit.value = val;

  TextEditingController panNumberController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  RxBool _fromKycDetail = false.obs;

  bool get fromKycDetail => _fromKycDetail.value;

  set fromKycDetail(val) => _fromKycDetail.value = val;

  @override
  void onInit() async {
    super.onInit();
    fromKycDetail = Get.parameters["from_kyc_detail"] != null;

    nameOnCard = getUserFullName();
    if (user.pan_no != null && user.pan_no.isNotEmpty) {
      panNumberController.text = MagicMask.buildMask('AAAAA 9999 A')
          .getMaskedString(user.pan_no.toString().toUpperCase());
    }
    showCheckIconP = panNumberController.text.length == 12;
    panNumberController.addListener(() {
      showCheckIconP = panNumberController.text.length == 12;
      /*if (showCheckIconP && !isVerifying) verifyPancard(false);
      if(!showCheckIconP) isVerifying =false;*/
    });
    referralController.addListener(() {
      showCheckIconR = referralController.text.length >= 8;
    });

    initDynamicLinks();
  }

  @override
  void onClose() {
    panNumberController.dispose();
    referralController.dispose();
    super.onClose();
  }

  selectDate(
      BuildContext context, TextEditingController textEditingController) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1970),
      initialDate: textEditingController.text.isNotEmpty &&
              textEditingController.text.toDateTime() != null
          ? textEditingController.text.toDateTime()!
          : DateTime.now(),
      lastDate: DateTime.now(),
    );
    if (picked != null)
      textEditingController.text = picked.toString().toDDMMYYYY();
  }

  initDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (data != null) {
      final Uri deepLink = data.link;
      String? code = deepLink.queryParameters['code'];
      if (!fromKycDetail) referralController.text = code ?? '';
      enableReferralCode = code == null;
      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData? dynamicLink) async {
        final Uri deepLink = dynamicLink!.link;
        print(deepLink.path);
        String code = deepLink.queryParameters['code'] ?? '';
        if (!fromKycDetail) referralController.text = code;
        enableReferralCode = false;
      }, onError: (OnLinkErrorException e) async {
        print('onLinkError');
        print(e.message);
      });
    }
  }

  verifyPancard(bool isreferral) {
    pageState = PageStates.PAGE_BUTTON_LOADING;
    restClient
        .panCardVerify(PanVerifyRequest(
            refferal_code:
                isreferral ? referralController.text : referralController.text,
            pan_no: isreferral
                ? null
                : panNumberController.text.replaceAll(' ', ''),
            user_id: getUserId()))
        .then((value) async {
      if (value.success) {
        getUser().then((value) {
          pageState = PageStates.PAGE_IDLE;
          if (!fromKycDetail) {
            if (!isreferral) {
              ispanCard = true;
              Get.toNamed(Routes.LOGIN + Routes.BANK_DETAIL_VERIFY);
            } else {
              isRefferalSubmit = true;
            }
          } else {
            if (Get.isBottomSheetOpen!) {
              Get.back();
            }
            Get.back();
          }
        });
      } else {
        pageState = PageStates.PAGE_BUTTON_ERROR;
        Get.snackbar('Error', value.message,
            snackPosition: SnackPosition.BOTTOM);
        panNumberController.text = '';
      }
    }).catchError((onError) {
      print(onError);
      panNumberController.text = '';
      pageState = PageStates.PAGE_IDLE;
      getUser();
    });
  }
}
