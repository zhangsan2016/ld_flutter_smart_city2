class AlarmApparatusInfo {
  int errno;
  String errmsg;
  Data data;

  AlarmApparatusInfo({this.errno, this.errmsg, this.data});

  AlarmApparatusInfo.fromJson(Map<String, dynamic> json) {
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
  List<AlarmApparatus> alarmApparatus;

  Data(
      {this.count,
        this.totalPages,
        this.pageSize,
        this.currentPage,
        this.alarmApparatus});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalPages = json['totalPages'];
    pageSize = json['pageSize'];
    currentPage = json['currentPage'];
    if (json['data'] != null) {
      alarmApparatus = new List<AlarmApparatus>();
      json['data'].forEach((v) {
        alarmApparatus.add(new AlarmApparatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['totalPages'] = this.totalPages;
    data['pageSize'] = this.pageSize;
    data['currentPage'] = this.currentPage;
    if (this.alarmApparatus != null) {
      data['data'] =
          this.alarmApparatus.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AlarmApparatus {
  String uUID;
  String lAT;
  String lNG;
  String nAME;
  int tYPE;
  String pROJECT;
  String sUBGROUP;
  int iId;
  String fUUID;
  String smsphone;
  String subgroups;
  String admin;
  Null config;
  Null reportConfig;
  int sTATE;
  String version;
  int gprsCsq;
  int illu;
  int tsMqtt;
  int warningState;
  int vAEnable;
  int vBEnable;
  int vCEnable;
  int aV;

  AlarmApparatus(
      {this.uUID,
        this.lAT,
        this.lNG,
        this.nAME,
        this.tYPE,
        this.pROJECT,
        this.sUBGROUP,
        this.iId,
        this.fUUID,
        this.smsphone,
        this.subgroups,
        this.admin,
        this.config,
        this.reportConfig,
        this.sTATE,
        this.version,
        this.gprsCsq,
        this.illu,
        this.tsMqtt,
        this.warningState,
        this.vAEnable,
        this.vBEnable,
        this.vCEnable,
        this.aV});

  AlarmApparatus.fromJson(Map<String, dynamic> json) {
    uUID = json['UUID'];
    lAT = json['LAT'];
    lNG = json['LNG'];
    nAME = json['NAME'];
    tYPE = json['TYPE'];
    pROJECT = json['PROJECT'];
    sUBGROUP = json['SUBGROUP'];
    iId = json['_id'];
    fUUID = json['FUUID'];
    smsphone = json['smsphone'];
    subgroups = json['subgroups'];
    admin = json['admin'];
    config = json['config'];
    reportConfig = json['report_config'];
    sTATE = json['STATE'];
    version = json['Version'];
    gprsCsq = json['Gprs_csq'];
    illu = json['Illu'];
    tsMqtt = json['ts_mqtt'];
    warningState = json['Warning_state'];
    vAEnable = json['V_A_enable'];
    vBEnable = json['V_B_enable'];
    vCEnable = json['V_C_enable'];
    aV = json['A_v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UUID'] = this.uUID;
    data['LAT'] = this.lAT;
    data['LNG'] = this.lNG;
    data['NAME'] = this.nAME;
    data['TYPE'] = this.tYPE;
    data['PROJECT'] = this.pROJECT;
    data['SUBGROUP'] = this.sUBGROUP;
    data['_id'] = this.iId;
    data['FUUID'] = this.fUUID;
    data['smsphone'] = this.smsphone;
    data['subgroups'] = this.subgroups;
    data['admin'] = this.admin;
    data['config'] = this.config;
    data['report_config'] = this.reportConfig;
    data['STATE'] = this.sTATE;
    data['Version'] = this.version;
    data['Gprs_csq'] = this.gprsCsq;
    data['Illu'] = this.illu;
    data['ts_mqtt'] = this.tsMqtt;
    data['Warning_state'] = this.warningState;
    data['V_A_enable'] = this.vAEnable;
    data['V_B_enable'] = this.vBEnable;
    data['V_C_enable'] = this.vCEnable;
    data['A_v'] = this.aV;
    return data;
  }
}