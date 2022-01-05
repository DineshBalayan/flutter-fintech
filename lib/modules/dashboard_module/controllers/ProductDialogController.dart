import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bank_sathi/Model/response/ProductDetailResponse.dart';
import 'package:bank_sathi/Model/response/ProductUrl.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class ProductDialogController extends BaseController {
  final _contentLanguage = "".obs;
  final globalKey = GlobalKey();
  final ProductDetailItem data;
  String short_url = "";
  ProductUrl producturl;

  ProductDialogController(this.data, this.short_url, this.producturl);

  String get contentLanguage => _contentLanguage.value;

  set contentLanguage(val) => _contentLanguage.value = val;

  final _imageAsset = 'assets/images/saving_account.jpg'.obs;

  String get imageAsset => _imageAsset.value;

  set imageAsset(val) => _imageAsset.value = val;

  onTap(lang) {
    contentLanguage = lang;
    prefManager.setContentLanguage(lang);
    changeContent();
  }

  changeContent() {
    content = data.share_content
            .firstWhere((element) => element.lang == contentLanguage)
            .content +
        " " +
        short_url;
  }

  @override
  void onInit() async {
    super.onInit();
    short_url = producturl.data.url;
    imageAsset = data.share_image;
    contentLanguage =
        prefManager.getContentLanguage() ?? data.share_content.first.lang;
    changeContent();
  }

  final _content = "".obs;

  String get content => _content.value;

  set content(val) => _content.value = val;

  Future capture() {
    return Future.delayed(20.milliseconds, () async {
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
        String path = '$directory/$fileName.png';
        File imgFile = new File(path);
        await imgFile.writeAsBytes(pngBytes);
        await Share.shareFiles([imgFile.path], text: content);
      } catch (Exception) {
        print(Exception);
        return null;
      }
    });
  }
}
