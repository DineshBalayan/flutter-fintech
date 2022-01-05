class AddExistingLoanRequest {
    var lead_id;
    var monthly_emi;
    var profile_id;
    var total_rem_loan;

    AddExistingLoanRequest({this.lead_id, this.monthly_emi, this.profile_id, this.total_rem_loan});

    factory AddExistingLoanRequest.fromJson(Map<String, dynamic> json) {
        return AddExistingLoanRequest(
            lead_id: json['lead_id'], 
            monthly_emi: json['monthly_emi'], 
            profile_id: json['profile_id'], 
            total_rem_loan: json['total_rem_loan'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['lead_id'] = this.lead_id;
        data['monthly_emi'] = this.monthly_emi;
        data['profile_id'] = this.profile_id;
        data['total_rem_loan'] = this.total_rem_loan;
        return data;
    }
}