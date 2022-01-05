// @dart=2.10
class CustomerQuery {
  String updated_at;
  String description;
  int id;
  String request_code;
  String status;
  String title;
  int user_id;

  CustomerQuery(
      {this.updated_at,
      this.description,
      this.id,
      this.request_code,
      this.status,
      this.title,
      this.user_id});

  factory CustomerQuery.fromJson(Map<String, dynamic> json) {
    return CustomerQuery(
      updated_at: json['updated_at'],
      description: json['description'],
      id: json['id'],
      request_code: json['request_code'],
      status: json['status'],
      title: json['title'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated_at'] = this.updated_at;
    data['description'] = this.description;
    data['id'] = this.id;
    data['request_code'] = this.request_code;
    data['status'] = this.status;
    data['title'] = this.title;
    data['user_id'] = this.user_id;
    return data;
  }
}
