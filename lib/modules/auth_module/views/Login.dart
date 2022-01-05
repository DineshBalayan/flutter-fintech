import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/custom_paints/login_bottom_cloud_shape.dart';
import 'package:bank_sathi/modules/auth_module/controllers/login_controller.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class Login extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(1080, 2280));
    return Scaffold(
      body: BasePageView(
          controller: controller,
          idleWidget: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Image.asset(
                'assets/images/login/login_bg.jpg',
                fit: BoxFit.fitWidth,
                width: Get.width,
              ),
              Positioned(
                top: 400.sp,
                left: 100.sp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/images/login/rupee.svg',
                      width: 230.sp,
                    ),
                    CustomText(
                      earning_by_selling.tr,
                      color: '#b9c1d8'.hexToColor(),
                      fontSize: 42.sp,
                    ).marginOnly(
                      top: 70.sp,
                    ),
                    AnimatedTextKit(
                      repeatForever: true,
                      isRepeatingAnimation: true,
                      pause: 100.milliseconds,
                      animatedTexts: [
                        TypewriterAnimatedText('Loans',
                            speed: 100.milliseconds,
                            textStyle: GoogleFonts.poppins(
                                color: ColorUtils.orange,
                                fontWeight: FontWeight.w600,
                                fontSize: 74.sp)),
                        TypewriterAnimatedText('Credit Cards',
                            speed: 100.milliseconds,
                            textStyle: GoogleFonts.poppins(
                                color: ColorUtils.orange,
                                fontWeight: FontWeight.w600,
                                fontSize: 74.sp)),
                       /* TypewriterAnimatedText('Insurance',
                            speed: 100.milliseconds,
                            textStyle: GoogleFonts.poppins(
                                color: ColorUtils.orange,
                                fontWeight: FontWeight.w600,
                                fontSize: 74.sp)),*/
                        TypewriterAnimatedText('Saving Account',
                            speed: 100.milliseconds,
                            textStyle: GoogleFonts.poppins(
                                color: ColorUtils.orange,
                                fontWeight: FontWeight.w600,
                                fontSize: 74.sp)),
                      ],
                      onTap: () {},
                    ),
                    Container(
                      height: 6.sp,
                      width: 150.sp,
                      decoration: BoxDecoration(
                          color: ColorUtils.orange,
                          borderRadius: BorderRadius.circular(10)),
                    ).marginOnly(top: 5.sp, left: 5.sp)
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: Get.height / 1.9,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CustomPaint(
                          painter: LoginBottomCloudShape(),
                          child: Container(
                            width: Get.width,
                            height: Get.width,
                            child: Padding(
                              padding: EdgeInsets.all(20.sp),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    mobile_required_continue.tr,
                                    fontSize: 55.sp,
                                    fontweight: Weight.BOLD,
                                  ).alignTo(Alignment.topLeft).marginOnly(
                                      bottom: 20.sp, left: 100.sp, top: 300.sp),
                                  CustomText(
                                    mobile_required_continue_msg.tr,
                                    color: ColorUtils.grey,
                                    fontSize: 42.sp,
                                    fontweight: FontWeight.w400,
                                  ).alignTo(Alignment.topLeft).marginOnly(
                                      bottom: 40.sp,
                                      left: 100.sp,
                                      right: 50.sp),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: Get.width * .56,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/login/phone.svg',
                                                  height: 52.sp,
                                                  color:
                                                      ColorUtils.textColorLight,
                                                ).marginOnly(bottom: 40.sp),
                                                Expanded(
                                                    child: TextField(
                                                  maxLength: 10,
                                                  autofocus: true,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                                    FilteringTextInputFormatter.deny(RegExp("[a-zA-Z.!#@%&'*+-/,=?^_`{|<>}~;:]")),
                                                  ],
                                                  onChanged: (val) {
                                                    if (val.length == 10) {
                                                      context.hideKeyboard();
                                                    }else if(val.isNotEmpty && val.length<2 && val.toInt() < 6 ){
                                                      controller.isInputValid = false;
                                                      controller.inputController.text = '';
                                                      if(controller.isMsgShowed==false)
                                                        Fluttertoast.showToast(msg: 'Enter Correct mobile number');
                                                      controller.isMsgShowed= true;
                                                    }
                                                  },
                                                  focusNode:
                                                      controller.focusNode,
                                                  decoration: InputDecoration(
                                                      counter: Container(),
                                                      isDense: true,
                                                      labelText: mobile_no.tr,
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .never,
                                                      prefixStyle: StyleUtils
                                                          .textStyleMediumPoppins(
                                                              fontSize: 52.sp,
                                                              isBold: false),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 0.sp),
                                                      border: InputBorder.none,
                                                      prefixText: "  +91  "),
                                                  controller: controller
                                                      .inputController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: StyleUtils
                                                      .textStyleMediumPoppins(
                                                          fontSize: 52.sp,
                                                          isBold: false),
                                                )),
                                                UnconstrainedBox(
                                                  child: Obx(() =>
                                                      SvgPicture.asset(
                                                        'assets/images/ic_check.svg',
                                                        fit: BoxFit.scaleDown,
                                                        height: 45.sp,
                                                        width: 45.sp,
                                                      ).visibility(controller
                                                          .showCheckIcon)),
                                                ).marginOnly(bottom: 40.sp),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 1,
                                            width: Get.width * .58,
                                            color: Colors.grey.shade300,
                                          ).marginOnly(top: 10.sp)
                                        ],
                                      ).marginOnly(top: 5.sp),
                                      Card(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Container(
                                            width: Get.width * .20,
                                            height: 150.sp,
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                  ColorUtils.orange_gr_light,
                                                  ColorUtils.orange_gr_dark
                                                ])),
                                            child: Obx(
                                              () => UnconstrainedBox(
                                                child: controller.pageState ==
                                                        PageStates
                                                            .PAGE_BUTTON_LOADING
                                                    ? CircularProgressIndicator(
                                                        color: ColorUtils.white,
                                                      ).marginAll(5)
                                                    : SvgPicture.asset(
                                                        'assets/images/login/right.svg',
                                                        width: 75.sp,
                                                        fit: BoxFit.scaleDown,
                                                      ),
                                              ).onClick(
                                                  controller.validateAndLogin),
                                            ),
                                          ))
                                    ],
                                  ).marginOnly(
                                      top: 100.sp,
                                      left: Get.width * .09,
                                      right: Get.width * .05),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          color: Colors.white,
                        ))
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}
