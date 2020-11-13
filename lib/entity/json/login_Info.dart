

/**
 * https://javiercbk.github.io/json_to_dart/
 */
class LoginInfo {
  int errno;
  String errmsg;
  Data data;
  List<String> services;

  LoginInfo({this.errno, this.errmsg, this.data, this.services});

  LoginInfo.fromJson(Map<String, dynamic> json) {
    errno = json['errno'];
    errmsg = json['errmsg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    services = json['services']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errno'] = this.errno;
    data['errmsg'] = this.errmsg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['services'] = this.services;
    return data;
  }
}

class Data {
  Token token;
  UserProfile userProfile;
  List<String> grantedActions;

  Data({this.token, this.userProfile, this.grantedActions});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
    userProfile = json['userProfile'] != null
        ? new UserProfile.fromJson(json['userProfile'])
        : null;
    grantedActions = json['grantedActions']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.token != null) {
      data['token'] = this.token.toJson();
    }
    if (this.userProfile != null) {
      data['userProfile'] = this.userProfile.toJson();
    }
    data['grantedActions'] = this.grantedActions;
    return data;
  }
}

class Token {
  String username;
  String token;
  int expired;

  Token({this.username, this.token, this.expired});

  Token.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    token = json['token'];
    expired = json['expired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['token'] = this.token;
    data['expired'] = this.expired;
    return data;
  }
}

class UserProfile {
  int iId;
  String username;
  String phone;
  String fullname;
  String roles;
  String openid;

  UserProfile({this.iId, this.username, this.phone, this.fullname, this.roles,this.openid});

  UserProfile.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    username = json['username'];
    phone = json['phone'];
    fullname = json['fullname'];
    roles = json['roles'];
    openid = json['openid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['fullname'] = this.fullname;
    data['roles'] = this.roles;
    data['openid'] = this.openid;
    return data;
  }
}