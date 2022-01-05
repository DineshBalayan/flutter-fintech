// @dart=2.10
class BaseResponse {
  int code;
  String message;
  bool success;
  var data;

  BaseResponse({this.code, this.message, this.success, this.data});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      code: json['code'],
      message: json['message'],
      success: json['success'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['success'] = this.success;
    data['data'] = this.data;
    return data;
  }
}
