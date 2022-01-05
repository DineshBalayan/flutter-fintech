// @dart=2.10
import 'package:get/get.dart';

class ParentProductDetailResponse {
  Data data;
  int code;
  String message;
  bool success;

  ParentProductDetailResponse(
      {this.data, this.code, this.message, this.success});

  factory ParentProductDetailResponse.fromJson(Map<String, dynamic> json) {
    return ParentProductDetailResponse(
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
  List<ChildProduct> childProduct;
  String title;

  Data({this.childProduct, this.title});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      childProduct: json['childProduct'] != null
          ? (json['childProduct'] as List)
              .map((i) => ChildProduct.fromJson(i))
              .toList()
          : null,
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.childProduct != null) {
      data['childProduct'] = this.childProduct.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildProduct {
  String basic_content;
  String product_sub_title;
  List<Faq> faq;
  String how_to_earn;
  String payout_amount;
  String product_title;
  String message;
  String product_logo;
  String video_url;
  int id;

  ChildProduct(
      {this.basic_content,
      this.faq,
      this.id,
      this.product_sub_title,
      this.how_to_earn,
      this.message,
      this.product_logo,
      this.payout_amount,
      this.product_title,
      this.video_url});

  factory ChildProduct.fromJson(Map<String, dynamic> json) {
    return ChildProduct(
      basic_content: json['basic_content'],
      faq: json['faq'] != null
          ? (json['faq'] as List).map((i) => Faq.fromJson(i)).toList()
          : null,
      how_to_earn: json['how_to_earn'],
      id: json['id'],
      product_logo: json['product_logo'],
      product_sub_title: json['product_sub_title'],
      message: json['message'],
      payout_amount: json['payout_amount'],
      product_title: json['product_title'],
      video_url: json['video_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['basic_content'] = this.basic_content;
    data['how_to_earn'] = this.how_to_earn;
    data['payout_amount'] = this.payout_amount;
    data['product_title'] = this.product_title;
    data['product_logo'] = this.product_logo;
    data['product_sub_title'] = this.product_sub_title;
    data['message'] = this.message;
    data['video_url'] = this.video_url;
    data['id'] = this.id;
    if (this.faq != null) {
      data['faq'] = this.faq.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Faq {
  String ans;
  String que;

  RxBool isExpanded = false.obs;

  Faq({this.ans, this.que});

  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(
      ans: json['ans'],
      que: json['que'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ans'] = this.ans;
    data['que'] = this.que;
    return data;
  }
}
