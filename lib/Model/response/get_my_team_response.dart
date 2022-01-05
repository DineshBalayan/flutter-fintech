// @dart=2.10
class GetMyTeamResponse {
  Data data;
  int code;
  String message;
  bool success;

  GetMyTeamResponse({this.data, this.code, this.message, this.success});

  factory GetMyTeamResponse.fromJson(Map<String, dynamic> json) {
    return GetMyTeamResponse(
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
  Members members;
  String self_earning;
  String team_earning;
  String year_earning;
  int inactive_advisor_of_month, active_advisor_of_month;

  Data(
      {this.members,
      this.self_earning,
      this.team_earning,
      this.year_earning,
      this.active_advisor_of_month,
      this.inactive_advisor_of_month});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      members:
          json['members'] != null ? Members.fromJson(json['members']) : null,
      self_earning: json['self_earning'],
      team_earning: json['total_referral_earning'],
      year_earning: json['year_earning'],
      active_advisor_of_month: json['active_advisor_of_month'],
      inactive_advisor_of_month: json['inactive_advisor_of_month'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self_earning'] = this.self_earning;
    data['team_earning'] = this.team_earning;
    data['year_earning'] = this.year_earning;
    if (this.members != null) {
      data['members'] = this.members.toJson();
    }
    return data;
  }
}

class Members {
  List<Member> data;
  int current_page;
  String first_page_url;
  int from;
  int last_page;
  String last_page_url;
  List<Link> links;
  String next_page_url;
  String path;
  int per_page;
  String prev_page_url;
  int to;
  int total;

  Members(
      {this.data,
      this.current_page,
      this.first_page_url,
      this.from,
      this.last_page,
      this.last_page_url,
      this.links,
      this.next_page_url,
      this.path,
      this.per_page,
      this.prev_page_url,
      this.to,
      this.total});

  factory Members.fromJson(Map<String, dynamic> json) {
    return Members(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Member.fromJson(i)).toList()
          : null,
      current_page: json['current_page'],
      first_page_url: json['first_page_url'],
      from: json['from'],
      last_page: json['last_page'],
      last_page_url: json['last_page_url'],
      links: json['links'] != null
          ? (json['links'] as List).map((i) => Link.fromJson(i)).toList()
          : null,
      next_page_url: json['next_page_url'],
      path: json['path'],
      per_page: json['per_page'],
      prev_page_url: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.current_page;
    data['first_page_url'] = this.first_page_url;
    data['from'] = this.from;
    data['last_page'] = this.last_page;
    data['last_page_url'] = this.last_page_url;
    data['next_page_url'] = this.next_page_url;
    data['path'] = this.path;
    data['per_page'] = this.per_page;
    data['prev_page_url'] = this.prev_page_url;
    data['to'] = this.to;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Link {
  bool active;
  String label;
  String url;

  Link({this.active, this.label, this.url});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      active: json['active'],
      label: json['label'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['label'] = this.label;
    data['url'] = this.url;
    return data;
  }
}

class Member {
  String created_at;
  String exist;
  String first_name;
  int id;
  String last_name;
  String mobile_no;
  String member_earning;
  String referral_earning;
  String profile_photo;
  String user_status;
  int user_type_id;

  Member(
      {this.created_at,
      this.exist,
      this.first_name,
      this.mobile_no,
      this.id,
      this.last_name,
      this.member_earning,
      this.referral_earning,
      this.profile_photo,
      this.user_status,
      this.user_type_id});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      created_at: json['created_at'],
      exist: json['exist'],
      first_name: json['first_name'],
      mobile_no: json['mobile_no'],
      id: json['id'],
      last_name: json['last_name'],
      member_earning: json['member_earning'],
      referral_earning: json['referral_earning'],
      profile_photo: json['profile_photo'],
      user_status: json['user_status'],
      user_type_id: json['user_type_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.created_at;
    data['exist'] = this.exist;
    data['first_name'] = this.first_name;
    data['mobile_no'] = this.mobile_no;
    data['id'] = this.id;
    data['last_name'] = this.last_name;
    data['member_earning'] = this.member_earning;
    data['referral_earning'] = this.referral_earning;
    data['profile_photo'] = this.profile_photo;
    data['user_status'] = this.user_status;
    data['user_type_id'] = this.user_type_id;
    return data;
  }
}
