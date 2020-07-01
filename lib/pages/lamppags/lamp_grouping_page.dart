import 'dart:convert';

import 'package:decorated_flutter/decorated_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/entity/json/alarm_apparatus_info.dart';
import 'package:ldfluttersmartcity2/entity/json/ebox%20_info.dart';
import 'package:ldfluttersmartcity2/entity/json/lamp_info.dart';
import 'package:ldfluttersmartcity2/entity/json/login_Info.dart';
import 'package:ldfluttersmartcity2/utils/dio_utils.dart';
import 'package:ldfluttersmartcity2/utils/shared_preference_util.dart';
import 'package:ldfluttersmartcity2/view/discrete_Setting.dart';
import 'package:oktoast/oktoast.dart';

import '../lamp_page.dart';

class GroupingPage extends StatefulWidget {
  // 当前项目
  String currentProject;

  GroupingPage(this.currentProject);

  @override
  _MyGroupingPageState createState() => _MyGroupingPageState(currentProject);
}

class _MyGroupingPageState extends State<GroupingPage> {
  // 当前路灯数据
  List<Lamp> lamps = [];
  // 当前电箱列表
  List<Ebox> eboxs = [];
  // 当前报警器列表
  List<AlarmApparatus> alarmApparatus = [];

  // 分组后的路灯
  var lampsGroup = <String, List<Lamp>>{};

  // 当前项目
  String currentProject;

  _MyGroupingPageState(this.currentProject);

  @override
  void initState() {
    super.initState();

    // 网络获取当前项目路灯数据
    getDeviceLampList(currentProject);

  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    // 获取传递过来的数据
    //  String projectTitle = ModalRoute.of(context).settings.arguments;
    //   print('projectTitle = $projectTitle');

    return new Scaffold(
      appBar: new AppBar(
        //自定义Drawer的按钮
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                onPressed:
                // () => Navigator.of(context).pop();
                Navigator.pop(context);
              });
        }),
        title: new Text('洛丁智慧照明'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
        decoration: new BoxDecoration(
          //color: Color.fromARGB(255, 11, 29, 77),
          color: Color.fromARGB(240, 11, 29, 77),
        ),
        child: ListView(
          children: getGroup(),
        ),
      ),
    );
  }

  // 设置标题
  Widget groupTitle(String title) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.all(5.0),
        color: Colors.transparent,
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ));
  }


  /**
   *  获取项目下的路灯列表
   */
  getDeviceLampList(String title) {
    SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val)  {
      // 解析 json
      var data = json.decode(val);
      LoginInfo loginInfo = LoginInfo.fromJson(data);

      var param = "{\"where\":{\"PROJECT\":\"" + title + "\"},\"size\":1000}";
      DioUtils.requestHttp(
        servicePath['DEVICE_LAMP_LIST_URL'],
        parameters: param,
        // token: token,
        token: loginInfo.data.token.token,
        method: DioUtils.POST,
        onSuccess: (String data) {
          // 解析 json
          var jsonstr = json.decode(data);
          // print('getDeviceLampList title $title = $data');
          print('getDeviceLampList title $title ');

          LampInfo lampInfo = LampInfo.fromJson(jsonstr);

          lampInfo.data.lamp.forEach((lamp) {
            print('lamp.sUBGROUP = ${lamp.sUBGROUP}');
            if (lamp.sUBGROUP.isNotEmpty) {
              if (lampsGroup.containsKey(lamp.sUBGROUP)) {
                var group = lampsGroup[lamp.sUBGROUP].add(lamp);
              } else {
                lampsGroup[lamp.sUBGROUP] = [lamp];
              }
            } else {
              // 未分组
              if (lampsGroup.containsKey('未分组')) {
                lampsGroup['未分组'].add(lamp);
              } else {
                lampsGroup['未分组'] = [lamp];
              }
            }
          });

          // 获取项目下的电箱
          getDeviceEbox(currentProject);
          // 获取项目下的报警器
          getAlarmApparatus(currentProject);

          setState(() {
            lamps = lampInfo.data.lamp;
          });
        },
        onError: (error) {
          print(' DioUtils.requestHttp error = $error');
        },
      );
    });
  }

  /**
   *  获取项目下的电箱列表
   */
  void getDeviceEbox(String title) {
    SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
      // 解析 json
      var data = json.decode(val);
      LoginInfo loginInfo = LoginInfo.fromJson(data);

      var param = "{\"where\":{\"PROJECT\":\"" + title + "\"},\"size\":1000}";
      DioUtils.requestHttp(
        servicePath['DEVICE_EBOX_URL'],
        parameters: param,
        // token: token,
        token: loginInfo.data.token.token,
        method: DioUtils.POST,
        onSuccess: (String data) {
          // 解析 json
          var jsonstr = json.decode(data);
          EboxInfo eboxInfo = EboxInfo.fromJson(jsonstr);

          setState(() {
           // eboxs = eboxInfo.data.ebox;
            lampsGroup['电箱分组']  = LampInfo.fromJson(json.decode(data)).data.lamp;
          });
        },
        onError: (error) {
          print(' DioUtils.requestHttp error = $error');
        },
      );
    });
  }

  /**
   *  获取项目下的报警器列表
   */
  void getAlarmApparatus(String title) {
    SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
      // 解析 json
      var data = json.decode(val);
      LoginInfo loginInfo = LoginInfo.fromJson(data);

      var param = "{\"where\":{\"PROJECT\":\"" + title + "\"},\"size\":1000}";
      DioUtils.requestHttp(
        servicePath['DEVICE_WIRESAFE_LIST_URL'],
        parameters: param,
        // token: token,
        token: loginInfo.data.token.token,
        method: DioUtils.POST,
        onSuccess: (String data) {
          // 解析 json
          var jsonstr = json.decode(data);
          AlarmApparatusInfo alarmApparatusInfo = AlarmApparatusInfo.fromJson(jsonstr);

          setState(() {
            // alarmApparatus = alarmApparatusInfo.data.alarmApparatus;
            lampsGroup['报警器分组']  = LampInfo.fromJson(json.decode(data)).data.lamp;
          });
        },
        onError: (error) {
          print(' DioUtils.requestHttp error = $error');
        },
      );
    });
  }

  /**
   *  获取分组
   */
  List<Widget> getGroup() {

    // 创建分组视图
       List<Widget> list = [];
    lampsGroup.keys.map((item) {
      List<Lamp> lamps = lampsGroup[item];
      if(lamps.isNotEmpty){
        list.add(groupTitle(item));
        list.add(_wrapList(lamps));
      }

    }).toList();
    return list;

  /*  List<Widget> list = [];
    list.add(groupTitle('默认分组'));
    List<Lamp> lampList =  lampsGroup['默认分组'];
    list.add(groupTitle('未分组'));
    list.add(_wrapLampList(lampsGroup['未分组']));
    list.add(groupTitle('电箱分组'));
    list.add(_wrapLampList(lampsGroup['电箱分组']));
    list.add(groupTitle('报警器分组'));
    list.add(_wrapLampList(lampsGroup['报警器分组']));
    return list;*/
  }


  Widget _wrapList(List<Lamp> lamps) {
    if (lamps?.length != 0) {
      List<Widget> listWidget = lamps.map((val) {
        Lamp lamp = val;
        return InkWell(
          /*    onTap: () {
            showToast('${lamp.nAME}', position: ToastPosition.bottom);
            print('${lamp.nAME} lamp.lAT ： ${lamp.lAT} lamp.lNG ：${lamp.lNG}');

          },*/
          child: Container(
            //width: ScreenUtil().setWidth(150),
            color: stateColor(lamp),
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                DiscreteSetting(
                  head: lamp.nAME,
                  options: ['定位', '控制'],
                  onSelected: (value) {
                    print('${lamp.nAME} ： $value');
                    switch (value) {
                      case '定位':
                        if (lamp.lNG.isNotEmpty && lamp.lNG.isNotEmpty) {
                          Navigator.pop(context, json.encode(lamp));
                        } else {
                          showToast('未能找到当前设备经纬度，请重新添加',
                              position: ToastPosition.bottom);
                        }

                        break;
                      case '控制':
                        Navigator.push<String>(
                          context,
                          new CupertinoPageRoute(
                            builder: (BuildContext context) {
                              return new LampPage(json.encode(lamp));
                            },
                          ),
                        );

                        break;
                    }
                  },
                ),

                /* Text(
                  lamp.nAME,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black, fontSize: ScreenUtil().setSp(26)),
                ),*/
              ],
            ),
          ),
        );
      }).toList();

      // 返回流式布局
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  Color stateColor(Lamp lamp) {
    // int warningState,double brightness
    // 类型 2 位路灯
    if(lamp.tYPE == 2){
      // 判断路灯报警状态
      if(lamp.warningState != null && lamp.warningState != 0 ){
        return Color.fromARGB(255, 255, 0, 0);
      }
      // 检查路灯是否在线
      // 检查路灯亮灯
      if (lamp.firDimming != null && lamp.firDimming != 0 && lamp.firDimming != '') {
        return Color.fromARGB(255, 255, 255, 0);
      } else {
        return Color.fromARGB(255, 37, 70, 131);
      }

    }else{
      return Color.fromARGB(255, 37, 70, 131);
     // return Color.fromARGB(255, 100, 149, 237);
    }



  }

}
