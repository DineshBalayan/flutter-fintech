import 'package:bank_sathi/Model/request/save_professional_detail_request.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/mixin/state_city_mixin.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

class ProfessionalDetailsController extends BaseController with StateCityMixin {
  TextEditingController totalIncome = TextEditingController();

  RxString _monthExperience = "0".obs;

  String get monthExperience => _monthExperience.value;

  set monthExperience(val) => _monthExperience.value = val;

  RxString _yearExperience = "1".obs;

  String get yearExperience => _yearExperience.value;

  set yearExperience(val) => _yearExperience.value = val;

  final RxString _haveOfficeSpace = yes.tr.obs;

  String get haveOfficeSpace => _haveOfficeSpace.value;

  set haveOfficeSpace(val) => _haveOfficeSpace.value = val;

  final _haveLicense = yes.tr.obs;

  get haveLicense => _haveLicense.value;

  set haveLicense(val) => _haveLicense.value = val;

  final RxList<String> selectedProducts = <String>[].obs;

  onProductTileClick(String value) {
    if (selectedProducts.contains(value)) {
      selectedProducts.remove(value);
    } else {
      selectedProducts.add(value);
    }
  }

  GlobalKey<FormState> globalKey = GlobalKey();

  @override
  void onClose() {
    totalIncome.dispose();
    super.onClose();
  }

  @override
  void onReady() async {
    super.onReady();
    await fetchData();
    haveOfficeSpace = user.office_space == 'y' ? yes.tr : no.tr;

    haveLicense = user.pos_licence == 'y' ? yes.tr : no.tr;

    if (user.pos_income_id != null) {
      selectedPos =
          posList.firstWhere((element) => element.id == user.pos_income_id);
    } else {
      selectedPos = posList[0];
    }

    totalIncome.text = user.total_bus_anum;

    yearExperience =
        user.total_fn_yr != null ? user.total_fn_yr.toString() : null;

    monthExperience =
        user.total_fn_month != null ? user.total_fn_month.toString() : null;

    if (finProducts != null) {
      selectedProducts
          .addAll(finProducts.map((e) => e.fin_product_id.toString()).toList());
    }
  }

  void saveProfessionalDetail() async {
    if (globalKey.currentState!.validate()) {
      pageState = PageStates.PAGE_BUTTON_LOADING;
      user = prefManager.getUserData();
      ProfessionalDetailRequest professionalDetailRequest =
          ProfessionalDetailRequest();
      professionalDetailRequest.did_sell = selectedProducts;
      professionalDetailRequest.office_space =
          haveOfficeSpace == yes.tr ? 'y' : 'n';
      professionalDetailRequest.pos_income_id = selectedPos.id.toString();
      professionalDetailRequest.pos_licence = haveLicense == yes.tr ? 'y' : 'n';
      professionalDetailRequest.total_bus_anum = totalIncome.text;
      professionalDetailRequest.total_fn_month = monthExperience;
      professionalDetailRequest.total_fn_yr = yearExperience;
      professionalDetailRequest.user_id = user.id.toString();
      restClient
          .proDetails(
              user_id: user.id.toString(),
              office_space: professionalDetailRequest.office_space,
              pos_income_id: professionalDetailRequest.pos_income_id,
              total_bus_anum: professionalDetailRequest.total_bus_anum,
              pos_licence: professionalDetailRequest.pos_licence,
              total_fn_month: professionalDetailRequest.total_fn_month,
              did_sell: selectedProducts.toString().replaceAll(" ", ""),
              total_fn_yr: professionalDetailRequest.total_fn_yr)
          .then((value) {
        pageState = PageStates.PAGE_IDLE;
        if (value.success) {
          getUser();
          Get.back();
        } else {
          handleError(msg: value.message);
        }
      }).catchError((onError) {
        pageState = PageStates.PAGE_IDLE;
      });
    }
  }
}
