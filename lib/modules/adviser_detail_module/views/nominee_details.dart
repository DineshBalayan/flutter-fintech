import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/Helpers/style_util.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/modules/adviser_detail_module/controllers/personal_details_controller.dart';
import 'package:bank_sathi/translations/string_keys.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

class NomineeDetails extends StatefulWidget {
  const NomineeDetails({Key? key}) : super(key: key);

  @override
  _NomineeDetailsState createState() => _NomineeDetailsState();
}

class _NomineeDetailsState extends State<NomineeDetails> {
  PersonalDetailsController controller = Get.find<PersonalDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          Container(
            margin: EdgeInsets.only(left: 50.sp,right: 50.sp),
            child:Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.sp)),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: controller.formGlobalKey,
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 60.sp),
                            CustomText(
                              add_nominee.tr,
                              fontSize: 48.sp,
                            ),
                            Container(
                              width: 180.sp,
                              height: 2,
                              color: ColorUtils.orange,
                            ).marginSymmetric(vertical: 30.sp),
                            CustomTextField(
                              controller: controller.nomineeNameController,
                              textField: nominee_name.tr,
                              outlinedBorder: true,
                              keyboardType: TextInputType.name,
                              isRequired: true,
                              onChanged: (text) {
                                if(text!.contains(RegExp("[0-9.!#@%&'*+-/,=?^_`{|<>}~;:]")) ){
                                  Fluttertoast.showToast(msg: 'Number not allowed.');
                                  controller.nomineeNameController.text = '';
                                }
                              },
                            ).paddingOnly(top:20.sp),
                            CustomTextField(
                              controller: controller.nomineeRelationController,
                              textField: nominee_relation.tr,
                              outlinedBorder: true,
                              keyboardType: TextInputType.name,
                              isRequired: true,
                            ),
                          ],
                        ).marginOnly(left: 50.sp,right: 50.sp,top:20.sp,bottom: 20.sp),
                      ),
                      CustomText(
                        enter_dob.tr,
                        textAlign: TextAlign.start,
                        fontSize: 32.sp,
                      ).marginOnly(left: 55.sp,right: 50.sp),
                      Container(
                        child: IgnorePointer(
                          child: CustomTextField(
                            controller: controller.nomineeController,
                            hint: 'Select Nominee Date of Birth',
                            outlinedBorder: true,
                            isEnabled: false,
                            prefixIcon: 'assets/images/new_images/profile_image/calendar.svg',
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ).onClick(() {
                        controller.selectDate(true);
                      }).marginOnly(left: 50.sp,right: 50.sp,top:10.sp,bottom: 20.sp),
                      WidgetUtil.getStateButton(
                        controller: controller,
                        color: ColorUtils.orange,
                        onPressed: () {
                          controller.savePersonalDetails('nominee');
                        },
                        textStyle: StyleUtils.textStyleNormalPoppins(
                            color: ColorUtils.white,
                            weight: FontWeight.w400,
                            fontSize: 36.sp),
                        width: 600.sp,
                        label: add_nominee_now.tr,
                      ).marginOnly(top: 60.sp),
                      SizedBox(height: 60.sp),
                    ],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
