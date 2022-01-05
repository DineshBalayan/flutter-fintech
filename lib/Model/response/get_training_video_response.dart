// @dart=2.10
class GetTrainingVideoResponse {
  List<TrainingVideo> data;
  int code;
  String message;
  bool success;

  GetTrainingVideoResponse({this.data, this.code, this.message, this.success});

  factory GetTrainingVideoResponse.fromJson(Map<String, dynamic> json) {
    return GetTrainingVideoResponse(
      data: json['data'] != null
          ? (json['data'] as List)
              .map((i) => TrainingVideo.fromJson(i))
              .toList()
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

class TrainingVideo {
  String end_date;
  String end_time;
  String share_msg;
  int id;
  int is_enrolled;
  String product_icon;
  String start_date;
  String start_time;
  String title;
  String video_url;

  TrainingVideo(
      {this.end_date,
      this.end_time,
      this.share_msg,
      this.id,
      this.is_enrolled,
      this.product_icon,
      this.start_date,
      this.start_time,
      this.title,
      this.video_url});

  factory TrainingVideo.fromJson(Map<String, dynamic> json) {
    return TrainingVideo(
      end_date: json['end_date'],
      end_time: json['end_time'],
      id: json['id'],
      share_msg: json['share_msg'],
      is_enrolled: json['is_enrolled'],
      product_icon: json['product_icon'],
      start_date: json['start_date'],
      start_time: json['start_time'],
      title: json['title'],
      video_url: json['video_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['end_date'] = this.end_date;
    data['end_time'] = this.end_time;
    data['id'] = this.id;
    data['is_enrolled'] = this.is_enrolled;
    data['product_icon'] = this.product_icon;
    data['start_date'] = this.start_date;
    data['share_msg'] = this.share_msg;
    data['start_time'] = this.start_time;
    data['title'] = this.title;
    data['video_url'] = this.video_url;
    return data;
  }
}
