import 'package:bank_sathi/Model/response/get_faqs_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:get/get.dart';

class CustomerSupportController extends BaseController {
  final _faqsList = <FAQsData>[].obs;

  List<FAQsData> get faqsList => _faqsList.value;

  set faqsList(val) => _faqsList.value = val;

  @override
  void onReady() {
    super.onReady();
    fetchFAQs();
  }

  void fetchFAQs() {
    pageState = PageStates.PAGE_LOADING;
    restClient.getAppFaqs().then((value) {
      if (value.success) {
        pageState = PageStates.PAGE_IDLE;
        faqsList = value.data;
      } else {
        pageState = PageStates.PAGE_ERROR;
      }
    }).catchError((e) {
      pageState = PageStates.PAGE_ERROR;
    });
  }
}
