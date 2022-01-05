import 'dart:async';

import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:bank_sathi/modules/dashboard_module/leads_module/controllers/webview_launcher_controller.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewLauncher extends StatelessWidget {
  WebviewLauncherController controller = Get.put(WebviewLauncherController());

  String? url;
  String? title;
  final Completer<WebViewController> webViewCompleterController =
      Completer<WebViewController>();

  WebViewLauncher({this.url, this.title});

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    return Scaffold(
      backgroundColor: ColorUtils.window_bg,
      appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.clear,
              size: 30,
              color: ColorUtils.black,
            ),
          ).onClick(() {
            Get.back();
          }),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: CustomText(
            title.toString().capitalizeFirst,
            textAlign: TextAlign.center,
            style: GoogleFonts.mulish(
                color: ColorUtils.bluebutton,
                fontWeight: FontWeight.w600,
                fontSize: 48.sp),
          ),
          actions: [
            Visibility(
                child: SvgPicture.asset(
              'assets/images/logo_banksathi_inverted.svg',
              height: 32,
            )).marginOnly(right: 20)
          ]),
      body: WillPopScope(
          child: WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              webViewCompleterController.complete(webViewController);
            },
            javascriptChannels: <JavascriptChannel>[
              _toasterJavascriptChannel(context),
            ].toSet(),
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                print('blocking navigation to $request}');
                return NavigationDecision.prevent;
              }
              print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              controller.showLoadingDialog();
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              Future.delayed(2.seconds, () => controller.hideDialog());
              print('Page finished loading: $url');
            },
            gestureNavigationEnabled: true,
          ),
          onWillPop: () async {
            return true;
          }),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
