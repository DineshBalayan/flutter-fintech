class FcmTokenRequest {
  var fcm_token;
  var user_id;

  FcmTokenRequest({this.fcm_token, this.user_id});

  factory FcmTokenRequest.fromJson(Map<String, dynamic> json) {
    return FcmTokenRequest(
      fcm_token: json['fcm_token'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fcm_token'] = this.fcm_token;
    data['user_id'] = this.user_id;
    return data;
  }
}
