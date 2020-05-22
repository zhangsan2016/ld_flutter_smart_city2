class EboxInfo {
  int errno;
  String errmsg;
  Data data;

  EboxInfo({this.errno, this.errmsg, this.data});

  EboxInfo.fromJson(Map<String, dynamic> json) {
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
  List<Ebox> ebox;

  Data(
      {this.count,
        this.totalPages,
        this.pageSize,
        this.currentPage,
        this.ebox});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalPages = json['totalPages'];
    pageSize = json['pageSize'];
    currentPage = json['currentPage'];
    if (json['data'] != null) {
      ebox = new List<Ebox>();
      json['data'].forEach((v) {
        ebox.add(new Ebox.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['totalPages'] = this.totalPages;
    data['pageSize'] = this.pageSize;
    data['currentPage'] = this.currentPage;
    if (this.ebox != null) {
      data['data'] = this.ebox.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ebox {
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
  String info;
  int sTATE;
  String aV;
  String bV;
  String cV;
  String aC;
  String bC;
  String cC;
  int tsMqtt;
  String frequency;
  String totPFac;
  String totViewP;
  String totActDeg;
  String totReactDeg;
  String aActP;
  String bActP;
  String cActP;
  String totActP;
  String aReactP;
  String bReactP;
  String cReactP;
  String totReactP;
  int warningEnable;
  int rollParameterEnable;
  String version;
  int firDimming;
  int secDimming;
  int firIllu;
  int secIllu;
  int relState;
  String time;
  int gprsCsq;
  int illu;
  String firTtFir;
  int firTpFir;
  String secTtFir;
  int secTpFir;
  String thirTtFir;
  int thirTpFir;
  String fourTtFir;
  int fourTpFir;
  String fifTtFir;
  int fifTpFir;
  String sixTtFir;
  int sixTpFir;
  String firTtSec;
  int firTpSec;
  String secTtSec;
  int secTpSec;
  String thirTtSec;
  int thirTpSec;
  String fourTtSec;
  int fourTpSec;
  String fifTtSec;
  int fifTpSec;
  String sixTtSec;
  int sixTpSec;

  Ebox(
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
        this.info,
        this.sTATE,
        this.aV,
        this.bV,
        this.cV,
        this.aC,
        this.bC,
        this.cC,
        this.tsMqtt,
        this.frequency,
        this.totPFac,
        this.totViewP,
        this.totActDeg,
        this.totReactDeg,
        this.aActP,
        this.bActP,
        this.cActP,
        this.totActP,
        this.aReactP,
        this.bReactP,
        this.cReactP,
        this.totReactP,
        this.warningEnable,
        this.rollParameterEnable,
        this.version,
        this.firDimming,
        this.secDimming,
        this.firIllu,
        this.secIllu,
        this.relState,
        this.time,
        this.gprsCsq,
        this.illu,
        this.firTtFir,
        this.firTpFir,
        this.secTtFir,
        this.secTpFir,
        this.thirTtFir,
        this.thirTpFir,
        this.fourTtFir,
        this.fourTpFir,
        this.fifTtFir,
        this.fifTpFir,
        this.sixTtFir,
        this.sixTpFir,
        this.firTtSec,
        this.firTpSec,
        this.secTtSec,
        this.secTpSec,
        this.thirTtSec,
        this.thirTpSec,
        this.fourTtSec,
        this.fourTpSec,
        this.fifTtSec,
        this.fifTpSec,
        this.sixTtSec,
        this.sixTpSec});

  Ebox.fromJson(Map<String, dynamic> json) {
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
    info = json['info'];
    sTATE = json['STATE'];
    aV = json['A_v'];
    bV = json['B_v'];
    cV = json['C_v'];
    aC = json['A_c'];
    bC = json['B_c'];
    cC = json['C_c'];
    tsMqtt = json['ts_mqtt'];
    frequency = json['Frequency'];
    totPFac = json['Tot_p_fac'];
    totViewP = json['Tot_view_p'];
    totActDeg = json['Tot_act_deg'];
    totReactDeg = json['Tot_react_deg'];
    aActP = json['A_act_p'];
    bActP = json['B_act_p'];
    cActP = json['C_act_p'];
    totActP = json['Tot_act_p'];
    aReactP = json['A_react_p'];
    bReactP = json['B_react_p'];
    cReactP = json['C_react_p'];
    totReactP = json['Tot_react_p'];
    warningEnable = json['Warning_enable'];
    rollParameterEnable = json['RollParameter_enable'];
    version = json['Version'];
    firDimming = json['FirDimming'];
    secDimming = json['SecDimming'];
    firIllu = json['FirIllu'];
    secIllu = json['SecIllu'];
    relState = json['Rel_State'];
    time = json['Time'];
    gprsCsq = json['Gprs_csq'];
    illu = json['Illu'];
    firTtFir = json['Fir_tt_Fir'];
    firTpFir = json['Fir_tp_Fir'];
    secTtFir = json['Sec_tt_Fir'];
    secTpFir = json['Sec_tp_Fir'];
    thirTtFir = json['Thir_tt_Fir'];
    thirTpFir = json['Thir_tp_Fir'];
    fourTtFir = json['Four_tt_Fir'];
    fourTpFir = json['Four_tp_Fir'];
    fifTtFir = json['Fif_tt_Fir'];
    fifTpFir = json['Fif_tp_Fir'];
    sixTtFir = json['Six_tt_Fir'];
    sixTpFir = json['Six_tp_Fir'];
    firTtSec = json['Fir_tt_Sec'];
    firTpSec = json['Fir_tp_Sec'];
    secTtSec = json['Sec_tt_Sec'];
    secTpSec = json['Sec_tp_Sec'];
    thirTtSec = json['Thir_tt_Sec'];
    thirTpSec = json['Thir_tp_Sec'];
    fourTtSec = json['Four_tt_Sec'];
    fourTpSec = json['Four_tp_Sec'];
    fifTtSec = json['Fif_tt_Sec'];
    fifTpSec = json['Fif_tp_Sec'];
    sixTtSec = json['Six_tt_Sec'];
    sixTpSec = json['Six_tp_Sec'];
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
    data['info'] = this.info;
    data['STATE'] = this.sTATE;
    data['A_v'] = this.aV;
    data['B_v'] = this.bV;
    data['C_v'] = this.cV;
    data['A_c'] = this.aC;
    data['B_c'] = this.bC;
    data['C_c'] = this.cC;
    data['ts_mqtt'] = this.tsMqtt;
    data['Frequency'] = this.frequency;
    data['Tot_p_fac'] = this.totPFac;
    data['Tot_view_p'] = this.totViewP;
    data['Tot_act_deg'] = this.totActDeg;
    data['Tot_react_deg'] = this.totReactDeg;
    data['A_act_p'] = this.aActP;
    data['B_act_p'] = this.bActP;
    data['C_act_p'] = this.cActP;
    data['Tot_act_p'] = this.totActP;
    data['A_react_p'] = this.aReactP;
    data['B_react_p'] = this.bReactP;
    data['C_react_p'] = this.cReactP;
    data['Tot_react_p'] = this.totReactP;
    data['Warning_enable'] = this.warningEnable;
    data['RollParameter_enable'] = this.rollParameterEnable;
    data['Version'] = this.version;
    data['FirDimming'] = this.firDimming;
    data['SecDimming'] = this.secDimming;
    data['FirIllu'] = this.firIllu;
    data['SecIllu'] = this.secIllu;
    data['Rel_State'] = this.relState;
    data['Time'] = this.time;
    data['Gprs_csq'] = this.gprsCsq;
    data['Illu'] = this.illu;
    data['Fir_tt_Fir'] = this.firTtFir;
    data['Fir_tp_Fir'] = this.firTpFir;
    data['Sec_tt_Fir'] = this.secTtFir;
    data['Sec_tp_Fir'] = this.secTpFir;
    data['Thir_tt_Fir'] = this.thirTtFir;
    data['Thir_tp_Fir'] = this.thirTpFir;
    data['Four_tt_Fir'] = this.fourTtFir;
    data['Four_tp_Fir'] = this.fourTpFir;
    data['Fif_tt_Fir'] = this.fifTtFir;
    data['Fif_tp_Fir'] = this.fifTpFir;
    data['Six_tt_Fir'] = this.sixTtFir;
    data['Six_tp_Fir'] = this.sixTpFir;
    data['Fir_tt_Sec'] = this.firTtSec;
    data['Fir_tp_Sec'] = this.firTpSec;
    data['Sec_tt_Sec'] = this.secTtSec;
    data['Sec_tp_Sec'] = this.secTpSec;
    data['Thir_tt_Sec'] = this.thirTtSec;
    data['Thir_tp_Sec'] = this.thirTpSec;
    data['Four_tt_Sec'] = this.fourTtSec;
    data['Four_tp_Sec'] = this.fourTpSec;
    data['Fif_tt_Sec'] = this.fifTtSec;
    data['Fif_tp_Sec'] = this.fifTpSec;
    data['Six_tt_Sec'] = this.sixTtSec;
    data['Six_tp_Sec'] = this.sixTpSec;
    return data;
  }
}