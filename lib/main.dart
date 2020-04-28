import 'dart:convert';

import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:ldfluttersmartcity2/utils/http_util.dart';

import 'config/aa.dart';

void main() async {
  runApp(MyApp());

  // 初始化地图
  await enableFluttifyLog(false);
  await AmapService.init(
    iosKey: '7a04506d15fdb7585707f7091d715ef4',
    androidKey: '4cac4b9b55cf85b94437655ff3a14543',
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '洛丁智慧城市',
      // 去掉运行时 debug 的提示
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '洛丁智慧城市'),
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
 /*   var formData = {'username': 'ld', 'password': 'ld9102'};
    request('LOGIN_URl',formData: formData).then((val) {
      var data = json.decode(val.toString());
      print('data = ' + data);

    });*/

    return Scaffold(
  /*    appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),*/
      body:LoginPage() // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class AmapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AmapView(
      // 地图类型 (可选)
      mapType: MapType.Standard,
      // 是否显示缩放控件 (可选)
      showZoomControl: false,
      // 是否显示指南针控件 (可选)
      showCompass: false,
      // 是否显示比例尺控件 (可选)
      showScaleControl: false,
      // 是否使能缩放手势 (可选)
      zoomGesturesEnabled: true,
      // 缩放级别 (可选)
      zoomLevel: 4,
      // 中心点坐标 (可选)
      centerCoordinate: LatLng(34.070022,109.617258),
      // 标记 (可选)
      markers: <MarkerOption>[],
      // 标识点击回调 (可选)
      onMarkerClicked: (Marker marker) {},
      // 地图点击回调 (可选)
      onMapClicked: (LatLng coord) {},
      // 地图创建完成回调 (可选)
      onMapCreated: (controller) async {
        // requestPermission是权限请求方法, 需要你自己实现
        // 如果不知道怎么处理, 可以参考example工程的实现, example工程依赖了`permission_handler`插件.
       /* if (await requestPermission()) {
          await controller.showMyLocation(MyLocationOption(show: true));
        }*/
      },
    );
  }


}
