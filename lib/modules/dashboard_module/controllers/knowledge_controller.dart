import 'package:bank_sathi/Model/response/get_knowledge_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:get/get.dart';

class KnowledgeController extends BaseController {
  final _knowledgeList = <Category>[].obs;

  List<Category> get knowledgeList => _knowledgeList.value;

  set knowledgeList(val) => _knowledgeList.value = val;

  @override
  void onReady() {
    super.onReady();
    fetchVideos();
  }

  fetchVideos() {
    pageState = PageStates.PAGE_LOADING;
    restClient.getKnowledgeVideo().then((value) {
      pageState = PageStates.PAGE_IDLE;
      if (value.success) {
        if (value.data.isNullEmpty) {
          pageState = PageStates.PAGE_EMPTY_DATA;
        } else {
          knowledgeList.addAll(value.data);
          pageState = PageStates.PAGE_IDLE;
        }
      }
    }).catchError((onError) {
      pageState = PageStates.PAGE_ERROR;
    });
  }
}
