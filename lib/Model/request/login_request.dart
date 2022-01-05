// @dart=2.10
class LoginRequest {
  String mobile_no;
  String otp;
  String login_type;
  String app_code;
  int user_id;

  LoginRequest({this.mobile_no, this.otp, this.login_type, this.app_code, this.user_id});

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      mobile_no: json['mobile_no'],
      otp: json['otp'],
      login_type: json['login_type'],
      app_code: json['app_code'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile_no'] = this.mobile_no;
    data['otp'] = this.otp;
    data['login_type'] = this.login_type;
    data['app_code'] = this.app_code;
    data['user_id'] = this.user_id;
    return data;
  }
}
