// @dart=2.10
class ReferralTransactionResponse {
  Data data;
  int code;
  String message;
  bool success;

  ReferralTransactionResponse(
      {this.data, this.code, this.message, this.success});

  factory ReferralTransactionResponse.fromJson(Map<String, dynamic> json) {
    return ReferralTransactionResponse(
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
  ReferralPayout referral_payout;
  int user_id;

  Data({this.referral_payout, this.user_id});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      referral_payout: json['referral_payout'] != null
          ? ReferralPayout.fromJson(json['referral_payout'])
          : null,
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.user_id;
    if (this.referral_payout != null) {
      data['referral_payout'] = this.referral_payout.toJson();
    }
    return data;
  }
}

class ReferralPayout {
  List<ReferralTransactions> data;
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

  ReferralPayout(
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

  factory ReferralPayout.fromJson(Map<String, dynamic> json) {
    return ReferralPayout(
      data: json['data'] != null
          ? (json['data'] as List)
              .map((i) => ReferralTransactions.fromJson(i))
              .toList()
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
    data['path'] = this.path;
    data['per_page'] = this.per_page;
    data['to'] = this.to;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.next_page_url;

    data['prev_page_url'] = this.prev_page_url;

    return data;
  }
}

class ReferralTransactions {
  String amount;
  String created_at;
  String name;
  String earning;
  int user_id;

  ReferralTransactions({this.amount, this.created_at, this.name, this.user_id, this.earning});

  factory ReferralTransactions.fromJson(Map<String, dynamic> json) {
    return ReferralTransactions(
      amount: json['amount'],
      created_at: json['created_at'],
      name: json['name'],
      user_id: json['user_id'],
      earning: json['earning'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['created_at'] = this.created_at;
    data['name'] = this.name;
    data['earning'] = this.earning;
    data['user_id'] = this.user_id;
    return data;
  }
}

class Link {
  bool active;
  String label;
  String url;

  Link({this.active, this.label, this.url});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(active: json['active'], label: json['label'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['label'] = this.label;
    if (this.url != null) {
      data['url'] = this.url;
    }
    return data;
  }
}
