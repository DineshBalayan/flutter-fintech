import 'dart:io';
import 'package:bank_sathi/Model/response/get_training_video_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/help_center_modules/model/training_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/faq_model.dart';

class HelpController extends BaseController with SingleGetTickerProviderMixin {
  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);

  late TabController trainingVideoController =
      TabController(length: 2, vsync: this);

  final _isValid = ''.obs;

  get isValid => _isValid.value;

  set isValid(val) => _isValid.value = val;

  final _tabItems = <String>[].obs;

  List<String> get tabItems => _tabItems.value;

  set tabItems(List<String> val) => _tabItems.value = val;

  final _selectedTab = 0.obs;

  get selectedTab => _selectedTab.value;

  set selectedTab(val) => _selectedTab.value = val;

  final _faqIndex = 0.obs;

  get faqIndex => _faqIndex.value;

  set faqIndex(val) => _faqIndex.value = val;

  final _expandIndex = 0.obs;

  get expandIndex => _expandIndex.value;

  set expandIndex(val) => _expandIndex.value = val;

  final _faqSubCatIndex = 0.obs;

  get faqSubCatIndex => _faqSubCatIndex.value;

  set faqSubCatIndex(val) => _faqSubCatIndex.value = val;

  RxList<FaqData> _faq = <FaqData>[].obs;

  List<FaqData> get faq => _faq;

  set faq(val) => _faq.value = val;

  RxList<FaqData> _faqProducts = <FaqData>[].obs;

  List<FaqData> get faqProducts => _faqProducts;

  set faqProducts(val) => _faqProducts.value = val;

  RxList<FaqData> _faqForTitle = <FaqData>[].obs;

  List<FaqData> get faqForTitle => _faqForTitle;

  set faqForTitle(val) => _faqForTitle.value = val;

  RxList<QueAn> _questionAnswer = <QueAn>[].obs;

  List<QueAn> get questionAnswer => _questionAnswer;

  set questionAnswer(val) => _questionAnswer.value = val;

  RxList<Subcatt> _subCategory = <Subcatt>[].obs;

  List<Subcatt> get subCategory => _subCategory;

  set subCategory(val) => _subCategory.value = val;

  RxList<QueAn> _subCatQuestionAnswer = <QueAn>[].obs;

  List<QueAn> get subCatQuestionAnswer => _subCatQuestionAnswer;

  set subCatQuestionAnswer(val) => _subCatQuestionAnswer.value = val;

  RxList<TrainingData> _trainingData = <TrainingData>[].obs;

  List<TrainingData> get trainingData => _trainingData.value;

  set trainingData(val) => _trainingData.value = val;

  RxList<TrainingVideo> _trainingVideo = <TrainingVideo>[].obs;

  List<TrainingVideo> get trainingVideo => _trainingVideo.value;

  set trainingVideo(val) => _trainingVideo.value = val;

  RxList<HelpSection> _helpTrainingData = <HelpSection>[].obs;

  List<HelpSection> get helpTrainingData => _helpTrainingData.value;

  set helpTrainingData(val) => _helpTrainingData.value = val;

  final _title = ''.obs;

  get title => _title.value;

  set title(val) => _title.value = val;

  final _emailBody = ''.obs;

  get emailBody => _emailBody.value;

  set emailBody(val) => _emailBody.value = val;

  final _trainingVideoType = 0.obs;

  int get trainingVideoType => _trainingVideoType.value;

  set trainingVideoType(val) => _trainingVideoType.value = val;

  int showEmptySubCategory() {
    var count = 0;
    // bool val = true;
    subCategory.forEach((element) {
      // element.queAns.length > 0 ? val = false : val = true;
      if (element.queAns.length > 0) count++;
    });
    print('showEmptySubCategory' + count.toString());
    return count;
  }

  late TextEditingController emailTitleController, emailBodyController;

  @override
  void onReady() {
    super.onReady();
    getDataOfFaq();
    getDataOfProducts();
    getDataForTraining();
    getZoomTrainingVideo();
  }

  @override
  void onClose() {
    emailTitleController.dispose();
    emailBodyController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    emailTitleController = TextEditingController();
    emailBodyController = TextEditingController();
    emailTitleController.addListener(() {
      title = emailTitleController.text;
    });
    emailBodyController.addListener(() {
      emailBody = emailBodyController.text;
    });
    _tabItems.insert(0, 'TOP FAQ');
    _tabItems.insert(1, 'TRAINING');
    _tabItems.insert(2, 'MARKETING');
  }

  updateSelectedValue(int index) {
    selectedTab = index;
    pageController.animateToPage(selectedTab,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  faqArrayUpdate(List<QueAn> queAns, List<Subcatt> subCat, int i,
      List<FaqData> faqProducts) {
    expandIndex = 0;
    faqIndex = i;
    questionAnswer = queAns;
    subCategory = subCat;
    /*   if (subCat.length == 0 && queAns.length == 0) {
      // pageState = PageStates.PAGE_EMPTY_DATA;
    } else {
      pageState = PageStates.PAGE_IDLE;
      subCategory = subCat;
    }*/
    faqForTitle = faqProducts;
  }

  faqCategoryArrayUpdate(List<QueAn> queAns, int i) {
    faqSubCatIndex = i;
    subCatQuestionAnswer = queAns;
    if (subCategory[i].queAns.length == 0) {
      // pageState = PageStates.PAGE_EMPTY_DATA;
    } else {
      pageState = PageStates.PAGE_IDLE;
    }
  }

  makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '917412933933',
    );
    await launch(launchUri.toString());
  }

  mailShare() {
    if (Platform.isAndroid) {
      /* _launchURL("support@banksathi.com", emailTitleController.text,
          emailBodyController.text); */
      _launchURL("support@banksathi.com", '', '');
    } else if (Platform.isIOS) {
      launch("message://").catchError((e) {});
    }
  }

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  verifyForm() async {
    if (emailBody.isEmpty || emailBody == '') {
      isValid = 'Please Enter Your Query!';
    } else {
      mailShare();
      Get.back();
    }
  }

  void getDataOfFaq() {
    pageState = PageStates.PAGE_LOADING;
    restClient.getHelpFaqs().then((value) {
      if (value.success) {
        pageState = PageStates.PAGE_IDLE;
        faq = value.data;
      } else {
        pageState = PageStates.PAGE_ERROR;
      }
    }).catchError((e) {
      pageState = PageStates.PAGE_ERROR;
    });
  }

  void getDataOfProducts() {
    pageState = PageStates.PAGE_LOADING;
    restClient.getHelpForProducts().then((value) {
      if (value.success) {
        pageState = PageStates.PAGE_IDLE;
        faqProducts = value.data;
      } else {
        pageState = PageStates.PAGE_ERROR;
      }
    }).catchError((e) {
      pageState = PageStates.PAGE_ERROR;
    });
  }

  void getDataForTraining() {
    pageState = PageStates.PAGE_LOADING;
    restClient.getHelpForTraining().then((value) {
      if (value.success) {
        pageState = PageStates.PAGE_IDLE;
        trainingData = value.mainData;
      } else {
        pageState = PageStates.PAGE_ERROR;
      }
    }).catchError((e) {
      pageState = PageStates.PAGE_ERROR;
    });
  }

  Future<void> getZoomTrainingVideo() async {
    try {
      pageState = PageStates.PAGE_LOADING;
      GetTrainingVideoResponse value =
          await restClient.getZoomTrainingVideo(getUserId().toString());
      if (value.success) {
        pageState = PageStates.PAGE_IDLE;
        trainingVideo = value.data;
      } else {
        pageState = PageStates.PAGE_ERROR;
      }
    } catch (e) {
      pageState = PageStates.PAGE_ERROR;
    }
  }

  void enrollTraining(String trainingId) {
    showLoadingDialog();
    restClient
        .enrollTraining(getUserId().toString(), trainingId)
        .then((value) async {
      if (value.success) {
        GetTrainingVideoResponse response =
            await restClient.getZoomTrainingVideo(getUserId().toString());
        hideDialog();
        if (response.success) {
          trainingVideo = response.data;
        }
      } else {
        hideDialog();
      }
    }).catchError((e) {
      print(e.toString());
      hideDialog();
    });
  }
}
