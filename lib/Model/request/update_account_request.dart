// @dart=2.10
class UpdateAccountRequest {
  String email;
  String first_name;
  String address;
  String pincode;
  String user_id;
  String referral_code;

  UpdateAccountRequest({this.email,
    this.first_name,
    this.address,
    this.pincode,
    this.referral_code,
    this.user_id});

  factory UpdateAccountRequest.fromJson(Map<String, dynamic> json) {
    return UpdateAccountRequest(
      email: json['email'],
      first_name: json['first_name'],
      address: json['address'],
      pincode: json['pincode'],
      referral_code: json['referral_code'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['first_name'] = this.first_name;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['referral_code'] = this.referral_code;
    data['user_id'] = this.user_id;
    return data;
  }
}
