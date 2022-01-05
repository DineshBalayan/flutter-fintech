import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class CardPreview extends StatelessWidget {
  final heroTag;
  String imagePath;

  DashboardController controller = Get.find();

  CardPreview({this.heroTag, required this.imagePath}) : super();

  final globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Card(
        color: ColorUtils.white,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: ColorUtils.white_bg,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0), topRight: Radius.circular(0))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RepaintBoundary(
              key: globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomImage.network(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: ColorUtils.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 64.sp,
                          backgroundImage:
                              NetworkImage(controller.user.profile_photo),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomText(
                                  controller.getUserFullName().length > 16
                                      ? controller.user.first_name
                                          .toString()
                                          .capitalizeFirst!
                                      : controller.getUserFullName(),
                                  style: GoogleFonts.mulish(
                                      fontSize: 54.sp,
                                      fontWeight: FontWeight.w700,
                                      color: ColorUtils.black),
                                ),
                                Visibility(
                                    visible: controller.getUserStatus() ==
                                        "Verified",
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: controller
                                              .getUserStatusColor()
                                              .withAlpha(15),
                                          border: Border.all(
                                              color: controller
                                                  .getUserStatusColor(),
                                              width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40))),
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            30.sp, 0, 30.sp, 0),
                                        child: Obx(() => CustomText(
                                              controller.getUserStatus(),
                                              color: controller
                                                  .getUserStatusColor(),
                                              fontSize: 28.sp,
                                            )),
                                      ),
                                    )).marginOnly(left: 20.sp),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/new_images/phone.svg',
                                  width: 32.sp,
                                ),
                                CustomText(
                                  "   +91 " + controller.user.mobile_no,
                                  style: GoogleFonts.mulish(
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w600,
                                      color: ColorUtils.black),
                                ).alignTo(
                                  Alignment.center,
                                )
                              ],
                            ).marginOnly(top: 10.sp),
                          ],
                        ).marginOnly(left: 20.sp),
                      ],
                    ).paddingSymmetric(horizontal: 20.sp, vertical: 25.sp),
                  ),
                ],
              ),
            ),
            Container(
              width: Get.width,
              child: RaisedButton.icon(
                      elevation: 0,
                      highlightColor: ColorUtils.blue,
                      padding: EdgeInsets.all(30.sp),
                      color: ColorUtils.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(200.sp)),
                      onPressed: () async {
                        final file = await capture();
                        if (file != null) await Share.shareFiles([file.path]);
                        Get.back();
                      },
                      icon: Icon(
                        Icons.share_sharp,
                        color: ColorUtils.white,
                      ),
                      label: CustomText(
                        share_this_card.tr,
                        color: ColorUtils.white,
                        customTextStyle: CustomTextStyle.MEDIUM,
                      ))
                  .marginOnly(
                      top: 10.sp, bottom: 30.sp, left: 60.sp, right: 60.sp),
            ),
          ],
        )).adjustForTablet();
  }

  Future<File?> capture(
      {String path = "", Duration delay: const Duration(milliseconds: 20)}) {
    return Future.delayed(delay, () async {
      try {
        RenderRepaintBoundary boundary = this
            .globalKey
            .currentContext!
            .findRenderObject()! as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage(pixelRatio: Get.pixelRatio);
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();
        if (path == "") {
          final directory = (await getApplicationDocumentsDirectory()).path;
          String fileName = "Card";
          path = '$directory/$fileName.png';
        }
        File imgFile = new File(path);
        await imgFile.writeAsBytes(pngBytes);
        return imgFile;
      } catch (Exception) {
        print(Exception);
        return null;
      }
    });
  }
}
