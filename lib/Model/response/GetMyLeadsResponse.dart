// @dart=2.10
class GetMyLeadsResponse {
  Data data;
  int code;
  String message;
  bool success;

  GetMyLeadsResponse({this.data, this.code, this.message, this.success});

  factory GetMyLeadsResponse.fromJson(Map<String, dynamic> json) {
    return GetMyLeadsResponse(
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
  String completed_leads;
  String inprocess_leads;
  Leads leads;
  List<Product> products;
  String rejected_leads;
  String total_leads;

  Data(
      {this.completed_leads,
      this.inprocess_leads,
      this.leads,
      this.products,
      this.rejected_leads,
      this.total_leads});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      completed_leads: json['completed_leads'],
      inprocess_leads: json['inprocess_leads'],
      leads: json['leads'] != null ? Leads.fromJson(json['leads']) : null,
      products: json['products'] != null
          ? (json['products'] as List).map((i) => Product.fromJson(i)).toList()
          : null,
      rejected_leads: json['rejected_leads'],
      total_leads: json['total_leads'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['completed_leads'] = this.completed_leads;
    data['inprocess_leads'] = this.inprocess_leads;
    data['rejected_leads'] = this.rejected_leads;
    data['total_leads'] = this.total_leads;
    if (this.leads != null) {
      data['leads'] = this.leads.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
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

class Leads {
  List<Lead> data;
  int current_page;
  String first_page_url;
  int from;
  int last_page;
  String last_page_url;
  List<Link> links;
  String next_page_url;
  String path;
  int per_page;
  Object prev_page_url;
  int to;
  int total;

  Leads(
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

  factory Leads.fromJson(Map<String, dynamic> json) {
    return Leads(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Lead.fromJson(i)).toList()
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

class Lead {
  String customer_name;
  int lead_id;
  String lead_remark;
  String lead_status;
  int lead_status_id;
  int lead_status_parent_id;
  String lead_title;
  String created_at;
  String updated_at;
  String logo;
  String mobile_no;

  Lead(
      {this.customer_name,
      this.lead_id,
      this.lead_remark,
      this.lead_status,
      this.lead_status_id,
      this.lead_status_parent_id,
      this.created_at,
      this.updated_at,
      this.lead_title,
      this.logo,
      this.mobile_no
      });

  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
      customer_name: json['customer_name'],
      lead_id: json['lead_id'],
      lead_remark: json['lead_remark'],
      lead_status: json['lead_status'],
      lead_status_id: json['lead_status_id'],
      lead_status_parent_id: json['lead_status_parent_id'],
      lead_title: json['lead_title'],
      updated_at: json['updated_at'],
      created_at: json['created_at'],
      mobile_no: json['mobile_no'],
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_name'] = this.customer_name;
    data['lead_id'] = this.lead_id;
    data['lead_remark'] = this.lead_remark;
    data['lead_status'] = this.lead_status;
    data['lead_status_id'] = this.lead_status_id;
    data['lead_status_parent_id'] = this.lead_status_parent_id;
    data['lead_title'] = this.lead_title;
    data['lead_status_parent_id'] = this.lead_status_parent_id;
    data['lead_title'] = this.lead_title;
    data['updated_at'] = this.updated_at;
    data['created_at'] = this.created_at;
    data['logo'] = this.logo;
    data['mobile_no'] = this.mobile_no;
    return data;
  }
}
