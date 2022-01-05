import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Model/add_lead_arguments.dart';
import 'package:bank_sathi/Model/request/pl_card_eligibility_request.dart';
import 'package:bank_sathi/Model/request/pan_varify_request.dart';
import 'package:bank_sathi/Model/response/app_pl_profile_response.dart';
import 'package:bank_sathi/Model/response/company_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/db/pincode_helper.dart';
import 'package:bank_sathi/mixin/state_city_mixin.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get/get.dart';

class CreditCardLeadController extends BaseController with StateCityMixin {
  final globalKey = GlobalKey<FormState>();
  final globalKey2 = GlobalKey<FormState>();
  final globalKey3 = GlobalKey<FormState>();
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

  late AddLeadArguments arguments;

  List<String> vintageList = [
    'Less Then 1 Year',
    '1 Year',
    '2 Years',
    '3 Years',
    'More Then 3 Years'
  ];

  final _vintageType = 'Less Then 1 Year'.obs;
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

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onInit() async{
    super.onInit();
    await fetchData();
    arguments = Get.arguments;
    if(arguments.cardData.profile_detail!=null){
      panNumberController.text = arguments.cardData.profile_detail.pan_no;
      pinCodeHelper.init(pinCodeId: arguments.cardData.profile_detail.pincode_id);
      isSalaried = arguments.cardData.profile_detail.occupation_id==1;
      isCardExist = arguments.cardData.profile_detail.is_card=='1';
      monthlySalaryController.text = arguments.cardData.profile_detail.occupation_id==1
          ?arguments.cardData.profile_detail.monthly_salary
          :arguments.cardData.profile_detail.itr_amount;
    }
    if(arguments.cardData.company_detail!=null){
      companyController.text = arguments.cardData.company_detail.name;
      if (companyController.text.isNotEmpty) {
        selectedCompany = CompanyData(id: arguments.cardData.company_detail.id, company_name: arguments.cardData.company_detail.name);
      }
      salariedCodeHelper.init(pinCodeId: arguments.cardData.company_detail.pincode_id);
    }
    if(arguments.cardData.card_detail!=null){
      ava_limitController.text = arguments.cardData.card_detail.ava_limit;
      total_limitController.text = arguments.cardData.card_detail.total_limit;
      selectedBank = bankList.firstWhere((element) => element.id == arguments.cardData.card_detail.bank_id);
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
            nameOnCard = value.data.first.name_on_card;
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
    if (globalKey.currentState!.validate()) {
      if (await pinCodeHelper.isValidPinCode() == -1) {
        pageState = PageStates.PAGE_BUTTON_ERROR;
        err_name = enter_correct_pin_code.tr;
      } else {
        pageState = PageStates.PAGE_IDLE;
        current_step++;
      }
    }
  }

  verifyOfficeArea() async {
    if (globalKey3.currentState!.validate()) {
      if (await salariedCodeHelper.isValidPinCode() == -1) {
        pageState = PageStates.PAGE_BUTTON_ERROR;
        err_name1 = enter_correct_pin_code.tr;
      } else {
        pageState = PageStates.PAGE_IDLE;
        current_step++;
      }
    }
  }

  verifySalary() {
    if (globalKey2.currentState!.validate()) {
      current_step++;
    }
  }

  onwillpop() {
    if (current_step > 1 && current_step<5) {
      current_step = current_step - 1;
    } else
      Get.back();
  }

  checkEligibility() {
    if (isCardExist) {
      if (cardglobalKey.currentState!.validate()) eligibilityApi();
    } else
      eligibilityApi();
  }

  eligibilityApi() async{
    try {
      pageState = PageStates.PAGE_BUTTON_LOADING;
      PL_CardEligibilityRequest req = PL_CardEligibilityRequest(
          full_name: nameOnCard.toString(),
          mobile_no: arguments.mobileNo,
          lead_by: getUserId(),
          pancard:panNumberController.text,
          is_card:isCardExist?'1':'0',
          profile_id:arguments.cardData.profile_detail!=null?arguments.cardData.profile_detail.profile_id:0,
          occupation_id:isSalaried?1:2,
          monthly_salary:isSalaried?monthlySalaryController.text:'',
          company_id: selectedCompany == null
          ? 0
          : selectedCompany!.company_name == companyController.string
          ? selectedCompany!.id.toString()
          : 0,
          company_name: companyController.string,
          itr_amount:isSalaried?'':monthlySalaryController.text,
          pincode_id: await pinCodeHelper.isValidPinCode(),
          company_pincode_id: await salariedCodeHelper.isValidPinCode(),
          bank_id : isCardExist?selectedBank!.id:null,
          total_limit: isCardExist?total_limitController.text:null,
          ava_limit: isCardExist?ava_limitController.text:null,
          card_vintage: isCardExist?vintageType:null
      );

      restClient.checkCardEligibity(req).then((value) {
        pageState = PageStates.PAGE_IDLE;
        if (value.success) {
          LeadIdData dd = LeadIdData(lead_id: value.data.lead_id);
          arguments.leadIdData = dd;
          arguments.cardsresponse = value.data.eleigiblity_card;
          Get.toNamed(Routes.CREDITCARDSLIST, arguments: arguments);
        } else {
          current_step = 5;
          eligilble_err_title=value.message;
          eligilble_err_msg=value.message;
        }
      }).catchError((onError) {
        pageState = PageStates.PAGE_IDLE;
      });
    } catch (er) {
      print(er);
      pageState = PageStates.PAGE_IDLE;
    }
  }

//*********************************************************//
}
