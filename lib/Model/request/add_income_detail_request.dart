class AddIncomeDetailRequest {
    var city_id;
    var company_address;
    var company_id;
    var company_name;
    var company_vintage;
    var designation;
    var gst_no;
    var gst_vintage;
    var itr_amount;
    var lead_id;
    var monthly_salary;
    var occupation_id;
    var office_email;
    var pincode_id;
    var profile_id;
    var state_id;
    var is_card;

    AddIncomeDetailRequest({this.city_id, this.company_address, this.company_id, this.company_name, this.company_vintage, this.designation, this.gst_no, this.gst_vintage, this.itr_amount, this.lead_id, this.monthly_salary, this.occupation_id, this.office_email, this.pincode_id, this.profile_id, this.state_id, this.is_card});

    factory AddIncomeDetailRequest.fromJson(Map<String, dynamic> json) {
        return AddIncomeDetailRequest(
            city_id: json['city_id'],
            company_address: json['company_address'],
            company_id: json['company_id'],
            company_name: json['company_name'],
            company_vintage: json['company_vintage'],
            designation: json['designation'],
            gst_no: json['gst_no'],
            gst_vintage: json['gst_vintage'],
            itr_amount: json['itr_amount'],
            lead_id: json['lead_id'],
            monthly_salary: json['monthly_salary'],
            occupation_id: json['occupation_id'],
            office_email: json['office_email'],
            pincode_id: json['pincode_id'],
            profile_id: json['profile_id'],
            state_id: json['state_id'],
            is_card: json['is_card'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['city_id'] = this.city_id;
        data['company_address'] = this.company_address;
        data['company_id'] = this.company_id;
        data['company_name'] = this.company_name;
        data['company_vintage'] = this.company_vintage;
        data['designation'] = this.designation;
        data['gst_no'] = this.gst_no;
        data['gst_vintage'] = this.gst_vintage;
        data['itr_amount'] = this.itr_amount;
        data['lead_id'] = this.lead_id;
        data['monthly_salary'] = this.monthly_salary;
        data['occupation_id'] = this.occupation_id;
        data['office_email'] = this.office_email;
        data['pincode_id'] = this.pincode_id;
        data['profile_id'] = this.profile_id;
        data['state_id'] = this.state_id;
        data['is_card'] = this.is_card;
        return data;
    }
}