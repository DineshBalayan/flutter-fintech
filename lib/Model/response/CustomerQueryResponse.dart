// @dart=2.10
import 'CustomerQuery.dart';

class CustomerQueryResponse {
  CustomerQuery data;
  int code;
  String message;
  bool success;

  CustomerQueryResponse({this.data, this.code, this.message, this.success});

  factory CustomerQueryResponse.fromJson(Map<String, dynamic> json) {
    return CustomerQueryResponse(
      data: json['data'] != null ? CustomerQuery.fromJson(json['data']) : null,
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