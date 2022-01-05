import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bank_sathi/Helpers/Constant.dart';
import 'package:bank_sathi/Model/pair.dart';
import 'package:bank_sathi/Model/response/SocialCardsListResponse.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:sms_retriever/sms_retriever.dart';
import 'package:social_share_plugin/social_share_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareTabController extends BaseController
    with SingleGetTickerProviderMixin {
  GlobalKey globalKey = GlobalKey();

  late TabController pageController = TabController(length: 2, vsync: this);

  late Pair<String, String> referContent;
  final _social_cards = <Cardscatlist>[].obs;

  final _selectedCat = "All".obs;

  String get selectedCat => _selectedCat.value;

  set selectedCat(String val) => _selectedCat.value = val;

  List<Cardscatlist> get social_cards => _social_cards.value;

  set social_cards(List<Cardscatlist> val) => _social_cards.value = val;

  final _currentIndex = 0.obs;

  get currentIndex => _currentIndex.value;

  set currentIndex(val) => _currentIndex.value = val;

  @override
  void onInit() async {
    super.onInit();
    await setReferContent();
  }

  changeIndex(position) async {
    currentIndex = position;
    try {
      if (pageController != null)
        pageController.animateTo(position,
            curve: Curves.easeInExpo, duration: 500.milliseconds);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    if (pageController != null) pageController.dispose();
    super.onClose();
  }

  @override
  void onReady() async {
    super.onReady();
    await fetchSocialCards();
  }

  void referEarnCall() {
    shareReferralLink();
  }

  Future<void> fetchSocialCards() async {
    try {
      SocialCardsListResponse response = await restClient.socialCards();
      print(response);
      if (response.success) {
        social_cards = response.data;
        selectedCat = response.data.first.cat_name;
      }
    } catch (e) {}
  }

  facebookShare() async {
    SocialSharePlugin.shareToFeedFacebook(
        path: referContent.second, caption: referContent.first);
  }

  instaShare() async {
    SocialSharePlugin.shareToFeedInstagram(path: referContent.second);
  }

  twitterShare() async {
    SocialSharePlugin.shareToTwitterLink(text: referContent.first, url: "");
  }

  whatsAppShare() async {
    SmsRetriever.shareToWhatsApp(referContent.second, referContent.first);
  }

  mailShare() {
    if (Platform.isAndroid) {
      _launchURL("", "Earn Money By Sharing Leads", referContent.first!);
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
