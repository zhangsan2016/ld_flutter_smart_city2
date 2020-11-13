import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ldfluttersmartcity2/common/event_bus.dart';
import 'package:ldfluttersmartcity2/entity/json/lamp_info.dart';
import 'package:ldfluttersmartcity2/entity/json/login_Info.dart';
import 'package:ldfluttersmartcity2/utils/shared_preference_util.dart';
import 'package:oktoast/oktoast.dart';

import 'lamppags/check_lamp_page.dart';
import 'lamppags/edit_lamp_page.dart';
import 'lamppags/lamp_control_page.dart';
import 'lamppags/lamp_history_page.dart';

class LampPage extends StatefulWidget {
  final String lampInfo;

  const LampPage(this.lampInfo, {Key key}) : super(key: key);

  @override
  _LampPageState createState() => _LampPageState();
}

class _LampPageState extends State<LampPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  List _spList = [];

  LoginInfo loginInfo;

  @override
  void initState() {
    super.initState();
    _tabController = null;
    _tabController = TabController(
        initialIndex: 0, length: _spList.length, vsync: this); // 直接传this

    // 根据权限设置 table 界面
    initTable();
  }

  @override
  Widget build(BuildContext context) {
    Lamp _lamp;
    if (widget.lampInfo != null) {
      _lamp = Lamp.fromJson(json.decode(widget.lampInfo));
    }
    return MaterialApp(
      // 去掉运行时 debug 的提示
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(primaryColor: Colors.blue),
      home: DefaultTabController(
        length: _spList.length, // tab个数
        child: Scaffold(
          // Tab组件必须放到Scaffold中
          appBar: AppBar(
              actions: <Widget>[
                IconButton(
                    icon: Image.asset('images/lamp_location.png'),
                    onPressed: () {
                      if (_lamp.lNG.isNotEmpty && _lamp.lNG.isNotEmpty) {
                        //  Navigator.popUntil(context, ModalRoute.withName('/pageC'));
                        // 设置回调
                        //   AmapPageState.location(json.encode(_lamp));
                        // Navigator.pop(context, json.encode(_lamp));
                        //        Navigator.of(context).pop();

                        // 向事件总线发射一个地图定位事件
                        eventBus.fire(AmapLocation(json.encode(_lamp)));
                        Navigator.popUntil(
                            context, ModalRoute.withName('/AmapPage'));
                      } else {
                        showToast('未能找到当前设备经纬度，请重新添加',
                            position: ToastPosition.bottom);
                      }
                    }
                    // showSearch(context:context,delegate: searchBarDelegate()),
                    ),
              ],
              title: Column(
                children: <Widget>[
                  Text('${_lamp?.nAME}'),
                  Text('${_lamp?.pROJECT}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          decorationStyle: TextDecorationStyle.solid,
                          fontSize: ScreenUtil().setSp(26),
                          color: Colors.white)),
                ],
              ),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop(), // exit(0),
              ),
              elevation: 20.0,
              backgroundColor: Colors.cyan,
              bottom: TabBar(
                tabs: _spList.isEmpty
                    ? []
                    : _spList.map((f) {
                        return Tab(
                          text: f,
                        );
                      }).toList(),
              )),
          body: TabBarView(
              physics: new NeverScrollableScrollPhysics(),
              // 类似ViewPage
              children: _spList.isEmpty
                  ? []
                  : _spList.map((f) {


        /*        CheckLampPage(widget.lampInfo), // 路灯查看信息界面
                LampControlPage(widget.lampInfo), // 路灯控制界面
                EditLampPage(widget.lampInfo), // 路灯编辑界面
                LampHistoryPage(widget.lampInfo),  // 历史记录界面*/


                      // 查看 控制 编辑 历史消息
                      if ('查看' == f) {
                        return CheckLampPage(widget.lampInfo); // 路灯查看信息界面
                      } else if ('控制' == f) {
                        return LampControlPage(widget.lampInfo); // 路灯控制界面
                      } else if ('编辑' == f) {
                        return EditLampPage(widget.lampInfo); // 路灯编辑界面
                      } else if ('历史消息' == f) {
                        return LampHistoryPage(widget.lampInfo); // 历史记录界面
                      }
                      return null;

                    }).toList()),
        ),
      ),
    );
  }

  void initTable() {
    SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
      // 解析 json
      var data = json.decode(val);
      loginInfo = LoginInfo.fromJson(data);

      setState(() {
        // 查看 控制 编辑 历史消息
        /*"v_device_lamp/view",
        "v_device_lamp/control",
        "v_device_lamp/edit",
        "v_device_lamp/metrics",*/

        if (loginInfo.data.grantedActions.contains('v_device_lamp/view')) {
          _spList.add("查看");
        }
        if (loginInfo.data.grantedActions.contains('v_device_lamp/control')) {
          _spList.add("控制");
        }
        if (loginInfo.data.grantedActions.contains('v_device_lamp/edit')) {
          _spList.add("编辑");
        }
        if (loginInfo.data.grantedActions.contains('v_device_lamp/metrics')) {
          _spList.add("历史消息");
        }

        /*_tabController = TabController(
            initialIndex: 1, length: _spList.length, vsync: this);
        _tabController.animateTo(0);*/
      });
    });
  }

  /// 切换tab后保留tab的状态，避免initState方法重复调用
  @override
  bool get wantKeepAlive => true;
}
