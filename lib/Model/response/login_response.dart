// @dart=2.10
class LoginResponse {
  Data data;
  int code;
  String message;
  bool success;

  LoginResponse({this.data, this.code, this.message, this.success});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
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

class Data {
  bool is_register;
  int otp;

  Data({this.is_register, this.otp});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      is_register: json['is_register'],
      otp: json['otp'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_register'] = this.is_register;
    data['otp'] = this.otp;
    return data;
  }
}