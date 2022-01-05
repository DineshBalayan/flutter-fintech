import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/customer_query_detail_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_scaffold.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomerQueryDetail extends GetView<CustomerQueryDetailsController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showAppIcon: true,
      title: "Query Detail",
      body: BasePageView(
          controller: controller,
          idleWidget: Column(
            children: [
              leadDetailWidget(),
              Obx(() => Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.commentslist.length,
                      itemBuilder: (context, position) {
                        return Bubble(
                          message: controller.commentslist[position].comment,
                          time: controller.commentslist[position].created_at
                              .formatDateTimeFromUtc()
                              .toUiDateTime()!,
                          username:
                              controller.commentslist[position].commented_by,
                          isMe:
                              // position % 2 == 0,
                              controller.commentslist[position].commented_by ==
                                  'You',
                        );
                      }).marginOnly(left: 15.sp, right: 15.sp))),
              _bottomBar()
            ],
          )),
    );
  }

  _bottomBar() => Container(
        color: Colors.white,
        width: double.infinity,
        height: 140.sp,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 45.sp,
            ),
            Expanded(
              child: TextFormField(
                controller: controller.msgController,
                autofocus: false,
                decoration: InputDecoration(
                    hintText: add_comment.tr,
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              width: 45.sp,
            ),
            FloatingActionButton(
              onPressed: () {
                FocusScope.of(Get.context!).requestFocus(FocusNode());
                // FocusScope.of(Get.context!).unfocus();
                controller.sendMsg();
              },
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 40.sp,
              ),
              backgroundColor: ColorUtils.black_light,
              elevation: 2.sp,
            ).marginAll(10.sp),
          ],
        ),
      );

  Widget leadDetailWidget() {
    return Obx(() => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(50.sp)),
            boxShadow: [
              BoxShadow(
                color: ColorUtils.greyshade.withOpacity(0.08),
                spreadRadius: 30.sp,
                blurRadius: 70.sp,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomText(
              controller.queryData.query.title,
              fontweight: Weight.BOLD,
              fontSize: 50.sp,
            ),
            CustomText(
              controller.queryData.query.description,
              fontSize: 36.sp,
              color: Colors.grey.shade500,
            ).marginSymmetric(vertical: 30.sp),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/new_images/profile_image/calendar.svg',
                  color: Colors.grey.shade500,
                  height: 36.sp,
                ),
                CustomText(
                  controller.queryData.query.created_at
                              .formatDateTimeFromUtc() ==
                          null
                      ? ""
                      : controller.queryData.query.created_at
                          .formatDateTimeFromUtc()
                          .toUiDateTime(),
                  color: ColorUtils.textColor,
                  fontSize: 36.sp,
                ).marginOnly(left: 30.sp),
                Container(
                  width: 50.sp,
                ),
                CustomText(
                  'Status - ',
                  color: Colors.grey.shade500,
                  fontSize: 36.sp,
                ).marginOnly(left: 30.sp),
                CustomText(
                  controller.queryData.query.status == "0" ? "Open" : "Close",
                  color: ColorUtils.textColor,
                  fontSize: 36.sp,
                ).marginOnly(left: 30.sp)
              ],
            )
          ]).marginSymmetric(horizontal: 30.sp, vertical: 30.sp),
        ).marginOnly(top: 30.sp, bottom: 30.sp, left: 50.sp, right: 60.sp));
  }
}

class Bubble extends StatelessWidget {
  Bubble(
      {required this.message,
      required this.time,
      required this.username,
      this.isMe});

  final String message, time, username;
  final isMe;

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? ColorUtils.white : Colors.white;
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = isMe
        ? BorderRadius.only(
            topLeft: Radius.circular(15.sp),
            bottomLeft: Radius.circular(15.sp),
            bottomRight: Radius.circular(30.sp),
          )
        : BorderRadius.only(
            topRight: Radius.circular(15.sp),
            bottomLeft: Radius.circular(30.sp),
            bottomRight: Radius.circular(15.sp),
          );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: align,
      children: <Widget>[
        Column(
          crossAxisAlignment: align,
          children: <Widget>[
            Visibility(
                child: CustomText(
                  username,
                  fontSize: 30.sp,
                  color: ColorUtils.grey,
                ),
                visible: !isMe),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: .5,
                      spreadRadius: 1.0,
                      color: Colors.black.withOpacity(.12))
                ],
                color: bg,
                borderRadius: radius,
              ),
              child: CustomText(
                message,
                fontSize: 36.sp,
              ).marginOnly(
                  left: 30.sp, top: 15.sp, bottom: 15.sp, right: 30.sp),
            ),
            CustomText(
              time.toDDMMYYYYHHMM(),
              color: ColorUtils.grey,
              fontSize: 28.sp,
            ).alignTo(!isMe ? Alignment.bottomLeft : Alignment.bottomRight),
          ],
        ),
      ],
    ).marginOnly(
        left: !isMe ? 10.sp : 150.sp,
        right: !isMe ? 150.sp : 10.sp,
        top: 15.sp,
        bottom: 15.sp);
  }
}
