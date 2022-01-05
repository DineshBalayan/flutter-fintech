import 'package:bank_sathi/Model/response/get_user_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

import 'custom_network_image.dart';

class DashboardSliderWidget extends StatefulWidget {
  final List<PrBanner> socialCardList;

  late List<Widget> imageSliders;

  DashboardSliderWidget(this.socialCardList) {
    if (socialCardList.length > 0) {
      imageSliders = socialCardList
          .map((item) => SizedBox(
                height: 400.sp,
                width: 812.sp,
                child: Card(
                    margin: EdgeInsets.only(left: 40.sp),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: CustomImage.network(
                      item.image,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    )).onClick(() {
                  String payload = item.url ?? "";
                  print("payload : " + payload);
                  Get.find<DashboardController>().handleNotifications(null,
                      screen: GetUtils.isURL(payload) ? null : payload,
                      link: payload);
                }),
              ))
          .toList(growable: true);
    }
  }

  @override
  _DashboardSliderWidgetState createState() => _DashboardSliderWidgetState();
}

class _DashboardSliderWidgetState extends State<DashboardSliderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _nextPage;
  int _currentPage = 0;

  InfiniteScrollController controller = InfiniteScrollController();

  @override
  void initState() {
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 4));
    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reset();
        final int page = widget.imageSliders.length;
        if (_currentPage < page) {
          _currentPage++;
          controller.animateToItem(
            _currentPage,
            duration: 300.milliseconds,
          );
        } else {
          _currentPage = 0;
          controller.animateToItem(
            _currentPage,
            duration: 300.milliseconds,
          );
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return SizedBox(
      height: 400.sp,
      child: InfiniteCarousel.builder(
        itemCount: widget.imageSliders.length,
        anchor: 0.0,
        controller: controller,
        center: false,
        velocityFactor: 0.2,
        onIndexChanged: (index) {
          _currentPage = index;
          _animationController.forward();
        },
        axisDirection: Axis.horizontal,
        loop: true,
        itemBuilder: (context, itemIndex, realIndex) {
          return widget.imageSliders[itemIndex];
        },
        itemExtent: Get.width * .8,
      ),
    );
  }
}
