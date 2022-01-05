// @dart=2.10
import 'dart:convert';

MarketingModel marketingModelFromJson(String str) => MarketingModel.fromJson(json.decode(str));

String marketingModelToJson(MarketingModel data) => json.encode(data.toJson());

class MarketingModel {
  MarketingModel({
    this.code,
    this.success,
    this.data,
    this.message,
  });

  int code;
  bool success;
  List<MarketingData> data;
  String message;

  factory MarketingModel.fromJson(Map<String, dynamic> json) => MarketingModel(
    code: json["code"],
    success: json["success"],
    data: List<MarketingData>.from(json["data"].map((x) => MarketingData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class MarketingData {
  MarketingData({
    this.catId,
    this.catName,
    this.cardArr,
  });

  int catId;
  bool isExpanded = false;
  String catName;
  List<CardArr> cardArr;

  factory MarketingData.fromJson(Map<String, dynamic> json) => MarketingData(
    catId: json["cat_id"],
    catName: json["cat_name"],
    cardArr: List<CardArr>.from(json["card_arr"].map((x) => CardArr.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cat_id": catId,
    "cat_name": catName,
    "card_arr": List<dynamic>.from(cardArr.map((x) => x.toJson())),
  };
}

class CardArr {
  CardArr({
    this.title,
    this.cardId,
    this.image,
  });

  String title;
  int cardId;
  String image;

  factory CardArr.fromJson(Map<String, dynamic> json) => CardArr(
    title: json["title"],
    cardId: json["card_id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "card_id": cardId,
    "image": image,
  };
}
