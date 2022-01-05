// @dart=2.10
class GetUserResponse {
  Data data;
  int code;
  String message;
  bool success;

  GetUserResponse({this.data, this.code, this.message, this.success});

  factory GetUserResponse.fromJson(Map<String, dynamic> json) {
    return GetUserResponse(
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

class Products {
  int id;
  String status, title, message, icon;

  Products({this.id, this.status, this.icon, this.message, this.title});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'],
      status: json['status'],
      icon: json['icon'],
      title: json['title'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['title'] = this.title;
    data['message'] = this.message;
    data['icon'] = this.icon;
    return data;
  }
}

class Data {
  List<Announcement> announcement;
  String is_bank_detail;
  List<Knowladge> knowladge;
  List<LeadBoard> lead_board;
  int noti_count;
  String limit_amount;
  List<PrBanner> pr_banners;
  List<RelFin> rel_fins;
  Transection transection;
  Users users;
  List<Products> products;
  List<String> featuredVideo;
  List<CategoryColor> category_colors;

  Data({
    this.announcement,
    this.is_bank_detail,
    this.knowladge,
    this.lead_board,
    this.noti_count,
    this.limit_amount,
    this.pr_banners,
    this.rel_fins,
    this.products,
    this.transection,
    this.users,
    this.featuredVideo,
    this.category_colors,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      announcement: json['announcement'] != null
          ? (json['announcement'] as List)
              .map((i) => Announcement.fromJson(i))
              .toList()
          : null,
      is_bank_detail: json['is_bank_detail'],
      knowladge: json['knowladge'] != null
          ? (json['knowladge'] as List)
              .map((i) => Knowladge.fromJson(i))
              .toList()
          : null,
      lead_board: json['lead_board'] != null
          ? (json['lead_board'] as List)
              .map((i) => LeadBoard.fromJson(i))
              .toList()
          : null,
      noti_count: json['noti_count'],
      limit_amount: json['limit_amount'],
      pr_banners: json['pr_banners'] != null
          ? (json['pr_banners'] as List)
              .map((i) => PrBanner.fromJson(i))
              .toList()
          : null,
      rel_fins: json['rel_fins'] != null
          ? (json['rel_fins'] as List).map((i) => RelFin.fromJson(i)).toList()
          : null,
      transection: json['transection'] != null
          ? Transection.fromJson(json['transection'])
          : null,
      products: json['products'] != null
          ? (json['products'] as List).map((i) => Products.fromJson(i)).toList()
          : null,
      category_colors: json['category_colors'] != null
          ? (json['category_colors'] as List)
              .map((i) => CategoryColor.fromJson(i))
              .toList()
          : null,
      featuredVideo: new List<String>.from(json['featured_video']),
      users: json['users'] != null ? Users.fromJson(json['users']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_bank_detail'] = this.is_bank_detail;
    data['noti_count'] = this.noti_count;
    data['limit_amount'] = this.limit_amount;
    if (this.announcement != null) {
      data['announcement'] = this.announcement.map((v) => v.toJson()).toList();
    }
    if (this.knowladge != null) {
      data['knowladge'] = this.knowladge.map((v) => v.toJson()).toList();
    }
    if (this.lead_board != null) {
      data['lead_board'] = this.lead_board.map((v) => v.toJson()).toList();
    }
    if (this.pr_banners != null) {
      data['pr_banners'] = this.pr_banners.map((v) => v.toJson()).toList();
    }
    if (this.rel_fins != null) {
      data['rel_fins'] = this.rel_fins.map((v) => v.toJson()).toList();
    }
    if (this.transection != null) {
      data['transection'] = this.transection.toJson();
    }
    if (this.users != null) {
      data['users'] = this.users.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    if (this.category_colors != null) {
      data['category_colors'] =
          this.category_colors.map((v) => v.toJson()).toList();
    }
    data['featured_video'] = this.featuredVideo;
    return data;
  }
}

class CategoryColor {
  String bg;
  int category_id;
  String icon;

  CategoryColor({this.bg, this.category_id, this.icon});

  factory CategoryColor.fromJson(Map<String, dynamic> json) {
    return CategoryColor(
      bg: json['bg'],
      category_id: json['category_id'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bg'] = this.bg;
    data['category_id'] = this.category_id;
    data['icon'] = this.icon;
    return data;
  }
}

class PrBanner {
  int id;
  String image;
  String url;

  PrBanner({this.id, this.image, this.url});

  factory PrBanner.fromJson(Map<String, dynamic> json) {
    return PrBanner(
      id: json['id'],
      image: json['image'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['url'] = this.url;
    return data;
  }
}

class Announcement {
  String file;
  String description;
  String file_type;
  int id;
  String status;
  String title;
  String updated_by;
  String url;
  String url_type;

  Announcement(
      {this.file,
      this.description,
      this.file_type,
      this.id,
      this.status,
      this.title,
      this.updated_by,
      this.url,
      this.url_type});

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      file: json['file'],
      description: json['description'],
      file_type: json['file_type'],
      id: json['id'],
      status: json['status'],
      title: json['title'],
      updated_by: json['updated_by'],
      url: json['url'],
      url_type: json['url_type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    data['description'] = this.description;
    data['file_type'] = this.file_type;
    data['id'] = this.id;
    data['status'] = this.status;
    data['title'] = this.title;
    data['updated_by'] = this.updated_by;
    data['url'] = this.url;
    data['url_type'] = this.url_type;
    return data;
  }
}

class RelFin {
  int fin_product_id;

  RelFin({this.fin_product_id});

  factory RelFin.fromJson(Map<String, dynamic> json) {
    return RelFin(
      fin_product_id: json['fin_product_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fin_product_id'] = this.fin_product_id;
    return data;
  }
}

class LeadBoard {
  String created_at;
  var earning;
  String first_name;
  int id;
  String last_name;
  String profile_photo;
  int rank;
  String location;

  String getFullName() {
    String fullName = first_name + " " + last_name;
    if (fullName.length < 14) {
      return fullName;
    } else {
      return fullName.substring(0, 13);
    }
  }

  LeadBoard(
      {this.created_at,
      this.earning,
      this.first_name,
      this.id,
      this.last_name,
      this.profile_photo,
      this.rank,
      this.location});

  factory LeadBoard.fromJson(Map<String, dynamic> json) {
    return LeadBoard(
      created_at: json['created_at'],
      earning: json['earning'],
      first_name: json['first_name'],
      id: json['id'],
      last_name: json['last_name'],
      profile_photo: json['profile_photo'],
      rank: json['rank'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.created_at;
    data['earning'] = this.earning;
    data['first_name'] = this.first_name;
    data['id'] = this.id;
    data['last_name'] = this.last_name;
    data['profile_photo'] = this.profile_photo;
    data['rank'] = this.rank;
    data['location'] = this.location;
    return data;
  }
}

class Transection {
  String total_amount;
  String total_withdrawal_amount;

  Transection({this.total_amount, this.total_withdrawal_amount});

  factory Transection.fromJson(Map<String, dynamic> json) {
    return Transection(
      total_amount: json['total_earning'],
      total_withdrawal_amount: json['total_balance'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_earning'] = this.total_amount;
    data['total_balance'] = this.total_withdrawal_amount;
    return data;
  }
}

class Knowladge {
  String created_at;
  int id;
  String status;
  String title;
  String type;
  int type_id;
  String updated_at;
  String video_url;

  String get videoId {
    if (video_url.contains(' ')) {
      return null;
    }

    Uri uri;
    try {
      uri = Uri.parse(video_url);
    } catch (e) {
      return null;
    }

    if (!['https', 'http'].contains(uri.scheme)) {
      return null;
    }

    // youtube.com/watch?v=xxxxxxxxxxx
    if (['youtube.com', 'www.youtube.com', 'm.youtube.com']
            .contains(uri.host) &&
        uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == 'watch' &&
        uri.queryParameters.containsKey('v')) {
      final videoId = uri.queryParameters['v'];
      return _isValidId(videoId) ? videoId : null;
    }

    // youtu.be/xxxxxxxxxxx
    if (uri.host == 'youtu.be' && uri.pathSegments.isNotEmpty) {
      final videoId = uri.pathSegments.first;
      return _isValidId(videoId) ? videoId : null;
    }

    return null;
  }

  bool _isValidId(String id) => RegExp(r'^[_\-a-zA-Z0-9]{11}$').hasMatch(id);

  Knowladge(
      {this.created_at,
      this.id,
      this.status,
      this.title,
      this.type,
      this.type_id,
      this.updated_at,
      this.video_url});

  factory Knowladge.fromJson(Map<String, dynamic> json) {
    return Knowladge(
      created_at: json['created_at'],
      id: json['id'],
      status: json['status'],
      title: json['title'],
      type: json['type'],
      type_id: json['type_id'],
      updated_at: json['updated_at'],
      video_url: json['video_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.created_at;
    data['id'] = this.id;
    data['status'] = this.status;
    data['title'] = this.title;
    data['type'] = this.type;
    data['type_id'] = this.type_id;
    data['updated_at'] = this.updated_at;
    data['video_url'] = this.video_url;
    return data;
  }
}

class Users {
  Address address;
  AddvisorBadge addvisor_badge;
  var adhar_no;
  var is_adhar_verified;
  var name_on_adhar;
  var name_on_pan;
  var is_pan_verified;
  var alt_mobile;
  var are_you;
  var badge;
  var badge_id;
  var bank_detail_progress = 0;
  var bsoffice_type;
  var busi_type_id;
  var citizenship;
  var created_at;
  var cur_job_month;
  var cur_job_year;
  var cur_lats_longs;
  var dependents;
  var dob;
  var email;
  var email_otp;
  var email_verified_at;
  var father_name;
  var fcm_token;
  var firm_name;
  String first_name;
  var full_address;
  var gender;
  var grade_id;
  var gros_mon_incm;
  var gros_yr_incm;
  var gst_no;
  var id;
  var is_contact;
  var is_mpin;
  var kyc_status;
  var kyc_video;
  String last_name;
  var marital_status;
  var middle_name;
  var mobile_no;
  var paytm_mobile_no;
  var paytm_no_status;
  var mother_name;
  var net_mon_incm;
  var net_yr_incm;
  var nominee_dob;
  var nominee_name;
  var nominee_relation;
  var occupation_id;
  var office_space;
  var organization_id;
  var otp;
  var pan_no;
  var parent_admin;
  var per_lats_longs;
  var pos_income_id;
  var pos_licence;
  var profession_id;
  var profile_photo;
  var profile_progress = 0;
  var kyc_progress = 0;
  var professional_progress = 0;
  var qualification;
  var referral_code;
  var referred_by;
  Relbank relbank;
  var res_status;
  var smoker_or_chewer;
  var source_from;
  var spouse_name;
  var total_bus_anum;
  var total_bus_month;
  var total_bus_yr;
  var total_ex_month;
  var total_ex_yr;
  var total_fn_month;
  var total_fn_yr;
  var updated_at;
  var upload_gst_no;
  var upload_pan_no;
  var upload_qual_doc;
  var user_code;
  var user_remark;
  var user_status;
  var user_type;
  var user_type_id;
  var verified_by;

  bool isEmpty() {
    return user_code == null || user_code.toString().isEmpty;
  }

  Users(
      {this.address,
      this.addvisor_badge,
      this.name_on_adhar,
      this.name_on_pan,
      this.adhar_no,
      this.is_adhar_verified,
      this.is_pan_verified,
      this.alt_mobile,
      this.are_you,
      this.badge,
      this.badge_id,
      this.bank_detail_progress = 0,
      this.bsoffice_type,
      this.busi_type_id,
      this.citizenship,
      this.created_at,
      this.cur_job_month,
      this.cur_job_year,
      this.cur_lats_longs,
      this.dependents,
      this.dob,
      this.email,
      this.email_otp,
      this.email_verified_at,
      this.father_name,
      this.fcm_token,
      this.firm_name,
      this.first_name,
      this.full_address,
      this.gender,
      this.grade_id,
      this.gros_mon_incm,
      this.gros_yr_incm,
      this.gst_no,
      this.id,
      this.is_contact,
      this.is_mpin,
      this.kyc_status,
      this.kyc_video,
      this.last_name,
      this.marital_status,
      this.middle_name,
      this.mobile_no,
      this.paytm_mobile_no,
      this.paytm_no_status,
      this.mother_name,
      this.net_mon_incm,
      this.net_yr_incm,
      this.nominee_dob,
      this.nominee_name,
      this.nominee_relation,
      this.occupation_id,
      this.office_space,
      this.organization_id,
      this.otp,
      this.pan_no,
      this.parent_admin,
      this.per_lats_longs,
      this.pos_income_id,
      this.pos_licence,
      this.profession_id,
      this.profile_photo,
      this.profile_progress = 0,
      this.kyc_progress = 0,
      this.professional_progress = 0,
      this.qualification,
      this.referral_code,
      this.referred_by,
      this.relbank,
      this.res_status,
      this.smoker_or_chewer,
      this.source_from,
      this.spouse_name,
      this.total_bus_anum,
      this.total_bus_month,
      this.total_bus_yr,
      this.total_ex_month,
      this.total_ex_yr,
      this.total_fn_month,
      this.total_fn_yr,
      this.updated_at,
      this.upload_gst_no,
      this.upload_pan_no,
      this.upload_qual_doc,
      this.user_code,
      this.user_remark,
      this.user_status,
      this.user_type,
      this.user_type_id,
      this.verified_by});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      addvisor_badge: json['addvisor_badge'] != null
          ? AddvisorBadge.fromJson(json['addvisor_badge'])
          : null,
      adhar_no: json['adhar_no'],
      name_on_adhar: json['name_on_adhar'],
      name_on_pan: json['name_on_pan'],
      is_adhar_verified: json['is_adhar_verified'],
      is_pan_verified: json['is_pan_verified'],
      alt_mobile: json['alt_mobile'],
      are_you: json['are_you'],
      badge: json['badge'],
      badge_id: json['badge_id'],
      bank_detail_progress: json['bank_detail_progress'],
      bsoffice_type: json['bsoffice_type'],
      busi_type_id: json['busi_type_id'],
      citizenship: json['citizenship'],
      created_at: json['created_at'],
      cur_job_month: json['cur_job_month'],
      cur_job_year: json['cur_job_year'],
      cur_lats_longs: json['cur_lats_longs'],
      dependents: json['dependents'],
      dob: json['dob'],
      email: json['email'],
      email_otp: json['email_otp'],
      email_verified_at: json['email_verified_at'],
      father_name: json['father_name'],
      fcm_token: json['fcm_token'],
      firm_name: json['firm_name'],
      first_name: json['first_name'],
      full_address: json['full_address'],
      gender: json['gender'],
      grade_id: json['grade_id'],
      gros_mon_incm: json['gros_mon_incm'],
      gros_yr_incm: json['gros_yr_incm'],
      gst_no: json['gst_no'],
      id: json['id'],
      is_contact: json['is_contact'],
      is_mpin: json['is_mpin'],
      kyc_status: json['kyc_status'],
      kyc_video: json['kyc_video'],
      last_name: json['last_name'],
      marital_status: json['marital_status'],
      middle_name: json['middle_name'],
      mobile_no: json['mobile_no'],
      paytm_mobile_no: json['paytm_mobile_no'],
      paytm_no_status: json['paytm_no_status'],
      mother_name: json['mother_name'],
      net_mon_incm: json['net_mon_incm'],
      net_yr_incm: json['net_yr_incm'],
      nominee_dob: json['nominee_dob'],
      nominee_name: json['nominee_name'],
      nominee_relation: json['nominee_relation'],
      occupation_id: json['occupation_id'],
      office_space: json['office_space'],
      organization_id: json['organization_id'],
      otp: json['otp'],
      pan_no: json['pan_no'],
      parent_admin: json['parent_admin'],
      per_lats_longs: json['per_lats_longs'],
      pos_income_id: json['pos_income_id'],
      pos_licence: json['pos_licence'],
      profession_id: json['profession_id'],
      profile_photo: json['profile_photo'],
      profile_progress: json['profile_progress'],
      kyc_progress: json['kyc_progress'],
      professional_progress: json['professional_progress'],
      qualification: json['qualification'],
      referral_code: json['referral_code'],
      referred_by: json['referred_by'],
      relbank:
          json['relbank'] != null ? Relbank.fromJson(json['relbank']) : null,
      res_status: json['res_status'],
      smoker_or_chewer: json['smoker_or_chewer'],
      source_from: json['source_from'],
      spouse_name: json['spouse_name'],
      total_bus_anum: json['total_bus_anum'],
      total_bus_month: json['total_bus_month'],
      total_bus_yr: json['total_bus_yr'],
      total_ex_month: json['total_ex_month'],
      total_ex_yr: json['total_ex_yr'],
      total_fn_month: json['total_fn_month'],
      total_fn_yr: json['total_fn_yr'],
      updated_at: json['updated_at'],
      upload_gst_no: json['upload_gst_no'],
      upload_pan_no: json['upload_pan_no'],
      upload_qual_doc: json['upload_qual_doc'],
      user_code: json['user_code'],
      user_remark: json['user_remark'],
      user_status: json['user_status'],
      user_type: json['user_type'],
      user_type_id: json['user_type_id'],
      verified_by: json['verified_by'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adhar_no'] = this.adhar_no;
    data['is_adhar_verified'] = this.is_adhar_verified;
    data['name_on_adhar'] = this.name_on_adhar;
    data['name_on_pan'] = this.name_on_pan;
    data['is_pan_verified'] = this.is_pan_verified;
    data['alt_mobile'] = this.alt_mobile;
    data['are_you'] = this.are_you;
    data['badge'] = this.badge;
    data['badge_id'] = this.badge_id;
    data['bank_detail_progress'] = this.bank_detail_progress;
    data['bsoffice_type'] = this.bsoffice_type;
    data['busi_type_id'] = this.busi_type_id;
    data['citizenship'] = this.citizenship;
    data['created_at'] = this.created_at;
    data['cur_job_month'] = this.cur_job_month;
    data['cur_job_year'] = this.cur_job_year;
    data['cur_lats_longs'] = this.cur_lats_longs;
    data['dependents'] = this.dependents;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['email_otp'] = this.email_otp;
    data['email_verified_at'] = this.email_verified_at;
    data['father_name'] = this.father_name;
    data['fcm_token'] = this.fcm_token;
    data['firm_name'] = this.firm_name;
    data['first_name'] = this.first_name;
    data['full_address'] = this.full_address;
    data['gender'] = this.gender;
    data['grade_id'] = this.grade_id;
    data['gros_mon_incm'] = this.gros_mon_incm;
    data['gros_yr_incm'] = this.gros_yr_incm;
    data['gst_no'] = this.gst_no;
    data['id'] = this.id;
    data['is_contact'] = this.is_contact;
    data['is_mpin'] = this.is_mpin;
    data['kyc_status'] = this.kyc_status;
    data['kyc_video'] = this.kyc_video;
    data['last_name'] = this.last_name;
    data['marital_status'] = this.marital_status;
    data['middle_name'] = this.middle_name;
    data['mobile_no'] = this.mobile_no;
    data['paytm_mobile_no'] = this.paytm_mobile_no;
    data['paytm_no_status'] = this.paytm_no_status;
    data['mother_name'] = this.mother_name;
    data['net_mon_incm'] = this.net_mon_incm;
    data['net_yr_incm'] = this.net_yr_incm;
    data['nominee_dob'] = this.nominee_dob;
    data['nominee_name'] = this.nominee_name;
    data['nominee_relation'] = this.nominee_relation;
    data['occupation_id'] = this.occupation_id;
    data['office_space'] = this.office_space;
    data['organization_id'] = this.organization_id;
    data['otp'] = this.otp;
    data['pan_no'] = this.pan_no;
    data['parent_admin'] = this.parent_admin;
    data['per_lats_longs'] = this.per_lats_longs;
    data['pos_income_id'] = this.pos_income_id;
    data['pos_licence'] = this.pos_licence;
    data['profession_id'] = this.profession_id;
    data['profile_photo'] = this.profile_photo;
    data['profile_progress'] = this.profile_progress;
    data['kyc_progress'] = this.kyc_progress;
    data['professional_progress'] = this.professional_progress;
    data['qualification'] = this.qualification;
    data['referral_code'] = this.referral_code;
    data['referred_by'] = this.referred_by;
    data['res_status'] = this.res_status;
    data['smoker_or_chewer'] = this.smoker_or_chewer;
    data['source_from'] = this.source_from;
    data['spouse_name'] = this.spouse_name;
    data['total_bus_anum'] = this.total_bus_anum;
    data['total_bus_month'] = this.total_bus_month;
    data['total_bus_yr'] = this.total_bus_yr;
    data['total_ex_month'] = this.total_ex_month;
    data['total_ex_yr'] = this.total_ex_yr;
    data['total_fn_month'] = this.total_fn_month;
    data['total_fn_yr'] = this.total_fn_yr;
    data['updated_at'] = this.updated_at;
    data['upload_gst_no'] = this.upload_gst_no;
    data['upload_pan_no'] = this.upload_pan_no;
    data['upload_qual_doc'] = this.upload_qual_doc;
    data['user_code'] = this.user_code;
    data['user_remark'] = this.user_remark;
    data['user_status'] = this.user_status;
    data['user_type'] = this.user_type;
    data['user_type_id'] = this.user_type_id;
    data['verified_by'] = this.verified_by;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.addvisor_badge != null) {
      data['addvisor_badge'] = this.addvisor_badge.toJson();
    }
    if (this.relbank != null) {
      data['relbank'] = this.relbank.toJson();
    }
    return data;
  }
}

class Relbank {
  String account_no;
  int bank_id;
  String branch_name;
  String created_at;
  String customer_id;
  int id;
  String ifsc_code;
  String name_on_bank;
  String status;
  String updated_at;
  String upload_doc;
  String uploads;
  int user_id;

  Relbank(
      {this.account_no,
      this.bank_id,
      this.branch_name,
      this.created_at,
      this.customer_id,
      this.id,
      this.ifsc_code,
      this.name_on_bank,
      this.status,
      this.updated_at,
      this.upload_doc,
      this.uploads,
      this.user_id});

  factory Relbank.fromJson(Map<String, dynamic> json) {
    return Relbank(
      account_no: json['account_no'],
      bank_id: json['bank_id'],
      branch_name: json['branch_name'],
      created_at: json['created_at'],
      customer_id: json['customer_id'],
      id: json['id'],
      ifsc_code: json['ifsc_code'],
      name_on_bank: json['name_on_bank'],
      status: json['status'],
      updated_at: json['updated_at'],
      upload_doc: json['upload_doc'],
      uploads: json['uploads'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_no'] = this.account_no;
    data['bank_id'] = this.bank_id;
    data['branch_name'] = this.branch_name;
    data['created_at'] = this.created_at;
    data['customer_id'] = this.customer_id;
    data['id'] = this.id;
    data['ifsc_code'] = this.ifsc_code;
    data['name_on_bank'] = this.name_on_bank;
    data['status'] = this.status;
    data['updated_at'] = this.updated_at;
    data['upload_doc'] = this.upload_doc;
    data['uploads'] = this.uploads;
    data['user_id'] = this.user_id;
    return data;
  }
}

class Address {
  String add1;
  String add2;
  String add_proof;
  String add_proof_exp_date;
  String add_proof_isu_date;
  String add_proof_no;
  String address_type;
  int city_id;
  String created_at;
  int id;
  String id_doc_back;
  String id_doc_front;
  String is_current;
  int pincode_id;
  int state_id;
  String updated_at;
  int user_id;

  Address(
      {this.add1,
      this.add2,
      this.add_proof,
      this.add_proof_exp_date,
      this.add_proof_isu_date,
      this.add_proof_no,
      this.address_type,
      this.city_id,
      this.created_at,
      this.id,
      this.id_doc_back,
      this.id_doc_front,
      this.is_current,
      this.pincode_id,
      this.state_id,
      this.updated_at,
      this.user_id});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      add1: json['add1'],
      add2: json['add2'],
      add_proof: json['add_proof'],
      add_proof_exp_date: json['add_proof_exp_date'],
      add_proof_isu_date: json['add_proof_isu_date'],
      add_proof_no: json['add_proof_no'],
      address_type: json['address_type'],
      city_id: json['city_id'],
      created_at: json['created_at'],
      id: json['id'],
      id_doc_back: json['id_doc_back'],
      id_doc_front: json['id_doc_front'],
      is_current: json['is_current'],
      pincode_id: json['pincode_id'],
      state_id: json['state_id'],
      updated_at: json['updated_at'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['add1'] = this.add1;
    data['add2'] = this.add2;
    data['add_proof'] = this.add_proof;
    data['add_proof_exp_date'] = this.add_proof_exp_date;
    data['add_proof_isu_date'] = this.add_proof_isu_date;
    data['add_proof_no'] = this.add_proof_no;
    data['address_type'] = this.address_type;
    data['city_id'] = this.city_id;
    data['created_at'] = this.created_at;
    data['id'] = this.id;
    data['id_doc_back'] = this.id_doc_back;
    data['id_doc_front'] = this.id_doc_front;
    data['is_current'] = this.is_current;
    data['pincode_id'] = this.pincode_id;
    data['state_id'] = this.state_id;
    data['updated_at'] = this.updated_at;
    data['user_id'] = this.user_id;
    return data;
  }
}

class AddvisorBadge {
  String created_at;
  int id;
  String payout_percentage;
  String status;
  String title;
  String updated_at;

  AddvisorBadge(
      {this.created_at,
      this.id,
      this.payout_percentage,
      this.status,
      this.title,
      this.updated_at});

  factory AddvisorBadge.fromJson(Map<String, dynamic> json) {
    return AddvisorBadge(
      created_at: json['created_at'],
      id: json['id'],
      payout_percentage: json['payout_percentage'],
      status: json['status'],
      title: json['title'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.created_at;
    data['id'] = this.id;
    data['payout_percentage'] = this.payout_percentage;
    data['status'] = this.status;
    data['title'] = this.title;
    data['updated_at'] = this.updated_at;
    return data;
  }
}
