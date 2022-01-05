// @dart=2.10
import 'package:bank_sathi/Model/response/CustomerQuery.dart';

class SupportQueryListResponse {
  List<CustomerQuery> data;
  int code;
  String message;
  bool success;

  SupportQueryListResponse({this.data, this.code, this.message, this.success});

  factory SupportQueryListResponse.fromJson(Map<String, dynamic> json) {
    return SupportQueryListResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => CustomerQuery.fromJson(i)).toList() : null,
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