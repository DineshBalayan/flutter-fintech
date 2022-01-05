// @dart=2.10

class NotificationResponse {
  Data data;
  int code;
  String message;
  bool success;

  NotificationResponse({this.data, this.code, this.message, this.success});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
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
  String current_time;
  List<Notification> notification;

  Data({this.current_time, this.notification});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      current_time: json['current_time'],
      notification: json['notification'] != null
          ? (json['notification'] as List)
              .map((i) => Notification.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_time'] = this.current_time;
    if (this.notification != null) {
      data['notification'] = this.notification.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notification {
  String content;
  int id;
  String image;
  String link;
  String status;
  String title;
  String updated_at;

  Notification(
      {this.content,
      this.id,
      this.image,
      this.link,
      this.status,
      this.title,
      this.updated_at});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      content: json['content'],
      id: json['id'],
      image: json['image'],
      link: json['link'],
      status: json['status'],
      title: json['title'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['id'] = this.id;
    data['image'] = this.image;
    data['status'] = this.status;
    data['title'] = this.title;
    data['updated_at'] = this.updated_at;

    data['link'] = this.link;

    return data;
  }
}
