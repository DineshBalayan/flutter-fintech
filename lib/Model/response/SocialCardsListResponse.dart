// @dart=2.10
import 'package:get/get.dart';

class SocialCardsListResponse {
  List<Cardscatlist> data;
  int code;
  String message;
  bool success;

  SocialCardsListResponse({this.data, this.code, this.message, this.success});

  factory SocialCardsListResponse.fromJson(Map<String, dynamic> json) {
    return SocialCardsListResponse(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Cardscatlist.fromJson(i)).toList()
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
      data['data`'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cardscatlist {
  List<Card> card_arr;
  int cat_id;
  String cat_name;

  final RxBool _isExpanded = false.obs;

  bool get isExpanded => _isExpanded.value;

  set isExpanded(val) => _isExpanded.value = val;

  Cardscatlist({this.card_arr, this.cat_id, this.cat_name});

  factory Cardscatlist.fromJson(Map<String, dynamic> json) {
    return Cardscatlist(
      card_arr: json['card_arr'] != null
          ? (json['card_arr'] as List).map((i) => Card.fromJson(i)).toList()
          : null,
      cat_id: json['cat_id'],
      cat_name: json['cat_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.cat_id;
    data['cat_name'] = this.cat_name;
    if (this.card_arr != null) {
      data['card_arr'] = this.card_arr.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Card {
  int card_id;
  String image;
  String title;

  Card({this.card_id, this.image, this.title});

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      card_id: json['card_id'],
      image: json['image'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_id'] = this.card_id;
    data['image'] = this.image;
    data['title'] = this.title;
    return data;
  }
}
