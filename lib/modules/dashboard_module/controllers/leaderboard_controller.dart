import 'package:bank_sathi/Model/request/my_leads_request.dart';
import 'package:bank_sathi/Model/response/LeaderBoardResponse.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:get/get.dart';

class LeaderBoardController extends BaseController {
  Rx<UserBoardData> leadData = UserBoardData().obs;
  final _selectedChip = 2.obs;

  int get selectedChip => _selectedChip.value;

  set selectedChip(val) => _selectedChip.value = val;

  final _userslist = <AllUser>[].obs;

  List<AllUser> get userslist => _userslist.value;

  set userslist(val) => _userslist.value = val;

  final RxBool _isOtherRewards = false.obs;

  get isOtherRewards => _isOtherRewards.value;

  set isOtherRewards(val) => _isOtherRewards.value = val;

  final RxBool _isApiDone = false.obs;

  bool get isApiDone => _isApiDone.value;

  set isApiDone(val) => _isApiDone.value = val;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    leaderBoard();
  }

  @override
  void onClose() {}

  goToNextScreen() {
    Get.back();
  }

  Future leaderBoard() async {
    isApiDone = false;
    pageState = PageStates.PAGE_LOADING;
    try {
      MyLeadsRequest request = MyLeadsRequest(user_id: getUserId(),this_week: selectedChip);
      final response = await restClient.leaderBoard(request);
      pageState = PageStates.PAGE_IDLE;
      leadData.value = response.data;
      userslist = leadData.value.all_users;
    } on Exception {}
    isApiDone = true;
    return;
  }
}
