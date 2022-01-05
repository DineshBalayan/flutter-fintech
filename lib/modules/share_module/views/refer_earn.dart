import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/response/ProductDetailResponse.dart';
import 'package:bank_sathi/modules/dashboard_module/controllers/share_tab_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_network_image.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ReferEarn extends GetView<ShareTabController> {
  RxList<Faq> faqList = [
    Faq(
        que: "What is the benefit I get on referring Banksathi?",
        ans:
            "When your friends sign up on the BankSathi app using your referral code, you earn a referral amount of 10% of their earnings."),
    Faq(
        que: "How can I refer my friend to Banksathi?",
        ans:
            "Referring your friend to Banksathi is easy! You can share via WhatsApp/Facebook/Instagram/Twitter/Message/E-Mail and much more."),
    Faq(
        que: "How do I know that my referral has been considered?",
        ans:
            "If anyone downloads and registers using your referral link, they will be shown on your team."),
    Faq(
        que: "How many friends can I refer?",
        ans: "You can refer as many friends as you wish."),
    Faq(
        que: "How will I get the Referral benefit?",
        ans:
            "If earnings are made by the friends you have referred, you will receive 10% commission on that income in your wallet"),
  ].obs;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 2 / 1,
            child: Stack(
              children: [
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.sp),
                    ),
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: CustomImage.network(
                        'https://www.youtube.com/watch?v=QRNWMtsrn64'.thumbnail,
                        width: Get.width,
                        fit: BoxFit.fill)),
                Positioned.fill(
                    child: Center(
                  child: SvgPicture.asset(
                    'assets/images/new_images/play_testimonial.svg',
                    width: 150.sp,
                    color: Colors.white,
                  ),
                ))
              ],
            ).onClick(() {
              Get.dialog(WidgetUtil.videoDialog(
                  'https://www.youtube.com/watch?v=QRNWMtsrn64'.videoId!));
            }),
          ).marginOnly(top: 20.sp),
          CustomText(
            'How to earn by Referral?',
            fontweight: FontWeight.w600,
            fontSize: 44.sp,
          ).marginOnly(top: 35.sp),
          CustomText(
            'Refer BankSathi app to your Friends or Family and start earning referral income of up to 10% on the Income earned by your referrals by their leads.',
            color: ColorUtils.greylight.withAlpha(200),
            textAlign: TextAlign.center,
            fontSize: 34.sp,
          ).marginAll(
            15.sp,
          ),
          AspectRatio(
              aspectRatio: 4.4,
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    color: '#FCF1ED'.hexToColor(),
                    borderRadius: BorderRadius.circular(40.sp)),
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/images/new_images/top_curve.svg',
                      color: ColorUtils.topCurveColor,
                      width: 600.sp,
                    ).alignTo(Alignment.topRight),
                    Positioned.fill(
                        child: Align(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                'Advisor Code :',
                                color: ColorUtils.orange_gr_light,
                                fontSize: 40.sp,
                              ),
                              Obx(
                                () => CustomText(
                                  controller.user.user_code != null
                                      ? controller.user.user_code
                                              .substring(0, 6) +
                                          "/" +
                                          controller.user.user_code.substring(6)
                                      : '',
                                  style: StyleUtils.textStyleNormalPoppins(
                                          fontSize: 52.sp,
                                          weight: FontWeight.w600)
                                      .copyWith(letterSpacing: 2),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 140.sp,
                            height: 125.sp,
                            padding: EdgeInsets.only(
                                left: 35.sp,
                                right: 35.sp,
                                top: 25.sp,
                                bottom: 25.sp),
                            decoration: BoxDecoration(
                                color: "#FEF6F3".hexToColor(),
                                border: Border.all(
                                    color:
                                        ColorUtils.textColorLight.withAlpha(30),
                                    width: 1),
                                borderRadius: BorderRadius.circular(30.sp)),
                            child: SvgPicture.asset(
                                'assets/images/new_images/copy.svg'),
                          ).onClick(() async {
                            await Clipboard.setData(ClipboardData(
                                text: controller.referContent.first));
                            Fluttertoast.showToast(msg: refer_copy.tr);
                          }),
                          SizedBox(
                            width: 320.sp,
                            child: WidgetUtil.getSecondaryButton(() {
                              controller.shareReferralLink();
                            }, color: false, label: 'Refer Now'),
                          )
                        ],
                      ).marginAll(30.sp),
                      alignment: Alignment.center,
                    ))
                  ],
                ),
              )).marginOnly(top: 40.sp),
          CustomText(
            'Frequently asked Questions :',
            color: ColorUtils.greylight.withAlpha(200),
            textAlign: TextAlign.start,
            fontSize: 40.sp,
          )
              .marginOnly(top: 60.sp, left: 10.sp, right: 20.sp, bottom: 30.sp)
              .alignTo(Alignment.centerLeft),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, position) {
              return Obx(() => ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    tilePadding: EdgeInsets.zero,
                    trailing: faqList[position].isExpanded.value
                        ? Icon(
                            Icons.remove,
                            size: 48.sp,
                            color: ColorUtils.textColor,
                          )
                        : Icon(
                            Icons.add,
                            size: 48.sp,
                            color: ColorUtils.textColor,
                          ),
                    title: CustomText(faqList[position].que),
                    maintainState: true,
                    onExpansionChanged: (isExpanded) {
                      faqList[position].isExpanded.value = isExpanded;
                    },
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        faqList[position].ans,
                        color: ColorUtils.greylight,
                        fontSize: 36.sp,
                      ).marginOnly(bottom: 32.sp).alignTo(Alignment.topLeft)
                    ],
                  ));
            },
            shrinkWrap: true,
            itemCount: faqList.length,
          ).marginSymmetric(horizontal: 10.sp)
        ],
      ).marginOnly(left: 40.sp, right: 40.sp),
    ));
  }
}
