// @dart=2.10

class LoginVerificationResponse {
  Data data;
  int code;
  String message;
  bool success;

  LoginVerificationResponse({this.data, this.code, this.message, this.success});

  factory LoginVerificationResponse.fromJson(Map<String, dynamic> json) {
        return LoginVerificationResponse(
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
    String token;
    User user;

    Data({this.token, this.user});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            token: json['token'], 
            user: json['user'] != null ? User.fromJson(json['user']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['token'] = this.token;
        if (this.user != null) {
            data['user'] = this.user.toJson();
        }
        return data;
    }
}

class User {
    int id;
    String user_code;

    User({this.id, this.user_code});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            id: json['id'], 
            user_code: json['user_code'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['user_code'] = this.user_code;
        return data;
    }
}