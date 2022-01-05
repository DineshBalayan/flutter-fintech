// @dart=2.10
class CrediCardProfile {
    CardData data;
    int code;
    String message;
    bool success;

    CrediCardProfile({this.data, this.code, this.message, this.success});

    factory CrediCardProfile.fromJson(Map<String, dynamic> json) {
        return CrediCardProfile(
            data: json['data'] != null ? CardData.fromJson(json['data']) : null,
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

class CardData {
    CardDetail card_detail;
    CompanyDetail company_detail;
    ProfileDetail profile_detail;

    CardData({this.card_detail, this.company_detail, this.profile_detail});

    factory CardData.fromJson(Map<String, dynamic> json) {
        return CardData(
            card_detail: json['card_detail'] != null ? CardDetail.fromJson(json['card_detail']) : null, 
            company_detail: json['company_detail'] != null ? CompanyDetail.fromJson(json['company_detail']) : null, 
            profile_detail: json['profile_detail'] != null ? ProfileDetail.fromJson(json['profile_detail']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.card_detail != null) {
            data['card_detail'] = this.card_detail.toJson();
        }
        if (this.company_detail != null) {
            data['company_detail'] = this.company_detail.toJson();
        }
        if (this.profile_detail != null) {
            data['profile_detail'] = this.profile_detail.toJson();
        }
        return data;
    }
}

class ProfileDetail {
    String dob;
    String email;
    String full_name;
    String is_card;
    String itr_amount;
    String mobile_no;
    String monthly_salary;
    int occupation_id;
    String pan_no;
    int pincode_id;
    int profile_id;

    ProfileDetail({this.dob, this.email, this.full_name, this.is_card, this.itr_amount, this.mobile_no, this.monthly_salary, this.occupation_id, this.pan_no, this.pincode_id, this.profile_id});

    factory ProfileDetail.fromJson(Map<String, dynamic> json) {
        return ProfileDetail(
            dob: json['dob'], 
            email: json['email'], 
            full_name: json['full_name'], 
            is_card: json['is_card'], 
            itr_amount: json['itr_amount']==null?'30000':json['itr_amount'] ,
            mobile_no: json['mobile_no'], 
            monthly_salary: json['monthly_salary']==null?'30000':json['monthly_salary'],
            occupation_id: json['occupation_id'], 
            pan_no: json['pan_no'],
            pincode_id: json['pincode_id'], 
            profile_id: json['profile_id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['dob'] = this.dob;
        data['email'] = this.email;
        data['full_name'] = this.full_name;
        data['is_card'] = this.is_card;
        data['mobile_no'] = this.mobile_no;
        data['monthly_salary'] = this.monthly_salary;
        data['occupation_id'] = this.occupation_id;
        data['pincode_id'] = this.pincode_id;
        data['profile_id'] = this.profile_id;
        data['itr_amount'] = this.itr_amount;
        data['pan_no'] = this.pan_no;

        return data;
    }
}

class CardDetail {
    int bank_id;
    String ava_limit;
    String total_limit;
    String card_vintage;
    int id;

    CardDetail({this.ava_limit, this.bank_id, this.card_vintage, this.id, this.total_limit});

    factory CardDetail.fromJson(Map<String, dynamic> json) {
        return CardDetail(
            ava_limit: json['ava_limit'], 
            bank_id: json['bank_id'], 
            card_vintage: json['card_vintage'], 
            id: json['id'], 
            total_limit: json['total_limit'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['ava_limit'] = this.ava_limit;
        data['bank_id'] = this.bank_id;
        data['card_vintage'] = this.card_vintage;
        data['id'] = this.id;
        data['total_limit'] = this.total_limit;
        return data;
    }
}

class CompanyDetail {
    int id;
    String name;
    int pincode_id;

    CompanyDetail({this.id, this.name, this.pincode_id});

    factory CompanyDetail.fromJson(Map<String, dynamic> json) {
        return CompanyDetail(
            id: json['id'], 
            name: json['name'], 
            pincode_id: json['pincode_id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['name'] = this.name;
        data['pincode_id'] = this.pincode_id;
        return data;
    }
}