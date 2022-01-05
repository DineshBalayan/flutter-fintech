// @dart=2.10
class AddCreditCardRequest {
  var lead_id;
  var card_id;

  AddCreditCardRequest(
      {this.lead_id,
      this.card_id});

  factory AddCreditCardRequest.fromJson(Map<String, dynamic> json) {
    return AddCreditCardRequest(
      lead_id: json['lead_id'],
      card_id: json['card_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lead_id'] = this.lead_id;
    data['card_id'] = this.card_id;
    return data;
  }
}
