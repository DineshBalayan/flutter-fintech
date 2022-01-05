import 'package:bank_sathi/Model/response/get_dropdown_data_response.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:get/get.dart';

mixin StateCityMixin on BaseController {
  RxList<PosIncome> _posList = <PosIncome>[].obs;
  RxList<FinProduct> _financialProducts = <FinProduct>[].obs;

  List<PosIncome> get posList => _posList.value;

  set posList(val) => _posList.value = val;

  List<FinProduct> get financialProducts => _financialProducts.value;

  set financialProducts(val) => _financialProducts.value = val;

  final _selectedPos = PosIncome().obs;

  set selectedPos(value) => _selectedPos.value = value;

  PosIncome get selectedPos => _selectedPos.value;

  RxList<Bank> _bankList = <Bank>[].obs;

  List<Bank> get bankList => _bankList.value;

  set bankList(val) => _bankList.value = val;

  final _selectedBank = Bank().obs;

  Bank? get selectedBank =>
      (_selectedBank.value == null || _selectedBank.value.id == null)
          ? null
          : _selectedBank.value;

  set selectedBank(val) => _selectedBank.value = val;
  static DropDownData? dropDownData;

  Future fetchData() async {
    if (dropDownData == null) {
      GetDropDownDataResponse getDropDownDataResponse =
          await restClient.getDropDowns();
      dropDownData = getDropDownDataResponse.data;
    }
    bankList = dropDownData!.banks;
    financialProducts = dropDownData!.fin_products;
    posList = dropDownData!.pos_incomes;
  }
}
