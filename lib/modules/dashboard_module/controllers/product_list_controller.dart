import 'package:bank_sathi/Model/response/parent_product_detail_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:get/get.dart';

class ProductListController extends BaseController {
  final _title = ''.obs;

  get title => _title.value;

  set title(val) => _title.value = val;

  final _productList = <ChildProduct>[].obs;

  List<ChildProduct> get productList => _productList.value;
  String id = "";
  set productList(val) => _productList.value = val;

  @override
  void onReady() {
    super.onReady();
    id = Get.parameters['product_id'] ?? "";
    title = prefManager
        .getProductsStatus()!
        .firstWhere((element) => element.id.toString() == id)
        .title;
    getProductList();
  }

  void getProductList() async {
    pageState = PageStates.PAGE_LOADING;
    try {
      pageState = PageStates.PAGE_LOADING;
      ParentProductDetailResponse productDetailResponse =
          await restClient.getParentProductDetail(id);
      pageState = PageStates.PAGE_IDLE;
      productList = productDetailResponse.data.childProduct;
    } catch (e) {
      print(e);
      pageState = PageStates.PAGE_IDLE;
    }
  }
}
