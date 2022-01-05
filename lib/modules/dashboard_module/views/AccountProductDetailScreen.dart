import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/full_screen_video_player.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/add_lead_arguments.dart';
import 'package:bank_sathi/Model/response/ProductDetailResponse.dart';
import 'package:bank_sathi/Model/response/ProductUrl.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/AccountProductDetailController.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/ProductDetailController.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:vibration/vibration.dart';
import 'ProductDialog.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:vibration/vibration.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AccountProductDetailScreen extends StatelessWidget {
  ProductDetailItem productDetail;
  ProductUrl prductUrl;

  AccountProductDetailScreen({
    Key? key,
    required this.productDetail,
    required this.prductUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductDetailController detailController =
        Get.find<ProductDetailController>();
    return GetBuilder<AccountProductDetailController>(
        init:
            AccountProductDetailController(this.productDetail, this.prductUrl),
        builder: (controller) => Column(
              children: [
                TabBar(
                    controller: controller.tabController,
                    isScrollable: true,
                    labelPadding: EdgeInsets.only(left: 0, right: 0),
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 4,
                          color: Colors.transparent,
                        ),
                        insets: EdgeInsets.only(left: 0, right: 8, bottom: 4)),
                    tabs: controller.productDetail.tab.map(
                      (e) {
                        int index = controller.productDetail.tab.indexOf(e);
                        return Obx(
                          () => ActionChip(
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: index == controller.currentPage
                                        ? ColorUtils.orange
                                        : ColorUtils.black,
                                    width: .5),
                                borderRadius: BorderRadius.circular(100.sp)),
                            label: CustomText(
                              e.tab_name,
                              fontweight: Weight.LIGHT,
                              fontSize: 36.sp,
                              color: index != controller.currentPage
                                  ? ColorUtils.textColor
                                  : ColorUtils.white,
                            ),
                            labelPadding:
                                EdgeInsets.symmetric(horizontal: 30.sp),
                            backgroundColor: index != controller.currentPage
                                ? ColorUtils.white
                                : ColorUtils.orange,
                            onPressed: () {
                              controller.tabController.animateTo(index);
                              controller.currentPage = index;
                            },
                          ),
                        ).marginOnly(
                            left: index == 0 ? 40.sp : 20.sp,
                            right:
                                index == controller.productDetail.tab.length - 1
                                    ? 40.sp
                                    : 0);
                      },
                    ).toList()),
                Expanded(
                    child: TabBarView(
                  controller: controller.tabController,
                  children: controller.productDetail.tab
                      .map((e) => SingleChildScrollView(
                            child: Html(
                              data: e.content ?? "",
                            ).marginSymmetric(horizontal: 40.sp),
                          ))
                      .toList(),
                )),
                WidgetUtil.getSecondaryButton(() {
                  // if(kReleaseMode) {
                  if (controller.productDetail.is_trained == null ||
                      controller.productDetail.is_trained == 'n') {
                    /*||
                        controller.productDetail.video_url != null ||
                        controller.productDetail.video_url != ''*/
                    Get.bottomSheet(
                        bottomSheetView(controller, detailController),
                        isScrollControlled: true,
                        isDismissible: false,
                        enableDrag: false);
                    /*Get.dialog(
                        openDialogue(controller, detailController));
                 */
                  } else if (controller.user.kyc_progress < 100) {
                    Get.toNamed(Routes.MY_DETAIL + Routes.KYC_DETAILS);
                  } else {
                    Get.bottomSheet(
                        ProductDialog(
                          data: productDetail,
                          short_url: prductUrl.data.url,
                          producturl: prductUrl,
                        ),
                        isScrollControlled: true);
                  }
                }, height: 125.sp, width: 600.sp, label: "Share to Customer")
                    .marginSymmetric(horizontal: 60.sp, vertical: 20.sp)
                    .visibility(prductUrl.data.url != null &&
                        prductUrl.data.url.isNotEmpty),
                WidgetUtil.getSecondaryButton(() {
                  if (productDetail.id == 3) {
                    AddLeadArguments arguments = AddLeadArguments();
                    arguments.leadCategoryId = 3;
                    Get.toNamed(Routes.CREDITCARDMOBILE, arguments: arguments);
                  } else if (productDetail.id == 11) {
                    Get.toNamed(Routes.DASHBOARD + Routes.KOTAK_INSURANCE);
                  } else if (productDetail.id == 4) {
                    Get.toNamed(Routes.PERSONAL_LOAN_LOGIN);
                  }
                }, height: 125.sp, width: 600.sp, label: "Add Lead")
                    .marginSymmetric(horizontal: 60.sp, vertical: 20.sp)
                    .visibility(
                        prductUrl.data.url == null || prductUrl.data.url == "")
              ],
            ));
  }
}

Widget bottomSheetView(AccountProductDetailController controller, ProductDetailController detailController) {
  late YoutubePlayerController ycontroller = YoutubePlayerController(
    initialVideoId: controller.productDetail.video_url != null
        ? controller.productDetail.video_url.toString().videoId!
        : '',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      // hideControls: true,
      disableDragSeek: true,
      isLive: false,
      controlsVisibleAtStart: false,
      mute: false,
    ),
  );

  return WillPopScope(
      child: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(
                color: ColorUtils.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.sp),
                  topRight: Radius.circular(50.sp),
                ),
              ),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          ScreenUtil().screenHeight / ScreenUtil().screenWidth <
                                  1.30
                              ? ScreenUtil().screenWidth / 10
                              : 0),
                  child: Column(
                    children: [
                      CustomText(
                        'Learning is the key of Earning.',
                      ).marginOnly(top: 30.sp),
                      Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          margin: EdgeInsets.only(top: 50.sp, bottom: 50.sp),
                          width: (Get.width * .95),
                          height: ((Get.width * .95) / 16) * 9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.sp),
                            child: YoutubePlayer(
                              controller: ycontroller,
                              //Add videoID.
                              onEnded: (YoutubeMetaData metaData) async {
                                Get.back();
                                if (controller.productDetail.quiz != null &&
                                    controller.productDetail.quiz.length != 0)
                                  Get.dialog(openDialogue(
                                      controller, detailController));
                                else
                                  Get.bottomSheet(
                                      ProductDialog(
                                        data: controller.productDetail,
                                        short_url: controller
                                                .productDetail.share_link +
                                            controller.getUserCode(),
                                        producturl: controller.prductUrl,
                                      ),
                                      isScrollControlled: true);
                              },
                              showVideoProgressIndicator: true,
                             /* bottomActions: [
                                SizedBox(width: 14.0),
                                CurrentPosition(),
                                SizedBox(width: 8.0),
                                Center(
                                  child: IgnorePointer(
                                    child: ProgressBar(
                                      isExpanded: true,
                                    ),
                                    ignoring: true,
                                  ),
                                ),
                                RemainingDuration(),
                              ],*/
                              progressColors: ProgressBarColors(
                                  playedColor: Colors.amber,
                                  handleColor: Colors.amberAccent),
                            ),
                          )).adjustForTablet(),
                      Row(
                        children: [
                          CustomText('Watch Later')
                              .marginOnly(left: 10)
                              .onClick(() => Get.back()),
                          Spacer(),
                          Row(
                            children: [
                              CustomText('Full Screen'),
                              Icon(Icons.fullscreen).marginSymmetric(
                                  horizontal: 30.sp, vertical: 30.sp)
                            ],
                          ).onClick(() async {
                            Get.back();
                            bool? isVideoEnded = await Get.to(
                                FullScreenVideoPlayer(
                                    videoId: detailController.productDetailItem!
                                        .video_url!.videoId!));
                            if (isVideoEnded != null && isVideoEnded == true) {
                              if (controller.productDetail.quiz != null &&
                                  controller.productDetail.quiz.length != 0)
                                Get.dialog(
                                    openDialogue(controller, detailController));
                              else
                                Get.bottomSheet(
                                    ProductDialog(
                                      data: controller.productDetail,
                                      short_url:
                                          controller.productDetail.share_link +
                                              controller.getUserCode(),
                                      producturl: controller.prductUrl,
                                    ),
                                    isScrollControlled: true);
                            }
                          }),
                        ],
                      )
                    ],
                  )).adjustForTablet())),
      onWillPop: () async {
        return false;
      });
}

Widget openDialogue(AccountProductDetailController controller, ProductDetailController detailController) {
  return Scaffold(
    body: Stack(
      children: [
        Container(
          color: '#2a2d34'.hexToColor().withAlpha(220),
        ),
        SafeArea(
          child: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: Column(
                  children: [
                    Center(
                      child: Text('Better Your Knowledge',
                          textAlign: TextAlign.center,
                          style: StyleUtils.textStyleNormalPoppins(
                              color: ColorUtils.white_dull,
                              weight: FontWeight.w600,
                              fontSize: 44.sp)),
                    ).marginOnly(top: 15.sp),
                    Center(
                      child: Text(
                          'Answer some simple questions that will improve your product knowledge!',
                          textAlign: TextAlign.center,
                          style: StyleUtils.textStyleNormalPoppins(
                              color: ColorUtils.white_dull,
                              weight: FontWeight.w300,
                              fontSize: 36.sp)),
                    ).marginOnly(top: 15.sp),
                  ],
                ),
              ),
              Container(
                height: Get.height / 1.5,
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller.pageController,
                  itemCount: detailController.productDetailItem!.quiz.length,
                  itemBuilder: (context, index) => cardView(
                      detailController.productDetailItem!.quiz[index],
                      controller,
                      detailController,
                      detailController.productDetailItem!.quiz.length,
                      index + 1),
                  // QuestionCard(question: _questionController.questions[index]),
                ),
              ).marginOnly(top: 30.sp),
            ],
          )),
        )
      ],
    ),
  );
}

Widget cardView(Quiz question, AccountProductDetailController controller, ProductDetailController detailController, int totalQue, int queNo) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 50.sp),
    padding: EdgeInsets.all(50.sp),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(40.sp),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Question ${queNo}',
                    style: StyleUtils.textStyleNormalPoppins(
                        color: ColorUtils.greylight,
                        weight: FontWeight.w400,
                        fontSize: 42.sp)),
                Text('/${totalQue}',
                    style: StyleUtils.textStyleNormalPoppins(
                        color: ColorUtils.greylight,
                        weight: FontWeight.w400,
                        fontSize: 42.sp)),
              ],
            ),
            SizedBox(
              width: 160.sp,
              child: Divider(thickness: 5.sp, color: ColorUtils.orange),
            ),
            SizedBox(
              height: 30.sp,
            ),
            CustomText(
              question.que_title,
            ),
          ],
        ),
        SizedBox(height: 30.sp),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: question.ansoptions.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Obx(() => Container(
                  margin: EdgeInsets.only(top: 60.sp),
                  padding: EdgeInsets.all(45.sp),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: (!question.ansoptions[index]!.is_clicked.value
                                ? Colors.grey
                                : question.ansoptions[index].is_correct == 'n'
                                    ? Colors.red
                                    : Colors.green)
                            .withOpacity(0.2)),
                    color: (!question.ansoptions[index].is_clicked.value
                            ? Colors.grey
                            : question.ansoptions[index].is_correct == 'n'
                                ? Colors.red
                                : Colors.green)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30.sp),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          question.ansoptions[index].ans_title,
                          style: StyleUtils.textStyleNormalPoppins(
                              color: !question
                                      .ansoptions[index]!.is_clicked.value
                                  ? ColorUtils.textColorLight
                                  : question.ansoptions[index].is_correct == 'n'
                                      ? Colors.red
                                      : Colors.green,
                              weight: FontWeight.w400,
                              fontSize: 42.sp),
                        ),
                      ),
                      Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                            color: !question.ansoptions[index].is_clicked.value
                                ? ColorUtils.lightDivider
                                : question.ansoptions[index].is_correct == 'n'
                                    ? Colors.red
                                    : Colors.green,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: !question
                                      .ansoptions[index].is_clicked.value
                                  ? Colors.white
                                  : question.ansoptions[index].is_correct == 'n'
                                      ? Colors.red
                                      : Colors.green,
                            ),
                          ),
                          child: !question.ansoptions[index].is_clicked.value
                              ? Icon(
                                  Icons.circle_rounded,
                                  size: 23,
                                  color: Colors.white,
                                )
                              : question.ansoptions[index].is_correct == 'n'
                                  ? Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.done,
                                      size: 16,
                                      color: Colors.white,
                                    ))
                    ],
                  ),
                ).onClick(() async {
                  question.ansoptions[index].is_clicked.value = true;
                  if (question.ansoptions[index].is_correct == 'n') {
                    Vibration.vibrate(duration: 100);
                    controller.update();
                  } else {
                    controller.update();
                    if (queNo == totalQue) {
                      await detailController.trainingCompleteApi();
                      detailController.productDetailApi();
                      Get.dialog(detailController
                          .trainingCompleteDialogue(detailController));
                    } else {
                      controller.pageController.nextPage(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.linear);
                    }
                  }
                }));
          },
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}
