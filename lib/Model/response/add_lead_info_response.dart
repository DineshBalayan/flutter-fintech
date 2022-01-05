// @dart=2.10
class AddLeadInfoResponse {
  AddLeadInfoData data;
  int code;
  String message;
  bool success;

  AddLeadInfoResponse({this.data, this.code, this.message, this.success});

  factory AddLeadInfoResponse.fromJson(Map<String, dynamic> json) {
    return AddLeadInfoResponse(
      data:
      json['data'] != null ? AddLeadInfoData.fromJson(json['data']) : null,
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

class AddLeadInfoData {
  Address address;
  Profile profile;
  int address_id;
  String fuel_desc;
  String insurance_upto;
  var lead_id;
  String maker_desc;
  String maker_model;
  var profile_id;
  String registered_at;
  String regn_dt;
  int vehicle_id;

  AddLeadInfoData({this.address, this.profile,this.address_id,
    this.fuel_desc,
    this.insurance_upto,
    this.lead_id,
    this.maker_desc,
    this.maker_model,
    this.profile_id,
    this.registered_at,
    this.regn_dt,
    this.vehicle_id});

  factory AddLeadInfoData.fromJson(Map<String, dynamic> json) {
    return AddLeadInfoData(
      address:
      json['address'] != null ? Address.fromJson(json['address']) : null,
      profile:
      json['profile'] != null ? Profile.fromJson(json['profile']) : null,
      address_id: json['address_id'],
      fuel_desc: json['fuel_desc'],
      insurance_upto: json['insurance_upto'],
      lead_id: json['lead_id'],
      maker_desc: json['maker_desc'],
      maker_model: json['maker_model'],
      profile_id: json['profile_id'],
      registered_at: json['registered_at'],
      regn_dt: json['regn_dt'],
      vehicle_id: json['vehicle_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    data['address_id'] = this.address_id;
    data['fuel_desc'] = this.fuel_desc;
    data['insurance_upto'] = this.insurance_upto;
    data['lead_id'] = this.lead_id;
    data['maker_desc'] = this.maker_desc;
    data['maker_model'] = this.maker_model;
    data['profile_id'] = this.profile_id;
    data['registered_at'] = this.registered_at;
    data['regn_dt'] = this.regn_dt;
    data['vehicle_id'] = this.vehicle_id;

    return data;
  }
}

class Profile {
  String dob;
  String email;
  String full_name;
  String mobile_no;
  var profile_id;
  String pan_no;
  String gender;

  Profile(
      {this.dob,
        this.email,
        this.full_name,
        this.mobile_no,
        this.profile_id,
        this.pan_no,
        this.gender,});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      dob: json['dob'],
      email: json['email'],
      full_name: json['full_name'],
      mobile_no: json['mobile_no'],
      profile_id: json['profile_id'],
      pan_no: json['pan_no'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dob'] = this.dob;
    data['full_name'] = this.full_name;
    data['mobile_no'] = this.mobile_no;
    data['profile_id'] = this.profile_id;
    data['email'] = this.email;
    data['pan_no'] = this.pan_no;
    data['gender'] = this.gender;
    return data;
  }
}

class Address {
  var address;
  var address_id;
  var city_id;
  var pincode_id;
  var state_id;

  Address(
      {this.address,
        this.address_id,
        this.city_id,
        this.pincode_id,
        this.state_id});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        address: json['address'],
        address_id: json['address_id'],
        city_id: json['city_id'],
        pincode_id: json['pincode_id'],
        state_id: json['state_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['address_id'] = this.address_id;
    data['city_id'] = this.city_id;
    data['pincode_id'] = this.pincode_id;
    data['state_id'] = this.state_id;
    return data;
  }
}
