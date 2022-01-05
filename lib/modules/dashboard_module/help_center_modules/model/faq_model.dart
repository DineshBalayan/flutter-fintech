// @dart=2.10
import 'dart:convert';

class FaqModel {
  FaqModel({
    this.code,
    this.success,
    this.data,
    this.message,
  });

  int code;
  bool success;
  List<FaqData> data;
  String message;

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
    code: json["code"],
    success: json["success"],
    data: List<FaqData>.from(json["data"].map((x) => FaqData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class FaqData {
  FaqData({
    this.title,
    this.queAns,
    this.subcatt,
  });

  String title;
  List<QueAn> queAns;
  List<Subcatt> subcatt;

  factory FaqData.fromJson(Map<String, dynamic> json) => FaqData(
    title: json["title"],
    queAns: List<QueAn>.from(json["que_ans"].map((x) => QueAn.fromJson(x))),
    subcatt: List<Subcatt>.from(json["subcat"].map((x) => Subcatt.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "que_ans": List<dynamic>.from(queAns.map((x) => x.toJson())),
    "subcat": List<dynamic>.from(subcatt.map((x) => x.toJson())),
  };
}

class QueAn {
  QueAn({
    this.question,
    this.answer,
    this.videoUrl,
  });

  String question;
  String answer;
  String videoUrl;

  factory QueAn.fromJson(Map<String, dynamic> json) => QueAn(
    question: json["question"],
    answer: json["answer"],
    videoUrl: json["video_url"],
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
    "video_url": videoUrl,
  };
}

class Subcatt {
  Subcatt({
    this.subTitle,
    this.queAns,
  });

  String subTitle;
  List<QueAn> queAns;

  factory Subcatt.fromJson(Map<String, dynamic> json) => Subcatt(
    subTitle: json["sub_title"],
    queAns: List<QueAn>.from(json["que_ans"].map((x) => QueAn.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sub_title": subTitle,
    "que_ans": List<dynamic>.from(queAns.map((x) => x.toJson())),
  };
}
