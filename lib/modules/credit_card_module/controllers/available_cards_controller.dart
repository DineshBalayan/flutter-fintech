// import 'package:bank_sathi/Model/add_lead_arguments.dart';
import 'package:bank_sathi/Model/add_lead_arguments.dart';
import 'package:bank_sathi/Model/pair.dart';
import 'package:bank_sathi/Model/request/addcreditcardrequest.dart';
import 'package:bank_sathi/Model/response/credit_card_list.dart';
import 'package:bank_sathi/base/base_controller.dart';
import 'package:bank_sathi/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvailableCardsController extends BaseController {
  late List<BankCards> cardsresponse;
  final _cardsList = <BankCardDetail>[].obs;

  List<BankCardDetail> get cardsList => _cardsList.value;

  set cardsList(val) => _cardsList.value = val;

  RxBool _apiCallDone = true.obs;

  get apiCallDone => _apiCallDone.value;

  set apiCallDone(val) => _apiCallDone.value = val;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late AddLeadArguments arguments;

  Map<String, Pair<String, List<Color>>> cardList = {
    'Visa': Pair.create('assets/images/cards/visa.png',
        [Colors.blue.shade900, Colors.blue.shade700, Colors.blue.shade500]),
    'RuPay': Pair.create('assets/images/cards/rupay.png', [
      Colors.orange.shade500,
      Colors.orange.shade300,
      Colors.orange.shade200
    ]),
    'MasterCard': Pair.create('assets/images/cards/master_card.png', [
      Colors.deepPurple.shade900,
      Colors.deepPurple.shade700,
      Colors.deepPurple.shade500
    ]),
    'American Express': Pair.create('assets/images/cards/american_express.png',
        [Colors.black87, Colors.black54, Colors.white]),
    'Discover': Pair.create('assets/images/cards/discover.png',
        [Colors.blueAccent, Colors.blueAccent, Colors.blue.shade500]),
    'Diners Club': Pair.create('assets/images/cards/diners_club.png',
        [Colors.black87, Colors.black54, Colors.white]),
    'Maestro': Pair.create('assets/images/cards/maestro.png', [
      Colors.purple.shade900,
      Colors.purpleAccent.shade700,
      Colors.deepPurple.shade500
    ]),
  };

  @override
  void onInit() {
    super.onInit();
    arguments = Get.arguments;
    arguments.cardsresponse.forEach((element) {
      print(element.bank_card_details[0].card_name);
    });
  }

  @override
  void onReady() {
    super.onReady();
    cardsresponse = arguments.cardsresponse;
    listConvert();
  }

  void listConvert() {
    cardsList = cardsresponse.expand((BankCards e) {
      e.bank_card_details.forEach((element) {
        element.bank_name = e.bank_name;
      });
      return e.bank_card_details;
    }).toList();
  }

  Future submitCard(int cardid) async {
    showLoadingDialog();
    try {
      AddCreditCardRequest req = AddCreditCardRequest(
          lead_id: arguments.leadIdData.lead_id, card_id: cardid);
      final response = await restClient.addCreditCardid(req);
      hideDialog();
      if (response.success) {
        var onClickRoute;
        onClickRoute = Routes.DASHBOARD +
            Routes.MY_LEAD_DETAILS +
            "?lead_id=" +
            arguments.leadIdData.lead_id.toString();
        Get.offNamedUntil(
            onClickRoute, (route) => route.settings.name == Routes.DASHBOARD);
      }
    } on Exception {}
    apiCallDone = true;
    return;
  }
}
