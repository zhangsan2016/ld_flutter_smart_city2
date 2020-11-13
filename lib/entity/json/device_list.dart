class DeviceList {
  int errno;
  String errmsg;
  List<Device> device;

  DeviceList({this.errno, this.errmsg, this.device});

  DeviceList.fromJson(Map<String, dynamic> json) {
    errno = json['errno'];
    errmsg = json['errmsg'];
    if (json['data'] != null) {
      device = new List<Device>();
      json['data'].forEach((v) {
        device.add(new Device.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errno'] = this.errno;
    data['errmsg'] = this.errmsg;
    if (this.device != null) {
      data['data'] = this.device.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Device {
  String uUID;
  String lAT;
  String lNG;
  String nAME;
  int tYPE;
  String pROJECT;
  String sUBGROUP;
  String aDDR;
  String iPADDR;
  String sId;
  String fUUID;
  String subgroups;
  String admin;
  String code;
  String members;
  Null config;
  String reportConfig;
  String energy;
  var firDimming;
  var illu;
  int sTATE;
  var temp;
  int tsMqtt;
  var power;
  int warningState;
  String lampDiameter;
  String powerManufacturer;
  String lampRatedCurrent;
  String lampRatedvoltage;
  String lampType;
  String lampManufacturer;
  String lampNum;
  String poleProductionDate;
  String poleHeight;
  String ratedPower;
  String subcommunicateMode;
  String info;
  String camId;
  String streamUrl;
  String streamUser;
  String streamPassword;
  String roadDirection;
  String onvifPort;
  String manufacturer;

  Device(
      {this.uUID,
        this.lAT,
        this.lNG,
        this.nAME,
        this.tYPE,
        this.pROJECT,
        this.sUBGROUP,
        this.aDDR,
        this.iPADDR,
        this.sId,
        this.fUUID,
        this.subgroups,
        this.admin,
        this.code,
        this.members,
        this.config,
        this.reportConfig,
        this.energy,
        this.firDimming,
        this.illu,
        this.sTATE,
        this.temp,
        this.tsMqtt,
        this.power,
        this.warningState,
        this.lampDiameter,
        this.powerManufacturer,
        this.lampRatedCurrent,
        this.lampRatedvoltage,
        this.lampType,
        this.lampManufacturer,
        this.lampNum,
        this.poleProductionDate,
        this.poleHeight,
        this.ratedPower,
        this.subcommunicateMode,
        this.info,
        this.camId,
        this.streamUrl,
        this.streamUser,
        this.streamPassword,
        this.roadDirection,
        this.onvifPort,
        this.manufacturer});

  Device.fromJson(Map<String, dynamic> json) {

    uUID = json['UUID'];
    lAT = json['LAT'];
    lNG = json['LNG'];
    nAME = json['NAME'];
    tYPE = json['TYPE'];
    pROJECT = json['PROJECT'];
    sUBGROUP = json['SUBGROUP'];
    aDDR = json['ADDR'];
    iPADDR = json['IPADDR'];
    sId = json['_id'].toString();
    fUUID = json['FUUID'];
    subgroups = json['subgroups'];
    admin = json['admin'];
    code = json['code'];
    members = json['members'];
    config = json['config'];
    reportConfig = json['report_config'];
    energy = json['Energy'].toString();
    firDimming = json['FirDimming'];
    illu = json['Illu'];
    sTATE = json['STATE'];
    temp = json['Temp'];
    tsMqtt = json['ts_mqtt'];
    power = json['Power'];
    warningState = json['Warning_state'];
    lampDiameter = json['LampDiameter'];
    powerManufacturer = json['Power_Manufacturer'];
    lampRatedCurrent = json['Lamp_RatedCurrent'];
    lampRatedvoltage = json['Lamp_Ratedvoltage'];
    lampType = json['lampType'];
    lampManufacturer = json['Lamp_Manufacturer'];
    lampNum = json['Lamp_Num'];
    poleProductionDate = json['PoleProductionDate'];
    poleHeight = json['Pole_height'];
    ratedPower = json['Rated_power'];
    subcommunicateMode = json['Subcommunicate_mode'];
    info = json['info'];
    camId = json['cam_id'];
    streamUrl = json['stream_url'];
    streamUser = json['stream_user'];
    streamPassword = json['stream_password'];
    roadDirection = json['road_direction'];
    onvifPort = json['onvif_port'];
    manufacturer = json['manufacturer'];


   /* try {



    } catch (e) {
      throw e;

    }*/


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
    data['ADDR'] = this.aDDR;
    data['IPADDR'] = this.iPADDR;
    data['_id'] = this.sId;
    data['FUUID'] = this.fUUID;
    data['subgroups'] = this.subgroups;
    data['admin'] = this.admin;
    data['code'] = this.code;
    data['members'] = this.members;
    data['config'] = this.config;
    data['report_config'] = this.reportConfig;
    data['Energy'] = this.energy;
    data['FirDimming'] = this.firDimming;
    data['Illu'] = this.illu;
    data['STATE'] = this.sTATE;
    data['Temp'] = this.temp;
    data['ts_mqtt'] = this.tsMqtt;
    data['Power'] = this.power;
    data['Warning_state'] = this.warningState;
    data['LampDiameter'] = this.lampDiameter;
    data['Power_Manufacturer'] = this.powerManufacturer;
    data['Lamp_RatedCurrent'] = this.lampRatedCurrent;
    data['Lamp_Ratedvoltage'] = this.lampRatedvoltage;
    data['lampType'] = this.lampType;
    data['Lamp_Manufacturer'] = this.lampManufacturer;
    data['Lamp_Num'] = this.lampNum;
    data['PoleProductionDate'] = this.poleProductionDate;
    data['Pole_height'] = this.poleHeight;
    data['Rated_power'] = this.ratedPower;
    data['Subcommunicate_mode'] = this.subcommunicateMode;
    data['info'] = this.info;
    data['cam_id'] = this.camId;
    data['stream_url'] = this.streamUrl;
    data['stream_user'] = this.streamUser;
    data['stream_password'] = this.streamPassword;
    data['road_direction'] = this.roadDirection;
    data['onvif_port'] = this.onvifPort;
    data['manufacturer'] = this.manufacturer;
    return data;
  }


}
