class LeadPersonalInfoRequest {
  var address;
  var address_id;
  var city_id;
  var dob;
  var email;
  var full_name;
  var lead_by;
  var mobile_no;
  var pincode_id;
  var product_id;
  var profile_id;
  var state_id;
  var lead_id;
  var pancard;
  var adhar_card;
  var gender;

  LeadPersonalInfoRequest(
      {this.address,
      this.address_id,
      this.city_id,
      this.dob,
      this.email,
      this.full_name,
      this.lead_by,
      this.mobile_no,
      this.pincode_id,
      this.product_id,
      this.profile_id,
      this.state_id,
      this.lead_id,
      this.pancard,
      this.gender,
      this.adhar_card});

  factory LeadPersonalInfoRequest.fromJson(Map<String, dynamic> json) {
    return LeadPersonalInfoRequest(
      address: json['address'],
      address_id: json['address_id'],
      city_id: json['city_id'],
      dob: json['dob'],
      email: json['email'],
      full_name: json['full_name'],
      lead_by: json['lead_by'],
      mobile_no: json['mobile_no'],
      pincode_id: json['pincode_id'],
      product_id: json['product_id'],
      profile_id: json['profile_id'],
      state_id: json['state_id'],
      lead_id: json['lead_id'],
      pancard: json['pancard'],
      adhar_card: json['adhar_card'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['address_id'] = this.address_id;
    data['city_id'] = this.city_id;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['full_name'] = this.full_name;
    data['lead_by'] = this.lead_by;
    data['mobile_no'] = this.mobile_no;
    data['pincode_id'] = this.pincode_id;
    data['product_id'] = this.product_id;
    data['profile_id'] = this.profile_id;
    data['state_id'] = this.state_id;
    data['adhar_card'] = this.adhar_card;
    data['pancard'] = this.pancard;
    data['gender'] = this.gender;
    if (this.lead_id != null) data['lead_id'] = this.lead_id;
    return data;
  }
}
