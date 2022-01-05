// @dart=2.10
class LeadDetailResponse {
  LeadData data;
  int code;
  String message;
  bool success;

  LeadDetailResponse({this.data, this.code, this.message, this.success});

  factory LeadDetailResponse.fromJson(Map<String, dynamic> json) {
    return LeadDetailResponse(
      data: json['data'] != null ? LeadData.fromJson(json['data']) : null,
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

class LeadData {
  String button_content;
  String button_text;
  String button_title;
  String costomer_name;
  String created_at;
  int lead_id;
  List<Journey> journey;
  String lead_remark;
  String lead_status;
  int lead_status_id;
  String lead_title;
  String mobile_no;
  int product_id;
  int show_button;
  String updated_at;
  String product_icon;

  LeadData(
      {this.button_content,
      this.button_text,
      this.button_title,
      this.product_icon,
      this.costomer_name,
      this.created_at,
      this.lead_id,
      this.journey,
      this.lead_remark,
      this.lead_status,
      this.lead_status_id,
      this.lead_title,
      this.mobile_no,
      this.product_id,
      this.show_button,
      this.updated_at});

  factory LeadData.fromJson(Map<String, dynamic> json) {
    return LeadData(
      button_content: json['button_content'],
      button_text: json['button_text'],
      button_title: json['button_title'],
      costomer_name: json['costomer_name'],
      product_icon: json['product_icon'],
      created_at: json['created_at'],
      lead_id: json['lead_id'],
      journey: json['lead_log'] != null
          ? (json['lead_log'] as List).map((i) => Journey.fromJson(i)).toList()
          : null,
      lead_remark: json['lead_remark'],
      lead_status: json['lead_status'],
      lead_status_id: json['lead_status_id'],
      lead_title: json['lead_title'],
      mobile_no: json['mobile_no'],
      product_id: json['product_id'],
      show_button: json['show_button'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['button_content'] = this.button_content;
    data['button_text'] = this.button_text;
    data['button_title'] = this.button_title;
    data['costomer_name'] = this.costomer_name;
    data['created_at'] = this.created_at;
    data['lead_id'] = this.lead_id;
    data['lead_remark'] = this.lead_remark;
    data['lead_status'] = this.lead_status;
    data['lead_status_id'] = this.lead_status_id;
    data['lead_title'] = this.lead_title;
    data['mobile_no'] = this.mobile_no;
    data['product_icon'] = this.product_icon;
    data['product_id'] = this.product_id;
    data['show_button'] = this.show_button;
    data['updated_at'] = this.updated_at;
    if (this.journey != null) {
      data['lead_log'] = this.journey.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Journey {
  String lead_status_title;
  String lead_sub_remark;
  String lead_sub_status;
  String updated_at;

  Journey(
      {this.lead_status_title,
      this.lead_sub_remark,
      this.lead_sub_status,
      this.updated_at});

  factory Journey.fromJson(Map<String, dynamic> json) {
    return Journey(
      lead_status_title: json['lead_status_title'],
      lead_sub_remark: json['lead_sub_remark'],
      lead_sub_status: json['lead_sub_status'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lead_status_title'] = this.lead_status_title;
    data['lead_sub_remark'] = this.lead_sub_remark;
    data['lead_sub_status'] = this.lead_sub_status;
    data['updated_at'] = this.updated_at;
    return data;
  }
}
