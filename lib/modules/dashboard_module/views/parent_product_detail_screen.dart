import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:bank_sathi/Helpers/util.dart';
import 'package:bank_sathi/Model/response/parent_product_detail_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/base/base_page_view.dart';
import 'package:bank_sathi/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ParentProductDetailScreen extends GetView<ParentProductDetailController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: LayoutBuilder(builder: (_, constraintSuper) {
      return Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          alignment: Alignment.topRight,
          child: SafeArea(
              child: SvgPicture.asset(
            'assets/images/new_images/top_curve.svg',
            color: ColorUtils.topCurveColor,
            width: Get.width - (Get.width * .2),
          )),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              titleSpacing: 0,
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                WidgetUtil.getNotificationIcon(),
                WidgetUtil.getSupportIcon()
              ],
              leading: SvgPicture.asset(
                'assets/images/ic_back_arrow.svg',
                width: 75.sp,
                fit: BoxFit.scaleDown,
              ).onClick(() => Get.back()),
              title: Obx(() => CustomText(controller.title)),
            ),
            body: BasePageView(
              controller: controller,
              idleWidget: Column(
                children: <Widget>[
                  /*    Expanded(
                      child: Obx(
                    () => DefaultTabController(
                      length: controller.productList.length,
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        appBar: AppBar(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          leading: Container(),
                          flexibleSpace: Stack(children: [
                            Positioned.fill(
                                child: Align(
                              child: Divider(
                                height: 2,
                                thickness: 1,
                                color: Colors.grey.shade300,
                              ),
                              alignment: Alignment.bottomRight,
                            )),
                            TabBar(
                                labelColor: ColorUtils.orange,
                                unselectedLabelColor: Colors.black,
                                isScrollable: true,
                                indicatorColor: Colors.black,
                                tabs: controller.productList
                                    .map((e) => Tab(
                                          text: e.product_title,
                                        ))
                                    .toList()),
                          ]).marginOnly(left: 40.sp),
                        ),
                        body: TabBarView(
                            children: controller.productList
                                .map((e) =>
                                    ChildProductDetailScreen(productDetail: e))
                                .toList()),
                      ),
                    ),
                  )),
                  Obx(() => WidgetUtil.getSecondaryButton(
                          () => Get.bottomSheet(
                              ProductDialog(
                                data: controller.data,
                              ),
                              isScrollControlled: true),
                          height: 125.sp,
                          width: 600.sp,
                          label: share.tr)
                      .marginSymmetric(horizontal: 60.sp, vertical: 20.sp)
                      .visibility(controller.data.share_link != null &&
                          controller.data.share_link.isNotEmpty)),
                  Obx(() => WidgetUtil.getSecondaryButton(() {
                        if (controller.productId == "3") {
                          AddLeadArguments arguments = AddLeadArguments();
                          arguments.leadCategoryId = 3;
                          Get.toNamed(Routes.CREDITCARDMOBILE,
                              arguments: arguments);
                        } else if (controller.productId == "2") {
                          Get.toNamed(Routes.INSURANCE_CATEGORY +
                              Routes.KOTAK_INSURANCE);
                        } else if (controller.productId == "4") {
                          Get.toNamed(Routes.PERSONAL_LOAN_LOGIN);
                        }
                      }, height: 125.sp, width: 600.sp, label: "Add Lead")
                          .marginSymmetric(horizontal: 60.sp, vertical: 20.sp)
                          .visibility(controller.data.share_link == null ||
                              controller.data.share_link == ""))*/
                ],
              ),
            ))
      ]);
    }));
  }
}

class ParentProductDetailController extends BaseController {
  final _productList = <ChildProduct>[].obs;

  List<ChildProduct> get productList => _productList.value;

  set productList(val) => _productList.value = val;
  final _data = Data().obs;

  Data get data => _data.value;

  set data(val) => _data.value = val;

  final _title = ''.obs;

  get title => _title.value;

  set title(val) => _title.value = val;
  String productId = "";

  @override
  void onReady() async {
    super.onReady();
    productId = Get.parameters['product_id'] as String;
    try {
      pageState = PageStates.PAGE_LOADING;
      ParentProductDetailResponse productDetailResponse =
          await restClient.getParentProductDetail(productId);
      pageState = PageStates.PAGE_IDLE;
      productList = productDetailResponse.data.childProduct;
      title = productDetailResponse.data.title;
      data = productDetailResponse.data;
      print("SSFF");
    } catch (e) {
      print(e);
      pageState = PageStates.PAGE_IDLE;
    }
  }
}

/*
class ProductDialog extends StatelessWidget {
  final Data data;

  const ProductDialog({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDialogController>(
        init: ProductDialogController(data),
        builder: (controller) {
          return Card(
              color: ColorUtils.white,
              margin: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shadowColor: ColorUtils.white_bg,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.sp),
                      topRight: Radius.circular(50.sp))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RepaintBoundary(
                    key: controller.globalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImage.network(data.share_image, fit: BoxFit.fill),
                        Container(
                          color: ColorUtils.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 64.sp,
                                backgroundImage:
                                    NetworkImage(controller.user.profile_photo),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        controller.getUserFullName().length > 16
                                            ? controller.user.first_name
                                                .toString()
                                                .capitalizeFirst!
                                            : controller.getUserFullName(),
                                        style: GoogleFonts.mulish(
                                            fontSize: 54.sp,
                                            fontWeight: FontWeight.w700,
                                            color: ColorUtils.black),
                                      ),
                                      Visibility(
                                          visible: controller.getUserStatus() ==
                                              "Verified",
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: controller
                                                    .getUserStatusColor()
                                                    .withAlpha(15),
                                                border: Border.all(
                                                    color: controller
                                                        .getUserStatusColor(),
                                                    width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40))),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  30.sp, 0, 30.sp, 0),
                                              child: Obx(() => CustomText(
                                                    controller.getUserStatus(),
                                                    color: controller
                                                        .getUserStatusColor(),
                                                    fontSize: 28.sp,
                                                  )),
                                            ),
                                          )).marginOnly(left: 20.sp),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/new_images/phone.svg',
                                        width: 32.sp,
                                      ),
                                      CustomText(
                                        "   +91 " + controller.user.mobile_no,
                                        style: GoogleFonts.mulish(
                                            fontSize: 32.sp,
                                            fontWeight: FontWeight.w600,
                                            color: ColorUtils.black),
                                      ).alignTo(
                                        Alignment.center,
                                      )
                                    ],
                                  ).marginOnly(top: 10.sp),
                                ],
                              ).marginOnly(left: 20.sp),
                            ],
                          ).paddingSymmetric(
                              horizontal: 20.sp, vertical: 25.sp),
                        ),
                      ],
                    ).marginOnly(left: 0.sp),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(5)),
                      child: Container(
                        width: double.infinity,
                        child: Obx(
                          () => CustomText(
                            controller.content,
                            fontType: FontType.OPEN_SANS,
                          ).marginAll(20.sp),
                        ),
                      )).marginAll(40.sp),
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: data.share_content
                            .map((e) => WidgetUtil.getRadio(
                                    isSelected:
                                        controller.contentLanguage == e.lang,
                                    label: e.lang.capitalizeFirst,
                                    onTap: () => controller.onTap(e.lang))
                                .marginAll(4))
                            .toList(),
                      ).marginSymmetric(horizontal: 40.sp)),
                  Container(
                    width: 600.sp,
                    child: WidgetUtil.getOrangeButton(
                            () => controller.capture(),
                            label: share.tr)
                        .marginAll(40.sp),
                  )
                ],
              ));
        });
  }
}

class ProductDialogController extends BaseController {
  final _contentLanguage = "".obs;
  final globalKey = GlobalKey();
  final Data data;
  String short_url = "";

  ProductDialogController(this.data);

  String get contentLanguage => _contentLanguage.value;

  set contentLanguage(val) => _contentLanguage.value = val;

  final _imageAsset = 'assets/images/saving_account.jpg'.obs;

  String get imageAsset => _imageAsset.value;

  set imageAsset(val) => _imageAsset.value = val;

  onTap(lang) {
    contentLanguage = lang;
    prefManager.setContentLanguage(lang);
    changeContent();
  }

  changeContent() {
    content = data.share_content
            .firstWhere((element) => element.lang == contentLanguage)
            .content +
        " " +
        short_url;
  }

  @override
  void onInit() async {
    super.onInit();

    short_url = await shortLink();
    imageAsset = data.share_image;
    contentLanguage =
        prefManager.getContentLanguage() ?? data.share_content.first.lang;
    changeContent();
  }

  final _content = "".obs;

  String get content => _content.value;

  set content(val) => _content.value = val;

  Future capture() {
    return Future.delayed(20.milliseconds, () async {
      try {
        RenderRepaintBoundary boundary = this
            .globalKey
            .currentContext!
            .findRenderObject()! as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage(pixelRatio: Get.pixelRatio);
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();

        final directory = (await getApplicationDocumentsDirectory()).path;
        String fileName = "Card";
        String path = '$directory/$fileName.png';
        File imgFile = new File(path);
        await imgFile.writeAsBytes(pngBytes);
        await Share.shareFiles([imgFile.path], text: content);
      } catch (Exception) {
        print(Exception);
        return null;
      }
    });
  }

  Future<String> shortLink() async {
    // showLoadingDialog();
    try {
      String link = data.share_link + getUserCode();
      final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: Constant.APP_ACC_LINK,
        link: Uri.parse(link),
      );
      final ShortDynamicLink shortDynamicLink =
          await parameters.buildShortLink();
      // hideDialog();
      return shortDynamicLink.shortUrl.toString();
    } finally {}
  }
}

class ChildProductDetailScreen extends StatefulWidget {
  ChildProduct productDetail;

  ChildProductDetailScreen({
    Key? key,
    required this.productDetail,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChildProductDetailScreen();
  }
}

class _ChildProductDetailScreen extends State<ChildProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late ChildProduct productDetail;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    productDetail = widget.productDetail;
    tabController.addListener(() {
      currentTab = tabController.index;
    });
  }

  final _currentPage = 0.obs;

  int get currentPage => _currentPage.value;

  set currentPage(val) {
    _currentPage.value = val;
  }

  final _currentTab = 0.obs;

  get currentTab => _currentTab.value;

  set currentTab(val) => _currentTab.value = val;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60.sp),
            ),
            margin: EdgeInsets.zero,
            elevation: .5,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: [
                CustomImage.network(productDetail.video_url.thumbnail,
                    fit: BoxFit.cover),
                Positioned.fill(
                    child: Center(
                  child: SvgPicture.asset(
                    'assets/images/new_images/play_testimonial.svg',
                    width: 150.sp,
                    color: Colors.white,
                  ),
                ))
              ],
            ),
          ).onClick(() => Get.dialog(
              WidgetUtil.videoDialog(productDetail.video_url.videoId!))),
          Html(
            data: productDetail.basic_content,
            style: {
              "body": Style(
                fontSize: FontSize(42.sp),
                color: ColorUtils.textColor,
              )
            },
          ).marginOnly(top: 20.sp, left: 30.sp, right: 30.sp),
          Stack(children: [
            Positioned.fill(
                child: Align(
              child: Divider(
                height: 2,
                thickness: 1,
                color: Colors.grey.shade300,
              ),
              alignment: Alignment.bottomRight,
            )),
            TabBar(
                labelColor: ColorUtils.orange,
                unselectedLabelColor: Colors.black,
                controller: tabController,
                indicatorColor: Colors.black,
                tabs: [Tab(text: 'DOCUMENTS'), Tab(text: 'PAYOUT')])
          ]).marginSymmetric(horizontal: 40.sp),
          CustomText(
            'Frequently asked Questions :',
            color: ColorUtils.grey,
            textAlign: TextAlign.start,
            fontSize: 42.sp,
          ).alignTo(Alignment.centerLeft).marginOnly(left: 60.sp, top: 80.sp),
          _page3(),
        ],
      ),
    );
  }

  Widget _page3() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, position) {
        return Obx(() => ExpansionTile(
              childrenPadding: EdgeInsets.all(0),
              tilePadding: EdgeInsets.zero,
              trailing: productDetail.faq[position].isExpanded.value
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
              title: CustomText(productDetail.faq[position].que),
              maintainState: true,
              onExpansionChanged: (isExpanded) {
                productDetail.faq[position].isExpanded.value = isExpanded;
              },
              children: [
                CustomText(
                  productDetail.faq[position].ans,
                  fontType: FontType.OPEN_SANS,
                  fontweight: Weight.LIGHT,
                ).marginOnly(bottom: 35.sp)
              ],
            ));
      },
      shrinkWrap: true,
      itemCount: productDetail.faq == null ? 0 : productDetail.faq.length,
    ).marginSymmetric(horizontal: 60.sp);
  }
}*/
