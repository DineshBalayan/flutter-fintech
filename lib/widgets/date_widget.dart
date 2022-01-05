import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:bank_sathi/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DateWidget extends StatelessWidget {
  DateWidgetController controller;
  final onChanged;
  String dd = '';
  String mm = '';
  String yy = '';

  DateWidget({required this.controller, Key? key, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: constraints.maxWidth * .22,
                  child: CustomTextField(
                    controller: controller.dateController,
                    maxLength: 2,
                    textAlign: TextAlign.center,
                    hideleftspace: true,
                    fontsize: 48.sp,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      if (value!.length == 2) {
                        controller.validate(false);
                        dd = value;
                        return onChanged('$dd/$mm/$yy');
                      }
                    },
                    hint: "DD",
                  ),
                ),
                SizedBox(
                  width: constraints.maxWidth * .05,
                  child: CustomText(
                    "-",
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: constraints.maxWidth * .22,
                  child: CustomTextField(
                    controller: controller.monthController,
                    textAlign: TextAlign.center,
                    hideleftspace: true,
                    fontsize: 48.sp,
                    hint: "MM",
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      if (value!.length == 2) {
                        controller.validate(true);
                        mm = value;
                        return onChanged('$dd/$mm/$yy');
                      }
                    },
                    maxLength: 2,
                  ),
                ),
                SizedBox(
                  width: constraints.maxWidth * .05,
                  child: CustomText(
                    "-",
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: constraints.maxWidth * .22,
                  child: CustomTextField(
                    controller: controller.yearController,
                    textAlign: TextAlign.center,
                    fontsize: 48.sp,
                    hideleftspace: true,
                    maxLength: 4,
                    onChanged: (value) {
                      if (value!.length == 4) {
                        controller.validate(false);
                        yy = value;
                        return onChanged('$dd/$mm/$yy');
                      }
                    },
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    hint: "YYYY",
                  ),
                ),
                SizedBox(
                    width: constraints.maxWidth * .15,
                    height: constraints.maxWidth * .15,
                    child: Card(
                      color: ColorUtils.lightShade,
                      child: UnconstrainedBox(
                        child: SvgPicture.asset(
                            'assets/images/new_images/profile_image/calendar.svg',
                            width: constraints.maxWidth * .07,
                            color: ColorUtils.black),
                      ),
                      shape: CircleBorder(),
                      elevation: 0.sp,
                      clipBehavior: Clip.antiAlias,
                    )).onClick(() => _selectDate())
              ],
            ),
            Obx(() => CustomText(
                  controller.errorMessage,
                  color: Colors.redAccent,
                  fontSize: 30.sp,
                ).visibility(!controller.isValid)),
          ],
        );
      },
    );
  }

  _selectDate() async {
    DateTime initDate = DateTime.now();
    if (controller.lastDate != null) {
      if (controller.date != null) {
        if (controller.date!.isAfter(controller.lastDate!)) {
          initDate = DateTime(1990, 1, 1);
        } else {
          initDate = controller.date!;
        }
      } else {
        initDate = DateTime(1990, 1, 1);
      }
    } else {
      if (controller.date != null) {
        initDate = controller.date!;
      } else {
        initDate = DateTime(1990, 1, 1);
      }
    }

    DateTime? date = await showDatePicker(
        context: Get.context!,
        initialDate: initDate,
        firstDate: controller.firstDate ?? DateTime(1960, 1, 1),
        lastDate: controller.lastDate ?? DateTime.now());
    if (date != null) {
      controller.date = date;
      controller.setDate();
    }
  }
}

class DateWidgetController extends BaseController {
  final DateTime? lastDate;
  final DateTime? firstDate;

  final _errorMessage = 'Please enter correct date.'.obs;

  get errorMessage => _errorMessage.value;

  set errorMessage(val) => _errorMessage.value = val;

  final isRequired;
  TextEditingController dateController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  final _date = Rxn<DateTime?>();

  DateWidgetController({
    this.isRequired = false,
    this.firstDate,
    this.lastDate,
  });

  DateTime? get date => _date.value;

  set date(val) => _date.value = val;

  RxBool _isValid = true.obs;

  get isValid => _isValid.value;

  set isValid(val) => _isValid.value = val;

  @override
  void onInit() {
    super.onInit();
  }

  bool isBlank() {
    return dateController.text.isEmpty &&
        monthController.text.isEmpty &&
        yearController.text.isEmpty;
  }

  setDate() {
    if (date != null) {
      dateController.text = date!.day.toString().padLeft(2, "0");
      monthController.text = date!.month.toString().padLeft(2, "0");
      yearController.text = date!.year.toString();
    } else {
      dateController.text = '';
      monthController.text = '';
      yearController.text = '';
    }
  }

  assignDate() {}

  bool validate(bool isRequired) {
    if (dateController.text.isEmpty &&
        monthController.text.isEmpty &&
        yearController.text.isEmpty) {
      isValid = !isRequired;
    } else {
      final day = int.tryParse(dateController.text);
      final month = int.tryParse(monthController.text);
      final year = int.tryParse(yearController.text);
      if (day != null && month != null && year != null) {
        final newDate = DateTime(year, month, day);
        if (newDate.year == year &&
            newDate.month == month &&
            newDate.day == day) {
          date = newDate;
          setDate();
          if (lastDate != null && newDate.isAfter(lastDate!)) {
            isValid = false;
            errorMessage =
                'Date should be between ${firstDate.toUiDate()} - ${lastDate.toUiDate()}';
          } else if (firstDate != null && newDate.isBefore(firstDate!)) {
            isValid = false;
            errorMessage =
                'Date should be between ${firstDate.toUiDate()} - ${lastDate.toUiDate()}';
          } else {
            isValid = true;
          }
        } else
          isValid = false;
      } else {
        isValid = false;
      }
    }
    return isValid;
  }

  String getServerDate() {
    return date == null ? "" : date!.toServerDate() ?? "";
  }

  void setInitDate(DateTime? dateTime) {
    try {
      date = dateTime;
      setDate();
    } catch (e) {
      print(e);
    }
  }
}
