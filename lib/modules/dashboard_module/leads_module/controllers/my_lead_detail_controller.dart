import 'dart:async';

import 'package:bank_sathi/Model/add_lead_arguments.dart';
import 'package:bank_sathi/Model/request/my_leads_request.dart';
import 'package:bank_sathi/Model/response/LeadDetailResponse.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLeadDetailsController extends BaseController {
  AddLeadArguments arguments = AddLeadArguments();
  final _leadData = LeadData().obs;

  LeadData get leadData => _leadData.value;

  set leadData(val) => _leadData.value = val;

  ScrollController scrollController = new ScrollController();
  int totalPage = 2;
  int currentPage = 1;

  RxList<Journey> _journeylist = <Journey>[].obs;

  List<Journey> get journeylist => _journeylist.value;

  set journeylist(val) => _journeylist.value = val;

  RxString _commentsMsg = no_comments.tr.obs;

  get commentsMsg => _commentsMsg.value;

  set commentsMsg(val) => _commentsMsg.value = val;

  TextEditingController msgController = TextEditingController();

  String leadId = "";

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    leadId = Get.parameters['lead_id'] ?? "";
    pageState = PageStates.PAGE_LOADING;
    await leadDetail(true);
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

  Future leadDetail(bool isloading) async {
    if (currentPage <= totalPage) {
      try {
        MyLeadsRequest request = MyLeadsRequest(
            user_id: getUserId(), lead_id: leadId, page: currentPage);
        final response = await restClient.leadsDetail(request);
        if (response.success) {
          try {
            leadData = response.data;
          } catch (e) {
            e.printError();
          }
          if (leadData.journey != null)
            journeylist.addAll(response.data.journey);
          _journeylist.refresh();
          /*
          if (currentPage == 1) {
            commentslist.clear();
          }
          currentPage++;

          totalPage = response.data.comments.last_page;
          commentslist.addAll(response.data.comments.data);
          commentsMsg = no_comments.tr;
          _commentslist.refresh();
          */
          // if (Get.context != null)
          //   FocusScope.of(Get.context!).requestFocus(FocusNode());
        } else {
          handleError(msg: response.message);
        }
      } on Exception {}
    }
    return;
  }

  sendMsg() async {
    if (msgController.text.isNotEmpty) {
      // showLoadingDialog();
      Get.snackbar("Comment", "updating...",
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM);
      try {
        MyLeadsRequest request = MyLeadsRequest(
            user_id: getUserId(), lead_id: leadId, comment: msgController.text);
        final response = await restClient.leadsComment(request);
        hideDialog();
        if (response.success) {
          msgController.text = '';
          currentPage = 1;
          leadDetail(false);
        }
      } on Exception {
        hideDialog();
      }
    }
  }
}
