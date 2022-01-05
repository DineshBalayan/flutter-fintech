// @dart=2.10
class MPinRequest {
  var mpin;
  var user_id;
  List<int> products;

  MPinRequest({this.mpin, this.products, this.user_id});

  factory MPinRequest.fromJson(Map<String, dynamic> json) {
    return MPinRequest(
      mpin: json['mpin'],
      user_id: json['user_id'],
      products: json['products'] != null
          ? new List<int>.from(json['products'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mpin'] = this.mpin;
    data['user_id'] = this.user_id;
    if (this.products != null) {
      data['products'] = this.products;
    }
    return data;
  }
}
