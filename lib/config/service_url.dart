
class Api {
  // 单例模式
  factory Api() =>_getInstance();
  static Api get instance => _getInstance();
  static Api _instance;
  Api._internal() {
    // 初始化
    _upServicePath();
  }
  static Api _getInstance() {
    if (_instance == null) {
      _instance = new Api._internal();
    }
    return _instance;
  }

  // base 地址
// const String URL_BASE = "https://iot.sz-luoding.com:888/api/";
  String _urlBase = "https://iot2.sz-luoding.com:2888" + PROFILE;
  // 后文件夹
  static String  PROFILE = "/api/";
// content-type 用户登录
  static final String CONTENT_TYPE_USER_LOGIN = "user/login";
// content-type 项目列表
  static final String CONTENT_TYPE_PROJECT_LIST = "project/list";
// content-type 电箱路灯列表
  static final String CONTENT_TYPE_DEVICE_LAMP_LIST = "v_device_lamp/list";
// content-type 电箱列表
  static final String DEVICE_EBOX = "v_device_ebox/list";
// content-type 汇报设备配置
  static final String REPORT_CONFIG = "device/reportConfig";
// content-type 单个设备信息
  static final String VIEW_BY_UUID = "device/viewByUUID";
// content-type 获取断缆报警器列表
  static final String DEVICE_WIRESAFE_LIST ="v_device_wiresafe/list";
// content-type 设备控制
  static final String DEVICE_CONTROL ="device/control";
// content-type 清除报警
  static final String CLEAN_ALARM ="device/cleanAlarm";
// content-type 历史记录
  static final String HISTORY_METRICS ="device/historyMetrics";
// content-type 检测 Token 状态
  static final String CONTENT_TYPE_USER_TOKEN = "user/checkToken";
// content-type 设备列表（包含当前项目下的所有设备）
  static final String CONTENT_TYPE_DEVICE_LIST = "device/list";


  String get urlBase => _urlBase;
  set urlBase(String value) {
    if(value != null){
       _urlBase = value + PROFILE;
      _upServicePath();
    }
  }

  var servicePath;
  _upServicePath(){
    servicePath = {
      'LOGIN_URl': _urlBase  + CONTENT_TYPE_USER_LOGIN, // 登录地址
      'PROJECT_LIST_URL':  _urlBase + CONTENT_TYPE_PROJECT_LIST, // 获取项目列表地址
      'DEVICE_LAMP_LIST_URL': _urlBase + CONTENT_TYPE_DEVICE_LAMP_LIST, // 获取项目下路灯地址
      'DEVICE_EBOX_URL':_urlBase + DEVICE_EBOX, // 获取电箱列表地址
      'REPORT_CONFIG_URL': _urlBase + REPORT_CONFIG, // 获取汇报设备配置地址
      'VIEW_BY_UUID_URL': _urlBase + VIEW_BY_UUID, // 获取获取单个设备信息
      'DEVICE_WIRESAFE_LIST_URL': _urlBase + DEVICE_WIRESAFE_LIST, // 获取断缆报警器列表
      'DEVICE_CONTROL_URL': _urlBase + DEVICE_CONTROL, // 设备控制
      'CLEAN_ALARM_URL': _urlBase + DEVICE_CONTROL, // 清除报警
      'HISTORY_METRICS_URL': _urlBase + HISTORY_METRICS, // 历史记录
      'CONTENT_TYPE_USER_TOKEN': _urlBase + CONTENT_TYPE_USER_TOKEN, // 检测 Token 状态
      'DEVICE_LIST_URL': _urlBase + CONTENT_TYPE_DEVICE_LIST, // 获取当前项目下的所有设备信息
    };
  }



  String getServicePath(String code){

    return servicePath[code];

  }

}




