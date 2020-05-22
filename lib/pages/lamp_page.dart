import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LampPage extends StatelessWidget {
  const LampPage({Key key}) : super(key: key);

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
              text: "控制",
            ),
            Tab(
              text: "编辑",
            ),
            Tab(
              text: "查看",
            ),
            Tab(
              text: "历史消息",
            )
          ],
        )),
        body: TabBarView(
          // 类似ViewPage
          children: <Widget>[
            ListView(
              children: <Widget>[
                ListTile(title: Text("控制 tab")),
                ListTile(title: Text("控制 tab")),
                ListTile(title: Text("控制 tab"))
              ],
            ),
            ListView(
              children: <Widget>[
                ListTile(title: Text("编辑 tab")),
                ListTile(title: Text("编辑 tab")),
                ListTile(title: Text("编辑 tab"))
              ],
            ),
            ListView(
              children: <Widget>[
                ListTile(title: Text("查看 tab")),
                ListTile(title: Text("查看 tab")),
                ListTile(title: Text("查看 tab"))
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
