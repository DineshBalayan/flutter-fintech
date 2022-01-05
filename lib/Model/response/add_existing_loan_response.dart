// @dart=2.10
class AddExistingLoanResponse {
    int code;
    LeadIncomeData data;
    String message;
    bool success;

    AddExistingLoanResponse({this.code, this.data, this.message, this.success});

    factory AddExistingLoanResponse.fromJson(Map<String, dynamic> json) {
        return AddExistingLoanResponse(
            code: json['code'], 
            data: json['data'] != null ? LeadIncomeData.fromJson(json['data']) : null,
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

class LeadIncomeData {
    Income income;
    String is_card;
    var lead_id;
    var profile_id;
    var city_name;
    var state_name;

    LeadIncomeData({this.income, this.is_card, this.lead_id, this.profile_id, this.city_name, this.state_name});

    factory LeadIncomeData.fromJson(Map<String, dynamic> json) {
        return LeadIncomeData(
            income: json['income'] != null
                ? Income.fromJson(json['income'])
                : null,
            is_card: json['is_card'],
            lead_id: json['lead_id'],
            city_name: json['city_name'],
            state_name: json['state_name'],
            profile_id: json['profile_id'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['lead_id'] = this.lead_id;
        data['profile_id'] = this.profile_id;
        data['city_name'] = this.city_name;
        data['state_name'] = this.state_name;
        data['is_card'] = this.is_card;
        if (this.income != null) {
            data['income'] = this.income.toJson();
        }
        return data;
    }
}

class Income {
    int occupation_id;
    int city_id;
    String company_address;
    int company_id;
    String company_name;
    String company_vintage;
    String designation;
    String gst_no;
    String gst_vintage;
    String itr_amount;
    String monthly_salary;
    String office_email;
    int pincode_id;
    int state_id;

    Income({this.occupation_id,this.city_id, this.company_address, this.company_id, this.company_name, this.company_vintage, this.designation, this.gst_no, this.gst_vintage, this.itr_amount, this.monthly_salary, this.office_email, this.pincode_id, this.state_id});

    factory Income.fromJson(Map<String, dynamic> json) {
        return Income(
            occupation_id: json['occupation_id'],
            city_id: json['city_id'],
            company_address: json['company_address'],
            company_id: json['company_id'],
            company_name: json['company_name'],
            company_vintage: json['company_vintage'],
            designation: json['designation'],
            gst_no: json['gst_no'],
            gst_vintage: json['gst_vintage'],
            itr_amount: json['itr_amount'],
            monthly_salary: json['monthly_salary'],
            office_email: json['office_email'],
            pincode_id: json['pincode_id'],
            state_id: json['state_id'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['occupation_id'] = this.occupation_id;
        data['city_id'] = this.city_id;
        data['company_address'] = this.company_address;
        data['company_id'] = this.company_id;
        data['company_name'] = this.company_name;
        data['company_vintage'] = this.company_vintage;
        data['designation'] = this.designation;
        data['gst_no'] = this.gst_no;
        data['gst_vintage'] = this.gst_vintage;
        data['itr_amount'] = this.itr_amount;
        data['monthly_salary'] = this.monthly_salary;
        data['office_email'] = this.office_email;
        data['pincode_id'] = this.pincode_id;
        data['state_id'] = this.state_id;
        return data;
    }
}