// @dart=2.10
class LeadTransactionsResponse {
  Data data;
  int code;
  String message;
  bool success;

  LeadTransactionsResponse({this.data, this.code, this.message, this.success});

  factory LeadTransactionsResponse.fromJson(Map<String, dynamic> json) {
    return LeadTransactionsResponse(
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
  LeadPayout lead_payout;
  int user_id;

  Data({this.lead_payout, this.user_id});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      lead_payout: json['lead_payout'] != null
          ? LeadPayout.fromJson(json['lead_payout'])
          : null,
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.user_id;
    if (this.lead_payout != null) {
      data['lead_payout'] = this.lead_payout.toJson();
    }
    return data;
  }
}

class LeadPayout {
  List<LeadTransactions> data;
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

  LeadPayout(
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

  factory LeadPayout.fromJson(Map<String, dynamic> json) {
    return LeadPayout(
      data: json['data'] != null
          ? (json['data'] as List)
              .map((i) => LeadTransactions.fromJson(i))
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

class LeadTransactions {
  String amount;
  String message;
  String mobile_no;
  String on_task_title;
  String created_at;
  int id;
  int lead_id;
  int lead_status;
  String name;
  String on_task_payout;
  String on_task_amt;
  String adviser_name;
  int user_id;

  LeadTransactions(
      {this.amount,
      this.message,
      this.created_at,
      this.id,
      this.mobile_no,
      this.lead_id,
      this.lead_status,
      this.on_task_title,
      this.name,
      this.on_task_payout,
      this.on_task_amt,
      this.adviser_name,
      this.user_id});

  factory LeadTransactions.fromJson(Map<String, dynamic> json) {
    return LeadTransactions(
      amount: json['amount'],
      created_at: json['created_at'],
      message: json['message'],
      id: json['id'],
      mobile_no: json['mobile_no'],
      lead_id: json['lead_id'],
      on_task_title: json['on_task_title'],
      lead_status: json['lead_status'],
      name: json['name'],
      on_task_amt: json['on_task_amt'],
      on_task_payout: json['on_task_payout'],
      adviser_name: json['customer_name'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['created_at'] = this.created_at;
    data['id'] = this.id;
    data['message'] = this.message;
    data['lead_id'] = this.lead_id;
    data['mobile_no'] = this.mobile_no;
    data['lead_status'] = this.lead_status;
    data['on_task_title'] = this.on_task_title;
    data['name'] = this.name;
    data['on_task_amt'] = this.on_task_amt;
    data['on_task_payout'] = this.on_task_payout;
    data['customer_name'] = this.adviser_name;
    data['user_id'] = this.user_id;
    return data;
  }
}
