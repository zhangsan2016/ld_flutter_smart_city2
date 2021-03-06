import 'dart:async';
import 'dart:convert';

import 'package:amap_core_fluttify/amap_core_fluttify.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:ldfluttersmartcity2/clusterutil/cluster_manager.dart';
import 'package:ldfluttersmartcity2/common/event_bus.dart';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/entity/json/lamp_info.dart';
import 'package:ldfluttersmartcity2/entity/json/login_Info.dart';
import 'package:ldfluttersmartcity2/entity/json/project_info.dart';
import 'package:ldfluttersmartcity2/interfaces/amap_listening.dart';
import 'package:ldfluttersmartcity2/pages/lamp_page.dart';
import 'package:ldfluttersmartcity2/pages/login_page.dart';
import 'package:ldfluttersmartcity2/utils/dio_utils.dart';
import 'package:ldfluttersmartcity2/utils/shared_preference_util.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'lamppags/lamp_grouping_page.dart';

final _assetsIcon1 = Uri.parse('images/test_icon.png');
final _assetsIcon2 = Uri.parse('images/arrow.png');
final uuidController = TextEditingController(); // uuid输入监听
final projectController = TextEditingController(); // project输入监听

class AmapPage extends StatefulWidget {
  @override
  createState() => AmapPageState();
}

class AmapPageState extends State<AmapPage> implements AMapListening {
  static AmapController _controller;
  static ClusterManager clusterManager;
  // 登录信息
  LoginInfo loginInfo;


  // 覆盖物展开状态
  bool isUnfold = false;

  // 异步订阅管理
  StreamSubscription _searchDelSubscription;
  BuildContext _context;

  @override
  void initState() {
    super.initState();

    /// 监听定位事件
    _searchDelSubscription = eventBus.on<AmapLocation>().listen((event){
       _locationUp(event.data);
    });

  }


  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    // 关闭高德地图聚合管理器
    clusterManager = null;
    // 清理高德地图控制器
    _controller.clear();
    // 取消监听，节省系统资源
    _searchDelSubscription.cancel();
  }


  @override
  Widget build(BuildContext context) {
    _context = context;
 /*   var name =  loginInfo?.data?.userProfile?.username;
    print('name = $name');*/

    // 定位变更监听
   // _locationUp(context);

    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return new MaterialApp(
      // 去掉运行时 debug 的提示
      debugShowCheckedModeBanner: false,
      title: '洛丁智慧照明',
      home: new Scaffold(
        appBar: new AppBar(
        /*  //AppBar 左侧图标，点击自定义Drawer的按钮
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
                icon: Icon(Icons.wifi_tethering),
                onPressed: () {
                   // 关闭抽屉布局
                  // Scaffold.of(context).openDrawer();

                });
          }),*/
          //  AppBar 右侧图标点击退出登录
          actions: <Widget>[

            Row(children: <Widget>[
              // 设置用户名
              Text(loginInfo?.data?.userProfile?.username == null?"": loginInfo?.data?.userProfile?.username,textAlign: TextAlign.center,style: TextStyle(fontSize: ScreenUtil().setSp(38)),),
              IconButton(
                  icon: Image.asset('images/my_user.png'),
                  onPressed: () {
                    // 打开提示框
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('退出当前账号'),
                          content: Text(('是否退出当前账号？')),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text("取消"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            new FlatButton(
                              child: new Text("确定"),
                              onPressed: () {

                                // 清除登录数据
                                SharedPreferenceUtil.del(SharedPreferenceUtil.LOGIN_INFO);

                                //跳转到登录界面
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  new MaterialPageRoute(builder: (context) => new LoginPage(true)),
                                      (route) => route == null,
                                );
                              },
                            ),
                          ],
                        ));
                  }
                // showSearch(context:context,delegate: searchBarDelegate()),
              ),
            ],),


        ],
          title: Text('洛丁智慧照明', textAlign: TextAlign.center,),
          backgroundColor: Colors.cyan,
        ),
        body: Stack(
          children: <Widget>[
            initAMap(),
            //  search(),
            mapBar(),
          ],
        ),
       // drawer: myDrawer(),
      ),
    );
  }

  /**
   *  获取当前用户下的所有项目
   */
  void getProject(String token) async{
    var param = "{\"size\":1000}";

    DioUtils.requestHttp(
      Api.instance.getServicePath('PROJECT_LIST_URL'),
      parameters: param,
      token: token,
      method: DioUtils.POST,
      onSuccess: (String data) async {
        // 解析 json
        var jsonstr = json.decode(data);
        ProjectInfo projectInfo = ProjectInfo.fromJson(jsonstr);

        // 设置好项目数量
        clusterManager.projectCount = projectInfo.data.data.length;
        // 添加地图覆盖物
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
        SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO)
            .then((val) async {
          _controller = controller;

          // 设置自定义地图
          await _controller?.setCustomMapStyle(
            styleDataPath: 'raw/style.data',
            styleExtraPath: 'raw/style_extra.data',
          );

          // 关闭旋转手势
          _controller?.setRotateGesturesEnabled(false);

          // 定义点聚合管理类ClusterManager
          clusterManager = new ClusterManager(context, _controller, this);

          // 解析 json
          var data = json.decode(val);
          loginInfo = LoginInfo.fromJson(data);

          // 设置用户名称
          //loginInfo.data.userProfile.username

          // 获取项目列表
          getProject(loginInfo.data.token.token);

          print('获取的登录信息 data = ${val.toString()}');
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
    if (isUnfold) {
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
                    // showToast('分组 ${clusterManager.getCurrentTitle()}',position: ToastPosition.bottom);
                    _navigateGroupingPage(context);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  void mapMoveListener(MapMove move) {}

  @override
  void mapMarkerStartListener(bool isUnfold) {
    setState(() {
      this.isUnfold = isUnfold;
    });
  }


  /**
   * 跳转到分组
   */
  _navigateGroupingPage(BuildContext context) async {
    // 获取当前点击的项目名称
    String currentProject = clusterManager.getCurrentTitle();

    /* var result = await Navigator.pushNamed(context, GroupingPage.routeName,
        arguments: currentProject);*/

    /*  print(result.toString());
    showToast('msg ${result.toString()}');*/

    /* var result2 = await Navigator.push(context, MaterialPageRoute(
        builder: (context)=>GroupingPage()
    )).then((data){
      //接受返回的参数
      print('data.toString() = ${data.toString()}');
    });*/

    Navigator.push<String>(
      context,
      new CupertinoPageRoute(
        settings: RouteSettings(name:"/GroupingPage"),
        builder: (BuildContext context) {
          return new GroupingPage(currentProject);
        },
      ),
    ).then((data) async {
      // 定位功能
      //接收返回的参数
      print('接收返回的参数 = ${data}');
      if(data != null){
        // 1.集中器 2.路灯 4.报警器
        Lamp lamp = Lamp.fromJson(json.decode(data));
        _controller?.setCenterCoordinate(
          LatLng(double.parse(lamp.lAT),double.parse(lamp.lNG)),
          animated: false,
        );

        // 更新图标
        clusterManager?.updateMarkerIco('${double.parse(lamp.lAT)},${double.parse(lamp.lNG)}');
      }

    });
  }

  /**
   *  抽屉布局
   */
  Widget myDrawer() {
   return Drawer(
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
                  Api.instance.getServicePath('DEVICE_EBOX_URL'),
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
    );
  }

  /**
   * 定位更新方法
   */
  _locationUp(String data){

    // 定位功能
    //接收返回的参数
    if(data != null){
      // 1.集中器 2.路灯 4.报警器
      Lamp lamp = Lamp.fromJson(json.decode(data));
      _controller?.setCenterCoordinate(
        LatLng(double.parse(lamp.lAT),double.parse(lamp.lNG)),
        animated: false,
      );

      print('更换图标 ${double.parse(lamp.lAT)},${double.parse(lamp.lNG)} ');

      // 更新图标
      clusterManager?.updateMarkerIco('${double.parse(lamp.lAT)},${double.parse(lamp.lNG)}');
    }

  }


}
