import 'dart:math';

import 'package:bank_sathi/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorController extends BaseController {
  final _totalInterest = '0.0'.obs;

  get totalInterest => _totalInterest.value;

  set totalInterest(val) => _totalInterest.value = val;

  final RxDouble _principleAmount = 400000.0.obs;

  double get principleAmount => _principleAmount.value;

  final _selectedProduct = 0.obs;

  int get selectedProduct => _selectedProduct.value;

  set selectedProduct(int val) {
    _selectedProduct.value = val;
    if (months != 0) months = 0;
    if (val == 0) {
      principleAmount = 400000;
      interestRate = 15.0;
      year = 4;
    } else if (val == 1) {
      principleAmount = 2500000;
      interestRate = 6.7;
      year = 20;
    } else if (val == 2) {
      principleAmount = 500000;
      interestRate = 16.0;
      year = 3;
    } else if (val == 3) {
      principleAmount = 100000;
      interestRate = 18.0;
      year = 1;
    }
    loanAmountController.text = principleAmount.currencyFormat();
    rateController.text = interestRate.toPrecision(2).toString() + " %";
    yearController.text = year.toString();
    monthController.text = months.toString();
  }

  set principleAmount(double val) {
    _principleAmount.value = val;
    _handleCalculation();
  }

  final _interestRate = 15.0.obs;

  double get interestRate => _interestRate.value;

  set interestRate(val) {
    _interestRate.value = val;
    _handleCalculation();
  }

  final _year = 4.obs;

  int get year => _year.value;

  set year(val) {
    _year.value = val;
    _handleCalculation();
  }

  final _months = 0.obs;

  int get months => _months.value;

  set months(val) {
    _months.value = val;
    _handleCalculation();
  }

  final _emiResult = '0.0'.obs;

  get emiResult => _emiResult.value;

  set emiResult(val) => _emiResult.value = val;

  late TextEditingController loanAmountController,
      rateController,
      yearController,
      monthController;

  @override
  void onInit() {
    super.onInit();
    loanAmountController = TextEditingController.fromValue(
        TextEditingValue(text: principleAmount.toString()));
    loanAmountController.addListener(() {
      if (loanAmountController.text.isNotEmpty &&
          loanAmountController.text.isNum)
        principleAmount = double.tryParse(loanAmountController.text) ?? 0;

      _handleCalculation();
    });

    rateController = TextEditingController.fromValue(
        TextEditingValue(text: interestRate.toString()));
    rateController.addListener(() {
      if (rateController.text.isNotEmpty && rateController.text.isNum)
        interestRate = double.tryParse(rateController.text);
      _handleCalculation();
    });

    yearController = TextEditingController.fromValue(
        TextEditingValue(text: year.toString()));
    yearController.addListener(() {
      if (yearController.text.isNotEmpty && yearController.text.isNum)
        year = int.tryParse(yearController.text);
      _handleCalculation();
    });

    monthController = TextEditingController.fromValue(
        TextEditingValue(text: months.toString()));
    monthController.addListener(() {
      if (monthController.text.isNotEmpty && monthController.text.isNum)
        months = int.tryParse(monthController.text);
      _handleCalculation();
    });
  }

  void _handleCalculation() {
    double A = 0.0;
    double P = principleAmount;
    double r = interestRate / 12 / 100;
    int n = year * 12 + months;
    if (year == 0 && months == 0) {
      A = 0;
    } else {
      A = (P * r * pow((1 + r), n) / (pow((1 + r), n) - 1));
    }

    emiResult = "₹ " + A.toStringAsFixed(2);
    if (n != 0)
      totalInterest = "₹ " + ((A * n) - P).toStringAsFixed(2);
    else
      totalInterest = "₹ 0.0";
  }
}
