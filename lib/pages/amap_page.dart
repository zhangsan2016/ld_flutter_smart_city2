import 'dart:convert';

import 'package:amap_core_fluttify/amap_core_fluttify.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ldfluttersmartcity2/clusterutil/cluster_manager.dart';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/entity/json/lamp_info.dart';
import 'package:ldfluttersmartcity2/entity/json/login_Info.dart';
import 'package:ldfluttersmartcity2/entity/json/project_info.dart';
import 'package:ldfluttersmartcity2/utils/dio_utils.dart';
import 'package:ldfluttersmartcity2/utils/shared_preference_util.dart';

final _assetsIcon1 = Uri.parse('images/test_icon.png');
final _assetsIcon2 = Uri.parse('images/arrow.png');

class AmapPage extends StatefulWidget {
  @override
  createState() => AmapPageState();
}

class AmapPageState extends State<AmapPage> {
  final List<Tab> _mTabs = <Tab>[
    Tab(
      text: 'Tab1',
      icon: Icon(Icons.airline_seat_flat_angled),
    ),
    Tab(
      text: 'Tab2',
      icon: Icon(Icons.airline_seat_flat_angled),
    ),
    Tab(
      text: 'Tab3',
      icon: Icon(Icons.airline_seat_flat_angled),
    ),
  ];

  AmapController _controller;
  ClusterManager clusterManager;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: '洛丁智慧照明',
        home: new Scaffold(
          appBar: new AppBar(
            //自定义Drawer的按钮
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                  icon: Icon(Icons.wifi_tethering),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  });
            }),
            title: new Text('洛丁智慧照明'),
            backgroundColor: Colors.cyan,
          ),
          body: initAMap(),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 200,
                  child: UserAccountsDrawerHeader(

                      //设置当前用户的头像
                      /*          currentAccountPicture: new CircleAvatar(
                        backgroundImage: new AssetImage('images/test_icon.jpg'),
                      ),*/
                      //回调事件
                      /*   onDetailsPressed: (){
                      },*/
                      ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  // leading: Icon(Icons.wifi),
                  title: new Text('地图'),
                  onTap: () {
                    print('ssss');
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: new Text('路灯'),
                  onTap: () {
                    print('ssss');
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: new Text('电箱'),
                  onTap: () {
                    print('ssss');
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: new Text('项目'),
                  onTap: () {
                    print('ssss');
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: new Text('报警'),
                  onTap: () {
                    print('ssss');
                  },
                ),
              ],
            ),
          ),
        ));
  }

  /**
   *  获取当前用户下的所有项目
   */
  void getProject(String token) {
    DioUtils.requestHttp(
      servicePath['PROJECT_LIST_URL'],
      parameters: null,
      token: token,
      method: DioUtils.POST,
      onSuccess: (String data) async {
        print(' DioUtils.requestHttp onSuccess = ${data.toString()}');

        // 解析 json
        var jsonstr = json.decode(data);
        ProjectInfo projectInfo = ProjectInfo.fromJson(jsonstr);

        clusterManager.addItems(projectInfo.data.data);
      },
      onError: (error) {
        print(' DioUtils.requestHttp error = $error');
      },
    );
  }

  /**
   *  初始化地图
   */
  Widget initAMap() {
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
      centerCoordinate: LatLng(34.070022, 109.617258),
      // 标记 (可选)
      markers: <MarkerOption>[],
      // 标识点击回调 (可选)
      onMarkerClicked: (Marker marker) {},
      // 地图点击回调 (可选)
      onMapClicked: (LatLng coord) {},
      // 地图创建完成回调 (可选)
      onMapCreated: (controller) async {
        SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) {
          _controller = controller;

          // 定义点聚合管理类ClusterManager
          clusterManager = new ClusterManager(context, _controller);

          // 解析 json
          var data = json.decode(val);
          LoginInfo loginInfo = LoginInfo.fromJson(data);

          // 获取项目列表
          getProject(loginInfo.data.token.token);
        });
      },
    );
  }
}
