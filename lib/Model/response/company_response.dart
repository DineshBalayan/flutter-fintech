// @dart=2.10
class CompanyResponse {
  List<CompanyData> data;
  int code;
  String message;
  bool success;

  CompanyResponse({this.data, this.code, this.message, this.success});

  factory CompanyResponse.fromJson(Map<String, dynamic> json) {
    return CompanyResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => CompanyData.fromJson(i)).toList() : null,
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
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompanyData {
  int id;
  String company_name;

  CompanyData({this.id, this.company_name});

  factory CompanyData.fromJson(Map<String, dynamic> json) {
    return CompanyData(
      id: json['id'],
      company_name: json['company_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.company_name;
    return data;
  }
}