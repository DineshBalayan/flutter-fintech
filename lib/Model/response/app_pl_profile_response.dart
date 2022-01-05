// @dart=2.10

class AddPlProfileResponse {
  LeadIdData data;
  int code;
  String message;
  bool success;

  AddPlProfileResponse({this.data, this.code, this.message, this.success});

  factory AddPlProfileResponse.fromJson(Map<String, dynamic> json) {
    return AddPlProfileResponse(
      data: json['data'] != null ? LeadIdData.fromJson(json['data']) : null,
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

class LeadIdData {
  var lead_id;
  var profile_id;
  final String web_view_url;

  LeadIdData({this.lead_id, this.profile_id, this.web_view_url});

  factory LeadIdData.fromJson(Map<String, dynamic> json) {
    return LeadIdData(
        lead_id: json['lead_id'],
        profile_id: json['profile_id'],
        web_view_url: json['web_view_url']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lead_id'] = this.lead_id;
    data['profile_id'] = this.profile_id;
    if (this.web_view_url != null) {
      data['web_view_url'] = this.web_view_url;
    }
    return data;
  }
}
