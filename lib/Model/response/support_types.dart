// @dart=2.10
class SupportTypeResponse {
  List<SupportType> types;
  int code;
  String message;
  bool success;

  SupportTypeResponse({this.types, this.code, this.message, this.success});

  factory SupportTypeResponse.fromJson(Map<String, dynamic> json) {
    return SupportTypeResponse(
      types: json['data'] != null ? (json['data'] as List).map((i) => SupportType.fromJson(i)).toList() : null,
      code: json['code'],
      message: json['message'],
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> types = new Map<String, dynamic>();
    types['code'] = this.code;
    types['message'] = this.message;
    types['success'] = this.success;
    if (this.types != null) {
      types['types'] = this.types.map((v) => v.toJson()).toList();
    }
    return types;
  }


}
class SupportType {
  int id;
  String status;
  String title;

  SupportType({this.id, this.status, this.title});

  factory SupportType.fromJson(Map<String, dynamic> json) {
    return SupportType(
      id: json['id'],
      status: json['status'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> types = new Map<String, dynamic>();
    types['id'] = this.id;
    types['status'] = this.status;
    types['title'] = this.title;
    return types;
  }
}

