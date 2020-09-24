import 'dart:convert';

import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:ldfluttersmartcity2/pages/amap_page.dart';
import 'package:ldfluttersmartcity2/pages/lamppags/lamp_grouping_page.dart';
import 'package:ldfluttersmartcity2/pages/login_page.dart';
import 'package:ldfluttersmartcity2/provide/device_search_provide.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());

  // 初始化地图
  await enableFluttifyLog(false);
  await AmapService.init(
    iosKey: '7a04506d15fdb7585707f7091d715ef4',
    androidKey: '4cac4b9b55cf85b94437655ff3a14543',
    /*iosKey: '2691a1ff880a31cc519476070f38e69e',
    androidKey: '2691a1ff880a31cc519476070f38e69e',*/
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
       ChangeNotifierProvider(create: (_) => DeviceSearchProvide()),
      ],
      child: OKToast(
        child: MaterialApp(
          title: '洛丁智慧城市',
          // 去掉运行时 debug 的提示
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: '洛丁智慧城市'),

          //    路由集合
          routes: {
            '/AmapPage': (context) => new AmapPage(),

          },
//      找不到路由，显示的错误页面
          onUnknownRoute: (RouteSettings setting) {
            String name = setting.name;
            showToast("未匹配到路由:$name");
            return new MaterialPageRoute(builder: (context) {
              return null;
            });
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*    appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),*/

        body: LoginPage(
            false) // This trailing comma makes auto-formatting nicer for build methods.
        // body: GroupingPage(),
        );
  }
}
