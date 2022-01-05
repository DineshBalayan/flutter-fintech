 import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

export 'package:bank_sathi/Helpers/extensions.dart';

typedef OnStateChanged = Function(PageStates pageState);

// ignore: must_be_immutable
class BasePageView<T extends BaseController> extends StatelessWidget {
  final T controller;
  Widget idleWidget;
  Widget? onLoadingWidget;
  Widget? errorOrEmptyWidget;
  Widget? paginationLoadingWidget;
  OnStateChanged? onStateChanged;

  BasePageView(
      {Key? key,
      required this.controller,
      required this.idleWidget,
      this.onLoadingWidget,
      this.errorOrEmptyWidget,
      this.paginationLoadingWidget,
      this.onStateChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (onStateChanged != null) onStateChanged!(controller.pageState);
      if (controller.pageState == PageStates.PAGE_IDLE ||
          controller.pageState == PageStates.PAGE_BUTTON_LOADING ||
          controller.pageState == PageStates.PAGE_BUTTON_ERROR ||
          controller.pageState == PageStates.PAGE_LOADING_MORE) {
        return idleWidget;
      } else if (controller.pageState == PageStates.PAGE_LOADING) {
        return onLoadingWidget ?? DefaultPageLoading();
      } else if (controller.pageState == PageStates.PAGE_ERROR ||
          controller.pageState == PageStates.PAGE_EMPTY_DATA) {
        return errorOrEmptyWidget ??
            EmptyDataErrorView(
              pageState: controller.pageState,
            );
      } else {
        return Container();
      }
    });
  }
}

class EmptyDataErrorView extends StatelessWidget {
  final String? image;
  final String? title;
  final String? message;
  final PageStates? pageState;

  EmptyDataErrorView(
      {Key? key,
      this.image,
      this.title,
      this.message,
      this.pageState = PageStates.PAGE_EMPTY_DATA})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ( pageState == PageStates.PAGE_EMPTY_DATA ?
          Lottie.asset('assets/animation/thinking_man.json',
              width: 800.sp,
              fit: BoxFit.fitWidth)
              :
          Lottie.asset('assets/animation/maintenance.json',
              width: 800.sp,
              fit: BoxFit.fitWidth)
          ),
          CustomText(
            message ??
                (pageState == PageStates.PAGE_EMPTY_DATA
                    ? "No Record Found"
                    : "Ohhhh...\nSomething Went Wrong"),
            textAlign: TextAlign.center,
          ).marginOnly(left: 40.sp, right: 40.sp,bottom: 50.sp)
        ],
      ),
    );
  }
}

class DefaultPageLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset('assets/animation/loading.json',
          width: 200.sp, fit: BoxFit.fitWidth),
    );
  }
}
