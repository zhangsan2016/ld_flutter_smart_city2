import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ldfluttersmartcity2/entity/json/lamp_info.dart';

import 'lamppags/check_lamp_page.dart';
import 'lamppags/lamp_control_page.dart';

class LampPage extends StatelessWidget {
  final String lampInfo;

  const LampPage(this.lampInfo, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        home: DefaultTabController(
      length: 4, // tab个数
      child: Scaffold(
        // Tab组件必须放到Scaffold中
        appBar: AppBar(
        title:TabBar(
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

            CheckLampPage(lampInfo),  // 查看路灯信息界面

            LampControlPage(),  // 路灯控制界面

            ListView(
              children: <Widget>[
                ListTile(title: Text("编辑 tab")),
                ListTile(title: Text("编辑 tab")),
                ListTile(title: Text("编辑 tab"))
              ],
            ),
            ListView(
              children: <Widget>[
                ListTile(title: Text("历史消息 tab")),
                ListTile(title: Text("历史消息 tab")),
                ListTile(title: Text("历史消息 tab"))
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
