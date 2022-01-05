// @dart=2.10
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class GetSectionHelpResponse {
  List<SectionHelpData> data;
  int code;
  String message;
  bool success;

  GetSectionHelpResponse({this.data, this.code, this.message, this.success});

  factory GetSectionHelpResponse.fromJson(Map<String, dynamic> json) {
    return GetSectionHelpResponse(
      data: json['data'] != null
          ? (json['data'] as List)
              .map((i) => SectionHelpData.fromJson(i))
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

class SectionHelpData {
  List<QueAn> que_ans;
  List<Subcat> subcat;
  String title;
  String description;

  SectionHelpData({this.que_ans, this.subcat, this.title, this.description});

  factory SectionHelpData.fromJson(Map<String, dynamic> json) {
    return SectionHelpData(
      que_ans: json['que_ans'] != null
          ? (json['que_ans'] as List).map((i) => QueAn.fromJson(i)).toList()
          : null,
      subcat: json['subcat'] != null
          ? (json['subcat'] as List).map((i) => Subcat.fromJson(i)).toList()
          : null,
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.que_ans != null) {
      data['que_ans'] = this.que_ans.map((v) => v.toJson()).toList();
    }
    if (this.subcat != null) {
      data['subcat'] = this.subcat.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QueAn {
  String answer;
  String question;
  String video_url;

  RxBool isExpanded = false.obs;

  QueAn({this.answer, this.question, this.video_url});

  factory QueAn.fromJson(Map<String, dynamic> json) {
    return QueAn(
        answer: json['answer'],
        question: json['question'],
        video_url: json['video_url']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer'] = this.answer;
    data['question'] = this.question;
    data['video_url'] = this.video_url;
    return data;
  }
}

class Subcat {
  List<QueAn> que_ans;
  String sub_title;

  Subcat({this.que_ans, this.sub_title});

  factory Subcat.fromJson(Map<String, dynamic> json) {
    return Subcat(
      que_ans: json['que_ans'] != null
          ? (json['que_ans'] as List).map((i) => QueAn.fromJson(i)).toList()
          : null,
      sub_title: json['sub_title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_title'] = this.sub_title;
    if (this.que_ans != null) {
      data['que_ans'] = this.que_ans.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
