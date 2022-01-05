// @dart=2.10
class KotakPersonalInfoResponse {
  KotakMemberDetail data;
  int code;
  String message;
  bool success;

  KotakPersonalInfoResponse({this.data, this.code, this.message, this.success});

  factory KotakPersonalInfoResponse.fromJson(Map<String, dynamic> json) {
    return KotakPersonalInfoResponse(
      data: json['data'] != null
          ? KotakMemberDetail.fromJson(json['data'])
          : null,
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

class KotakMemberDetail {
  List<ChildInfoServer> child_info;
  String lead_code;
  var profile_id;
  String spouse_dob;
  String spouse_gender;
  String spouse_name;
  String spouse_pre_existing_health;

  KotakMemberDetail(
      {this.child_info,
      this.lead_code,
      this.profile_id,
      this.spouse_dob,
      this.spouse_gender,
      this.spouse_name,
      this.spouse_pre_existing_health});

  factory KotakMemberDetail.fromJson(Map<String, dynamic> json) {
    return KotakMemberDetail(
      child_info: json['child_info'] != null
          ? (json['child_info'] as List)
              .map((i) => ChildInfoServer.fromJson(i))
              .toList()
          : null,
      lead_code: json['lead_code'],
      profile_id: json['profile_id'],
      spouse_dob: json['spouse_dob'],
      spouse_gender: json['spouse_gender'],
      spouse_name: json['spouse_name'],
      spouse_pre_existing_health: json['spouse_pre_existing_health'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lead_code'] = this.lead_code;
    data['profile_id'] = this.profile_id;
    data['spouse_dob'] = this.spouse_dob;
    data['spouse_gender'] = this.spouse_gender;
    data['spouse_name'] = this.spouse_name;
    data['spouse_pre_existing_health'] = this.spouse_pre_existing_health;
    if (this.child_info != null) {
      data['child_info'] = this.child_info.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildInfoServer {
  String child_dob;
  String child_gender;
  String child_name;
  String created_at;
  String lead_code;
  int lead_profile_id;
  bool pre_existing_health;
  String status;
  String updated_at;

  ChildInfoServer(
      {this.child_dob,
      this.child_gender,
      this.child_name,
      this.created_at,
      this.lead_code,
      this.lead_profile_id,
      this.pre_existing_health,
      this.status,
      this.updated_at});

  factory ChildInfoServer.fromJson(Map<String, dynamic> json) {
    return ChildInfoServer(
      child_dob: json['child_dob'],
      child_gender: json['child_gender'],
      child_name: json['child_name'],
      created_at: json['created_at'],
      lead_code: json['lead_code'],
      lead_profile_id: json['lead_profile_id'],
      pre_existing_health: json['pre_existing_health'] == 1,
      status: json['status'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = '';
    data['child_dob'] = this.child_dob;
    data['child_gender'] = this.child_gender;
    data['child_name'] = this.child_name;
    data['created_at'] = this.created_at;
    data['lead_code'] = this.lead_code;
    data['lead_profile_id'] = this.lead_profile_id;
    data['pre_existing_health'] = this.pre_existing_health ? 1 : 0;
    data['status'] = this.status;
    data['updated_at'] = this.updated_at;
    return data;
  }
}

class MemberInfo {
  String dob;
  String gender;
  String name;
  bool pre_existing_health;
  bool ischild;

  MemberInfo(
      {this.dob,
      this.gender,
      this.name,
      this.pre_existing_health =  false,
      this.ischild =  true,
      });

  factory MemberInfo.fromJson(Map<String, dynamic> json) {
    return MemberInfo(
      dob: json['dob'],
      gender: json['gender'],
      name: json['name'],
      pre_existing_health: json['pre_existing_health'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['name'] = this.name;
    data['pre_existing_health'] = this.pre_existing_health;
    return data;
  }
}

