import 'package:bank_sathi/Model/request/my_leads_request.dart';
import 'package:bank_sathi/Model/response/LeaderBoardResponse.dart';
import 'package:bank_sathi/Model/response/base_response.dart';
import 'package:bank_sathi/Model/response/get_section_help_response.dart';
import 'package:bank_sathi/Model/response/get_section_help_response.dart';
import 'package:bank_sathi/Model/response/tds_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:get/get.dart';

class TDSInfoController extends BaseController {
  final RxString _htmldata = ''.obs;
  String get htmldata => _htmldata.value;
  set htmldata(val) => _htmldata.value = val;

  final _helpdata = <SectionHelpData>[].obs;
  List<SectionHelpData> get helpdata => _helpdata.value;
  set helpdata(val) => _helpdata.value = val;

  @override
  void onReady() async {
    super.onReady();
    tdsInfoApi();
  }

  tdsInfoApi() async {
    try {
      pageState = PageStates.PAGE_LOADING;
      TDSResponse response =  await restClient.tdsInfo();
      htmldata = response.tdsData.description;
      pageState = PageStates.PAGE_IDLE;
      showSectionInfoById(12);
    } catch (e) {
      print(e);
      e.printInfo();
      pageState = PageStates.PAGE_IDLE;
    }
  }

  void showSectionInfoById(int id) async {
    try {
      GetSectionHelpResponse response = await restClient.getSectionHelp(id);
      helpdata = response.data;
    } catch (e) {
      print(e);
      e.printInfo();
    }
  }

}
