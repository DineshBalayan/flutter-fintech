class CheckUpdateRequest {
    var user_id;
    var ip;
    var mobile_no;
    var lags_longs;
    var device_id;
    var app_version;
    var mobile_type;

    CheckUpdateRequest({this.user_id, this.ip, this.mobile_no, this.lags_longs, this.device_id, this.app_version, this.mobile_type});

    factory CheckUpdateRequest.fromJson(Map<String, dynamic> json) {
        return CheckUpdateRequest(
            user_id: json['user_id'], 
            ip: json['ip'], 
            mobile_no: json['mobile_no'], 
            lags_longs: json['lags_longs'], 
            device_id: json['device_id'], 
            app_version: json['app_version'], 
            mobile_type: json['mobile_type'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['user_id'] = this.user_id;
        data['ip'] = this.ip;
        data['mobile_no'] = this.mobile_no;
        data['lags_longs'] = this.lags_longs;
        data['device_id'] = this.device_id;
        data['app_version'] = this.app_version;
        data['mobile_type'] = this.mobile_type;
        return data;
    }
}