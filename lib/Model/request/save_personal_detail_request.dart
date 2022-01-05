// @dart=2.10
class SavePersonalDetailsRequest {
  String add1;
  String add2;
  String are_you;
  String city_id;
  String dob;
  String email;
  String firm_name;
  String first_name;
  String gender;
  String is_current;
  String last_name;
  String mobile_no;
  String nominee_dob;
  String nominee_name;
  String nominee_relation;
  String pincode_id;
  String state_id;
  String user_id;

  SavePersonalDetailsRequest({this.add1,
    this.add2,
    this.are_you,
    this.city_id,
    this.dob,
    this.email,
    this.firm_name,
    this.first_name,
    this.gender,
    this.is_current,
    this.last_name,
    this.mobile_no,
    this.nominee_dob,
    this.nominee_name,
    this.nominee_relation,
    this.pincode_id,
    this.state_id,
    this.user_id});

  factory SavePersonalDetailsRequest.fromJson(Map<String, dynamic> json) {
    return SavePersonalDetailsRequest(
      add1: json['add1'],
      add2: json['add2'],
      are_you: json['are_you'],
      city_id: json['city_id'],
      dob: json['dob'],
      email: json['email'],
      firm_name: json['firm_name'],
      first_name: json['first_name'],
      gender: json['gender'],
      is_current: json['is_current'],
      last_name: json['last_name'],
      mobile_no: json['mobile_no'],
      nominee_dob: json['nominee_dob'],
      nominee_name: json['nominee_name'],
      nominee_relation: json['nominee_relation'],
      pincode_id: json['pincode_id'],
      state_id: json['state_id'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['add1'] = this.add1;
    data['add2'] = this.add2;
    data['are_you'] = this.are_you;
    data['city_id'] = this.city_id;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['firm_name'] = this.firm_name;
    data['first_name'] = this.first_name;
    data['gender'] = this.gender;
    data['is_current'] = this.is_current;
    data['last_name'] = this.last_name;
    data['mobile_no'] = this.mobile_no;
    data['nominee_dob'] = this.nominee_dob;
    data['nominee_name'] = this.nominee_name;
    data['nominee_relation'] = this.nominee_relation;
    data['pincode_id'] = this.pincode_id;
    data['state_id'] = this.state_id;
    data['user_id'] = this.user_id;
    return data;
  }
}
