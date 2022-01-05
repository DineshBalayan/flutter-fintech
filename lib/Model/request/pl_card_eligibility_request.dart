class PL_CardEligibilityRequest {
  var full_name;
  var mobile_no;
  var lead_by;
  var pancard;
  var is_card;
  var profile_id;
  var occupation_id;
  var monthly_salary;
  var company_id;
  var company_name;
  var itr_amount;
  var pincode_id;
  var company_pincode_id;
  var bank_id;
  var total_limit;
  var ava_limit;
  var card_vintage;

  var dob;
  var address;
  var degination;
  var is_loan;
  var total_rem_loan;
  var monthly_emi;
  var email;
  var office_email;
  var company_vintage;


  PL_CardEligibilityRequest(
      {
        this.full_name,
        this.mobile_no,
        this.lead_by,
        this.pancard,
        this.is_card,
        this.profile_id,
        this.occupation_id,
        this.monthly_salary,
        this.company_id,
        this.company_name,
        this.itr_amount,
        this.pincode_id,
        this.company_pincode_id,
        this.bank_id,
        this.total_limit,
        this.ava_limit,
        this.card_vintage,
        this.dob,
        this.address,
        this.degination,
        this.is_loan,
        this.total_rem_loan,
        this.monthly_emi,
        this.email,
        this.office_email,
        this.company_vintage,
      });

  factory PL_CardEligibilityRequest.fromJson(Map<String, dynamic> json) {
    return PL_CardEligibilityRequest(
      full_name: json['full_name'],
      mobile_no: json['mobile_no'],
      lead_by: json['lead_by'],
      pancard: json['pancard'],
      is_card: json['is_card'],
      profile_id: json['profile_id'],
      occupation_id: json['occupation_id'],
      monthly_salary: json['monthly_salary'],
      company_id: json['company_id'],
      company_name: json['company_name'],
      itr_amount: json['itr_amount'],
      pincode_id: json['pincode_id'],
      company_pincode_id: json['company_pincode_id'],
      bank_id: json['bank_id'],
      total_limit: json['total_limit'],
      ava_limit: json['ava_limit'],
      card_vintage: json['card_vintage'],
      dob: json['dob'],
      address: json['address'],
      degination: json['degination'],
      is_loan: json['is_loan'],
      total_rem_loan: json['total_rem_loan'],
      monthly_emi: json['monthly_emi'],
      email: json['email'],
      office_email: json['office_email'],
      company_vintage: json['company_vintage'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.full_name;
    data['mobile_no'] = this.mobile_no;
    data['lead_by'] = this.lead_by;
    data['pancard'] = this.pancard;
    data['is_card'] = this.is_card;
    data['profile_id'] = this.profile_id;
    data['occupation_id'] = this.occupation_id;
    data['monthly_salary'] = this.monthly_salary;
    data['company_id'] = this.company_id;
    data['company_name'] = this.company_name;
    data['itr_amount'] = this.itr_amount;
    data['pincode_id'] = this.pincode_id;
    data['company_pincode_id'] = this.company_pincode_id;
    data['bank_id'] = this.bank_id;
    data['total_limit'] = this.total_limit;
    data['ava_limit'] = this.ava_limit;
    data['card_vintage'] = this.card_vintage;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['degination'] = this.degination;
    data['is_loan'] = this.is_loan;
    data['total_rem_loan'] = this.total_rem_loan;
    data['monthly_emi'] = this.monthly_emi;
    data['email'] = this.email;
    data['office_email'] = this.office_email;
    data['company_vintage'] = this.company_vintage;
    return data;
  }
}
