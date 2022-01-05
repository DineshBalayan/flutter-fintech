// @dart=2.10
class ProfessionalDetailRequest {
  List<String> did_sell;
  String office_space;
  String pos_income_id;
  String pos_licence;
  String total_bus_anum;
  String total_fn_month;
  String total_fn_yr;
  String user_id;

  ProfessionalDetailRequest({this.did_sell, this.office_space, this.pos_income_id, this.pos_licence, this.total_bus_anum, this.total_fn_month, this.total_fn_yr, this.user_id});

  factory ProfessionalDetailRequest.fromJson(Map<String, dynamic> json) {
    return ProfessionalDetailRequest(
      did_sell: json['did_sell'] != null ? new List<String>.from(json['did_sell']) : null,
      office_space: json['office_space'],
      pos_income_id: json['pos_income_id'],
      pos_licence: json['pos_licence'],
      total_bus_anum: json['total_bus_anum'],
      total_fn_month: json['total_fn_month'],
      total_fn_yr: json['total_fn_yr'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['office_space'] = this.office_space;
    data['pos_income_id'] = this.pos_income_id;
    data['pos_licence'] = this.pos_licence;
    data['total_bus_anum'] = this.total_bus_anum;
    data['total_fn_month'] = this.total_fn_month;
    data['total_fn_yr'] = this.total_fn_yr;
    data['user_id'] = this.user_id;
    if (this.did_sell != null) {
      data['did_sell'] = this.did_sell;
    }
    return data;
  }
}