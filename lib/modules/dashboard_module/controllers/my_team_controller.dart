import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bank_sathi/Helpers/Constant.dart';
import 'package:bank_sathi/Model/pair.dart';
import 'package:bank_sathi/Model/response/get_my_team_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class MyTeamController extends BaseController {
  final _teamList = <Member>[].obs;
  int totalPage = 2;
  int currentPage = 1;

  final _totalReferrals = 0.obs;

  get totalReferrals => _totalReferrals.value;

  set totalReferrals(val) => _totalReferrals.value = val;

  final _active_user = 0.obs;
  get active_user => _active_user.value;
  set active_user(val) => _active_user.value = val;

  final _inactive_user = 0.obs;
  get inactive_user => _inactive_user.value;
  set inactive_user(val) => _inactive_user.value = val;

  RxInt inactive_advisor_of_month = 0.obs, active_advisor_of_month = 0.obs;

  List<Member> get teamList => _teamList.value;

  set teamList(val) => _teamList.value = val;

  RxBool _apiCallDone = false.obs;

  get apiCallDone => _apiCallDone.value;

  set apiCallDone(val) => _apiCallDone.value = val;

  final _referralEarning = '0'.obs;

  get referralEarning => _referralEarning.value;

  set referralEarning(val) => _referralEarning.value = val;

  final _totalEarning = '0'.obs;

  get totalEarning => _totalEarning.value;

  set totalEarning(val) => _totalEarning.value = val;

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  final _selectedTime = 0.obs;

  int get selectedTime => _selectedTime.value;

  set selectedTime(val) => _selectedTime.value = val;

  final RxBool _isSortByDate = true.obs;

  bool get isSortByDate => _isSortByDate.value;

  set isSortByDate(val) => _isSortByDate.value = val;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    fetchTeam();
    setReferContent();
  }

  Future fetchTeam() async {
    if (currentPage <= totalPage) {
      try {
        apiCallDone = false;
        pageState = currentPage == 1
            ? PageStates.PAGE_LOADING
            : PageStates.PAGE_LOADING_MORE;

        final response = await restClient.myTeam(
            getUserId(),
            null, active_user,inactive_user,
            currentPage,
            getUserCode(),
            fromDateController.text,
            toDateController.text,
            isSortByDate ? 0 : 1,
            isSortByDate ? 1 : 0);
        if (response.success) {
          pageState = PageStates.PAGE_IDLE;

          currentPage = response.data.members.current_page;
          totalPage = response.data.members.last_page;

          referralEarning = response.data.team_earning;
          totalEarning = response.data.self_earning;
          totalPage = response.data.members.last_page;

          if (currentPage == 1) {
            totalReferrals = response.data.members.total;
            inactive_advisor_of_month.value =
                response.data.inactive_advisor_of_month;
            active_advisor_of_month.value =
                response.data.active_advisor_of_month;
            if (response.data.members.data == null ||
                response.data.members.data.length == 0) {
              pageState = PageStates.PAGE_EMPTY_DATA;
            } else {
              teamList.clear();
            }
          }

          teamList.addAll(response.data.members.data);

          currentPage++;

          apiCallDone = true;
        } else {
          apiCallDone = true;
          handleError(msg: response.message);
          pageState = PageStates.PAGE_ERROR;
        }
      } catch (e) {
        print(e);
        apiCallDone = true;
        pageState = PageStates.PAGE_IDLE;
      }
      _teamList.refresh();
    }
    return;
  }

  late Pair<String, String> referContent;

  setReferContent() async {
    final assetname = 'assets/images/sharing_image.jpg';
    final filename = 'sharing_image.png';
    var bytes = await rootBundle.load(assetname);
    String dir = (await getTemporaryDirectory()).path;
    var filepath = '$dir/$filename';
    if (await File(filepath).exists()) File(filepath).delete();
    await writeToFile(bytes, filepath);

    String link =
        Constant.REFERENCE_BASE_URL + prefManager.getUserData()!.user_code;
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: Constant.APP_PAGE_LINK,
      link: Uri.parse(link),
      androidParameters: AndroidParameters(
        packageName: 'com.app.banksathi',
        minimumVersion: 0,
      ),
      iosParameters: IosParameters(bundleId: 'com.example.myappname'),
    );
    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();

    referContent = Pair.create(
        "You have a chance to earn over Rs. 50,000 from home. Join BankSathi and its family over 30k+ people who are getting extra income using the BankSathi app. Use referral code: ${getUserCode()}. Download BankSathi app today. Tap the Link ${shortDynamicLink.shortUrl.toString()}",
        filepath);
  }

  GlobalKey globalKey = GlobalKey();

  shareCard() async {
    try {
      RenderRepaintBoundary boundary = this
          .globalKey
          .currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: Get.pixelRatio);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      final directory = (await getApplicationDocumentsDirectory()).path;
      String fileName = "Card";
      var path = '$directory/$fileName.png';
      File imgFile = new File(path);
      await imgFile.writeAsBytes(pngBytes);
      await Share.shareFiles([imgFile.path]);
    } catch (exception) {
      print(exception);
      return null;
    }
  }
}
