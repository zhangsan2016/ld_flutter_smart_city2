import 'dart:convert';

import 'package:amap_core_fluttify/amap_core_fluttify.dart';
import 'package:amap_core_fluttify/amap_core_fluttify.dart';
import 'package:amap_core_fluttify/amap_core_fluttify.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ldfluttersmartcity2/clusterutil/cluster_manager.dart';
import 'package:ldfluttersmartcity2/clusterutil/overlay_item.dart';
import 'package:ldfluttersmartcity2/clusterutil/project_overlay.dart';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/entity/lamp_info.dart';
import 'package:ldfluttersmartcity2/entity/login_Info.dart';
import 'package:ldfluttersmartcity2/entity/project_info.dart';
import 'package:ldfluttersmartcity2/utils/dio_utils.dart';
import 'package:ldfluttersmartcity2/utils/misc.dart';
import 'package:ldfluttersmartcity2/utils/shared_preference_util.dart';

final _assetsIcon1 = Uri.parse('images/test_icon.png');
final _assetsIcon2 = Uri.parse('images/arrow.png');

class AmapPage extends StatefulWidget {
  @override
  createState() => AmapPageState();
}

class AmapPageState extends State<AmapPage> {
  AmapController _controller;
  ClusterManager clusterManager;

  @override
  void initState() {
    super.initState();
  }

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
          clusterManager = new ClusterManager(context,_controller);


          // 解析 json
          var data = json.decode(val);
          LoginInfo loginInfo = LoginInfo.fromJson(data);

          // 获取项目列表
          getProject(loginInfo.data.token.token);



        });



        /*final marker = await _controller?.addMarker(
          MarkerOption(
            latLng: LatLng(39.90960, 116.39722800),
            title: '北京',
            snippet: '描述',
            iconUri: _assetsIcon1,
            imageConfig: createLocalImageConfiguration(context),
            width: 48,
            height: 48,
            object: '自定义数据',
          ),
        );

        final marke2r = await _controller?.addMarker(
          MarkerOption(
            latLng: LatLng(24.879994, 105.571501),
            title: '北京',
            snippet: '描述',
            iconUri: Uri.parse('images/bian.png'),
            imageConfig: createLocalImageConfiguration(context),
            width: 48,
            height: 48,
            object: '自定义数据',
          ),
        );

        final marker4 = await _controller?.addMarker(
          MarkerOption(
            latLng: LatLng(28.953875, 108.471891),
            title: '北京',
            snippet: '描述',
            iconUri: Uri.parse('images/bian.png'),
            imageConfig: createLocalImageConfiguration(context),
            width: 48,
            height: 48,
            object: '自定义数据',
          ),
        );*/



        // _markers.add(marker);
      },
    );
  }

  /**
   *  获取项目下的路灯列表
   */
   getDeviceLampList(String title, token, Project project) {
    var param = "{\"where\":{\"PROJECT\":\"" + title + "\"},\"size\":5000}";

    DioUtils.requestHttp(
      servicePath['DEVICE_LAMP_LIST_URL'],
      parameters: param,
      token: token,
      method: DioUtils.POST,
      onSuccess: (String data) async {
        // 解析 json
        var jsonstr = json.decode(data);
        LampInfo lampInfo = LampInfo.fromJson(jsonstr);
        project.setLamps(lampInfo.data.lamp);

      },
      onError: (error) {
        print(' DioUtils.requestHttp error = $error');
      },
    );
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

        for (var i = 0; i < projectInfo.data.data.length; ++i) {
          Project project = projectInfo.data.data[i];

          // 获取路灯列表
          await getDeviceLampList(project.title, token,project);

        }
      },
      onError: (error) {
        print(' DioUtils.requestHttp error = $error');
      },
    );

  }
}

