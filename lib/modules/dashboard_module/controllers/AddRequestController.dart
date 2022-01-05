import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Model/response/support_types.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddRequestController extends BaseController {
  final globalKey = GlobalKey<FormState>();
  CancelToken cancelToken = CancelToken();

  late TextEditingController messageController;

  RxList<SupportType> _types = <SupportType>[].obs;

  List<SupportType> get availableTypes => _types.value;

  set availableTypes(val) => _types = val;

  final _selectedType = SupportType().obs;

  SupportType get selectedType => _selectedType.value;

  set selectedType(val) => _selectedType.value = val;

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  @override
  void onReady() async {
    super.onReady();
    _types.add(SupportType(id: -1, status: '1', title: select_support_type.tr));
    getSupportTypes();
  }

  @override
  void onInit() {
    super.onInit();
    messageController = TextEditingController();
  }

  getSupportTypes() {
    showLoadingDialog();
    restClient.getSupportTypes().then((response) {
      if (response.success) {
        hideDialog();
        selectedType = availableTypes[0];
        availableTypes.addAll(response.types);
        _types.refresh();
      } else {
        handleError(msg: response.message);
      }
    }).catchError((onError) {});
  }
}

Widget successDialog(String requestNumber, String requesttype) {
  return Center(
      child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.sp),
              ),
              color: ColorUtils.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.cancel_presentation_rounded,
                    color: ColorUtils.black,
                    size: 100.sp,
                  ).onClick(() => Get.back()).alignTo(Alignment.topRight),
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
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: support_contact_msg.tr,
                            style: StyleUtils.textStyleNormalPoppins(
                              color: ColorUtils.blackLight,
                              weight: FontWeight.w400,
                            )),
                        TextSpan(
                            text: ' ' + requesttype,
                            style: StyleUtils.textStyleNormalPoppins(
                              color: ColorUtils.darkGreen,
                              weight: FontWeight.w600,
                            ))
                      ],
                    ),
                  ).marginOnly(top: 30.sp, left: 10, right: 10),
                ],
              ).marginAll(40.sp))
          .marginAll(40.sp));
}
