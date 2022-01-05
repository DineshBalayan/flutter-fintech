import 'package:bank_sathi/Model/response/ProductDetailResponse.dart';
import 'package:bank_sathi/Model/response/ProductUrl.dart';
import 'package:bank_sathi/Model/response/base_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/modules/dashboard_module/views/ProductDialog.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ProductDetailController extends BaseController {
  Rxn<ProductDetailItem?> _productDetailItem = Rxn<ProductDetailItem?>();

  ProductDetailItem? get productDetailItem => _productDetailItem.value;

  set productDetailItem(val) => _productDetailItem.value = val;

  Rxn<ProductUrl> _productURL = Rxn<ProductUrl>();

  ProductUrl? get productURL => _productURL.value;

  set productURL(val) => _productURL.value = val;

  @override
  void onReady() async {
    super.onReady();
    await productDetailApi();
    await productUrl();
  }

  productDetailApi() async {
    String productId = Get.parameters['product_id'] as String;
    try {
      pageState = PageStates.PAGE_LOADING;
      ProductDetailResponse productDetailResponse =
          await restClient.productDetail(productId, getUserId());
      pageState = PageStates.PAGE_IDLE;
      productDetailItem = productDetailResponse.data;
    } catch (e) {
      print(e);
      e.printInfo();
      pageState = PageStates.PAGE_IDLE;
    }
  }

  productUrl() async {
    String productId = Get.parameters['product_id'] as String;
    String userCode = prefManager.getUserData()!.user_code;
    try {
      pageState = PageStates.PAGE_LOADING;
      ProductUrl productUrl = await restClient.productUrl(productId, userCode);
      pageState = PageStates.PAGE_IDLE;
      productURL = productUrl;
    } catch (e) {
      print(e);
      e.printInfo();
      pageState = PageStates.PAGE_IDLE;
    }
  }

  trainingCompleteApi() async {
    try {
      pageState = PageStates.PAGE_LOADING;
      BaseResponse response = await restClient.trainingComplete(
          Get.parameters['product_id'] as String, getUserId());
      pageState = PageStates.PAGE_IDLE;
      Get.back();
    } catch (e) {
      print(e);
      e.printInfo();
      pageState = PageStates.PAGE_IDLE;
    }
  }

  Widget trainingCompleteDialogue(ProductDetailController controller) {
    return Center(
      child: Wrap(
        children: [
          Card(
            margin: const EdgeInsets.all(25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Stack(
                children: [
                  Container(child: Column(
                    children: [
                      Text(
                        'Congratulations',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 60.sp),
                      Text(
                        'You have successfully completed your one time product information step',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black38,
                            letterSpacing: 0.5,
                            height: 1.4,
                            fontSize: 14),
                      ),
                      SizedBox(height: 60.sp),
                      Divider(
                        height: 1.5,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 60.sp),
                      Text(
                        'Please Complete your KYC before sharing lead to hassle free experience ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            letterSpacing: 0.5,
                            height: 1.4),
                      ),
                      SizedBox(height: 60.sp),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        width: 220,
                        height: 50,
                        child: Center(
                          child: CustomText(
                            user.kyc_progress < 100
                                ? 'Complete My KYC'
                                : 'Share product now',
                            textAlign: TextAlign.center,
                            color: Colors.white,
                          ),
                        ),
                      ).onClick(() async {
                        if (user.kyc_progress < 100) {
                          Get.back();
                          await Get.toNamed(
                              Routes.MY_DETAIL + Routes.KYC_DETAILS);
                        } else {
                          Get.back();
                          Get.bottomSheet(
                              ProductDialog(
                                data: productDetailItem!,
                                short_url: productURL!.data.url,
                                producturl: productURL!,
                              ),
                              isScrollControlled: true);
                        }
                      }),
                    ],
                  ),).paddingAll(40.sp),
                  SizedBox(height:800.sp,child:Lottie.asset('assets/animation/party_popper_animation.json')).alignTo(Alignment.center),
                ],
              ),
          ),
        ],
      ),
    );
  }
}
