import 'dart:convert';

import 'package:amap_core_fluttify/amap_core_fluttify.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:ldfluttersmartcity2/clusterutil/cluster_manager.dart';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/entity/json/lamp_info.dart';
import 'package:ldfluttersmartcity2/entity/json/login_Info.dart';
import 'package:ldfluttersmartcity2/entity/json/project_info.dart';
import 'package:ldfluttersmartcity2/interfaces/amap_listening.dart';
import 'package:ldfluttersmartcity2/pages/lamp_page.dart';
import 'package:ldfluttersmartcity2/utils/dio_utils.dart';
import 'package:ldfluttersmartcity2/utils/shared_preference_util.dart';
import 'package:oktoast/oktoast.dart';

final _assetsIcon1 = Uri.parse('images/test_icon.png');
final _assetsIcon2 = Uri.parse('images/arrow.png');
final uuidController = TextEditingController(); // uuid输入监听
final projectController = TextEditingController(); // project输入监听

class AmapPage extends StatefulWidget {
  @override
  createState() => AmapPageState();
}

class AmapPageState extends State<AmapPage> implements AMapListening {
  AmapController _controller;
  ClusterManager clusterManager;
  // 覆盖物展开状态
  bool isUnfold = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return new MaterialApp(
        // 去掉运行时 debug 的提示
        debugShowCheckedModeBanner: false,
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
          body: Stack(
            children: <Widget>[
              initAMap(),
              //  search(),
              mapBar(),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 200,
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  // leading: Icon(Icons.wifi),
                  title: new Text('地图'),
                  onTap: () {
                    // 获取项目中的路灯
                    SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO)
                        .then((val) async {
                      // 解析 json
                      var data = json.decode(val);
                      LoginInfo loginInfo = LoginInfo.fromJson(data);

                      var param = "{\"where\":{\"PROJECT\":\"" +
                          "中科洛丁展示项目/深圳展厅" +
                          "\"},\"size\":1000}";

                      DioUtils.requestHttp(
                        servicePath['DEVICE_EBOX_URL'],
                        parameters: param,
                        token: loginInfo.data.token.token,
                        method: DioUtils.POST,
                        onSuccess: (String data) {
                          // 解析 json
                          var jsonstr = json.decode(data);
                          // print('getDeviceLampList title $title = $data');
                          print('get jsonstr = $jsonstr ');
                        },
                        onError: (error) {
                          print(' DioUtils.requestHttp error = $error');
                        },
                      );
                    });
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: new Text('路灯'),
                  onTap: () {
                    showToast('路灯');
                    Navigator.push<String>(
                      context,
                      new MaterialPageRoute(
                        builder: (BuildContext context) {
                          //  return new OtherPage(pwd: "123456");
                          return new LampPage("");
                        },
                      ),
                    );
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: new Text('电箱'),
                  onTap: () {
                    showToast('电箱');
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: new Text('项目'),
                  onTap: () {
                    showToast('项目');
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: new Text('报警'),
                  onTap: () {
                    showToast('报警');
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
    var param = "{\"size\":1000}";

    DioUtils.requestHttp(
      servicePath['PROJECT_LIST_URL'],
      parameters: param,
      token: token,
      method: DioUtils.POST,
      onSuccess: (String data) async {
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
        SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
          _controller = controller;

          // 设置自定义地图
            await _controller?.setCustomMapStyle(
            styleDataPath: 'raw/style.data',
            styleExtraPath: 'raw/style_extra.data',
          );

          // 定义点聚合管理类ClusterManager
          clusterManager = new ClusterManager(context, _controller,this);

          // 解析 json
          var data = json.decode(val);
          LoginInfo loginInfo = LoginInfo.fromJson(data);

          // 获取项目列表
          getProject(loginInfo.data.token.token);
        });
      },
    );
  }

  /**
   *  搜索
   */
  Widget search() {
    return new Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(15.0, 0, 5.0, 0),
          height: ScreenUtil().setHeight(90),
          width: ScreenUtil().setWidth(200),
          //  color: Colors.blue.shade100,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextField(
              controller: uuidController,
              decoration: InputDecoration(
                  hintText: "UUID",
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0, 0, 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 1, 188, 213), //边框颜色为绿色
                    width: 1, //宽度为5
                  ))),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(5.0, 0, 10.0, 0),
          height: ScreenUtil().setHeight(90),
          width: ScreenUtil().setWidth(200),
          //  color: Colors.blue.shade100,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextField(
              controller: projectController,
              decoration: InputDecoration(
                hintText: "项目名称",
                contentPadding: EdgeInsets.fromLTRB(10.0, 0, 0, 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromARGB(255, 1, 188, 213), //边框颜色为绿色
                  width: 1, //宽度为5
                )),

                // labelStyle: TextStyle(color: Colors.blue, fontSize: 24.0),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5.0),
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(200),
          child: RaisedButton(
            child: Text('搜索'),
            color: Color.fromARGB(255, 1, 188, 213),
            textColor: Colors.white,
            onPressed: () {
              print('提交');
              if (uuidController.text.length > 0) {
                print('提交${uuidController.text}');
              } else {
                print('提交失败');
              }
            },
          ),
        )
      ],
    );
  }

  /**
   * 地图功能栏
   */
  Widget mapBar() {
    if(isUnfold){
      return Positioned(
        left: 1,
        right: 1,
        child: Container(
          padding: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
          color: Colors.black26,
          child: Row(
            children: <Widget>[
              Spacer(),
              //Expanded(child: SizedBox()),//自动扩展挤压

              Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: IconButton(
                  icon: Image.asset('images/refresh.png'),
                  onPressed: () {
                   // showToast('刷新',position: ToastPosition.bottom);
                    clusterManager.refresh();
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: IconButton(
                  icon: Image.asset('images/restoration.png'),
                  onPressed: () {
                    clusterManager.relocation();
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: IconButton(
                  icon: Image.asset('images/group.png'),
                  onPressed: () {
                    showToast('分组',position: ToastPosition.bottom);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }else{
      return  Container();
    }

  }

  @override
  void mapMoveListener(MapMove move) {
  }


  @override
  void mapMarkerStartListener(bool isUnfold) {
    setState(() {
      this.isUnfold = isUnfold;
    });
    print('mapMarkerStartListener isUnfold $isUnfold ');
  }
}
