import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Model/request/save_personal_detail_request.dart';
import 'package:bank_sathi/Model/response/base_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalDetailsController extends BaseController {
  List<String> userTypeList = [individual.tr, non_individual.tr];

  final formGlobalKey = GlobalKey<FormState>();

  TextEditingController dobController = TextEditingController();
  TextEditingController nomineeController = TextEditingController();

  final _userType = individual.tr.obs;

  String get userType => _userType.value;

  set userType(val) => _userType.value = val;

  RxInt _genderSelected = 0.obs;

  final globalKey = GlobalKey<FormState>();

  int get genderSelected => _genderSelected.value;

  set genderSelected(value) => _genderSelected.value = value;

  final RxBool _isCurrentAddress = true.obs;

  bool get isCurrentAddress => _isCurrentAddress.value;

  set isCurrentAddress(val) => _isCurrentAddress.value = val;

  late TextEditingController nomineeNameController,
      nomineeRelationController,
      firmNameController,
      emailController;

  @override
  void onClose() {
    nomineeNameController.dispose();
    nomineeRelationController.dispose();
    firmNameController.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    print(user.dob);
    nomineeNameController = TextEditingController();
    nomineeRelationController = TextEditingController();
    firmNameController = TextEditingController();
    emailController = TextEditingController();
    nomineeNameController.text = user.nominee_name;
    nomineeRelationController.text = user.nominee_relation;

    // dobController.text = user.dob.toString().toDDMMYYYY();
    dobController.text = user.dob == null || user.dob.toString().isEmpty|| user.dob.toString() == '1970-01-01'
        ? ""
        : user.dob.toString().toDDMMYYYY();


    nomineeController.text =
        user.nominee_dob == null || user.nominee_dob.toString().isEmpty || user.nominee_dob.toString() == '1970-01-01'
            ? ""
            : user.nominee_dob.toString().toDDMMYYYY();

    emailController.text = user.email;

    if (user.gender != null) {
      genderSelected = user.gender == 'm'
          ? 0
          : user.gender == "f"
              ? 1
              : 2;
    } else {
      genderSelected = 0;
    }
    print("user.are_you" + user.are_you);

    userType = user.are_you != 'company' ? userTypeList[0] : userTypeList[1];
    firmNameController.text = user.firm_name;
  }

  verify() async {
    if (emailController.text.isNotEmpty &&
        !GetUtils.isEmail(emailController.text)) {
      handleError(msg: 'Please enter valid email address.');
      return;
    }else if (userType != userTypeList[0] && firmNameController.text.isEmpty) {
      handleError(msg: 'Please tell us Firm Name.');
      return;
    }
    savePersonalDetails('person');
  }

  Future<void> savePersonalDetails(String s) async {
    if (s == 'nominee' && formGlobalKey.currentState!.validate()) {
      saveDetails();
    } else if( s == 'person') {
      saveDetails();
    }
  }

    Future<void> saveDetails() async {
      try {
        pageState = PageStates.PAGE_BUTTON_LOADING;
        SavePersonalDetailsRequest savePersonalDetailsRequest =
        SavePersonalDetailsRequest(
            are_you: userType == individual.tr ? 'Solo' : 'Company',
            email: emailController.text,
            // dob: dobController.text.toServerDate(),
            dob:(dobController.text.toServerDate() == null || dobController.text.trim().isEmpty || dobController.text.trim() == '01/01/1970')
                ? ""
                : dobController.text.toServerDate(),
            firm_name:
            userType == individual.tr ? "" : firmNameController.text,
            gender: genderSelected == 0
                ? 'm'
                : genderSelected == 1
                ? 'f'
                : 'o',
            nominee_dob: (nomineeController.text.toServerDate() == null || nomineeController.text.trim().isEmpty || nomineeController.text.trim() == '01/01/1970')
                ? ""
                : nomineeController.text.toServerDate(),
            nominee_name: nomineeNameController.text,
            nominee_relation: nomineeRelationController.text,
            user_id: user.id.toString());
        BaseResponse value =
        await restClient.personalDetails(savePersonalDetailsRequest);
        pageState = PageStates.PAGE_IDLE;
        if (value.success) {
          getUser();
          Get.back();
        } else {
          handleError(msg: value.message);
        }
      } catch (e) {
        print("ERRRRRRRRROR : " + e.toString());
        pageState = PageStates.PAGE_IDLE;
        handleError();
      }
  }



  selectDate(bool isNomineeDOB) async {
    TextEditingController textEditingController =
        isNomineeDOB ? nomineeController : dobController;
    DateTime initDate = textEditingController.text.isEmpty
        ? DateTime.now()
        : textEditingController.text.toDateTime()!;

    DateTime? date = await showDatePicker(
        context: Get.context!,
        initialDate: initDate,
        firstDate: DateTime(1960, 1, 1),
        lastDate: DateTime.now());
    if (date != null) {
      textEditingController.text = date.toServerDate()!.toDDMMYYYY();
    }
  }
}
