import 'package:bank_sathi/Model/response/ProductDetailResponse.dart';
import 'package:bank_sathi/Model/response/ProductUrl.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountProductDetailController extends BaseController
    with SingleGetTickerProviderMixin {
  late TabController tabController;
  late PageController _pageController;

  PageController get pageController => _pageController;

  final _currentPage = 0.obs;

  AccountProductDetailController(this.productDetail, this.prductUrl);

  int get currentPage => _currentPage.value;

  final _durationTime = 0.obs;

  int get durationTime => _durationTime.value;

  set durationTime(val) => _durationTime.value = val;

  set currentPage(val) {
    _currentPage.value = val;
  }

  final ProductUrl prductUrl;
  final ProductDetailItem productDetail;

  @override
  void onClose() {
    _pageController.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    super.onClose();
    // getDetail(productDetail.video_url);
  }

  @override
  void onInit() {
    super.onInit();
    _pageController = PageController();
    tabController =
        TabController(length: productDetail.tab.length, vsync: this);

    tabController.animation!
      ..addListener(() {
        if (tabController.animation!.status == AnimationStatus.forward) {
          if (tabController.animation!.value % 1 > .8 ||
              tabController.animation!.value % 1 < .15) {
            currentPage = tabController.animation!.value.round();
          }
        }
      });
    // getDetail(productDetail.video_url);
  }
}
