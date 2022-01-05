// @dart=2.10
class CreditCardsList {
  int code;
  Data data;
  String message;
  bool success;

  CreditCardsList({this.code, this.data, this.message, this.success});

  factory CreditCardsList.fromJson(Map<String, dynamic> json) {
    return CreditCardsList(
      code: json['code'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  var lead_id;
  var profile_id;
  List<BankCards> eleigiblity_card;

  Data({this.lead_id, this.profile_id, this.eleigiblity_card});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      eleigiblity_card: json['eleigiblity_card'] != null &&
          json['eleigiblity_card'] != ''
          ? (json['eleigiblity_card'] as List)
          .map((i) => BankCards.fromJson(i))
          .toList()
          : null,
      lead_id: json['lead_id'],
      profile_id: json['profile_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lead_id'] = this.lead_id;
    data['profile_id'] = this.profile_id;
    if (this.eleigiblity_card != null) {
      data['eleigiblity_card'] = this.eleigiblity_card.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankCards {
  List<BankCardDetail> bank_card_details;
  int bank_id;
  String bank_name;

  BankCards({this.bank_card_details, this.bank_id, this.bank_name});

  factory BankCards.fromJson(Map<String, dynamic> json) {
    return BankCards(
      bank_card_details: json['bank_card_details'] != null
          ? (json['bank_card_details'] as List)
          .map((i) => BankCardDetail.fromJson(i))
          .toList()
          : null,
      bank_id: json['bank_id'],
      bank_name: json['bank_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank_id'] = this.bank_id;
    data['bank_name'] = this.bank_name;
    if (this.bank_card_details != null) {
      data['bank_card_details'] =
          this.bank_card_details.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankCardDetail {
  String card_name;
  String existing_card_limit;
  int id;
  String network_title;
  String rewards_point_details;
  String bank_name = '';

  BankCardDetail({this.card_name, this.existing_card_limit, this.id, this.network_title, this.rewards_point_details});

  factory BankCardDetail.fromJson(Map<String, dynamic> json) {
    return BankCardDetail(
      card_name: json['card_name'],
      existing_card_limit: json['existing_card_limit'],
      id: json['id'],
      network_title: json['network_title'],
      rewards_point_details: json['rewards_point_details'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_name'] = this.card_name;
    data['existing_card_limit'] = this.existing_card_limit;
    data['id'] = this.id;
    data['network_title'] = this.network_title;
    data['rewards_point_details'] = this.rewards_point_details;
    return data;
  }
}

