// @dart=2.10
class KotakMemberDetailResponse {
  Data data;
  int code;
  String message;
  bool success;

  KotakMemberDetailResponse({this.data, this.code, this.message, this.success});

  factory KotakMemberDetailResponse.fromJson(Map<String, dynamic> json) {
    return KotakMemberDetailResponse(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      code: json['code'],
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
  int insurance_id;
  String insurance_name;
  List<MembersDetail> members_details;
  int no_of_person;
  String nominee_dob;
  String nominee_name;
  String nominee_gender;
  int premium_amount;
  String realtion_with_nominee;
  String sum_assored_amount;
  String covid_sum_assored_amount;
  String customer_name;

  Data(
      {this.insurance_id,
      this.insurance_name,
      this.members_details,
      this.no_of_person,
      this.nominee_dob,
      this.nominee_name,
      this.nominee_gender,
      this.premium_amount,
      this.realtion_with_nominee,
      this.sum_assored_amount,
      this.covid_sum_assored_amount,
      this.customer_name});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      insurance_id: json['insurance_id'],
      insurance_name: json['insurance_name'],
      members_details: json['members_details'] != null
          ? (json['members_details'] as List)
              .map((i) => MembersDetail.fromJson(i))
              .toList()
          : null,
      no_of_person: json['no_of_person'],
      nominee_dob: json['nominee_dob'],
      nominee_name: json['nominee_name'],
      nominee_gender: json['nominee_gender'],
      premium_amount: json['premium_amount'],
      realtion_with_nominee: json['realtion_with_nominee'],
      sum_assored_amount: json['sum_assored_amount'],
      covid_sum_assored_amount: json['covid_sum_assored_amount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['insurance_id'] = this.insurance_id;
    data['insurance_name'] = this.insurance_name;
    data['no_of_person'] = this.no_of_person;
    data['nominee_dob'] = this.nominee_dob;
    data['nominee_name'] = this.nominee_name;
    data['nominee_gender'] = this.nominee_gender;
    data['premium_amount'] = this.premium_amount;
    data['realtion_with_nominee'] = this.realtion_with_nominee;
    data['sum_assored_amount'] = this.sum_assored_amount;
    data['covid_sum_assored_amount'] = this.covid_sum_assored_amount;
    if (this.members_details != null) {
      data['members_details'] =
          this.members_details.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MembersDetail {
  String age;
  String name;

  MembersDetail({this.age, this.name});

  factory MembersDetail.fromJson(Map<String, dynamic> json) {
    return MembersDetail(
      age: json['age'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['name'] = this.name;
    return data;
  }
}
