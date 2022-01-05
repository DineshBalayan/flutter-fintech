import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Model/add_lead_arguments.dart';
import 'package:bank_sathi/Model/request/pan_varify_request.dart';
import 'package:bank_sathi/Model/request/pl_card_eligibility_request.dart';
import 'package:bank_sathi/Model/response/company_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/db/pincode_helper.dart';
import 'package:bank_sathi/mixin/state_city_mixin.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/widgets/ButtonState.dart';
import 'package:bank_sathi/widgets/IconedButton.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:bank_sathi/widgets/date_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PersonalLoanLeadController extends BaseController with StateCityMixin {
  final globalKey = GlobalKey<FormState>();
  final globalKey2 = GlobalKey<FormState>();
  final globalKey3 = GlobalKey<FormState>();
  final globalKey4 = GlobalKey<FormState>();

  final RxBool _ispanCard = false.obs;

  bool get ispanCard => _ispanCard.value;

  set ispanCard(val) => _ispanCard.value = val;

  final RxString _nameOnCard = ''.obs;

  String get nameOnCard => _nameOnCard.value;

  set nameOnCard(val) => _nameOnCard.value = val;
  final RxString _dob = ''.obs;

  String get dob => _dob.value;

  set dob(val) => _dob.value = val;

  final _currentStep = 1.obs;

  int get currentStep => _currentStep.value;

  set currentStep(val) => _currentStep.value = val;

  TextEditingController monthlySalaryController = TextEditingController();

  var jobVintages = ['00 - 01', '01 - 03', '04 - 06', '07 - 10 or more'];
  final RxString _selected_vintage = '00 - 01'.obs;

  String get selected_vintage => _selected_vintage.value;

  set selected_vintage(val) => _selected_vintage.value = val;

  final _dobDate = Rxn<DateTime?>();

  // DateTime? get dobDate => _dobDate.value;
  // set dobDate(val) => _dobDate.value = val;
  // DateWidgetController dobController = DateWidgetController();

  final RxString _dateofBirth = 'dd/mm/yyyy'.obs;

  String get dateofBirth => _dateofBirth.value;

  set dateofBirth(val) => _dateofBirth.value = val;

  final RxDouble _earning = 10000.0.obs;

  double get earning => _earning.value;

  set earning(val) => _earning.value = val;

  final RxString _err_name = ''.obs;

  String get err_name => _err_name.value;

  set err_name(val) => _err_name.value = val;

  final RxInt _isLoanExist = 2.obs;

  int get isLoanExist => _isLoanExist.value;

  set isLoanExist(val) => _isLoanExist.value = val;

  final RxBool _showCheckIconP = false.obs;
  get showCheckIconP => _showCheckIconP.value;
  set showCheckIconP(val) => _showCheckIconP.value = val;

  final RxBool _showCheckIconD = false.obs;
  get showCheckIconD => _showCheckIconD.value;
  set showCheckIconD(val) => _showCheckIconD.value = val;
  bool isVerifying = false;
  late AddLeadArguments arguments;

  TextEditingController designationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController officeemailController = TextEditingController();
  TextEditingController addressContoller = TextEditingController();
  TextEditingController panNumberController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController remainingLoanController = TextEditingController();
  TextEditingController monthEmiController = TextEditingController();

  CompanyData? selectedCompany;
  PinCodeHelper pinCodeHelper = PinCodeHelper();
  PinCodeHelper ofcPincodeHelper = PinCodeHelper();

  @override
  void onReady() async {
    super.onReady();
    openPanCardView();

    monthlySalaryController = TextEditingController.fromValue(
        TextEditingValue(text: earning.toString()));

    if (arguments.plData.profile_detail != null) {
      nameOnCard = arguments.plData.profile_detail.full_name;
      dob = arguments.plData.profile_detail.dob.toString().toDDMMYYYY();
      dobController.text =
          arguments.plData.profile_detail.dob.toString().toDDMMYYYY();
      emailController.text = arguments.plData.profile_detail.email;
      pinCodeHelper.init(pinCodeId: arguments.plData.profile_detail.pincode_id);
      panNumberController.text = arguments.plData.profile_detail.pan_no;
    }

    if (arguments.plData.company_detail != null) {
      monthlySalaryController.text =
          arguments.plData.company_detail.monthly_salary.toInt() < 30000
              ? 30000.toString()
              : arguments.plData.company_detail.monthly_salary;
      companyController.text = arguments.plData.company_detail.name;
      designationController.text = arguments.plData.company_detail.designation;
      officeemailController.text = arguments.plData.company_detail.office_email;
      if (companyController.text.isNotEmpty) {
        selectedCompany = CompanyData(
            id: arguments.plData.company_detail.id,
            company_name: arguments.plData.company_detail.name);
      }
      selected_vintage = arguments.plData.company_detail.job_vintage;
      ofcPincodeHelper.init(
          pinCodeId: arguments.plData.company_detail.pincode_id);
    }

    if (arguments.plData.is_loan_detail != null) {
      monthEmiController.text = arguments.plData.is_loan_detail.monthly_emi;
      remainingLoanController.text =
          arguments.plData.is_loan_detail.total_rem_loan;
    }

    // dobController.setInitDate(dobDate);
  }

  @override
  void onInit() async {
    super.onInit();
    arguments = Get.arguments;
    panNumberController.addListener(() {
      showCheckIconP = panNumberController.text.length == 10;
      if (showCheckIconP && !isVerifying) verifyPan();
      if(!showCheckIconP) isVerifying =false;
    });
    dobController.addListener(() {
      showCheckIconD = dobController.text.length == 8;
    });
  }

  @override
  void onClose() {
    designationController.dispose();
    emailController.dispose();
    officeemailController.dispose();
    addressContoller.dispose();
    pinCodeHelper.dispose();
    dobController.dispose();
    panNumberController.dispose();
    companyController.dispose();
    remainingLoanController.dispose();
    monthEmiController.dispose();
    try {
      pinCodeHelper.dispose();
      ofcPincodeHelper.dispose();
    } catch (_) {}
    super.onClose();
  }

  void openPanCardView() {
    Get.bottomSheet(PanCardView(),
        isScrollControlled: true, isDismissible: false, enableDrag: false);
  }

  Widget PanCardView() {
    return WillPopScope(
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
                    child: BasePageView(
                      controller: this,
                      idleWidget: Form(
                        key: globalKey2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Enter ',
                                        style:
                                            StyleUtils.textStyleNormalPoppins(
                                                color: ColorUtils.textColor,
                                                weight: FontWeight.w600,
                                                fontSize: 58.sp)),
                                    TextSpan(
                                        text: 'PAN Number\n',
                                        style:
                                            StyleUtils.textStyleNormalPoppins(
                                                color:
                                                    ColorUtils.orange_gr_light,
                                                weight: FontWeight.w600,
                                                fontSize: 58.sp)),
                                    TextSpan(
                                        text:
                                            'We will use this to collect your details for making the process more easier.',
                                        style:
                                            StyleUtils.textStyleNormalPoppins(
                                                color: ColorUtils.grey,
                                                weight: FontWeight.w300,
                                                fontSize: 40.sp)),
                                  ],
                                )).alignTo(Alignment.topLeft),
                            Stack(
                              children: [
                                Image.asset('assets/images/cards/pan_bg.png'),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      'Verify pan Details'.toUpperCase(),
                                      color: '#884C5E'.hexToColor(),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 55,
                                            child: CustomText(
                                              'pan number'.toUpperCase(),
                                              color: '#7A85AF'.hexToColor(),
                                              fontSize: 30.sp,
                                            )),
                                        Expanded(
                                          flex: 45,
                                          child: CustomText(
                                            'Date of Birth'.toUpperCase(),
                                            color: '#7A85AF'.hexToColor(),
                                            fontSize: 30.sp,
                                          ),
                                        )
                                      ],
                                    ).marginOnly(top: 40.sp),
                                    LayoutBuilder(
                                      builder: (BuildContext context,
                                          BoxConstraints constraints) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp),
                                                  color:
                                                      '#F4F4F4'.hexToColor()),
                                              width: constraints.maxWidth * .47,
                                              child: Center(
                                                child: Obx(() =>
                                                    CustomTextField(
                                                      controller: panNumberController,
                                                      verticalMargin: 0,
                                                      hideUnderLine: true,
                                                      maxLength: 10,
                                                      // inputFormatter: [
                                                      //   MaskTextInputFormatter(
                                                      //       mask: "##### #### #")
                                                      // ],
                                                      suffixIconSize: showCheckIconP
                                                          ? 50.sp:0,
                                                      suffixIcon:
                                                          SvgPicture.asset(
                                                        'assets/images/ic_check.svg',
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                                      validator:
                                                          (String value) {
                                                        Pattern pattern =
                                                            "[A-Z]{5}[0-9]{4}[A-Z]{1}";
                                                        RegExp regex =
                                                            new RegExp(pattern
                                                                .toString());
                                                        if (!regex.hasMatch(value
                                                            .toUpperCase())) {
                                                          return correct_pan_msg
                                                              .tr;
                                                        }
                                                        return null;
                                                      },
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      hint: 'Ex. KHPKU 5487 U',
                                                      textCapitalization: true,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      textStyle: StyleUtils
                                                          .textStyleNormalPoppins(
                                                              fontSize: 40.sp),
                                                    ).marginOnly(right: 10.sp)),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp),
                                                  color:
                                                      '#F4F4F4'.hexToColor()),
                                              width: constraints.maxWidth * .47,
                                              child: Obx(() => CustomTextField(
                                                    controller: dobController,
                                                    verticalMargin: 0,
                                                    hideUnderLine: true,
                                                    keyboardType:
                                                        TextInputType.datetime,
                                                    hint: "31/12/2020",
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .never,
                                                    isRequired: true,
                                                suffixIconSize: showCheckIconD
                                                    ? 50.sp
                                                    : 0.sp,
                                                    suffixIcon:
                                                        SvgPicture.asset(
                                                      'assets/images/ic_check.svg',
                                                      fit: BoxFit.scaleDown,
                                                    ),
                                                    textStyle: StyleUtils
                                                        .textStyleNormalPoppins(
                                                            fontSize: 40.sp),
                                                    inputFormatter: [
                                                      MaskTextInputFormatter(
                                                          mask: "##/##/####")
                                                    ],
                                                  ).marginOnly(right: 10.sp)),
                                            ).onClick(() => _selectDate(context, dobController)),
                                          ],
                                        );
                                      },
                                    ).marginOnly(top: 10.sp),
                                    CustomText(
                                      'Name As on PANCARD'.toUpperCase(),
                                      color: '#7A85AF'.hexToColor(),
                                      fontSize: 30.sp,
                                    ).marginOnly(top: 40.sp),
                                    Obx(() => CustomText(
                                          nameOnCard,
                                          fontSize: 50.sp,
                                        )),
                                  ],
                                ).marginAll(30.sp)
                              ],
                              /* CustomTextField(
                              maxLength: 10,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              isRequired: true,
                              fontsize: 56.sp,
                              textAlign: TextAlign.center,
                              validator: (String value) {
                                Pattern pattern = "[A-Z]{5}[0-9]{4}[A-Z]{1}";
                                RegExp regex = new RegExp(pattern.toString());
                                if (!regex.hasMatch(value.toUpperCase())) {
                                  return correct_pan_msg.tr;
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.done,
                              controller: panNumberController,
                              hint: 'Ex. KHPKU 5487 U',
                              textCapitalization: true,
                            )*/
                            ).marginOnly(top: 50.sp),
                           Obx(() => CustomText(
                              err_name,
                              color: ColorUtils.red,
                              fontSize: 30.sp,
                            ).marginOnly(top: 10.sp).visibility(err_name.isNotEmpty)),
                            Obx(() => ProgressButton.icon(
                                    radius: 100.sp,
                                    progressIndicator:
                                        CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                    iconedButtons: {
                                      ButtonState.idle: IconedButton(
                                          text: verify.tr,
                                          icon: Icon(
                                            Icons.domain_verification,
                                            size: 0,
                                            color: ColorUtils.orange_gr_light,
                                          ),
                                          color: ColorUtils.orange_gr_light),
                                      ButtonState.loading: IconedButton(
                                          text: "Verifying",
                                          color: ColorUtils.orange_gr_light),
                                      ButtonState.fail: IconedButton(
                                          text: "Verify Again",
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
                                    textStyle:
                                        StyleUtils.textStyleNormalPoppins(
                                            color: ColorUtils.white,
                                            fontSize: 50.sp,
                                            weight: FontWeight.w500),
                                    onPressed: () => verifyPancard(),
                                    state: pageState.getMatchingButtonState)
                                .marginOnly(top: 60.sp, bottom: 40.sp)),
                          ],
                        ).paddingAll(60.sp),
                      ),
                    ))).adjustForTablet()),
        onWillPop: () async {
          Get.back();
          Get.back();
          return true;
        });
  }

  verifyPan() {
    isVerifying=true;
    restClient
        .panCardVerify(PanVerifyRequest(pan_no: panNumberController.text))
        .then((value) async {
      if (!value.success || value.data.first.pan_status != 'INVALID') {
        ispanCard = true;
        pageState = PageStates.PAGE_IDLE;
        nameOnCard = value.data.first.name_on_card ??
            value.data.first.first_name +
                " " +
                (value.data.first.middle_name ?? "") +
                (value.data.first.middle_name == null ? "" : " ") +
                value.data.first.last_name;
      } else {
        err_name = 'PAN number found INVALID.';
      }
    }).catchError((onError) {
      err_name = 'Something went wrong.';
    });
  }

  verifyPancard() {
    if (panNumberController.text.isNotEmpty && dobController.text.isNotEmpty) {
      pageState = PageStates.PAGE_BUTTON_LOADING;
      restClient.panCardVerify(PanVerifyRequest(pan_no: panNumberController.text))
          .then((value) async {
        if (!value.success || value.data.first.pan_status != 'INVALID') {
          ispanCard = true;
          pageState = PageStates.PAGE_IDLE;
          nameOnCard = value.data.first.name_on_card ??
              value.data.first.first_name +
                  " " +
                  (value.data.first.middle_name ?? "") +
                  (value.data.first.middle_name == null ? "" : " ") +
                  value.data.first.last_name;
          Get.back();
        } else {
          pageState = PageStates.PAGE_BUTTON_ERROR;
          err_name = 'PAN number found INVALID.';
        }
      }).catchError((onError) {
        pageState = PageStates.PAGE_BUTTON_ERROR;
        err_name = 'Something went wrong.';
      });
    }else err_name  = 'Cant submit Empty value';
  }

  _selectDate(BuildContext context, TextEditingController textEditingController) async {
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

  void openIsLoanView() {
    Get.bottomSheet(
      isLoanView(),
      isScrollControlled: true,
    );
  }

  Widget isLoanView() {
    return Container(
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
                    ScreenUtil().screenHeight / ScreenUtil().screenWidth < 1.30
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
                  idleWidget: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 30.sp,
                      ),
                      Obx(() => RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Have Any '.toUpperCase(),
                                      style: StyleUtils.textStyleNormalPoppins(
                                          color: ColorUtils.textColor,
                                          weight: FontWeight.w600,
                                          fontSize: 50.sp)),
                                  TextSpan(
                                      text: 'Existing Loan?'.toUpperCase(),
                                      style: StyleUtils.textStyleNormalPoppins(
                                          color: ColorUtils.orange_gr_light,
                                          weight: FontWeight.w600,
                                          fontSize: 50.sp)),
                                  TextSpan(
                                      text:
                                          '\nIf yes you also have to provide details about the amount and EMI in next step.',
                                      style: StyleUtils.textStyleNormalPoppins(
                                          color: ColorUtils.grey,
                                          weight: FontWeight.w300,
                                          fontSize: 40.sp)),
                                ],
                              ))
                          .alignTo(Alignment.topLeft)
                          .visibility(isLoanExist != 1)),
                      Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Obx(() => Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(50.sp),
                                      border: Border.all(
                                          width: 2.sp,
                                          color: isLoanExist == 1
                                              ? ColorUtils.orange_gr_light
                                              : ColorUtils.textColorLight),
                                      color: ColorUtils.white,
                                    ),
                                    child: CustomText(
                                      'Yes, Have',
                                      color: isLoanExist == 1
                                          ? ColorUtils.orange_gr_light
                                          : ColorUtils.greyshade,
                                    )
                                        .alignTo(Alignment.center)
                                        .marginAll(10.sp),
                                  )
                                      .marginOnly(right: 30.sp)
                                      .onClick(() => isLoanExist = 1))),
                              Obx(() => Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(50.sp),
                                      border: Border.all(
                                          width: 2.sp,
                                          color: isLoanExist == 0
                                              ? ColorUtils.orange_gr_light
                                              : ColorUtils.greyshade),
                                      color: ColorUtils.white,
                                    ),
                                    child: CustomText(
                                      'No, Don\'t',
                                      color: isLoanExist == 0
                                          ? ColorUtils.orange_gr_light
                                          : ColorUtils.greylight,
                                    )
                                        .alignTo(Alignment.center)
                                        .marginAll(10.sp),
                                  )
                                      .marginOnly(left: 30.sp, right: 30.sp)
                                      .onClick(() {
                                    isLoanExist = 0;
                                    Get.back();
                                    currentStep = 2;
                                  }))),
                            ],
                          )
                              .marginOnly(top: 70.sp, bottom: 120.sp)
                              .visibility(isLoanExist != 1)),
                      Obx(() => Column(
                            children: [
                              RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Please submit '.toUpperCase(),
                                          style:
                                              StyleUtils.textStyleNormalPoppins(
                                                  color: ColorUtils.textColor,
                                                  weight: FontWeight.w600,
                                                  fontSize: 50.sp)),
                                      TextSpan(
                                          text: 'Existing Loan details'
                                              .toUpperCase(),
                                          style:
                                              StyleUtils.textStyleNormalPoppins(
                                                  color: ColorUtils
                                                      .orange_gr_light,
                                                  weight: FontWeight.w600,
                                                  fontSize: 50.sp)),
                                      TextSpan(
                                          text:
                                              '\nPlease Don\'t fill wrong information, given info will be verified by PAN Card.',
                                          style:
                                              StyleUtils.textStyleNormalPoppins(
                                                  color: ColorUtils.grey,
                                                  weight: FontWeight.w300,
                                                  fontSize: 40.sp)),
                                    ],
                                  )).alignTo(Alignment.topLeft),
                              Form(
                                  key: globalKey3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.sp)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorUtils.greyshade
                                              .withOpacity(0.08),
                                          spreadRadius: 30.sp,
                                          blurRadius: 70.sp,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        CustomTextField(
                                          isRequired: true,
                                          controller: remainingLoanController,
                                          textField: 'Remaining Loan Amount',
                                          fontsize: 44.sp,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.number,
                                        ),
                                        CustomTextField(
                                          isRequired: true,
                                          controller: monthEmiController,
                                          textField: 'Total Monthly EMI',
                                          fontsize: 44.sp,
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.number,
                                        ),
                                      ],
                                    ).marginAll(30.sp),
                                  ).marginOnly(top: 50.sp)),
                              ProgressButton.icon(
                                      radius: 100.sp,
                                      progressIndicator:
                                          CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                      iconedButtons: {
                                        ButtonState.idle: IconedButton(
                                            text: continue_label.tr,
                                            icon: Icon(
                                              Icons.navigate_next,
                                              size: 0,
                                              color: ColorUtils.orange_gr_light,
                                            ),
                                            color: ColorUtils.textColorLight),
                                        ButtonState.loading: IconedButton(
                                            text: "Verifying",
                                            color: ColorUtils.orange),
                                        ButtonState.fail: IconedButton(
                                            text: continue_label.tr,
                                            icon: Icon(
                                                Icons.domain_verification,
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
                                      textStyle:
                                          StyleUtils.textStyleNormalPoppins(
                                              color: ColorUtils.white,
                                              fontSize: 50.sp,
                                              weight: FontWeight.w500),
                                      onPressed: () {
                                        if (globalKey3.currentState!
                                            .validate()) {
                                          if (remainingLoanController.text
                                                  .toInt() >=
                                              monthEmiController.text.toInt()) {
                                            Get.back();
                                            currentStep = 2;
                                          } else
                                            Get.snackbar(app_alert.tr,
                                                'Entered Amount Details are Wrong!!',
                                                duration: 3.seconds,
                                                snackPosition:
                                                    SnackPosition.BOTTOM);
                                        }
                                      },
                                      state: pageState.getMatchingButtonState)
                                  .marginOnly(top: 60.sp, bottom: 40.sp)
                            ],
                          ).visibility(isLoanExist == 1)),
                    ],
                  ).paddingAll(60.sp),
                ))).adjustForTablet());
  }

  onwillpop() {
    if (currentStep > 1) {
      currentStep = currentStep - 1;
    } else
      Get.back();
  }

  checkPersonalInfo() async {
    if (globalKey.currentState!.validate()) {
      if (await pinCodeHelper.isValidPinCode() != -1)
        openIsLoanView();
      else
        Get.snackbar('PinCode Error', 'PinCode not Existing',
            snackPosition: SnackPosition.BOTTOM);
    }
  }

  checkIncomeInfo() async {
    if (globalKey4.currentState!.validate()) {
      if (await pinCodeHelper.isValidPinCode() != -1)
        savePLDetailsApi();
      else
        Get.snackbar('PinCode Error', 'PinCode not Existing');
    }
  }

  savePLDetailsApi() async {
    try {
      pageState = PageStates.PAGE_BUTTON_LOADING;
      PL_CardEligibilityRequest req = PL_CardEligibilityRequest(
          full_name: nameOnCard.toString(),
          mobile_no: arguments.mobileNo,
          lead_by: getUserId(),
          pancard: panNumberController.text,
          is_loan: isLoanExist == 1 ? '1' : '0',
          profile_id: arguments.plData.profile_detail != null
              ? arguments.plData.profile_detail.profile_id
              : 0,
          monthly_salary: monthlySalaryController.text,
          company_vintage: selected_vintage.toString(),
          company_id: selectedCompany == null
              ? 0
              : selectedCompany!.company_name == companyController.string
                  ? selectedCompany!.id.toString()
                  : 0,
          company_name: companyController.string,
          pincode_id: await pinCodeHelper.isValidPinCode(),
          company_pincode_id: await ofcPincodeHelper.isValidPinCode(),
          address: addressContoller.text,
          degination: designationController.text,
          total_rem_loan: remainingLoanController.text,
          monthly_emi: monthEmiController.text,
          email: emailController.text,
          office_email: officeemailController.text);

      restClient.addPLDetail(req).then((value) {
        pageState = PageStates.PAGE_IDLE;
        if (value.success) {
          // LeadIdData dd = LeadIdData(lead_id: value.data.lead_id);
          // arguments.leadIdData = dd;
          currentStep = currentStep++;
          Get.snackbar('APP MESSAGE', value.message + '\n',
              backgroundColor: ColorUtils.orange,
              duration: 1.seconds,
              snackPosition: SnackPosition.BOTTOM);
          Get.offNamedUntil(Routes.DASHBOARD + Routes.MY_LEADS,
              (route) => route.settings.name == Routes.DASHBOARD);
        } else {
          pageState = PageStates.PAGE_IDLE;
        }
      }).catchError((onError) {
        pageState = PageStates.PAGE_IDLE;
      });
    } catch (er) {
      pageState = PageStates.PAGE_IDLE;
      print(er);
    }
  }

//*********************************************************//
}
