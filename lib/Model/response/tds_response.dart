// @dart=2.10
class TDSResponse {
  int code;
  String message;
  bool success;
  Data tdsData;

  TDSResponse({this.code, this.message, this.success, this.tdsData});

  factory TDSResponse.fromJson(Map<String, dynamic> json) {
    return TDSResponse(
      code: json['code'],
      message: json['message'],
      success: json['success'],
      tdsData: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['success'] = this.success;
    if (this.tdsData != null) {
      data['data'] = this.tdsData.toJson();
    }
    return data;
  }
}
class Data {
  var title;
  var description;

  Data({this.title, this.description});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}