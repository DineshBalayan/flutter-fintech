// @dart=2.10
import 'dart:convert';

import 'package:get/get.dart';

TrainingModel trainingModelFromJson(String str) => TrainingModel.fromJson(json.decode(str));

String trainingModelToJson(TrainingModel data) => json.encode(data.toJson());

class TrainingModel {
  TrainingModel({
    this.code,
    this.success,
    this.mainData,
    this.message,
  });

  int code;
  bool success;
  List<TrainingData> mainData;
  String message;

  factory TrainingModel.fromJson(Map<String, dynamic> json) => TrainingModel(
    code: json["code"],
    success: json["success"],
    mainData: List<TrainingData>.from(json["data"].map((x) => TrainingData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "data": List<dynamic>.from(mainData.map((x) => x.toJson())),
    "message": message,
  };
}

class TrainingData {
  TrainingData({
    this.title,
    this.helpSection,
  });


  final RxBool _isExpanded = false.obs;

  bool get isExpanded => _isExpanded.value;

  set isExpanded(val) => _isExpanded.value = val;
  String title;
  List<HelpSection> helpSection;

  factory TrainingData.fromJson(Map<String, dynamic> json) => TrainingData(
    title: json["title"],
    helpSection: List<HelpSection>.from(json["help_section"].map((x) => HelpSection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "help_section": List<dynamic>.from(helpSection.map((x) => x.toJson())),
  };
}

class HelpSection {
  HelpSection({
    this.title,
    this.videoUrl,
  });

  String title;
  String videoUrl;

  factory HelpSection.fromJson(Map<String, dynamic> json) => HelpSection(
    title: json["title"],
    videoUrl: json["video_url"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "video_url": videoUrl,
  };
}
