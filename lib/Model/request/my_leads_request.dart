// @dart=2.10
class MyLeadsRequest {
  int user_id;
  int this_week;
  int card_id;
  var lead_id;
  int page;
  String comment;
  int status;
  String fromDate;
  String toDate;
  List<int> products;

  MyLeadsRequest(
      {this.user_id,
      this.card_id,
      this.this_week,
      this.lead_id,
      this.page,
      this.comment,
      this.status,
      this.fromDate,
      this.products,
      this.toDate});

  factory MyLeadsRequest.fromJson(Map<String, dynamic> json) {
    return MyLeadsRequest(
      user_id: json['user_id'],
      this_week: json['this_week'],
      card_id: json['card_id'],
      lead_id: json['lead_id'],
      page: json['page'],
      comment: json['comment'],
      status: json['lead_status_parent_id'],
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      products: json['product_id'] != null
          ? new List<int>.from(json['products'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.user_id;
    data['card_id'] = this.card_id;
    data['this_week'] = this.this_week;
    data['lead_id'] = this.lead_id;
    data['page'] = this.page;
    data['comment'] = this.comment;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;

    if (this.status != null) {
      data['lead_status_parent_id'] = this.status;
    }

    if (this.products != null && this.products.isNotEmpty) {
      data['product_id'] = this.products;
    }
    return data;
  }
}
