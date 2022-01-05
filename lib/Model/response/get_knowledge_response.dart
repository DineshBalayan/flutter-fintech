// @dart=2.10
class GetKnowledgeResponse {
  List<Category> data;
  int code;
  String message;
  bool success;

  GetKnowledgeResponse({this.data, this.code, this.message, this.success});

  factory GetKnowledgeResponse.fromJson(Map<String, dynamic> json) {
    return GetKnowledgeResponse(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Category.fromJson(i)).toList()
          : null,
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
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String category_name;
  List<Video> video_list;

  Category({this.category_name, this.video_list});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      category_name: json['category_name'],
      video_list: json['video_list'] != null
          ? (json['video_list'] as List).map((i) => Video.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.category_name;
    if (this.video_list != null) {
      data['video_list'] = this.video_list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Video {
  String title;
  String video_url;

  Video({this.title, this.video_url});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      title: json['title'],
      video_url: json['video_url'],
    );
  }

  String get videoId {
    if (video_url.contains(' ')) {
      return null;
    }

    Uri uri;
    try {
      uri = Uri.parse(video_url);
    } catch (e) {
      return null;
    }

    if (!['https', 'http'].contains(uri.scheme)) {
      return null;
    }

    // youtube.com/watch?v=xxxxxxxxxxx
    if (['youtube.com', 'www.youtube.com', 'm.youtube.com']
            .contains(uri.host) &&
        uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == 'watch' &&
        uri.queryParameters.containsKey('v')) {
      final videoId = uri.queryParameters['v'];
      return _isValidId(videoId) ? videoId : null;
    }

    // youtu.be/xxxxxxxxxxx
    if (uri.host == 'youtu.be' && uri.pathSegments.isNotEmpty) {
      final videoId = uri.pathSegments.first;
      return _isValidId(videoId) ? videoId : null;
    }

    return null;
  }

  bool _isValidId(String id) => RegExp(r'^[_\-a-zA-Z0-9]{11}$').hasMatch(id);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['video_url'] = this.video_url;
    return data;
  }
}
