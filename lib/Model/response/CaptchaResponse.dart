// @dart=2.10
class CaptchaResponse {
    CaptchaData data;
    int code;
    String message;
    bool success;

    CaptchaResponse({this.data, this.code, this.message, this.success});

    factory CaptchaResponse.fromJson(Map<String, dynamic> json) {
        return CaptchaResponse(
            data: json['data'] != null ? CaptchaData.fromJson(json['data']) : null,
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

class CaptchaData {
    String captcha;
    String uuid;

    CaptchaData({this.captcha, this.uuid});

    factory CaptchaData.fromJson(Map<String, dynamic> json) {
        return CaptchaData(
            captcha: json['captcha'],
            uuid: json['uuid'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['captcha'] = this.captcha;
        data['uuid'] = this.uuid;
        return data;
    }
}