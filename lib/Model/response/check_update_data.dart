// @dart=2.10
class CheckUpdateData {
  String and_version;
  String created_at;
  String force_update;
  String message;
  int id;
  String ios_version;
  String updated_at;

  CheckUpdateData({this.and_version, this.created_at, this.force_update, this.message, this.id, this.ios_version, this.updated_at});

  factory CheckUpdateData.fromJson(Map<String, dynamic> json) {
    return CheckUpdateData(
      and_version: json['and_version'],
      created_at: json['created_at'],
      force_update: json['force_update'],
      id: json['id'],
      message: json['msg'],
      ios_version: json['ios_version'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['and_version'] = this.and_version;
    data['created_at'] = this.created_at;
    data['force_update'] = this.force_update;
    data['id'] = this.id;
    data['msg'] = this.message;
    data['ios_version'] = this.ios_version;
    data['updated_at'] = this.updated_at;
    return data;
  }
}