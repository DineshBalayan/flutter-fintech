// @dart=2.10
class WithdrawalTransactionsResponse {
  Data data;
  int code;
  String message;
  bool success;

  WithdrawalTransactionsResponse(
      {this.data, this.code, this.message, this.success});

  factory WithdrawalTransactionsResponse.fromJson(Map<String, dynamic> json) {
    return WithdrawalTransactionsResponse(
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
  List<Product> products;
  String total_balance;
  String total_earning;
  int user_id;
  Withdrawals withdrawals;

  Data(
      {this.products,
      this.total_balance,
      this.total_earning,
      this.user_id,
      this.withdrawals});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      products: json['products'] != null
          ? (json['products'] as List).map((i) => Product.fromJson(i)).toList()
          : null,
      total_balance: json['total_balance'],
      total_earning: json['total_earning'],
      user_id: json['user_id'],
      withdrawals: json['withdrawals'] != null
          ? Withdrawals.fromJson(json['withdrawals'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_balance'] = this.total_balance;
    data['total_earning'] = this.total_earning;
    data['user_id'] = this.user_id;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    if (this.withdrawals != null) {
      data['withdrawals'] = this.withdrawals.toJson();
    }
    return data;
  }
}

class Product {
  int id;
  String title;

  Product({this.id, this.title});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

class Withdrawals {
  List<WithdrawalTransections> data;
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

  Withdrawals(
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

  factory Withdrawals.fromJson(Map<String, dynamic> json) {
    return Withdrawals(
      data: json['data'] != null
          ? (json['data'] as List)
              .map((i) => WithdrawalTransections.fromJson(i))
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

class WithdrawalTransections {
  String acc_no;
  var amount;
  var tds;
  String created_at;
  String first_status;
  String transaction_type;
  int id;
  String mobile_no;
  String order_id;
  String status;
  String updated_at;
  int user_id;

  WithdrawalTransections(
      {this.acc_no,
      this.amount,
      this.created_at,
      this.first_status,
      this.transaction_type,
      this.tds,
      this.id,
      this.mobile_no,
      this.order_id,
      this.status,
      this.updated_at,
      this.user_id});

  factory WithdrawalTransections.fromJson(Map<String, dynamic> json) {
    return WithdrawalTransections(
      acc_no: json['acc_no'],
      amount: json['amount'],
      created_at: json['created_at'],
      first_status: json['first_status'],
      transaction_type: json['transaction_type'],
      tds: json['tds'],
      id: json['id'],
      mobile_no: json['mobile_no'],
      order_id: json['order_id'],
      status: json['status'],
      updated_at: json['updated_at'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acc_no'] = this.acc_no;
    data['amount'] = this.amount;
    data['created_at'] = this.created_at;
    data['first_status'] = this.first_status;
    data['transaction_type'] = this.transaction_type;
    data['tds'] = this.tds;
    data['id'] = this.id;
    data['mobile_no'] = this.mobile_no;
    data['order_id'] = this.order_id;
    data['status'] = this.status;
    data['updated_at'] = this.updated_at;
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
