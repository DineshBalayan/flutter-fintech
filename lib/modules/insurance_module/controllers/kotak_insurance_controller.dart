import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:bank_sathi/Helpers/Constant.dart';
import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/add_lead_arguments.dart';
import 'package:bank_sathi/Model/request/kotal_insurance_nominee_request.dart';
import 'package:bank_sathi/Model/request/lead_personal_info_request.dart';
import 'package:bank_sathi/Model/response/base_response.dart';
import 'package:bank_sathi/Model/response/kotak_member_detail_response.dart';
import 'package:bank_sathi/Model/response/kotak_personal_info_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/db/pincode_helper.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/ButtonState.dart';
import 'package:bank_sathi/widgets/IconedButton.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/date_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class KotakInsuranceLeadController extends BaseController {
  DateWidgetController dobController = DateWidgetController(
    firstDate: DateTime(
            DateTime.now().year - 55, DateTime.now().month, DateTime.now().day)
        .subtract(Duration(days: 1)),
    lastDate: DateTime(
            DateTime.now().year - 22, DateTime.now().month, DateTime.now().day)
        .subtract(Duration(days: 1)),
  );
  final _dobDate = Rxn<DateTime?>();

  DateTime? get dobDate => _dobDate.value;

  set dobDate(val) => _dobDate.value = val;

  DateWidgetController spousedobController = DateWidgetController(
      firstDate: DateTime(DateTime.now().year - 55, DateTime.now().month,
              DateTime.now().day)
          .subtract(Duration(days: 1)),
      lastDate: DateTime(DateTime.now().year - 22, DateTime.now().month,
              DateTime.now().day)
          .subtract(Duration(days: 1)));
  final _spousedobDate = Rxn<DateTime?>();

  DateTime? get spousedobDate => _spousedobDate.value;

  set spousedobDate(val) => _spousedobDate.value = val;

  DateWidgetController childdobController = DateWidgetController(
      firstDate: DateTime(DateTime.now().year - 22, DateTime.now().month,
              DateTime.now().day)
          .subtract(Duration(days: 1)),
      lastDate: DateTime(DateTime.now().year - 10, DateTime.now().month,
              DateTime.now().day)
          .subtract(Duration(days: 1)));
  final _childdobDate = Rxn<DateTime?>();

  DateTime? get childdobDate => _childdobDate.value;

  set childdobDate(val) => _childdobDate.value = val;

  DateWidgetController nomineedobController = DateWidgetController(
      firstDate: DateTime(1950),
      lastDate: DateTime(DateTime.now().year - 18, DateTime.now().month,
              DateTime.now().day)
          .subtract(Duration(days: 1)));
  final _nomineedobDate = Rxn<DateTime?>();

  DateTime? get nomineedobDate => _nomineedobDate.value;

  set nomineedobDate(val) => _nomineedobDate.value = val;

  GlobalKey globalKeyPaint = GlobalKey();

  final _currentStep = 1.obs;

  int get currentStep => _currentStep.value;

  set currentStep(val) => _currentStep.value = val;

  final _spouseCondition = no.tr.obs;

  String get spouseCondition => _spouseCondition.value;

  set spouseCondition(val) => _spouseCondition.value = val;

  final _spouseGender = female.tr.obs;

  String get spouseGender => _spouseGender.value;

  set spouseGender(val) => _spouseGender.value = val;

  final _gender = male.tr.obs;

  String get gender => _gender.value;

  set gender(val) => _gender.value = val;

  final RxInt _addFamilyDetail = 2.obs;

  int get addFamilyDetail => _addFamilyDetail.value;

  set addFamilyDetail(val) => _addFamilyDetail.value = val;

  int? profileId;

  String? leadCode;

  late KotakMemberDetailResponse kotakMemberDetailResponse;

  final _timerSeconds = 0.obs;

  get timerSeconds => _timerSeconds.value;

  set timerSeconds(val) => _timerSeconds.value = val;

  late Timer recurringTask;

  PinCodeHelper pinCodeHelper = PinCodeHelper();

  AddLeadArguments arguments = AddLeadArguments();

  List<String> relationList = [
    "Self",
    "Spouse",
    "Son",
    "Daughter",
    "Mother",
    "Father",
    "Brother",
    "Sister"
  ];

  final _nomineeRelation = "Spouse".obs;

  String get nomineeRelation => _nomineeRelation.value;

  set nomineeRelation(val) => _nomineeRelation.value = val;

  String otpError = '';

  String get remainingMinutes =>
      (timerSeconds ~/ 60).toString().padLeft(2, "0");

  String get remainingSeconds => (timerSeconds % 60).toString().padLeft(2, "0");

  TextEditingController firstNameController = TextEditingController(),
      emailController = TextEditingController(),
      spouseNameController = TextEditingController(),
      currentResidentialAddress = TextEditingController(),
      companyController = TextEditingController();

  final _membersList = <MemberInfo>[].obs;

  List<MemberInfo> get membersList => _membersList.value;

  set membersList(val) => _membersList.value = val;

  final _childList = <ChildInfoServer>[].obs;

  List<ChildInfoServer> get childList => _childList.value;

  set childList(val) => _childList.value = val;

  PageController childInfoPageController = PageController();

  TextEditingController childNameController = TextEditingController();

  TextEditingController nomineeNameController = TextEditingController();

  final globalKey = GlobalKey<FormState>();
  GlobalKey<FormState> childGlobalKey = GlobalKey();
  GlobalKey<FormState> nomineeGlobalKey = GlobalKey();
  GlobalKey<FormState> shareGlobalKey = GlobalKey();
  GlobalKey<FormState> nomineeKey = GlobalKey();

  final _nomineeGender = male.tr.obs;

  get nomineeGender => _nomineeGender.value;

  set nomineeGender(val) => _nomineeGender.value = val;

  final RxBool _childConditionYes = false.obs;

  bool get childCondition => _childConditionYes.value;

  set childCondition(bool val) => _childConditionYes.value = val;

  final RxBool _isSpouse = false.obs;

  bool get isSpouse => _isSpouse.value;

  set isSpouse(bool val) => _isSpouse.value = val;

  final _childGender = male.tr.obs;

  String get childGender => _childGender.value;

  set childGender(val) => _childGender.value = val;

  @override
  void onInit() async {
    super.onInit();
    arguments = Get.arguments;
  }

  @override
  void onReady() async {
    super.onReady();
    if (arguments.kiData.profile != null) {
      firstNameController.text = arguments.kiData.profile.full_name.toString();
      emailController.text = arguments.kiData.profile.email.toString();
      dobDate = arguments.kiData.profile.dob.toString().serverToDateTime();
    }
    if (arguments.kiData.address != null) {
      currentResidentialAddress.text = arguments.kiData.address.address;
      pinCodeHelper.init(pinCodeId: arguments.kiData.address.pincode_id);
    } else {
      pinCodeHelper.init();
    }
    dobController.setInitDate(dobDate);
  }

  @override
  void onClose() {
    pinCodeHelper.dispose();
    super.onClose();
  }

  Future<int> verifyPincode() async {
    if (globalKey.currentState!.validate()) {
      if (await pinCodeHelper.isValidPinCode() == -1) {
        handleError(msg: enter_correct_pin_code.tr);
      } else {
        return await pinCodeHelper.isValidPinCode();
      }
    }
    return 0;
  }

  removeChild(int childPosition) {
    Get.dialog(WidgetUtil.logoutDialog(() => Get.back(), () {
      _membersList.removeAt(childPosition);
      Get.back();
    },
        title: remove.tr,
        button: remove.tr,
        message: 'Are you sure to remove child from list?'));
  }

  void askForAddMembers() async {
    if (globalKey.currentState!.validate() && dobController.validate(true)) {
      if (await pinCodeHelper.isValidPinCode() == -1) {
        Get.snackbar('App Alert !!', enter_correct_pin_code.tr,
            duration: 3.seconds, snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.bottomSheet(
          Container(
              decoration: BoxDecoration(
                color: ColorUtils.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.sp),
                  topRight: Radius.circular(50.sp),
                ),
              ),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          ScreenUtil().screenHeight / ScreenUtil().screenWidth <
                                  1.30
                              ? ScreenUtil().screenWidth / 10
                              : 0),
                  child: Card(
                    color: ColorUtils.white,
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shadowColor: ColorUtils.white_bg,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60.sp),
                            topRight: Radius.circular(60.sp))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 30.sp,
                        ),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Want to '.toUpperCase(),
                                    style: StyleUtils.textStyleNormalPoppins(
                                        color: ColorUtils.textColor,
                                        weight: FontWeight.w600,
                                        fontSize: 50.sp)),
                                TextSpan(
                                    text: 'Add a member?'.toUpperCase(),
                                    style: StyleUtils.textStyleNormalPoppins(
                                        color: ColorUtils.orange_gr_light,
                                        weight: FontWeight.w600,
                                        fontSize: 50.sp)),
                                TextSpan(
                                    text:
                                        '\nWhom you want to cover in this policy.',
                                    style: StyleUtils.textStyleNormalPoppins(
                                        color: ColorUtils.grey,
                                        weight: FontWeight.w300,
                                        fontSize: 40.sp)),
                              ],
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(() => Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.sp),
                                    border: Border.all(
                                        width: 2.sp,
                                        color: addFamilyDetail == 1
                                            ? ColorUtils.orange_gr_light
                                            : ColorUtils.greyshade),
                                    color: ColorUtils.white,
                                  ),
                                  child: CustomText(
                                    'Yes, Want',
                                    color: addFamilyDetail == 1
                                        ? ColorUtils.orange_gr_light
                                        : ColorUtils.greyshade,
                                  ).alignTo(Alignment.center).marginAll(10.sp),
                                ).marginOnly(right: 30.sp).onClick(() {
                                  Get.back();
                                  addFamilyDetail = 1;
                                  addPersonalInfo();
                                }))),
                            Obx(() => Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.sp),
                                    border: Border.all(
                                        width: 2.sp,
                                        color: addFamilyDetail == 0
                                            ? ColorUtils.orange_gr_light
                                            : ColorUtils.greyshade),
                                    color: ColorUtils.white,
                                  ),
                                  child: CustomText(
                                    'No, Don\'t',
                                    color: addFamilyDetail == 0
                                        ? ColorUtils.orange_gr_light
                                        : ColorUtils.greyshade,
                                  ).alignTo(Alignment.center).marginAll(10.sp),
                                )
                                    .marginOnly(left: 30.sp, right: 30.sp)
                                    .onClick(() {
                                  addFamilyDetail = 0;
                                  Get.back();
                                  addPersonalInfo();
                                }))),
                          ],
                        ).marginOnly(top: 70.sp, bottom: 120.sp),
                      ],
                    ).paddingAll(60.sp),
                  )).adjustForTablet()),
          isScrollControlled: true,
        );
      }
    } else {
      Get.snackbar('App Alert !!', 'Fill All Fields Correctly.',
          duration: 2.seconds, snackPosition: SnackPosition.BOTTOM);
    }
  }

  addPersonalInfo() async {
    if (dobController.validate(true)) {
      try {
        pageState = PageStates.PAGE_BUTTON_LOADING;
        LeadPersonalInfoRequest leadPersonalInfoRequest =
            LeadPersonalInfoRequest(
          address: currentResidentialAddress.text,
          address_id: arguments.kiData.address == null
              ? ""
              : arguments.kiData.address.address_id,
          dob: dobController.getServerDate(),
          profile_id: arguments.kiData.profile == null
              ? ""
              : arguments.kiData.profile.profile_id,
          email: emailController.text,
          full_name: firstNameController.text,
          lead_by: getUserId(),
          mobile_no: arguments.mobileNo,
          pincode_id: await pinCodeHelper.isValidPinCode(),
          state_id: pinCodeHelper.selectedState!.id,
          city_id: pinCodeHelper.selectedCity!.id,
          gender: gender.genderForServer,
        );
        restClient
            .kotakHealthPersonalInfo(leadPersonalInfoRequest)
            .then((response) {
          if (response.success) {
            pageState = PageStates.PAGE_IDLE;
            leadCode = response.data.lead_code;
            if (response.data.spouse_name != null &&
                response.data.spouse_name.isNotEmpty) {
              _membersList.add(MemberInfo(
                  pre_existing_health:
                      response.data.spouse_pre_existing_health == "1"
                          ? true
                          : false,
                  gender:
                      response.data.spouse_gender ?? 'Female'.genderFromServer,
                  dob: response.data.spouse_dob,
                  name: response.data.spouse_name,
                  ischild: false));
            }
            if (response.data.child_info != null) {
              childList = response.data.child_info;
              _membersList.addAll(childList
                  .map((e) => MemberInfo(
                      pre_existing_health: e.pre_existing_health,
                      gender: e.child_gender ?? 'Female'.genderFromServer,
                      dob: e.child_dob,
                      name: e.child_name,
                      ischild: true))
                  .toList());
            }

            profileId = response.data.profile_id;
            if (addFamilyDetail == 1) {
              currentStep = 2;
            } else {
              spouseNameController.text = "";
              childList = <ChildInfoServer>[];
              addMemberDetail();
            }
          } else {
            pageState = PageStates.PAGE_IDLE;
          }
        }).catchError((onError) {
          pageState = PageStates.PAGE_IDLE;
        });
      } catch (er) {
        print(er);
        pageState = PageStates.PAGE_IDLE;
      }
      spousedobController.setInitDate(spousedobDate);
      childdobController.setInitDate(childdobDate);
    }
  }

  void addChildwithcontinue() {
    if (isSpouse) {
      if (childNameController.text.isNotEmpty || !spousedobController.isBlank())
        addChild(2);
      else
        addMemberDetail();
    } else {
      if (childNameController.text.isNotEmpty || !childdobController.isBlank())
        addChild(2);
      else
        addMemberDetail();
    }
  }

  void addChild(int condition) {
    if (isSpouse) {
      if (membersList.any((element) => !element.ischild)) {
        handleError(msg: spouse_already_added.tr);
      } else if (childNameController.text.isEmpty) {
        handleError(msg: enter_spouse_name.tr);
      } else {
        if (childGlobalKey.currentState!.validate()) {
          if (spousedobController.validate(true)) {
            if (!childCondition) {
              _membersList.add(MemberInfo(
                  pre_existing_health: childCondition,
                  gender: childGender,
                  dob: spousedobController.getServerDate(),
                  name: childNameController.text,
                  ischild: false));
              childCondition = false;
              childGender = male.tr;
              childNameController.clear();
              childdobDate = null;
              spousedobController.setInitDate(childdobDate);

              if (condition == 2) addMemberDetail();
            } else {
              handleError(msg: cant_add_preexisting_health.tr);
            }
          }
        }
      }
    } else {
      if (membersList.where((c) => c.ischild).toList().length == 3) {
        handleError(msg: cant_add_child.tr);
      } else if (childNameController.text.isEmpty) {
        handleError(msg: enter_child_name.tr);
      } else {
        if (childGlobalKey.currentState!.validate()) {
          if (childdobController.validate(true)) {
            if (!childCondition) {
              _membersList.add(MemberInfo(
                  pre_existing_health: childCondition,
                  gender: childGender,
                  dob: childdobController.getServerDate(),
                  name: childNameController.text,
                  ischild: true));
              childCondition = false;
              childGender = male.tr.genderForServer;
              childNameController.clear();
              childdobDate = null;
              childdobController.setInitDate(childdobDate);

              if (condition == 2) addMemberDetail();
            } else {
              handleError(msg: cant_add_preexisting_health.tr);
            }
          }
        }
      }
    }
  }

  Future<void> addMemberDetail({bool checkBlankMemberList = true}) async {
    if (checkBlankMemberList && currentStep == 2 && membersList.isEmpty) {
      Get.dialog(WidgetUtil.logoutDialog(() => Get.back(), () async {
        await addMemberDetail(checkBlankMemberList: false);
        Get.back();
      },
          title: add_member.tr,
          button: continue_label.tr,
          cancelLabel: add.tr,
          message: continue_without_family.tr));
      return;
    }
    try {
      pageState = PageStates.PAGE_BUTTON_LOADING;
      var listS = membersList.where((c) => !c.ischild).toList();
      var listC = membersList.where((c) => c.ischild).toList();
      childList.clear();
      childList.addAll(listC
          .map((e) => ChildInfoServer(
              pre_existing_health: e.pre_existing_health,
              child_gender: e.gender ?? female.tr.genderForServer,
              child_dob: e.dob,
              child_name: e.name))
          .toList());
      KotakMemberDetail kotakMemberDetail = KotakMemberDetail(
          lead_code: leadCode,
          profile_id: profileId,
          spouse_dob: listS.length != 0 ? listS[0].dob : "",
          spouse_gender:
              listS.length != 0 ? listS[0].gender.genderForServer : "",
          spouse_name: listS.length != 0 ? listS[0].name : '',
          spouse_pre_existing_health: listS.length != 0
              ? listS[0].pre_existing_health
                  ? "0"
                  : ""
              : '',
          child_info: childList);
      kotakMemberDetailResponse =
          await restClient.kotakHealthMemberDetail(kotakMemberDetail);
      if (kotakMemberDetailResponse.success) {
        pageState = PageStates.PAGE_IDLE;
        if (kotakMemberDetailResponse.data.nominee_dob != null) {
          nomineedobDate =
              kotakMemberDetailResponse.data.nominee_dob.serverToDateTime();
          nomineedobController.setInitDate(nomineedobDate);
        }
        nomineeNameController.text =
            kotakMemberDetailResponse.data.nominee_name;

        if (kotakMemberDetailResponse.data.realtion_with_nominee != null &&
            relationList.contains(kotakMemberDetailResponse
                .data.realtion_with_nominee.capitalizeFirst))
          nomineeRelation =
              kotakMemberDetailResponse.data.realtion_with_nominee;

        if (kotakMemberDetailResponse.data.nominee_gender != null)
          nomineeGender =
              kotakMemberDetailResponse.data.nominee_gender.capitalizeFirst;
        currentStep = 3;
      } else
        pageState = PageStates.PAGE_BUTTON_ERROR;
    } catch (e) {
      print(e);
      pageState = PageStates.PAGE_IDLE;
    }

    nomineedobController.setInitDate(nomineedobDate);
    return;
  }

  addNomineeDetail() async {
    if (nomineeKey.currentState!.validate()) {
      if (nomineedobController.validate(true)) {
        pageState = PageStates.PAGE_BUTTON_LOADING;
        KotakInsuranceNomineeRequest kotakInsuranceNomineeRequest =
            KotakInsuranceNomineeRequest(
          insurance_id: kotakMemberDetailResponse.data.insurance_id.toString(),
          nominee_dob: nomineedobController.getServerDate(),
          nominee_gender: nomineeGender,
          nominee_name: nomineeNameController.text,
          realtion_with_nominee: nomineeRelation,
        );
        try {
          BaseResponse baseResponse = await restClient
              .kotakHealthNomineeDetail(kotakInsuranceNomineeRequest);
          pageState = PageStates.PAGE_IDLE;
          if (baseResponse.success) {
            await Get.dialog(insuranceDialog(baseResponse.message),
                barrierDismissible: false);
          } else {
            pageState = PageStates.PAGE_BUTTON_ERROR;
          }
        } catch (e) {
          print(e);
          pageState = PageStates.PAGE_IDLE;
        }
      }
    }
  }

  Widget insuranceDialog(String message) {
    return UnconstrainedBox(
      child: SizedBox(
        width: Get.width * .95,
        child: Card(
            shadowColor: ColorUtils.lightShade,
            elevation: 30.sp,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.sp),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80.sp,
                  height: 80.sp,
                  margin: EdgeInsets.only(right: 30.sp, top: 30.sp),
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: ColorUtils.textColor, width: 1)),
                  child: Icon(
                    Icons.clear,
                    size: 50.sp,
                  ),
                ).onClick(() {
                  Get.back();
                  Get.offNamedUntil(Routes.DASHBOARD + Routes.MY_LEADS,
                      (route) => route.settings.name == Routes.DASHBOARD);
                }).alignTo(Alignment.centerRight),
                RepaintBoundary(
                    key: shareGlobalKey,
                    child: Container(
                      color: ColorUtils.white,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.sp),
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                ColorUtils.grey_blue
                                                    .withAlpha(190),
                                                ColorUtils.grey_blue
                                                    .withAlpha(180),
                                                ColorUtils.grey_blue
                                                    .withAlpha(170),
                                              ]),
                                        ),
                                        height: 160.sp,
                                        width: 180.sp,
                                        child: Image.asset(
                                          'assets/images/new_images/insurance/kotak.png',
                                          width: 120.sp,
                                        ))
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      covid_policy.tr,
                                      color: ColorUtils.orange_gr_dark,
                                    ),
                                    CustomText(
                                        kotakMemberDetailResponse
                                            .data.insurance_name,
                                        color: ColorUtils.greylight,
                                        fontSize: 32.sp),
                                  ],
                                ).marginOnly(left: 30.sp),
                              ],
                            ),
                            Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(40.sp),
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            '#FFFCF7'.hexToColor(),
                                            '#FFFCF7'.hexToColor(),
                                            '#FFFCF7'.hexToColor(),
                                          ]),
                                    ),
                                    child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                          RichText(
                                                  textAlign: TextAlign.start,
                                                  text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: 'CI ' +
                                                                cover.tr
                                                                    .toUpperCase(),
                                                            style: StyleUtils
                                                                .textStyleNormalPoppins(
                                                                    color: ColorUtils
                                                                        .silver,
                                                                    weight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        40.sp)),
                                                        TextSpan(
                                                            text:
                                                                '\n${Constant.RUPEE_SIGN}',
                                                            style: StyleUtils
                                                                .textStyleNormal(
                                                                    color: ColorUtils
                                                                        .black_gr_light,
                                                                    weight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        50.sp)),
                                                        TextSpan(
                                                            text:
                                                                '${kotakMemberDetailResponse.data.sum_assored_amount}',
                                                            style: StyleUtils
                                                                .textStyleNormal(
                                                                    color: ColorUtils
                                                                        .black,
                                                                    weight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        50.sp)),
                                                        TextSpan(
                                                            text:
                                                                '/' + person.tr,
                                                            style: StyleUtils
                                                                .textStyleNormalPoppins(
                                                                    color: ColorUtils
                                                                        .textColor,
                                                                    weight:
                                                                        FontWeight
                                                                            .w300,
                                                                    fontSize:
                                                                        34.sp)),
                                                      ]))
                                              .marginSymmetric(
                                                  horizontal: 40.sp,
                                                  vertical: 20.sp),
                                          RichText(
                                                  textAlign: TextAlign.start,
                                                  text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: 'COVID ' +
                                                                cover.tr
                                                                    .toUpperCase(),
                                                            style: StyleUtils
                                                                .textStyleNormalPoppins(
                                                                    color: ColorUtils
                                                                        .silver,
                                                                    weight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        40.sp)),
                                                        TextSpan(
                                                            text:
                                                                '\n${Constant.RUPEE_SIGN}',
                                                            style: StyleUtils
                                                                .textStyleNormal(
                                                                    color: ColorUtils
                                                                        .black,
                                                                    weight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        50.sp)),
                                                        TextSpan(
                                                            text:
                                                                '${kotakMemberDetailResponse.data.covid_sum_assored_amount}',
                                                            style: StyleUtils
                                                                .textStyleNormal(
                                                                    color: ColorUtils
                                                                        .black,
                                                                    weight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        50.sp)),
                                                        TextSpan(
                                                            text:
                                                                '/' + person.tr,
                                                            style: StyleUtils
                                                                .textStyleNormalPoppins(
                                                                    color: ColorUtils
                                                                        .black,
                                                                    weight:
                                                                        FontWeight
                                                                            .w300,
                                                                    fontSize:
                                                                        34.sp)),
                                                      ]))
                                              .marginSymmetric(
                                                  horizontal: 40.sp,
                                                  vertical: 20.sp),
                                        ])
                                        .marginOnly(top: 30.sp, bottom: 30.sp))
                                .marginOnly(top: 30.sp),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  net_premium.tr + ':',
                                  color: ColorUtils.textColor,
                                  fontweight: FontWeight.w400,
                                ),
                                CustomText(
                                  '${Constant.RUPEE_SIGN}${kotakMemberDetailResponse.data.premium_amount * kotakMemberDetailResponse.data.no_of_person}',
                                  color: ColorUtils.orange,
                                  fontSize: 52.sp,
                                  fontweight: FontWeight.w600,
                                ),
                              ],
                            ).marginOnly(top: 50.sp),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  gst_included.tr,
                                  color: ColorUtils.grey,
                                  fontSize: 30.sp,
                                ),
                                CustomText(
                                  '(${kotakMemberDetailResponse.data.no_of_person} ${person_s.tr})',
                                  color: ColorUtils.grey,
                                  fontSize: 30.sp,
                                ),
                              ],
                            ),
                          ]).marginAll(50.sp),
                    )),
                ProgressButton.icon(
                        radius: 100.sp,
                        maxWidth: 200.0,
                        progressIndicator: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(left: 10, right: 20),
                        iconedButtons: {
                          ButtonState.idle: IconedButton(
                              text: share_payment_link.tr,
                              icon: Icon(
                                Icons.arrow_forward,
                                size: 0,
                                color: ColorUtils.white,
                              ),
                              color: ColorUtils.orange_gr_dark),
                          ButtonState.loading: IconedButton(
                              text: verifying.tr, color: ColorUtils.orange),
                          ButtonState.fail: IconedButton(
                              text: retry.tr,
                              icon: Icon(Icons.arrow_forward,
                                  size: 0, color: Colors.red),
                              color: Colors.red.shade300),
                          ButtonState.success: IconedButton(
                              text: success.tr,
                              icon: Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                              color: Colors.green.shade400)
                        },
                        textStyle: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.white,
                            fontSize: 40.sp,
                            weight: FontWeight.w500),
                        onPressed: () async {
                          final file = await capture();
                          if (file != null)
                            await Share.shareFiles([file.path],
                                text: dear.tr +
                                    firstNameController.text +
                                    '\n\n    ' +
                                    message);
                        },
                        state: pageState.getMatchingButtonState)
                    .marginAll(30.sp)
                    .alignTo(Alignment.center),
                /*WidgetUtil.getOrangeButton(() async {
              final file = await capture();
              if (file != null)
                await Share.shareFiles([file.path],
                    text: 'Dear ' +
                        firstNameController.text +
                        '\n\n    ' +
                        message);
              Get.back();
            }, label: 'Share Payment Link').marginAll(50.sp),*/
              ],
            )),
      ),
    );
  }

  Future<File?> capture(
      {String path = "", Duration delay: const Duration(milliseconds: 20)}) {
    return Future.delayed(delay, () async {
      try {
        RenderRepaintBoundary boundary = this
            .shareGlobalKey
            .currentContext!
            .findRenderObject()! as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage(pixelRatio: Get.pixelRatio);
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();
        if (path == "") {
          final directory = (await getApplicationDocumentsDirectory()).path;
          String fileName = "Card";
          path = '$directory/$fileName.png';
        }
        File imgFile = new File(path);
        await imgFile.writeAsBytes(pngBytes);
        return imgFile;
      } catch (Exception) {
        print(Exception);
        return null;
      }
    });
  }

  String kotakTerms =
      """\n\t\t*A* The Covers shall be applicable after an Initial Waiting Period of 30 days or as mentioned in the Policy Schedule/Certificate of Insurance.
\n\t\t*B* The Insured must have tested positive for COVID-19 as per report from laboratories authorized by Union Health Ministry of India for COVID-19 testing.
\n\t\t*C* The Insured should not have traveled to travel restricted countries against travel advisory whether in force or freshly issued by Government of India at any time during the Policy Period.
\n\t\t*D* The Insured Person(s) should not violate any of the directives issued by the Government of India or any other government authorities with respect to Novel Coronavirus Disease (COVID-19).
\n\t\t*E* Co-habitation: No claim shall be payable where the Insured Person was living with and sharing the same address as that of persons who were Diagnosed with COVID-19 or Quarantined at the time of Proposal.
\n\t\t*F* Pre-existing diseases: Any Pre-existing condition whether declared or not declared is not covered.
\n\t\t*G* There is no survival period applicable for this Policy.
\n\t\t*H* Unauthorized testing center: Testing done at a diagnostic center which is not recognized and authorized by the Union Health Ministry of India shall not be covered under this Policy.
\n\t\t*I* Self-Quarantine/ Self isolation: Self Quarantine/ Self isolation is not covered under the Policy.
\n\t\t*J* *Negative or Inconclusive Reports:* If the test report is negative or if Insured Person is “Patient under investigation” with inconclusive reports, it will not be covered under the Policy.
\n\t\t*K* Claim admissible subject to 24 hrs hospitalization""";
}
