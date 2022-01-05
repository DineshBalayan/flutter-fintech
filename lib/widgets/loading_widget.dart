import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Center(
          child: Card(
            child: Padding(
                padding: EdgeInsets.all(30),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    backgroundColor: ColorUtils.white,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(ColorUtils.orange),
                    strokeWidth: 5.0,
                  ),
                )),
          ),
        ),
        onWillPop: () async => false);
  }
}
