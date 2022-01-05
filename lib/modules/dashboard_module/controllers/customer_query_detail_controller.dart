import 'dart:async';

import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Model/response/query_detail_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerQueryDetailsController extends BaseController {
  final _queryData = QueryData().obs;

  QueryData get queryData => _queryData.value;

  set queryData(val) => _queryData.value = val;

  RxList<Comment> _commentslist = RxList();

  List<Comment> get commentslist => _commentslist.value;

  set commentslist(val) => _commentslist.value = val;

  RxString _commentsMsg = no_comments.tr.obs;

  get commentsMsg => _commentsMsg.value;

  set commentsMsg(val) => _commentsMsg.value = val;

  TextEditingController msgController = TextEditingController();

  int supportId = 0;

  @override
  void onInit() {
    super.onInit();

    supportId = Get.parameters['support_id'].toString().toInt();
  }

  @override
  void onReady() async {
    super.onReady();
    pageState = PageStates.PAGE_LOADING;
    await queryDetail();
    pageState = PageStates.PAGE_IDLE;
  }

  @override
  void onClose() {
    msgController.dispose();
    super.onClose();
  }

  goToNextScreen() {
    Get.back();
  }

  Future queryDetail() async {
    try {
      final response =
          await restClient.getQueryDetail(getUserId().toString(), supportId);
      if (response.success) {
        try {
          queryData = response.data;
          commentslist = response.data.comments;
        } catch (e) {
          e.printError();
        }
      } else {
        handleError(msg: response.message);
      }
    } on Exception {}
    return;
  }

  sendMsg() async {
    if (msgController.text.isNotEmpty) {
      Get.snackbar("Comment", "updating...",
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM);
      try {
        final response = await restClient.addQueryComment(
            getUserId().toString(), supportId, msgController.text);
        hideDialog();
        if (response.success) {
          msgController.text = '';
          queryDetail();
        }
      } on Exception {}
    }
  }
}
