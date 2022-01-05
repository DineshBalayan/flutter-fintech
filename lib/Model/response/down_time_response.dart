// @dart=2.10

class DownTimeResponse {
  DownTimeMessages data;
  String code;
  String message;
  bool success;

  DownTimeResponse({this.data, this.code, this.message, this.success});

  factory DownTimeResponse.fromJson(Map<String, dynamic> json) {
    return DownTimeResponse(
      data:
          json['data'] != null ? DownTimeMessages.fromJson(json['data']) : null,
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

class DownTimeMessages {
  List<String> err_msg;

  DownTimeMessages({this.err_msg});

  factory DownTimeMessages.fromJson(Map<String, dynamic> json) {
    return DownTimeMessages(
      err_msg: json['err_msg'] != null
          ? new List<String>.from(json['err_msg'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.err_msg != null) {
      data['err_msg'] = this.err_msg;
    }
    return data;
  }
}
