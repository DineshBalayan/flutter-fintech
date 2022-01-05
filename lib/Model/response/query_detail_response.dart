// @dart=2.10
class QueryDetailResponse {
  QueryData data;
  int code;
  String message;
  bool success;

  QueryDetailResponse({this.data, this.code, this.message, this.success});

  factory QueryDetailResponse.fromJson(Map<String, dynamic> json) {
    return QueryDetailResponse(
      data: json['data'] != null ? QueryData.fromJson(json['data']) : null,
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

class QueryData {
  List<Comment> comments;
  CustomerQuery query;

  QueryData({this.comments, this.query});

  factory QueryData.fromJson(Map<String, dynamic> json) {
    return QueryData(
      comments: json['comments'] != null
          ? (json['comments'] as List).map((i) => Comment.fromJson(i)).toList()
          : null,
      query:
          json['query'] != null ? CustomerQuery.fromJson(json['query']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    if (this.query != null) {
      data['query'] = this.query.toJson();
    }
    return data;
  }
}

class CustomerQuery {
  String created_at;
  String description;
  String request_code;
  String status;
  int support_id;
  String title;
  int user_id;

  CustomerQuery(
      {this.created_at,
      this.description,
      this.request_code,
      this.status,
      this.support_id,
      this.title,
      this.user_id});

  factory CustomerQuery.fromJson(Map<String, dynamic> json) {
    return CustomerQuery(
      created_at: json['created_at'],
      description: json['description'],
      request_code: json['request_code'],
      status: json['status'],
      support_id: json['support_id'],
      title: json['title'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.created_at;
    data['description'] = this.description;
    data['request_code'] = this.request_code;
    data['status'] = this.status;
    data['support_id'] = this.support_id;
    data['title'] = this.title;
    data['user_id'] = this.user_id;
    return data;
  }
}

class Comment {
  String comment;
  int comment_id;
  String commented_by;
  String created_at;

  Comment({this.comment, this.comment_id, this.commented_by, this.created_at});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      comment: json['comment'],
      comment_id: json['comment_id'],
      commented_by: json['commented_by'],
      created_at: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    data['comment_id'] = this.comment_id;
    data['commented_by'] = this.commented_by;
    data['created_at'] = this.created_at;
    return data;
  }
}
