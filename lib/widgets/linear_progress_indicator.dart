import 'package:bank_sathi/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LinearProgressBar extends StatelessWidget {
  late BaseController controller;

  LinearProgressBar(this.controller);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Visibility(
        visible: controller.isLoading, child: LinearProgressIndicator()));
  }
}
