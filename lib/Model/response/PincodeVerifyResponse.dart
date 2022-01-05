// @dart=2.10
class PincodeVerifyResponse {
    Data data;
    int code;
    String message;
    bool success;

    PincodeVerifyResponse({this.data, this.code, this.message, this.success});

    factory PincodeVerifyResponse.fromJson(Map<String, dynamic> json) {
        return PincodeVerifyResponse(
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
    int min_salary;

    Data({this.min_salary});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            min_salary: json['min_salary'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['min_salary'] = this.min_salary;
        return data;
    }
}