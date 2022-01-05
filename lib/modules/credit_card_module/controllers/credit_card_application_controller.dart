import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/add_lead_arguments.dart';
import 'package:bank_sathi/Model/request/pan_varify_request.dart';
import 'package:bank_sathi/Model/request/pl_card_eligibility_request.dart';
import 'package:bank_sathi/Model/response/app_pl_profile_response.dart';
import 'package:bank_sathi/Model/response/company_response.dart';
import 'package:bank_sathi/Model/response/get_dropdown_data_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/db/pincode_helper.dart';
import 'package:bank_sathi/mixin/state_city_mixin.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/widgets/ButtonState.dart';
import 'package:bank_sathi/widgets/IconedButton.dart';
import 'package:bank_sathi/widgets/company_suggestion.dart';
import 'package:bank_sathi/widgets/custom_drop_down.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:bank_sathi/widgets/pincode_suggestion.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get/get.dart';

class CreditCardApplicationController extends BaseController
    with StateCityMixin {
  final globalKey = GlobalKey<FormState>();
  final globalKey2 = GlobalKey<FormState>();
  final globalKey3 = GlobalKey<FormState>();
  final globalKey4 = GlobalKey<FormState>();
  final globalKey5 = GlobalKey<FormState>();
  final cardglobalKey = GlobalKey<FormState>();

  final RxString _nameOnCard = ''.obs;

  String get nameOnCard => _nameOnCard.value;

  set nameOnCard(val) => _nameOnCard.value = val;

  final RxString _eligilble_err_title = ''.obs;

  String get eligilble_err_title => _eligilble_err_title.value;

  set eligilble_err_title(val) => _eligilble_err_title.value = val;

  final RxString _eligilble_err_msg = ''.obs;

  String get eligilble_err_msg => _eligilble_err_msg.value;

  set eligilble_err_msg(val) => _eligilble_err_msg.value = val;

  final RxString _err_name = ''.obs;

  String get err_name => _err_name.value;

  set err_name(val) => _err_name.value = val;

  final RxString _pincode = ''.obs;

  String get pincode => _pincode.value;

  set pincode(val) => _pincode.value = val;
  final RxString _opincode = ''.obs;

  String get opincode => _opincode.value;

  set opincode(val) => _opincode.value = val;

  final RxDouble _earning = 10000.0.obs;

  double get earning => _earning.value;

  set earning(val) => _earning.value = val;

  final RxString _cname = ''.obs;

  String get cname => _cname.value;

  set cname(val) => _cname.value = val;

  final RxString _err_name1 = ''.obs;

  String get err_name1 => _err_name1.value;

  set err_name1(val) => _err_name1.value = val;

  final RxBool _ispanCard = false.obs;
  final RxBool _isCardExist = false.obs;
  final RxBool _isSalaried = true.obs;

  bool get isSalaried => _isSalaried.value;

  bool get isCardExist => _isCardExist.value;

  bool get ispanCard => _ispanCard.value;

  set isSalaried(val) => _isSalaried.value = val;

  set isCardExist(val) => _isCardExist.value = val;

  set ispanCard(val) => _ispanCard.value = val;

  final RxInt _current_step = 1.obs;

  int get current_step => _current_step.value;

  set current_step(val) => _current_step.value = val;

  var vintageList = ['00 - 01', '01 - 03', '04 - 06', '07 - 10 or more'];
  final RxString _vintageType = '00 - 01'.obs;

  get vintageType => _vintageType.value;

  set vintageType(val) => _vintageType.value = val;

  TextEditingController panNumberController = TextEditingController();
  TextEditingController monthlySalaryController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController total_limitController = TextEditingController();
  TextEditingController ava_limitController = TextEditingController();

  CompanyData? selectedCompany;
  PinCodeHelper pinCodeHelper = PinCodeHelper();
  PinCodeHelper salariedCodeHelper = PinCodeHelper();

  AddLeadArguments arguments = AddLeadArguments();

  @override
  void onReady() async {
    super.onReady();
    Get.bottomSheet(bottomSheetView(),
        isScrollControlled: true, isDismissible: false, enableDrag: false);
  }

  @override
  void onInit() async {
    super.onInit();
    arguments = await Get.arguments;
    await fetchData();
    monthlySalaryController = TextEditingController.fromValue(
        TextEditingValue(text: earning.toString()));
    if (arguments.cardData.profile_detail != null) {
      panNumberController.text = arguments.cardData.profile_detail.pan_no;
      pinCodeHelper.init(
          pinCodeId: arguments.cardData.profile_detail.pincode_id);
      pincode = pinCodeHelper.pinCodeController.text;
      isSalaried = arguments.cardData.profile_detail.occupation_id == 1;
      isCardExist = arguments.cardData.profile_detail.is_card == '1';
      monthlySalaryController.text =
          arguments.cardData.profile_detail.occupation_id == 1
              ? arguments.cardData.profile_detail.monthly_salary.toInt() < 30000
                  ? 30000.toString()
                  : arguments.cardData.profile_detail.monthly_salary
              : arguments.cardData.profile_detail.itr_amount.toInt() < 30000
                  ? 30000.toString()
                  : arguments.cardData.profile_detail.itr_amount;
      earning = monthlySalaryController.text.toString().toDouble()! < 10000.0
          ? 10000.0
          : monthlySalaryController.text.toString().toDouble();
    }
    if (arguments.cardData.company_detail != null) {
      companyController.text = arguments.cardData.company_detail.name;
      if (companyController.text.isNotEmpty) {
        selectedCompany = CompanyData(
            id: arguments.cardData.company_detail.id,
            company_name: arguments.cardData.company_detail.name);
      }
      salariedCodeHelper.init(
          pinCodeId: arguments.cardData.company_detail.pincode_id);
      opincode = salariedCodeHelper.pinCodeController.text;
    }
    if (arguments.cardData.card_detail != null) {
      ava_limitController.text = arguments.cardData.card_detail.ava_limit;
      total_limitController.text = arguments.cardData.card_detail.total_limit;
      selectedBank = bankList.firstWhere(
          (element) => element.id == arguments.cardData.card_detail.bank_id);
      vintageType = arguments.cardData.card_detail.card_vintage;
    }
  }

  @override
  void onClose() {
    pinCodeHelper.dispose();
    panNumberController.dispose();
    monthlySalaryController.dispose();
    companyController.dispose();
    total_limitController.dispose();
    ava_limitController.dispose();
    try {
      pinCodeHelper.dispose();
      salariedCodeHelper.dispose();
    } catch (_) {}
    super.onClose();
  }

  Widget bottomSheetView() {
    return WillPopScope(
        child: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                  color: ColorUtils.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.sp),
                    topRight: Radius.circular(50.sp),
                  ),
                ),
                child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().screenHeight /
                                        ScreenUtil().screenWidth <
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
                            child: BasePageView(
                                controller: this,
                                idleWidget: Container(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/new_images/back_bottom.svg',
                                          width: 50.sp,
                                          height: 50.sp,
                                          color: ColorUtils.greylight,
                                        ).onClick(() => onwillpop()),
                                        CustomText(
                                          'Apply A Credit Card'.toUpperCase(),
                                          fontSize: 42.sp,
                                          color: ColorUtils.greylight,
                                        ),
                                        Container(
                                          width: 100.sp,
                                        )
                                      ],
                                    ).marginOnly(bottom: 30.sp),
                                    Obx(
                                      () => current_step == 1
                                          ? step1()
                                          : current_step == 2
                                              ? step2()
                                              : current_step == 3
                                                  ? step3()
                                                  : current_step == 4
                                                      ? step4()
                                                      : current_step == 5
                                                          ? step5()
                                                          : current_step == 6
                                                              ? step6()
                                                              : current_step ==
                                                                      7
                                                                  ? step7()
                                                                  : current_step ==
                                                                          8
                                                                      ? step8()
                                                                      : notEligible(),
                                    ),
                                  ],
                                )).marginAll(50.sp))))
                    .adjustForTablet())),
        onWillPop: () async {
          //double back; 1 for bottom sheet
          Get.back();
          Get.back();
          return true;
        });
  }

  verifyPancard() {
    if (globalKey.currentState!.validate()) {
      pageState = PageStates.PAGE_BUTTON_LOADING;
      restClient
          .panCardVerify(PanVerifyRequest(pan_no: panNumberController.text))
          .then((value) async {
        if (value.success) {
          if (value.data.first.pan_status != 'INVALID') {
            ispanCard = true;
            pageState = PageStates.PAGE_IDLE;
            nameOnCard = value.data.first.name_on_card ??
                value.data.first.first_name +
                    " " +
                    (value.data.first.middle_name ?? "") +
                    (value.data.first.middle_name == null ? "" : " ") +
                    value.data.first.last_name;
            current_step++;
          } else {
            pageState = PageStates.PAGE_BUTTON_ERROR;
            err_name = 'PAN number Found INVALID.';
          }
        } else
          pageState = PageStates.PAGE_BUTTON_ERROR;
      }).catchError((onError) {
        pageState = PageStates.PAGE_BUTTON_ERROR;
        err_name = 'Something went wrong.';
      });
    }
  }

  verifyArea() async {
    if (await pinCodeHelper.isValidPinCode() == -1) {
      pageState = PageStates.PAGE_BUTTON_ERROR;
      err_name = enter_correct_pin_code.tr;
    } else {
      pageState = PageStates.PAGE_IDLE;
      pincode = pinCodeHelper.pinCodeController.text;
      current_step++;
    }
  }

  verifyOfficeArea() async {
    if (await salariedCodeHelper.isValidPinCode() == -1) {
      pageState = PageStates.PAGE_BUTTON_ERROR;
      err_name1 = enter_correct_pin_code.tr;
    } else {
      pageState = PageStates.PAGE_IDLE;
      opincode = salariedCodeHelper.pinCodeController.text;
      current_step++;
    }
  }

  verifyCompany() {
    if (globalKey2.currentState!.validate()) {
      cname = companyController.text.toString();
      current_step++;
    }
  }

  verifyCard() {
    if (cardglobalKey.currentState!.validate()) Get.back();
  }

  onwillpop() {
    if (current_step > 1 && current_step < 9) {
      current_step = current_step - 1;
    } else
      Get.back();
  }

  eligibilityApi() async {
    try {
      pageState = PageStates.PAGE_BUTTON_LOADING;
      PL_CardEligibilityRequest req = PL_CardEligibilityRequest(
          full_name: nameOnCard.toString(),
          mobile_no: arguments.mobileNo,
          lead_by: getUserId(),
          pancard: panNumberController.text,
          is_card: isCardExist ? '1' : '0',
          profile_id: arguments.cardData.profile_detail != null
              ? arguments.cardData.profile_detail.profile_id
              : 0,
          occupation_id: isSalaried ? 1 : 2,
          monthly_salary: isSalaried ? monthlySalaryController.text : '',
          company_id: selectedCompany == null
              ? 0
              : selectedCompany!.company_name == companyController.string
                  ? selectedCompany!.id.toString()
                  : 0,
          company_name: companyController.string,
          itr_amount: isSalaried ? '' : monthlySalaryController.text,
          pincode_id: await pinCodeHelper.isValidPinCode(),
          company_pincode_id: await salariedCodeHelper.isValidPinCode(),
          bank_id: isCardExist ? selectedBank!.id : null,
          total_limit: isCardExist ? total_limitController.text : null,
          ava_limit: isCardExist ? ava_limitController.text : null,
          card_vintage: isCardExist ? vintageType : null);

      restClient.checkCardEligibity(req).then((value) {
        pageState = PageStates.PAGE_IDLE;
        if (value.success) {
          LeadIdData dd = LeadIdData(lead_id: value.data.lead_id);
          arguments.leadIdData = dd;
          arguments.cardsresponse = value.data.eleigiblity_card;
          Get.toNamed(Routes.CREDITCARDSLIST, arguments: arguments);
        } else {
          current_step = 10;
          eligilble_err_title = value.message;
          eligilble_err_msg = value.message;
          Get.bottomSheet(bottomSheetView(),
              isScrollControlled: true,
              isDismissible: false,
              enableDrag: false);
        }
      }).catchError((onError) {
        pageState = PageStates.PAGE_IDLE;
        Get.snackbar('SERVER ERROR', 'Something went wrong\n',
            duration: 3.seconds, snackPosition: SnackPosition.BOTTOM);
      });
    } catch (er) {
      print(er);
      pageState = PageStates.PAGE_IDLE;
      Get.snackbar('APP ERROR', 'Something went wrong',
          duration: 3.seconds, snackPosition: SnackPosition.BOTTOM);
    }
  }

  Widget step1() {
    return Container(
      color: Colors.white,
      child: Form(
        key: globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Enter ',
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.textColor,
                            weight: FontWeight.w600,
                            fontSize: 54.sp)),
                    TextSpan(
                        text: 'PAN Number\n',
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.orange_gr_light,
                            weight: FontWeight.w600,
                            fontSize: 54.sp)),
                    TextSpan(
                        text:
                            'Enter the 10 digit PAN Card Number to get\nprofile more stronger.',
                        style: StyleUtils.textStyleNormalPoppins(
                            weight: FontWeight.w500,
                            color: ColorUtils.greylight,
                            fontSize: 40.sp)),
                  ],
                )).marginOnly(top: 30.sp),
            CustomTextField(
              maxLength: 10,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              isRequired: true,
              fontsize: 56.sp,
              hideleftspace: true,
              textAlign: TextAlign.center,
              validator: (String value) {
                Pattern pattern = "[A-Z]{5}[0-9]{4}[A-Z]{1}";
                RegExp regex = new RegExp(pattern.toString());
                if (!regex.hasMatch(value)) {
                  return correct_pan_msg.tr;
                }
                return null;
              },
              controller: panNumberController,
              hint: 'Ex. KHPKU 5487 U',
              textInputAction: TextInputAction.done,
              textCapitalization: true,
            ).marginOnly(
                left: Get.width * .15, right: Get.width * .15, top: 50.sp),
            Obx(
              () => Visibility(
                  visible: pageState == PageStates.PAGE_BUTTON_ERROR,
                  child: CustomText(
                    'Error: ' + err_name,
                    color: ColorUtils.red,
                  ).marginOnly(top: 20.sp)),
            ),
            Obx(() => ProgressButton.icon(
                    radius: 100.sp,
                    progressIndicator: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    iconedButtons: {
                      ButtonState.idle: IconedButton(
                          text: continue_label.tr.toUpperCase(),
                          icon: Icon(
                            Icons.domain_verification,
                            size: 0,
                            color: ColorUtils.orange_gr_light,
                          ),
                          color: ColorUtils.orange_gr_light),
                      ButtonState.loading: IconedButton(
                          text: "Verifying", color: ColorUtils.orange),
                      ButtonState.fail: IconedButton(
                          text: continue_label.tr.toUpperCase(),
                          icon: Icon(Icons.domain_verification,
                              size: 0, color: Colors.white),
                          color: Colors.red.shade300),
                      ButtonState.success: IconedButton(
                          text: "Success",
                          icon: Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          ),
                          color: Colors.green.shade400)
                    },
                    textStyle: StyleUtils.textStyleNormalPoppins(
                        color: ColorUtils.white,
                        fontSize: 50.sp,
                        weight: FontWeight.w400),
                    onPressed: () => verifyPancard(),
                    state: pageState.getMatchingButtonState)
                .marginOnly(top: 60.sp, bottom: 40.sp)),
          ],
        ).marginOnly(right: 30.sp),
      ),
    );
  }

  Widget step2() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'Hello, ',
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.textColor,
                      weight: FontWeight.w600,
                      fontSize: 54.sp)),
              TextSpan(
                  text: nameOnCard + '\n',
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.orange_gr_light,
                      weight: FontWeight.w600,
                      fontSize: 54.sp)),
              TextSpan(
                  text:
                      'Enter current residence area pincode to filter best cards.',
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.greylight,
                      weight: FontWeight.w500,
                      fontSize: 40.sp)),
            ],
          )).marginOnly(left: 40.sp, right: 40.sp, top: 20.sp),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50.sp)),
          boxShadow: [
            BoxShadow(
              color: ColorUtils.greyshade.withOpacity(0.08),
              spreadRadius: 30.sp,
              blurRadius: 70.sp,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            /* CustomText(
              'Residence PinCode :',
              color: ColorUtils.textColorLight,
            ),*/
            PincodeSuggestion(
              pinCodeHelper: pinCodeHelper,
              fontsize: 56.sp,
              hideleftspace: true,
              textAlign: TextAlign.center,
              onSuggestionSelected: (pin) async {
                verifyArea();
              },
            )
          ],
        ).marginOnly(
            left: Get.width * .1, right: Get.width * .1, bottom: 60.sp),
      ).marginOnly(top: 70.sp, bottom: 70.sp),
      Obx(() => Visibility(
          visible: pageState == PageStates.PAGE_BUTTON_ERROR,
          child: CustomText(
            'Error: ' + err_name,
            color: ColorUtils.red,
          ).marginOnly(top: 30.sp, bottom: 30.sp))),
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'Want to do it later? ',
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.textColorLight.withAlpha(210),
                      weight: FontWeight.w500,
                      fontSize: 36.sp)),
              TextSpan(
                  text: 'Cancel Now',
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () => Get.back(),
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.orange_gr_light,
                      weight: FontWeight.w500,
                      fontSize: 36.sp)),
            ],
          )),
    ]);
  }

  Widget step3() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'FILTERING ',
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.orange_gr_light,
                      weight: FontWeight.w600,
                      fontSize: 50.sp)),
              TextSpan(
                  text: 'Best cards for you'.toUpperCase(),
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.textColor,
                      weight: FontWeight.w600,
                      fontSize: 50.sp)),
              TextSpan(
                  text: '\nTill give some answers to get best offers',
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.greylight,
                      weight: FontWeight.w500,
                      fontSize: 40.sp)),
            ],
          )).marginOnly(top: 20.sp),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50.sp)),
          boxShadow: [
            BoxShadow(
              color: ColorUtils.greyshade.withOpacity(0.08),
              spreadRadius: 30.sp,
              blurRadius: 70.sp,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            CustomText(
              'Working as :',
              color: ColorUtils.textColor,
            ).alignTo(Alignment.centerLeft),
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
                            color: isSalaried
                                ? ColorUtils.orange_gr_light
                                : ColorUtils.textColorLight),
                        color: ColorUtils.white,
                      ),
                      child: CustomText(
                        'Salaried',
                        color: isSalaried
                            ? ColorUtils.orange_gr_light
                            : ColorUtils.greyshade,
                      ).alignTo(Alignment.center).marginAll(15.sp),
                    ).marginOnly(right: 20.sp).onClick(() {
                      isSalaried = true;
                      current_step++;
                    }))),
                Obx(() => Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.sp),
                        border: Border.all(
                            width: 2.sp,
                            color: isSalaried
                                ? ColorUtils.greyshade
                                : ColorUtils.orange_gr_light),
                        color: ColorUtils.white,
                      ),
                      child: CustomText(
                        'Non Salaried',
                        color: isSalaried
                            ? ColorUtils.greylight
                            : ColorUtils.orange_gr_light,
                      ).alignTo(Alignment.center).marginAll(15.sp),
                    ).marginOnly(left: 30.sp, right: 30.sp).onClick(() {
                      isSalaried = false;
                      current_step++;
                    }))),
              ],
            ).marginOnly(top: 50.sp),
          ],
        ).marginAll(50.sp),
      ).marginOnly(top: 70.sp, bottom: 70.sp),
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'Want to do it later? ',
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.textColorLight.withAlpha(210),
                      weight: FontWeight.w500,
                      fontSize: 36.sp)),
              TextSpan(
                  text: 'Cancel Now',
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () => Get.back(),
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.orange_gr_light,
                      weight: FontWeight.w500,
                      fontSize: 36.sp)),
            ],
          )),
    ]);
  }

  Widget step4() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'FILTERING ',
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.orange_gr_light,
                      weight: FontWeight.w600,
                      fontSize: 50.sp)),
              TextSpan(
                  text: 'Best cards for you'.toUpperCase(),
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.textColor,
                      weight: FontWeight.w600,
                      fontSize: 50.sp)),
              TextSpan(
                  text: '\nTill give some answers to get best offers',
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.greylight,
                      weight: FontWeight.w500,
                      fontSize: 40.sp)),
            ],
          )).marginOnly(top: 20.sp),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50.sp)),
          boxShadow: [
            BoxShadow(
              color: ColorUtils.greyshade.withOpacity(0.08),
              spreadRadius: 30.sp,
              blurRadius: 70.sp,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            CustomText(
              isSalaried ? 'Monthly Salary :' : 'ITR Amount :',
              color: ColorUtils.textColorLight,
            ).alignTo(Alignment.centerLeft),
            WidgetUtil.getSlider(
              Obx(() => Slider(
                    value: earning.toDouble(),
                    //inactiveColor: Colors.purple,
                    onChanged: (double newValue) {
                      monthlySalaryController.text =
                          newValue.toInt().toString();
                      earning = newValue;
                    },
                    min: 10000.0,
                    max: 500000.0,
                    divisions: 980,
                    semanticFormatterCallback: (value) =>
                        " ${value < 10000 ? 10000.0.toInt().toString() : value.toInt().toString()}",
                    label: earning.toInt().toString(),
                  )),
            ).marginOnly(
              top: 50.sp,
            ),
            CustomTextField(
              keyboardType: TextInputType.number,
              controller: monthlySalaryController,
              fontsize: 54.sp,
              onChanged: (value) {
                earning = value.toString().toDouble()! < 10000.0
                    ? 10000.0
                    : value.toString().toDouble()! > 500000.0
                        ? 500000.0
                        : value.toString().toDouble();
              },
            ),
            Obx(() => ProgressButton.icon(
                    radius: 100.sp,
                    maxWidth: 200.0,
                    progressIndicator: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    iconedButtons: {
                      ButtonState.idle: IconedButton(
                          text: continue_label.tr,
                          icon: Icon(
                            Icons.search_outlined,
                            size: 0,
                            color: ColorUtils.orange_gr_light,
                          ),
                          color: ColorUtils.orange_gr_light),
                      ButtonState.loading: IconedButton(
                          text: "Finding", color: ColorUtils.orange),
                      ButtonState.fail: IconedButton(
                          text: "continue_label",
                          icon: Icon(Icons.domain_verification,
                              color: Colors.white),
                          color: Colors.red.shade300),
                      ButtonState.success: IconedButton(
                          text: "Success",
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
                    onPressed: () {
                      if (earning < 30000) {
                        Get.snackbar(app_alert.tr, 'Min Amount required 30000',
                            duration: 3.seconds,
                            snackPosition: SnackPosition.BOTTOM);
                      } else
                        current_step++;
                    },
                    state: pageState.getMatchingButtonState)
                .alignTo(Alignment.center)
                .marginOnly(top: 30.sp))
          ],
        ).marginAll(50.sp),
      ).marginOnly(top: 60.sp, bottom: 60.sp),
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'Want to do it later? ',
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.textColorLight.withAlpha(210),
                      weight: FontWeight.w500,
                      fontSize: 36.sp)),
              TextSpan(
                  text: 'Cancel Now',
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () => Get.back(),
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.orange_gr_light,
                      weight: FontWeight.w500,
                      fontSize: 36.sp)),
            ],
          )),
    ]);
  }

  Widget step5() {
    return Form(
      key: globalKey2,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: 'FILTERING ',
                    style: StyleUtils.textStyleNormalPoppins(
                        color: ColorUtils.orange_gr_light,
                        weight: FontWeight.w500,
                        fontSize: 52.sp)),
                TextSpan(
                    text: 'Best cards for you'.toUpperCase(),
                    style: StyleUtils.textStyleNormalPoppins(
                        color: ColorUtils.textColor,
                        weight: FontWeight.w500,
                        fontSize: 52.sp)),
                TextSpan(
                    text: '\nTill give some answers to get best offers',
                    style: StyleUtils.textStyleNormalPoppins(
                        color: ColorUtils.greylight,
                        weight: FontWeight.w500,
                        fontSize: 40.sp)),
              ],
            )).marginOnly(top: 20.sp),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(50.sp)),
            boxShadow: [
              BoxShadow(
                color: ColorUtils.greyshade.withOpacity(0.08),
                spreadRadius: 30.sp,
                blurRadius: 70.sp,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              CustomText(
                isSalaried ? 'Company Name :' : 'Business Name :',
                color: ColorUtils.textColorLight,
              ).alignTo(Alignment.centerLeft),
              CompanySuggestion(
                suggestionCallback: (company) {
                  selectedCompany = company;
                },
                textAlign: TextAlign.center,
                hint: isSalaried ? 'Company Name :' : 'Business Name :',
                restClient: restClient,
                textEditingController: companyController,
              ),
              Obx(() => ProgressButton.icon(
                      radius: 100.sp,
                      maxWidth: 200.0,
                      progressIndicator: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      iconedButtons: {
                        ButtonState.idle: IconedButton(
                            text: continue_label.tr,
                            icon: Icon(
                              Icons.search_outlined,
                              size: 0,
                              color: ColorUtils.orange_gr_light,
                            ),
                            color: ColorUtils.orange_gr_light),
                        ButtonState.loading: IconedButton(
                            text: "Finding", color: ColorUtils.orange),
                        ButtonState.fail: IconedButton(
                            text: continue_label.tr,
                            icon: Icon(Icons.domain_verification,
                                color: Colors.white),
                            color: Colors.red.shade300),
                        ButtonState.success: IconedButton(
                            text: "Success",
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
                      onPressed: () {
                        verifyCompany();
                      },
                      state: pageState.getMatchingButtonState)
                  .alignTo(Alignment.center)
                  .marginOnly(top: 30.sp))
            ],
          ).marginAll(50.sp),
        ).marginOnly(top: 70.sp, bottom: 70.sp),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: 'Want to do it later? ',
                    style: StyleUtils.textStyleNormalPoppins(
                        color: ColorUtils.textColorLight.withAlpha(210),
                        weight: FontWeight.w500,
                        fontSize: 36.sp)),
                TextSpan(
                    text: 'Cancel Now',
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () => Get.back(),
                    style: StyleUtils.textStyleNormalPoppins(
                        color: ColorUtils.orange_gr_light,
                        weight: FontWeight.w500,
                        fontSize: 36.sp)),
              ],
            )),
      ]),
    );
  }

  Widget step6() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'FILTERING ',
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.orange_gr_light,
                      weight: FontWeight.w500,
                      fontSize: 52.sp)),
              TextSpan(
                  text: 'Best cards for you'.toUpperCase(),
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.textColor,
                      weight: FontWeight.w500,
                      fontSize: 52.sp)),
              TextSpan(
                  text: '\nTill give some answers to get best offers',
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.greylight,
                      weight: FontWeight.w500,
                      fontSize: 40.sp)),
            ],
          )).marginOnly(top: 20.sp),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50.sp)),
          boxShadow: [
            BoxShadow(
              color: ColorUtils.greyshade.withOpacity(0.08),
              spreadRadius: 30.sp,
              blurRadius: 70.sp,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            PincodeSuggestion(
                pinCodeHelper: salariedCodeHelper,
                fontsize: 56.sp,
                hideleftspace: true,
                textAlign: TextAlign.center,
                hint: 'Office Pincode',
                onSuggestionSelected: (pin) async {
                  verifyOfficeArea();
                })
          ],
        ).marginOnly(
            left: Get.width * .1, right: Get.width * .1, bottom: 60.sp),
      ).marginOnly(top: 70.sp, bottom: 70.sp),
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'Want to do it later? ',
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.textColorLight.withAlpha(210),
                      weight: FontWeight.w500,
                      fontSize: 36.sp)),
              TextSpan(
                  text: 'Cancel Now',
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () => Get.back(),
                  style: StyleUtils.textStyleNormalPoppins(
                      color: ColorUtils.orange_gr_light,
                      weight: FontWeight.w500,
                      fontSize: 36.sp)),
            ],
          )),
    ]);
  }

  Widget step7() {
    return Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'FILTERING ',
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.orange_gr_light,
                            weight: FontWeight.w500,
                            fontSize: 52.sp)),
                    TextSpan(
                        text: 'Best cards for you'.toUpperCase(),
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.textColor,
                            weight: FontWeight.w500,
                            fontSize: 52.sp)),
                    TextSpan(
                        text: '\nTill give some answers to get best offers',
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.greylight,
                            weight: FontWeight.w500,
                            fontSize: 40.sp)),
                  ],
                )).marginOnly(top: 20.sp),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                boxShadow: [
                  BoxShadow(
                    color: ColorUtils.greyshade.withOpacity(0.08),
                    spreadRadius: 30.sp,
                    blurRadius: 70.sp,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  CustomText(
                    'Have existing card? :',
                    color: ColorUtils.textColor,
                  ).alignTo(Alignment.centerLeft),
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
                                  color: isSalaried
                                      ? ColorUtils.orange_gr_light
                                      : ColorUtils.textColorLight),
                              color: ColorUtils.white,
                            ),
                            child: CustomText(
                              'Yes, Have',
                              color: isSalaried
                                  ? ColorUtils.orange_gr_light
                                  : ColorUtils.greyshade,
                            ).alignTo(Alignment.center).marginAll(15.sp),
                          ).marginOnly(right: 20.sp).onClick(() {
                            isCardExist = true;
                            current_step++;
                          }))),
                      Obx(() => Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.sp),
                              border: Border.all(
                                  width: 2.sp,
                                  color: isSalaried
                                      ? ColorUtils.greyshade
                                      : ColorUtils.orange_gr_light),
                              color: ColorUtils.white,
                            ),
                            child: CustomText(
                              'No, Don\'t Have',
                              color: isSalaried
                                  ? ColorUtils.greylight
                                  : ColorUtils.orange_gr_light,
                            ).alignTo(Alignment.center).marginAll(15.sp),
                          ).marginOnly(left: 30.sp, right: 30.sp).onClick(() {
                            isCardExist = false;
                            Get.back();
                          }))),
                    ],
                  ).marginOnly(top: 50.sp),
                ],
              ).marginAll(50.sp),
            ).marginOnly(top: 70.sp, bottom: 70.sp),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Want to do it later? ',
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.textColorLight.withAlpha(210),
                            weight: FontWeight.w500,
                            fontSize: 36.sp)),
                    TextSpan(
                        text: 'Cancel Now',
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => Get.back(),
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.orange_gr_light,
                            weight: FontWeight.w500,
                            fontSize: 36.sp)),
                  ],
                )),
          ],
        ));
  }

  Widget step8() {
    return Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'FILTERING ',
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.orange_gr_light,
                            weight: FontWeight.w500,
                            fontSize: 52.sp)),
                    TextSpan(
                        text: 'Best cards for you'.toUpperCase(),
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.textColor,
                            weight: FontWeight.w500,
                            fontSize: 52.sp)),
                    TextSpan(
                        text: '\nTill give some answers to get best offers',
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.greylight,
                            weight: FontWeight.w500,
                            fontSize: 40.sp)),
                  ],
                )).marginOnly(top: 20.sp),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50.sp)),
                boxShadow: [
                  BoxShadow(
                    color: ColorUtils.greyshade.withOpacity(0.08),
                    spreadRadius: 30.sp,
                    blurRadius: 70.sp,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Form(
                    key: cardglobalKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Details of ',
                                    style: StyleUtils.textStyleNormalPoppins(
                                        color: ColorUtils.textColor,
                                        weight: FontWeight.w600,
                                        fontSize: 44.sp)),
                                TextSpan(
                                    text: 'Highest Limit ',
                                    style: StyleUtils.textStyleNormalPoppins(
                                        color: ColorUtils.orange_gr_light,
                                        weight: FontWeight.w600,
                                        fontSize: 46.sp)),
                                TextSpan(
                                    text: 'Credit card.',
                                    style: StyleUtils.textStyleNormalPoppins(
                                        color: ColorUtils.textColor,
                                        weight: FontWeight.w600,
                                        fontSize: 44.sp)),
                              ],
                            )).alignTo(Alignment.topLeft),
                        Obx(
                          () => CustomDropDown(
                              hint: select_bank.tr,
                              verticalMargin: 30.sp,
                              value: selectedBank,
                              items: bankList
                                  .map((e) => DropdownMenuItem<Bank>(
                                        child: CustomText(e.bank_title),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                selectedBank = val;
                              }),
                        ),
                        CustomText(
                          'Available card limit :',
                          color: ColorUtils.textColorLight,
                        ).alignTo(Alignment.topLeft).marginOnly(top: 30.sp),
                        CustomTextField(
                          isRequired: true,
                          controller: ava_limitController,
                          textField: available_limit.tr,
                          fontsize: 44.sp,
                          keyboardType: TextInputType.number,
                        ),
                        CustomText(
                          'Total card limit :',
                          color: ColorUtils.textColorLight,
                        ).alignTo(Alignment.topLeft).marginOnly(top: 30.sp),
                        CustomTextField(
                          isRequired: true,
                          controller: total_limitController,
                          textField: limit.tr,
                          fontsize: 44.sp,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                        ),
                        Row(children: [
                          CustomText(
                            'Card Vintage : ',
                            color: ColorUtils.textColorLight,
                          ),
                          CustomText(
                            '(in years)',
                            fontSize: 30.sp,
                            color: ColorUtils.greylight,
                          )
                        ]).alignTo(Alignment.topLeft).marginOnly(top: 30.sp),
                        Obx(() => Wrap(
                              alignment: WrapAlignment.start,
                              children: vintageList
                                  .map(
                                    (e) => ActionChip(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: vintageType == e
                                                  ? ColorUtils.orange
                                                  : ColorUtils.greylight,
                                              width: 3.sp),
                                          borderRadius:
                                              BorderRadius.circular(60.sp)),
                                      label: CustomText(
                                        e,
                                        fontSize: 38.sp,
                                        color: vintageType == e
                                            ? ColorUtils.orange
                                            : ColorUtils.greylight,
                                      ),
                                      backgroundColor: ColorUtils.white,
                                      labelPadding: EdgeInsets.symmetric(
                                          horizontal: 30.sp),
                                      onPressed: () => vintageType = e,
                                    ).marginSymmetric(
                                      horizontal: 30.sp,
                                    ),
                                  )
                                  .toList(),
                            )),
                      ],
                    ),
                  ),
                  Obx(() => ProgressButton.icon(
                          radius: 100.sp,
                          maxWidth: 250.0,
                          progressIndicator: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          iconedButtons: {
                            ButtonState.idle: IconedButton(
                                text: 'SAVE',
                                icon: Icon(
                                  Icons.search_outlined,
                                  size: 0,
                                  color: ColorUtils.orange_gr_light,
                                ),
                                color: ColorUtils.orange_gr_light),
                            ButtonState.loading: IconedButton(
                                text: "Finding", color: ColorUtils.orange),
                            ButtonState.fail: IconedButton(
                                text: "SAVE",
                                icon: Icon(Icons.domain_verification,
                                    size: 0, color: Colors.white),
                                color: Colors.red.shade300),
                            ButtonState.success: IconedButton(
                                text: "Success",
                                icon: Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                ),
                                color: Colors.green.shade400)
                          },
                          textStyle: StyleUtils.textStyleNormalPoppins(
                              color: ColorUtils.white,
                              fontSize: 56.sp,
                              weight: FontWeight.w500),
                          onPressed: () => verifyCard(),
                          state: pageState.getMatchingButtonState)
                      .alignTo(Alignment.center)
                      .marginOnly(
                        top: isCardExist ? 50.sp : 150.sp,
                      )),
                ],
              ).marginAll(50.sp),
            ).marginOnly(top: 70.sp, bottom: 70.sp),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Want to do it later? ',
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.textColorLight.withAlpha(210),
                            weight: FontWeight.w500,
                            fontSize: 36.sp)),
                    TextSpan(
                        text: 'Cancel Now',
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => Get.back(),
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.orange_gr_light,
                            weight: FontWeight.w500,
                            fontSize: 36.sp)),
                  ],
                )),
          ],
        ));
  }

  Widget notEligible() {
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/new_images/error_card.png',
            ),
            Obx(() => RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'OOPS,\n',
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.orange_gr_light,
                            weight: FontWeight.w600,
                            fontSize: 54.sp)),
                    TextSpan(
                        text: eligilble_err_title.toString().toUpperCase(),
                        style: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.textColor,
                            weight: FontWeight.w600,
                            fontSize: 48.sp)),
                  ],
                ))).marginOnly(top: 30.sp),
            Obx(() => CustomText(
                  eligilble_err_msg,
                  fontSize: 40.sp,
                  color: ColorUtils.grey,
                ).marginOnly(top: 40.sp)),
            SizedBox(
                width: Get.width * 0.6,
                child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80)),
                        color: ColorUtils.orange_gr_light,
                        child: CustomText(
                          'Return to DashBoard',
                          fontSize: 48.sp,
                          color: ColorUtils.white,
                        ).marginOnly(top: 100.sp))
                    .onClick(() => Get.offAllNamed(Routes.DASHBOARD)))
          ],
        ).marginAll(50.sp));
  }

//*********************************************************//
}
