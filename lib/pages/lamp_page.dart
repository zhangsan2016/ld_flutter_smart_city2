import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ldfluttersmartcity2/entity/json/lamp_info.dart';
import 'package:ldfluttersmartcity2/pages/amap_page.dart';
import 'package:oktoast/oktoast.dart';

import 'lamppags/check_lamp_page.dart';
import 'lamppags/edit_lamp_page.dart';
import 'lamppags/lamp_control_page.dart';
import 'lamppags/lamp_history_page.dart';

class LampPage extends StatelessWidget {
  final String lampInfo;

  const LampPage(this.lampInfo, {Key key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    Lamp _lamp;
    if (lampInfo != null) {
      _lamp = Lamp.fromJson(json.decode(lampInfo));
    }
    return MaterialApp(
        // 去掉运行时 debug 的提示
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(primaryColor: Colors.blue),
        home: DefaultTabController(
          length: 4, // tab个数
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
                          AmapPageState.location(json.encode(_lamp));
                          Navigator.pop(context, json.encode(_lamp));
                        //  Navigator.of(context).pop();
                        } else {
                          showToast('未能找到当前设备经纬度，请重新添加', position: ToastPosition.bottom);
                        }
                      }
                    // showSearch(context:context,delegate: searchBarDelegate()),
                  ),
                ],
                title: Column(children: <Widget>[
                  Text('${_lamp?.nAME}'),
                  Text('${_lamp?.pROJECT}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          decorationStyle: TextDecorationStyle.solid,
                          fontSize: ScreenUtil().setSp(26),
                          color: Colors.white)),
                ],),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.of(context).pop(), // exit(0),
                ),
                elevation: 20.0,
                backgroundColor: Colors.cyan,
                bottom: TabBar(
                  tabs: <Widget>[
                    Tab(
                      text: "查看",
                    ),
                    Tab(
                      text: "控制",
                    ),
                    Tab(
                      text: "编辑",
                    ),
                    Tab(
                      text: "历史消息",
                    )
                  ],
                )),
            body: TabBarView(
              physics: new NeverScrollableScrollPhysics(),
              // 类似ViewPage
              children: <Widget>[
                CheckLampPage(lampInfo), // 路灯查看信息界面

                LampControlPage(lampInfo), // 路灯控制界面

                EditLampPage(lampInfo), // 路灯编辑界面

                LampHistoryPage(lampInfo),  // 历史记录界面


                /*  ListView(
              children: <Widget>[
                ListTile(title: Text("历史消息 tab")),
                ListTile(title: Text("历史消息 tab")),
                ListTile(title: Text("历史消息 tab"))
              ],
            ),*/
              ],
            ),
          ),
        ));
  }
}
