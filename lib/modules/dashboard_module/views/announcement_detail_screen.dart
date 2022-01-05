import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Model/response/get_user_response.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_scaffold.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/simple_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Announcement announcement = Get.arguments;

    return CustomScaffold(
        title: 'Announcement',
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.sp),
                ),
                elevation: .5,
                margin: EdgeInsets.only(left: 40.sp, right: 40.sp),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  children: [
                    CustomImage.network(announcement.file),
                  ],
                ),
              ).marginOnly(top: 15.sp),
              CustomText(
                announcement.title,
                fontweight: Weight.BOLD,
                fontSize: 54.sp,
              ).marginOnly(top: 60.sp),
              SimpleRichText(
                key: UniqueKey(),
                text: announcement.description,
                textAlign: TextAlign.start,
                style: StyleUtils.textStyleNormalPoppins(
                    fontSize: 38.sp, color: Colors.grey.shade200),
              ).marginOnly(top: 40.sp, left: 40.sp, right: 40.sp),
            ],
          ),
        ));
  }
}
