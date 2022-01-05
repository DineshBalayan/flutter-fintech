// @dart=2.10
class LeaderBoardResponse {
  UserBoardData data;
  int code;
  String message;
  bool success;

  LeaderBoardResponse({this.data, this.code, this.message, this.success});

  factory LeaderBoardResponse.fromJson(Map<String, dynamic> json) {
    return LeaderBoardResponse(
      data: json['data'] != null ? UserBoardData.fromJson(json['data']) : null,
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

class UserBoardData {
  List<AllUser> all_users;
  String first_name;
  int id;
  String last_name;
  String profile_photo;
  int total_leads;
  String location;
  var rank;
  var earning;

  UserBoardData(
      {this.all_users,
      this.first_name,
      this.id,
      this.last_name,
      this.profile_photo,
      this.total_leads,
      this.location,
      this.rank,
      this.earning});

  factory UserBoardData.fromJson(Map<String, dynamic> json) {
    return UserBoardData(
      all_users: json['all_users'] != null
          ? (json['all_users'] as List).map((i) => AllUser.fromJson(i)).toList()
          : null,
      first_name: json['first_name'],
      id: json['id'],
      last_name: json['last_name'],
      profile_photo: json['profile_photo'],
      total_leads: json['total_leads'],
      location: json['location'],
      rank: json['rank'] == null ? 0 : json['rank'],
      earning: json['earning'] == null ? 0 : json['earning'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.first_name;
    data['id'] = this.id;
    data['last_name'] = this.last_name;
    data['total_leads'] = this.total_leads;
    data['rank'] = this.rank;
    data['earning'] = this.earning;
    data['location'] = this.location;
    if (this.all_users != null) {
      data['all_users'] = this.all_users.map((v) => v.toJson()).toList();
    }
    if (this.profile_photo != null) {
      data['profile_photo'] = this.profile_photo;
    }
    return data;
  }
}

class AllUser {
  String earning;
  String first_name;
  int id;
  String last_name;
  String profile_photo;
  var rank;
  var total_leads;
  var location;

  AllUser(
      {this.earning,
      this.first_name,
      this.id,
      this.last_name,
      this.profile_photo,
      this.rank,
      this.total_leads,
      this.location});

  factory AllUser.fromJson(Map<String, dynamic> json) {
    return AllUser(
      earning: json['earning'],
      first_name: json['first_name'],
      id: json['id'],
      last_name: json['last_name'],
      profile_photo: json['profile_photo'],
      rank: json['rank'],
      total_leads: json['total_leads'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['earning'] = this.earning;
    data['first_name'] = this.first_name;
    data['id'] = this.id;
    data['last_name'] = this.last_name;
    data['profile_photo'] = this.profile_photo;
    data['rank'] = this.rank;
    data['total_leads'] = this.total_leads;
    data['location'] = this.location;
    return data;
  }
}
