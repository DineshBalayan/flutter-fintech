import 'dart:io';

import 'package:bank_sathi/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:sms_retriever/sms_retriever.dart';
import 'package:social_share_plugin/social_share_plugin.dart';

class AdviserBadgesController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  goToNextScreen() {
    Get.back();
  }

  instaShare(File file) async {
    await SocialSharePlugin.shareToFeedInstagram(path: file.path);
  }

  fbShare(File file) async {
    await SocialSharePlugin.shareToFeedFacebook(
        caption:
            'https://play.google.com/store/apps/details?id=com.app.banksathi&hl=en_IN&gl=US',
        path: file.path);
  }

  whataAppShare(File file) async {
    await SmsRetriever.shareToWhatsApp(file.path,
        "https://play.google.com/store/apps/details?id=com.app.banksathi&hl=en_IN&gl=US");
  }

  genericShare(File file) async {
    await Share.shareFiles([file.path],
        text:
            "https://play.google.com/store/apps/details?id=com.app.banksathi&hl=en_IN&gl=US");
  }
}
