// @dart=2.10
class PersonalLoanProfile {
    PLData data;
    int code;
    String message;
    bool success;

    PersonalLoanProfile({this.data, this.code, this.message, this.success});

    factory PersonalLoanProfile.fromJson(Map<String, dynamic> json) {
        return PersonalLoanProfile(
            data: json['data'] != null ? PLData.fromJson(json['data']) : null,
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

class PLData {
    CompanyDetail company_detail;
    IsLoanDetail is_loan_detail;
    ProfileDetail profile_detail;

    PLData({this.company_detail, this.is_loan_detail, this.profile_detail});

    factory PLData.fromJson(Map<String, dynamic> json) {
        return PLData(
            company_detail: json['company_detail'] != null ? CompanyDetail.fromJson(json['company_detail']) : null, 
            is_loan_detail: json['is_loan_detail'] != null ? IsLoanDetail.fromJson(json['is_loan_detail']) : null, 
            profile_detail: json['profile_detail'] != null ? ProfileDetail.fromJson(json['profile_detail']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.company_detail != null) {
            data['company_detail'] = this.company_detail.toJson();
        }
        if (this.is_loan_detail != null) {
            data['is_loan_detail'] = this.is_loan_detail.toJson();
        }
        if (this.profile_detail != null) {
            data['profile_detail'] = this.profile_detail.toJson();
        }
        return data;
    }
}

class ProfileDetail {
    var dob;
    var email;
    var full_name;
    var mobile_no;
    var pan_no;
    int pincode_id;
    int profile_id;

    ProfileDetail({this.dob, this.email, this.full_name, this.mobile_no, this.pan_no, this.pincode_id, this.profile_id});

    factory ProfileDetail.fromJson(Map<String, dynamic> json) {
        return ProfileDetail(
            dob: json['dob']??"",
            email: json['email']??'',
            full_name: json['full_name']??'',
            mobile_no: json['mobile_no']??'',
            pan_no: json['pan_no']??'',
            pincode_id: json['pincode_id'], 
            profile_id: json['profile_id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['dob'] = this.dob;
        data['email'] = this.email;
        data['full_name'] = this.full_name;
        data['mobile_no'] = this.mobile_no;
        data['pincode_id'] = this.pincode_id;
        data['profile_id'] = this.profile_id;
        data['pan_no'] = this.pan_no;
        return data;
    }
}

class IsLoanDetail {
    int loan_id;
    var monthly_emi;
    var total_rem_loan;

    IsLoanDetail({this.loan_id, this.monthly_emi, this.total_rem_loan});

    factory IsLoanDetail.fromJson(Map<String, dynamic> json) {
        return IsLoanDetail(
            loan_id: json['loan_id'], 
            monthly_emi: json['monthly_emi']??'',
            total_rem_loan: json['total_rem_loan']??'',
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['loan_id'] = this.loan_id;
        data['monthly_emi'] = this.monthly_emi;
        data['total_rem_loan'] = this.total_rem_loan;
        return data;
    }
}

class CompanyDetail {
    var designation;
    int id;
    var job_vintage;
    var monthly_salary;
    var name;
    var office_email;
    int pincode_id;

    CompanyDetail({this.designation, this.id, this.job_vintage, this.monthly_salary, this.name, this.office_email, this.pincode_id});

    factory CompanyDetail.fromJson(Map<String, dynamic> json) {
        return CompanyDetail(
            designation: json['designation']??'',
            id: json['id'], 
            job_vintage: json['job_vintage']??'00 - 01',
            monthly_salary: json['monthly_salary']??'',
            name: json['name']??'',
            office_email: json['office_email']??'',
            pincode_id: json['pincode_id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['designation'] = this.designation;
        data['id'] = this.id;
        data['job_vintage'] = this.job_vintage;
        data['monthly_salary'] = this.monthly_salary;
        data['name'] = this.name;
        data['office_email'] = this.office_email;
        data['pincode_id'] = this.pincode_id;
        return data;
    }
}