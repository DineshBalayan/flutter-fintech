// @dart=2.10
class InsuranceProfile {
    KIData data;
    int code;
    String message;
    bool success;

    InsuranceProfile({this.data, this.code, this.message, this.success});

    factory InsuranceProfile.fromJson(Map<String, dynamic> json) {
        return InsuranceProfile(
            data: json['data'] != null ? KIData.fromJson(json['data']) : null,
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

class KIData {
    List<ChildInfo> child_info;
    Profile profile;
    Address address;
    String banner_image;

    KIData({this.child_info, this.profile, this.address, this.banner_image});

    factory KIData.fromJson(Map<String, dynamic> json) {
        return KIData(
            child_info: json['child_info'] != null ? (json['child_info'] as List).map((i) => ChildInfo.fromJson(i)).toList() : null, 
            profile: json['profile'] != null ? Profile.fromJson(json['profile']) : null,
            address: json['address'] != null ? Address.fromJson(json['address']) : null,
            banner_image: json['banner_image'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.child_info != null) {
            data['child_info'] = this.child_info.map((v) => v.toJson()).toList();
        }
        if (this.profile != null) {
            data['profile'] = this.profile.toJson();
        }
        if (this.address != null) {
            data['address'] = this.address.toJson();
        }

        data['banner_image'] = this.banner_image;

        return data;
    }
}

class ChildInfo {
    var child_dob;
    var child_gender;
    String child_name;
    var created_at;
    int id;
    var lead_code;
    int lead_profile_id;
    var pre_existing_health;
    var status;
    var updated_at;

    ChildInfo({this.child_dob, this.child_gender, this.child_name, this.created_at, this.id, this.lead_code, this.lead_profile_id, this.pre_existing_health, this.status, this.updated_at});

    factory ChildInfo.fromJson(Map<String, dynamic> json) {
        return ChildInfo(
            child_dob: json['child_dob'], 
            child_gender: json['child_gender'], 
            child_name: json['child_name'], 
            created_at: json['created_at'], 
            id: json['id'], 
            lead_code: json['lead_code'], 
            lead_profile_id: json['lead_profile_id'], 
            pre_existing_health: json['pre_existing_health'], 
            status: json['status'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['child_dob'] = this.child_dob;
        data['child_gender'] = this.child_gender;
        data['child_name'] = this.child_name;
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['lead_code'] = this.lead_code;
        data['lead_profile_id'] = this.lead_profile_id;
        data['pre_existing_health'] = this.pre_existing_health;
        data['status'] = this.status;
        data['updated_at'] = this.updated_at;
        return data;
    }
}
class Address {
    String address;
    var address_id;
    var city_id;
    var pincode_id;
    var state_id;
    var add_proof_id;
    var add_proof_no;
    var add_proof_front;
    var add_proof_back;

    Address(
        {this.address,
            this.address_id,
            this.city_id,
            this.pincode_id,
            this.state_id,
            this.add_proof_no,
            this.add_proof_id,
            this.add_proof_front,
            this.add_proof_back});

    factory Address.fromJson(Map<String, dynamic> json) {
        return Address(
            address: json['address'],
            address_id: json['address_id'],
            city_id: json['city_id'],
            pincode_id: json['pincode_id'],
            add_proof_no: json['add_proof_no'],
            add_proof_id: json['add_proof_id'],
            add_proof_front: json['add_proof_front'],
            add_proof_back: json['add_proof_back'],
            state_id: json['state_id']);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['address'] = this.address;
        data['address_id'] = this.address_id;
        data['city_id'] = this.city_id;
        data['pincode_id'] = this.pincode_id;
        data['state_id'] = this.state_id;
        data['add_proof_no'] = this.add_proof_no;
        data['add_proof_id'] = this.add_proof_id;
        data['add_proof_front'] = this.add_proof_front;
        data['add_proof_back'] = this.add_proof_back;
        return data;
    }
}
class Profile {
    String dob;
    String email;
    String full_name;
    String gender;
    String mobile_no;
    int no_of_daughter;
    int no_of_son;
    int pincode_id;
    int profile_id;
    String spouse_dob;
    String spouse_gender;
    String spouse_name;
    String spouse_pre_existing_health;

    Profile({this.dob, this.email, this.full_name, this.gender, this.mobile_no, this.no_of_daughter, this.no_of_son, this.pincode_id, this.profile_id, this.spouse_dob, this.spouse_gender, this.spouse_name, this.spouse_pre_existing_health});

    factory Profile.fromJson(Map<String, dynamic> json) {
        return Profile(
            dob: json['dob'], 
            email: json['email'], 
            full_name: json['full_name'], 
            gender: json['gender'], 
            mobile_no: json['mobile_no'], 
            no_of_daughter: json['no_of_daughter'], 
            no_of_son: json['no_of_son'], 
            pincode_id: json['pincode_id'], 
            profile_id: json['profile_id'], 
            spouse_dob: json['spouse_dob'], 
            spouse_gender: json['spouse_gender'], 
            spouse_name: json['spouse_name'], 
            spouse_pre_existing_health: json['spouse_pre_existing_health'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['dob'] = this.dob;
        data['email'] = this.email;
        data['full_name'] = this.full_name;
        data['gender'] = this.gender;
        data['mobile_no'] = this.mobile_no;
        data['no_of_daughter'] = this.no_of_daughter;
        data['no_of_son'] = this.no_of_son;
        data['pincode_id'] = this.pincode_id;
        data['profile_id'] = this.profile_id;
        data['spouse_dob'] = this.spouse_dob;
        data['spouse_gender'] = this.spouse_gender;
        data['spouse_name'] = this.spouse_name;
        data['spouse_pre_existing_health'] = this.spouse_pre_existing_health;
        return data;
    }
}