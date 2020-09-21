import 'dart:convert';

import 'package:decorated_flutter/decorated_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/dialog/progress_dialog.dart';
import 'package:ldfluttersmartcity2/entity/json/alarm_apparatus_info.dart';
import 'package:ldfluttersmartcity2/entity/json/device_list.dart';
import 'package:ldfluttersmartcity2/entity/json/ebox%20_info.dart';
import 'package:ldfluttersmartcity2/entity/json/lamp_info.dart';
import 'package:ldfluttersmartcity2/entity/json/login_Info.dart';
import 'package:ldfluttersmartcity2/pages/search/mysearch_delegate.dart';
import 'package:ldfluttersmartcity2/utils/dio_utils.dart';
import 'package:ldfluttersmartcity2/utils/resource_request.dart';
import 'package:ldfluttersmartcity2/utils/shared_preference_util.dart';
import 'package:ldfluttersmartcity2/view/discrete_Setting.dart';
import 'package:oktoast/oktoast.dart';

import '../lamp_page.dart';

class GroupingPage extends StatefulWidget {
  // 当前项目
  String currentProject;

  GroupingPage(this.currentProject);

  @override
  _MyGroupingPageState createState() => _MyGroupingPageState();
}

class _MyGroupingPageState extends State<GroupingPage> {
  // 分组后的路灯
  var lampsGroup = <String, List<Device>>{};

  @override
  void initState() {
    super.initState();
    // 获取设备信息
    getDeviceList(widget.currentProject);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);

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
        // 导航栏右侧搜索图标
        /*    actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //  showSearch(context: context, delegate: MySearchDelegate());
              }
            // showSearch(context:context,delegate: searchBarDelegate()),
          ),
        ],*/
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
        child: Column(
          children: <Widget>[
            // 搜索按钮
            buildSearchButton(),
            getGroupView(),
          ],
        ),
      ),
    );
  }

  /**
   *  创建搜索按钮
   */
  Widget buildSearchButton() {
    return Container(
      height: 30,

      ///外边距
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20),
      child: Material(
        color: Colors.transparent,
        child: Ink(

            ///圆角边框
            decoration: BoxDecoration(
              border: new Border.all(color: Color(0xFFD6D6D6), width: 0.5),
              // 边色与边宽度
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: InkWell(
              onTap: () {
                showSearch(
                    context: context,
                    delegate: MySearchDelegate(widget.currentProject));
              },
              splashColor: const Color(0xFFD6D6D6),
              // splashColor: Colors.white,
              ///点击事件的圆角
              ///表现为水波纹的圆角
              borderRadius: BorderRadius.circular(20.0),

              ///页面过渡动画
              child: Container(
                alignment: Alignment.center,
                child: new Text(
                  '搜索',
                  style: TextStyle(color: Color(0xff999999)),
                ),
              ),
            )),
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
   *  获取分组
   */
  List<Widget> getGroup() {
    // 创建分组视图
    List<Widget> list = [];
    lampsGroup.keys.map((item) {
      List<Device> lamps = lampsGroup[item];
      if (lamps.isNotEmpty) {
        list.add(groupTitle(item));
        list.add(_wrapList(lamps));
      }
    }).toList();
    return list;
  }

  Widget _wrapList(List<Device> lamps) {
    if (lamps?.length != 0) {
      List<Widget> listWidget = lamps.map((val) {
        Device lamp = val;
        return InkWell(
          onTap: () {
            /* showToast('${lamp.nAME}', position: ToastPosition.bottom);
            print('${lamp.nAME} lamp.lAT ： ${lamp.lAT} lamp.lNG ：${lamp.lNG}');*/
            if (lamp.lNG.isNotEmpty && lamp.lNG.isNotEmpty) {
              Navigator.pop(context, json.encode(lamp));
            } else {
              showToast('未能找到当前设备经纬度，请重新添加', position: ToastPosition.bottom);
            }
          },
          child: Container(
            //width: ScreenUtil().setWidth(150),
            color: stateColor(lamp),
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                /*DiscreteSetting(
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
                ),*/

                Text(
                  lamp.nAME,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black, fontSize: ScreenUtil().setSp(26)),
                ),
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

  Color stateColor(Device lamp) {
    // int warningState,double brightness
    // 类型 2 位路灯
    if (lamp.tYPE == 2) {
      // 判断路灯报警状态
      if (lamp.warningState != null && lamp.warningState != 0) {
        return Color.fromARGB(255, 255, 0, 0);
      }
      // 检查路灯是否在线
      // 检查路灯亮灯
      if (lamp.firDimming != null &&
          lamp.firDimming != 0 &&
          lamp.firDimming != '') {
        return Color.fromARGB(255, 255, 255, 0);
      } else {
        return Color.fromARGB(255, 37, 70, 131);
      }
    } else {
      return Color.fromARGB(255, 37, 70, 131);
      // return Color.fromARGB(255, 100, 149, 237);
    }
  }

  /**
   *   获取设备列表（包含路灯、电箱、报警器）
   *   temporary 当前用户下所有的项目
   *   title 指定项目
   */
  void getDeviceList(String title) async {
    // 获取项目中的路灯
    SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
      // 解析 json
      var data = json.decode(val);
      LoginInfo loginInfo = LoginInfo.fromJson(data);

      ResourceRequest.deviceList(title, loginInfo.data.token.token,
          (DeviceList val) {
        // 解析当前项目设备，根据类型分类（包含电箱、路灯、控制器）
        parseDevice(val, title);
      });
    });
  }

  /**
   * 解析当前项目设备，根据类型分类（包含电箱、路灯、控制器）
   */
  void parseDevice(DeviceList val, title) {
    for (Device device in val.device) {
      if (device.tYPE == 1) {
        // 电箱信息
        lampsGroup['电箱分组'] = [device];
      } else if (device.tYPE == 2) {
        // 路灯信息
        if (device.sUBGROUP.isNotEmpty) {
          if (lampsGroup.containsKey(device.sUBGROUP)) {
            var group = lampsGroup[device.sUBGROUP].add(device);
          } else {
            lampsGroup[device.sUBGROUP] = [device];
          }
        } else {
          // 未分组
          if (lampsGroup.containsKey('未分组')) {
            lampsGroup['未分组'].add(device);
          } else {
            lampsGroup['未分组'] = [device];
          }
        }
      } else if (device.tYPE == 4) {
        // 报警器信息
        lampsGroup['报警器分组'] = [device];
      }
    }

    if (lampsGroup.length > 0) {
      setState(() {});
    } else {
      showToast('当前数据为空', position: ToastPosition.bottom);
    }
  }

  /**
   *  获取分组视图
   */
  Widget getGroupView() {
    if (lampsGroup != null && lampsGroup.length > 0) {
      // 返回分组界面
      return Expanded(
        child: ListView(
          children: getGroup(),
        ),
      );
    } else {
      return

        Expanded(
          child:  Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: SizedBox(
                  width: ScreenUtil().setWidth(100.0),
                  height: ScreenUtil().setWidth(100.0),
                  child: CircularProgressIndicator(strokeWidth: 2.0) // 加载转圈
              )),
        );

    }
  }
}
