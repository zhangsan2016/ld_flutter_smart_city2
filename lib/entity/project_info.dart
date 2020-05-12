class ProjectInfo {
  int errno;
  String errmsg;
  Data data;

  ProjectInfo({this.errno, this.errmsg, this.data});

  ProjectInfo.fromJson(Map<String, dynamic> json) {
    errno = json['errno'];
    errmsg = json['errmsg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errno'] = this.errno;
    data['errmsg'] = this.errmsg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int count;
  int totalPages;
  int pageSize;
  int currentPage;
  List<Project> data;

  Data(
      {this.count,
        this.totalPages,
        this.pageSize,
        this.currentPage,
        this.data});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalPages = json['totalPages'];
    pageSize = json['pageSize'];
    currentPage = json['currentPage'];
    if (json['data'] != null) {
      data = new List<Project>();
      json['data'].forEach((v) {
        data.add(new Project.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['totalPages'] = this.totalPages;
    data['pageSize'] = this.pageSize;
    data['currentPage'] = this.currentPage;
    if (this.data != null) {
      data['project'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Project {
  int iId;
  String title;
  String lng;
  String lat;
  String smsphone;
  String subgroups;
  String admin;
  String code;

  Project(
      {this.iId,
        this.title,
        this.lng,
        this.lat,
        this.smsphone,
        this.subgroups,
        this.admin,
        this.code});

  Project.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    title = json['title'];
    lng = json['lng'];
    lat = json['lat'];
    smsphone = json['smsphone'];
    subgroups = json['subgroups'];
    admin = json['admin'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['title'] = this.title;
    data['lng'] = this.lng;
    data['lat'] = this.lat;
    data['smsphone'] = this.smsphone;
    data['subgroups'] = this.subgroups;
    data['admin'] = this.admin;
    data['code'] = this.code;
    return data;
  }
}