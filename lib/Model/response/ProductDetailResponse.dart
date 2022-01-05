// @dart=2.10
import 'package:get/get.dart';

class ProductDetailResponse {
  ProductDetailItem data;
  int code;
  String message;
  bool success;

  ProductDetailResponse({this.data, this.code, this.message, this.success});

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailResponse(
      data: json['data'] != null
          ? ProductDetailItem.fromJson(json['data'])
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
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ProductDetailItem {
  int id;
  List<PayoutDetail> payout_detail;
  List<Quiz> quiz;
  String  is_trained;
  String  video_url;
  List<ShareContent> share_content;
  String share_image;
  String share_link;
  List<DetailTab> tab;
  String title;

  ProductDetailItem(
      {this.id,
      this.payout_detail,
      this.quiz,
      this.share_content,
      this.share_image,
      this.is_trained,
      this.video_url,
      this.share_link,
      this.tab,
      this.title});

  factory ProductDetailItem.fromJson(Map<String, dynamic> json) {
    return ProductDetailItem(
      id: json['id'],
      payout_detail: json['payout_detail'] != null
          ? (json['payout_detail'] as List)
              .map((i) => PayoutDetail.fromJson(i))
              .toList()
          : null,
      quiz: json['quiz'] != null
          ? (json['quiz'] as List)
              .map((i) => Quiz.fromJson(i))
              .toList()
          : null,
      share_content: json['share_content'] != null
          ? (json['share_content'] as List)
              .map((i) => ShareContent.fromJson(i))
              .toList()
          : null,
      share_image: json['share_image'],
      is_trained: json['is_trained'],
      video_url: json['video_url'],
      share_link: json['share_link'],
      tab: json['tab'] != null
          ? (json['tab'] as List).map((i) => DetailTab.fromJson(i)).toList()
          : null,
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['share_image'] = this.share_image;
    data['is_trained'] = this.is_trained;
    data['video_url'] = this.video_url;
    data['share_link'] = this.share_link;
    data['title'] = this.title;
    if (this.payout_detail != null) {
      data['payout_detail'] =
          this.payout_detail.map((v) => v.toJson()).toList();
    }
    if (this.quiz != null) {
      data['quiz'] =
          this.quiz.map((v) => v.toJson()).toList();
    }
    if (this.share_content != null) {
      data['share_content'] =
          this.share_content.map((v) => v.toJson()).toList();
    }
    if (this.tab != null) {
      data['tab'] = this.tab.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DetailTab {
  String content;
  int language_id;
  String tab_name;

  DetailTab({this.content, this.language_id, this.tab_name});

  factory DetailTab.fromJson(Map<String, dynamic> json) {
    return DetailTab(
      content: json['content'],
      language_id: json['language_id'],
      tab_name: json['tab_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['language_id'] = this.language_id;
    data['tab_name'] = this.tab_name;
    return data;
  }
}

class ShareContent {
  String content;
  String lang;

  ShareContent({this.content, this.lang});

  factory ShareContent.fromJson(Map<String, dynamic> json) {
    return ShareContent(
      content: json['content'],
      lang: json['lang'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['lang'] = this.lang;
    return data;
  }
}

class PayoutDetail {
  String business_type;
  String category;
  List<Payout> payout;

  PayoutDetail({this.business_type, this.category, this.payout});

  factory PayoutDetail.fromJson(Map<String, dynamic> json) {
    return PayoutDetail(
      business_type: json['business_type'],
      category: json['category'],
      payout: json['payout'] != null
          ? (json['payout'] as List).map((i) => Payout.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_type'] = this.business_type;
    data['category'] = this.category;
    if (this.payout != null) {
      data['payout'] = this.payout.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quiz {
  String que_title;
  List<AnsOptions> ansoptions;

  Quiz({this.que_title, this.ansoptions});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      que_title: json['que_title'],
      ansoptions: json['options'] != null
          ? (json['options'] as List)
          .map((i) => AnsOptions.fromJson(i))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['options'] = this.que_title;
    if (this.ansoptions != null) {
      data['options'] =
          this.ansoptions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnsOptions {
  String ans_title;
  String is_correct;
  RxBool is_clicked = false.obs;

  AnsOptions({this.ans_title, this.is_correct});

  factory AnsOptions.fromJson(Map<String, dynamic> json) {
    return AnsOptions(
      ans_title: json['ans_title'],
      is_correct: json['is_correct'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ans_title'] = this.ans_title;
    data['is_correct'] = this.is_correct;
    return data;
  }
}

class Payout {
  String payout;
  String range;

  Payout({this.payout, this.range});

  factory Payout.fromJson(Map<String, dynamic> json) {
    return Payout(
      payout: json['payout'],
      range: json['range'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payout'] = this.payout;
    data['range'] = this.range;
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
