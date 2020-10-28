
class Api {


  // base 地址
// const String URL_BASE = "https://iot.sz-luoding.com:888/api/";
  static  String URL_BASE = "https://iot2.sz-luoding.com:2888/api/";
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


  static final ServiceUrl = 'http://test.baixingliangfan.cn/baixing/';
  static var servicePath = {
    'LOGIN_URl': URL_BASE + CONTENT_TYPE_USER_LOGIN, // 登录地址
    'PROJECT_LIST_URL':  URL_BASE + CONTENT_TYPE_PROJECT_LIST, // 获取项目列表地址
    'DEVICE_LAMP_LIST_URL': URL_BASE + CONTENT_TYPE_DEVICE_LAMP_LIST, // 获取项目下路灯地址
    'DEVICE_EBOX_URL':URL_BASE + DEVICE_EBOX, // 获取电箱列表地址
    'REPORT_CONFIG_URL': URL_BASE + REPORT_CONFIG, // 获取汇报设备配置地址
    'VIEW_BY_UUID_URL': URL_BASE + VIEW_BY_UUID, // 获取获取单个设备信息
    'DEVICE_WIRESAFE_LIST_URL': URL_BASE + DEVICE_WIRESAFE_LIST, // 获取断缆报警器列表
    'DEVICE_CONTROL_URL': URL_BASE + DEVICE_CONTROL, // 设备控制
    'CLEAN_ALARM_URL': URL_BASE + DEVICE_CONTROL, // 清除报警
    'HISTORY_METRICS_URL': URL_BASE + HISTORY_METRICS, // 历史记录
    'CONTENT_TYPE_USER_TOKEN': URL_BASE + CONTENT_TYPE_USER_TOKEN, // 检测 Token 状态
    'DEVICE_LIST_URL': URL_BASE + CONTENT_TYPE_DEVICE_LIST, // 获取当前项目下的所有设备信息
  };

}




