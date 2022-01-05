class PanVerifyRequest {
    var pan_no;
    var user_id;
    var pincode_id;
    var refferal_code;

    PanVerifyRequest({this.pan_no,this.pincode_id,this.user_id,this.refferal_code,});

    factory PanVerifyRequest.fromJson(Map<String, dynamic> json) {
        return PanVerifyRequest(
            pan_no: json['pan_no'],
            pincode_id: json['pincode_id'],
            user_id: json['user_id'],
            refferal_code: json['refferal_code'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['pan_no'] = this.pan_no;
        data['pincode_id'] = this.pincode_id;
        data['user_id'] = this.user_id;
        data['refferal_code'] = this.refferal_code;
        return data;
    }
}
