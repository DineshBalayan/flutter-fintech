import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Model/pair.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/dashboard_controller.dart';
import 'package:bank_sathi/modules/share_module/views/visiting_cards.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyDetail extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16.0 / 10.0,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/new_images/profile_image/profile_bg.jpg',
                        fit: BoxFit.fitWidth,
                      ),
                      top: 0,
                      left: 0,
                    ),
                    Column(
                      children: [
                        AppBar(
                          elevation: 0,
                          leading: SvgPicture.asset(
                            'assets/images/ic_back_arrow.svg',
                            width: 75.sp,
                            fit: BoxFit.scaleDown,
                            color: Colors.white,
                          ).onClick(() {
                            Get.back();
                          }),
                          actions: [
                            SvgPicture.asset(
                              'assets/images/new_images/profile_image/language.svg',
                              width: 58.sp,
                            )
                                .onClick(
                                    () => Get.toNamed(Routes.SELECT_LANGUAGE))
                                .marginOnly(left: 30.sp, right: 30.sp),
                          ],
                          backgroundColor: Colors.transparent,
                          title: CustomText(
                            my_profile.tr,
                            style: GoogleFonts.mulish(
                                color: ColorUtils.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 48.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraint) {
                            return SizedBox(
                              width: Get.width,
                              child: Row(children: [
                                Stack(children: <Widget>[
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: SizedBox(
                                          width: constraint.maxWidth * .25,
                                          height: constraint.maxWidth * .25,
                                          child: Stack(
                                            children: [
                                              CircleAvatar(
                                                  radius:
                                                      constraint.maxWidth * .5,
                                                  backgroundColor:
                                                      "#DADAE6".hexToColor(),
                                                  child: Card(
                                                    elevation: 1,
                                                    margin:
                                                        EdgeInsets.all(5.sp),
                                                    color: Colors.white,
                                                    clipBehavior: Clip
                                                        .antiAliasWithSaveLayer,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(constraint
                                                                  .maxWidth *
                                                              .5),
                                                    ),
                                                    child: Obx(() =>
                                                        CustomImage.network(
                                                            controller.user
                                                                .profile_photo,
                                                            height:
                                                                constraint
                                                                        .maxWidth *
                                                                    .25,
                                                            errorWidget:
                                                                UnconstrainedBox(
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/images/ic_cc_user.svg',
                                                                color:
                                                                    ColorUtils
                                                                        .black,
                                                                height: 100.sp,
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                              ),
                                                            ),
                                                            width: constraint
                                                                    .maxWidth *
                                                                .25,
                                                            fit: BoxFit.fill)),
                                                  )),
                                              Positioned(
                                                  right: 0.sp,
                                                  top: 170.sp,
                                                  child: ImagePickerWidget(
                                                    onFilePicked: (file) {
                                                      controller
                                                          .uploadProfilePic(
                                                              file);
                                                    },
                                                    cropRatio: [
                                                      CropAspectRatioPreset
                                                          .square
                                                    ],
                                                    showPreview: false,
                                                    child: Card(
                                                      color: "#DADAE6"
                                                          .hexToColor(),
                                                      child: SvgPicture.asset(
                                                              'assets/images/new_images/profile_image/camera.svg',
                                                              color: ColorUtils
                                                                  .black,
                                                              height: 30.sp)
                                                          .marginAll(25.sp),
                                                      shape: CircleBorder(),
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                    ).visibility(true),
                                                  )),
                                            ],
                                          )))
                                ]).marginOnly(
                                    left: 60.sp, top: 30.sp, right: 30.sp),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Obx(() => CustomText(
                                              controller
                                                  .getUserFullName()
                                                  .split(" ")
                                                  .take(2)
                                                  .join(" ")
                                                  .toUpperCase(),
                                              color: ColorUtils.white,
                                              fontSize: 48.sp,
                                              maxLines: 2,
                                              customTextStyle:
                                                  CustomTextStyle.NORMAL,
                                            )),
                                        Obx(() => SvgPicture.asset(
                                              'assets/images/new_images/verify.svg',
                                              height: 45.sp,
                                              width: 45.sp,
                                            )
                                                .marginOnly(
                                                  left: 20.sp,
                                                )
                                                .visibility(controller
                                                        .user.user_status ==
                                                    "3")),
                                      ],
                                    ).marginOnly(left: 15.sp),
                                    CustomText(
                                      "${advisor_code.tr.toUpperCase()} : ${controller.getUserCode()}",
                                      color: ColorUtils.orange,
                                      fontSize: 38.sp,
                                    ).marginOnly(top: 3.sp, left: 15.sp),
                                    Container(
                                      width: 500.sp,
                                      height: 100.sp,
                                      child: RaisedButton(
                                        color: ColorUtils.orange,
                                        onPressed: () {
                                          Get.bottomSheet(
                                              Container(
                                                child: VisitingCards(),
                                                color: Colors.white,
                                                padding: EdgeInsets.only(
                                                    bottom: 30.sp),
                                              ),
                                              isScrollControlled: true);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.sp),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            CustomText(
                                              share_id_card.tr,
                                              fontSize: 36.sp,
                                              color: Colors.white,
                                            ),
                                            /*Icon(
                                              Icons.account_box_sharp,
                                              color: Colors.white,
                                            ),*/
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                        ),
                                      ),
                                    ).marginOnly(top: 30.sp, left: 12.sp),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ]),
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  CustomText(
                    details_about_you.tr.toUpperCase(),
                    color: ColorUtils.textColor,
                  ).alignTo(Alignment.topLeft),
                  SvgPicture.asset(
                    'assets/images/new_images/profile_image/information.svg',
                    height: 50.sp,
                  ).marginOnly(right: 50.sp, left: 30.sp).onClick(() {
                    controller.showSectionInfoById(2);
                  })
                ],
              ).marginSymmetric(horizontal: 40.sp, vertical: 30.sp),
              MediaQuery.removePadding(
                context: context,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, position) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50.sp,
                        width: 50.sp,
                        child: SvgPicture.asset(
                          detailList[position].first,
                          color: ColorUtils.textColor,
                        ),
                      ),
                      CustomText(
                        detailList[position].second.toString().tr,
                        color: ColorUtils.textColor,
                        fontweight: FontWeight.w400,
                      ).marginOnly(left: 50.sp),
                      Spacer(),
                      Obx(() => getProgressByPosition(position) == 100
                          ? SvgPicture.asset(
                              'assets/images/new_images/profile_image/check.svg',
                              height: 60.sp,
                            )
                          : CircularPercentIndicator(
                              radius: 70.sp,
                              lineWidth: 5.sp,
                              backgroundColor:
                                  getProgressByPosition(position) == 0
                                      ? Colors.red.shade900
                                      : ColorUtils.grey,
                              percent: double.parse(
                                      (getProgressByPosition(position))
                                          .toString()) /
                                  100,
                              center: Obx(() => CustomText(
                                    getProgressByPosition(position).toString(),
                                    fontSize: 28.sp,
                                  )),
                              progressColor:
                                  getProgressByPosition(position) < 20
                                      ? Colors.red.shade700
                                      : Colors.yellow.shade700,
                            ))
                    ],
                  )
                      .paddingOnly(
                          left: 40.sp, top: 40.sp, bottom: 40.sp, right: 40.sp)
                      .onClick(() {
                    onDetailClick(position);
                  }),
                  itemCount: detailList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 2,
                    );
                  },
                ).marginSymmetric(horizontal: 50.sp),
                removeTop: true,
              ),
              CustomText(
                other_links.tr.toUpperCase(),
                color: ColorUtils.textColor,
              )
                  .alignTo(Alignment.topLeft)
                  .marginSymmetric(horizontal: 40.sp, vertical: 30.sp),
              MediaQuery.removePadding(
                context: context,
                child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            height: 2,
                          );
                        },
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, position) => Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50.sp,
                                  width: 50.sp,
                                  child: SvgPicture.asset(
                                    otherList[position].first,
                                    color: ColorUtils.textColor,
                                  ),
                                ),
                                CustomText(
                                  otherList[position].second.toString().tr,
                                  color: ColorUtils.textColor,
                                  fontweight: FontWeight.w400,
                                ).marginOnly(left: 50.sp),
                                Spacer(),
                                Icon(
                                  Icons.chevron_right_outlined,
                                  color: ColorUtils.black,
                                )
                              ],
                            )
                                .paddingOnly(
                                    left: 40.sp,
                                    top: 40.sp,
                                    bottom: 40.sp,
                                    right: 40.sp)
                                .onClick(() {
                              _onClick(position);
                            }),
                        itemCount: otherList.length)
                    .marginSymmetric(horizontal: 50.sp),
                removeTop: true,
              ),
            ],
          ),
        ));
  }

  int getProgressByPosition(int position) {
    if (position == 0) {
      return controller.user.profile_progress;
    } else if (position == 1) {
      return controller.user.bank_detail_progress;
    } else if (position == 2) {
      return controller.user.profile_progress;
    } else {
      return controller.user.kyc_progress;
    }
  }

  List<Pair> detailList = [
    Pair.create(
        "assets/images/new_images/profile_image/personal.svg", personal),
    Pair.create("assets/images/new_images/profile_image/bank.svg", banking),
    Pair.create("assets/images/new_images/profile_image/professional.svg",
        professional_details),
    Pair.create("assets/images/new_images/profile_image/kyc.svg", kyc_details),
  ];

  List<Pair> otherList = [
    Pair.create(
        "assets/images/new_images/profile_image/privacy.svg", privacy_policy),
    Pair.create("assets/images/new_images/profile_image/rate.svg", rate_us),
    Pair.create(
        "assets/images/new_images/profile_image/about.svg", about_banksathi),
    Pair.create("assets/images/new_images/profile_image/form16.svg", about_tds),
    Pair.create("assets/images/new_images/profile_image/logout.svg", logout)
  ];

  void _onClick(int position) {
    DashboardController controller = Get.find<DashboardController>();
    if (position == 0) {
      controller.launchURL("https://www.banksathi.com/terms.html");
    } else if (position == 1) {
      controller.launchURL(
          "https://play.google.com/store/apps/details?id=com.app.banksathi");
    } else if (position == 2) {
      controller.launchURL("https://www.banksathi.com/about_us.html");
    } else if (position == 3) {
      Get.toNamed(Routes.MY_DETAIL + Routes.TDS_INFO);
    } else {
      controller.Logout();
    }
  }

  void onDetailClick(position) {
    if (position == 0) {
      Get.toNamed(Routes.MY_DETAIL + Routes.PERSONAL_DETAILS);
    } else if (position == 1) {
      Get.toNamed(Routes.MY_DETAIL + Routes.BANK_DETAILS);
    } else if (position == 2) {
      Get.toNamed(Routes.MY_DETAIL + Routes.PROFESSIONAL_DETAILS);
    } else if (position == 3) {
      Get.toNamed(Routes.MY_DETAIL + Routes.KYC_DETAILS);
    }
  }
}
