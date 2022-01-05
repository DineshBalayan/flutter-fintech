class AddCustomerRequest {
  var user_id;
  var description;
  var title;

  AddCustomerRequest({this.user_id, this.title, this.description});

  factory AddCustomerRequest.fromJson(Map<String, dynamic> json) {
    return AddCustomerRequest(
      user_id: json['user_id'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.user_id;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
