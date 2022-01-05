// @dart=2.10
import 'package:get/get.dart';

class GetFAQsResponse {
  List<FAQsData> data;
  int code;
  String message;
  bool success;

  GetFAQsResponse({this.data, this.code, this.message, this.success});

  factory GetFAQsResponse.fromJson(Map<String, dynamic> json) {
    return GetFAQsResponse(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => FAQsData.fromJson(i)).toList()
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

class FAQsData {
  String category;
  List<Faq> faq;

  FAQsData({this.category, this.faq});

  factory FAQsData.fromJson(Map<String, dynamic> json) {
    return FAQsData(
      category: json['category'],
      faq: json['faq'] != null
          ? (json['faq'] as List).map((i) => Faq.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.faq != null) {
      data['faq'] = this.faq.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Faq {
  String answer;
  String question;
  RxBool isExpanded = false.obs;

  Faq({this.answer, this.question});

  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(
      answer: json['answer'],
      question: json['question'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer'] = this.answer;
    data['question'] = this.question;
    return data;
  }
}
