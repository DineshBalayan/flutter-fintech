// @dart=2.10
class KotakInsuranceNomineeRequest {
  String insurance_id;
  String nominee_dob;
  String nominee_gender;
  String nominee_name;
  String realtion_with_nominee;

  KotakInsuranceNomineeRequest(
      {this.insurance_id,
      this.nominee_dob,
      this.nominee_gender,
      this.nominee_name,
      this.realtion_with_nominee});

  factory KotakInsuranceNomineeRequest.fromJson(Map<String, dynamic> json) {
    return KotakInsuranceNomineeRequest(
      insurance_id: json['insurance_id'],
      nominee_dob: json['nominee_dob'],
      nominee_gender: json['nominee_gender'],
      nominee_name: json['nominee_name'],
      realtion_with_nominee: json['realtion_with_nominee'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['insurance_id'] = this.insurance_id;
    data['nominee_dob'] = this.nominee_dob;
    data['nominee_gender'] = this.nominee_gender;
    data['nominee_name'] = this.nominee_name;
    data['realtion_with_nominee'] = this.realtion_with_nominee;
    return data;
  }
}
