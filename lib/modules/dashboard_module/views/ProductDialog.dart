import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/response/ProductDetailResponse.dart';
import 'package:bank_sathi/Model/response/ProductUrl.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/ProductDialogController.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/dotterd_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDialog extends StatelessWidget {
  final ProductDetailItem data;
  final ProductUrl producturl;
  final String short_url;

  const ProductDialog(
      {Key? key,
      required this.data,
      required this.short_url,
      required this.producturl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDialogController>(
        init: ProductDialogController(data, short_url, producturl),
        builder: (controller) {
          return Card(
              color: ColorUtils.white,
              margin: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shadowColor: ColorUtils.white_bg,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.sp),
                      topRight: Radius.circular(50.sp))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RepaintBoundary(
                    key: controller.globalKey,
                    child: Column(
                      children: [
                        CustomImage.network(data.share_image),
                        Container(
                          color: Colors.white,
                          child: DottedBorder(
                            strokeWidth: .5,
                            color: ColorUtils.greylight,
                            borderType: BorderType.RRect,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 60.sp,
                                  backgroundImage: NetworkImage(
                                      controller.user.profile_photo),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          controller.getUserFullName().length >
                                                  16
                                              ? controller.user.first_name
                                                  .toString()
                                                  .capitalizeFirst!
                                              : controller.getUserFullName(),
                                          style: GoogleFonts.mulish(
                                              fontSize: 50.sp,
                                              fontWeight: FontWeight.w600,
                                              color: ColorUtils.black),
                                        ),
                                        Visibility(
                                          visible: false,
                                          child: Card(
                                            color: ColorUtils.blue,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                            ),
                                            child: Icon(
                                              Icons.check,
                                              color: ColorUtils.white,
                                              size: 20.sp,
                                            ).paddingAll(3.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                    CustomText(
                                      '(Authorised Advisor)',
                                      style: GoogleFonts.mulish(
                                          fontSize: 25.sp,
                                          fontWeight: FontWeight.w600,
                                          color: ColorUtils.black),
                                    ).alignTo(Alignment.center),
                                  ],
                                ).marginOnly(left: 20.sp),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      size: 48.sp,
                                    ),
                                    CustomText(
                                      "+91-" + controller.user.mobile_no,
                                      style: GoogleFonts.mulish(
                                          fontSize: 40.sp,
                                          fontWeight: FontWeight.w600,
                                          color: ColorUtils.black),
                                    ).alignTo(
                                      Alignment.center,
                                    )
                                  ],
                                ),
                              ],
                            ).paddingSymmetric(
                                horizontal: 20.sp, vertical: 10.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(5)),
                      child: Container(
                        width: double.infinity,
                        child: Obx(
                          () => CustomText(
                            controller.content,
                            fontType: FontType.OPEN_SANS,
                          ).marginAll(20.sp),
                        ),
                      )).marginAll(40.sp),
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: data.share_content
                            .map((e) => WidgetUtil.getRadio(
                                    isSelected:
                                        controller.contentLanguage == e.lang,
                                    label: e.lang.capitalizeFirst,
                                    onTap: () => controller.onTap(e.lang))
                                .marginAll(4))
                            .toList(),
                      ).marginSymmetric(horizontal: 40.sp)),
                  Container(
                      width: 600.sp,
                      child: WidgetUtil.getSecondaryButton(
                              () => controller.capture(),
                              color: true,
                              height: 125.sp,
                              width: 600.sp,
                              label: share_now.tr)
                          .marginSymmetric(horizontal: 60.sp, vertical: 20.sp))
                ],
              ));
        });
  }
}
