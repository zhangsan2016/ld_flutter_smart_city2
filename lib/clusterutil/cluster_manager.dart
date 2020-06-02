import 'dart:convert';
import 'dart:math';

import 'package:amap_core_fluttify/amap_core_fluttify.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/entity/json/ebox%20_info.dart';
import 'package:ldfluttersmartcity2/entity/json/lamp_info.dart';
import 'package:ldfluttersmartcity2/entity/json/login_Info.dart';
import 'package:ldfluttersmartcity2/entity/json/project_info.dart';
import 'package:ldfluttersmartcity2/pages/lamp_page.dart';
import 'package:ldfluttersmartcity2/utils/dio_utils.dart';
import 'package:ldfluttersmartcity2/utils/shared_preference_util.dart';

import 'overlay_item.dart';

class ClusterManager {
  AmapController _controller;
  BuildContext _context;

  // 是否展开
  bool isUnfold = false;
  // 项目路灯集合
  var lampMap = <String, List<Lamp>>{};
  // 项目电箱集合
  var eboxMap = <String, List<Ebox>>{};

  ClusterManager(BuildContext context, AmapController controller) {
    this._context = context;
    this._controller = controller;

    init();
  }

  Future init() async {

    // marker 点击事件
    _controller?.setMarkerClickedListener((marker) async {
      print('isUnfold = $isUnfold');
      print(
          '${await marker.title}, ${await marker.snippet}, ${await marker.location}, ${await marker.object} ,${lampMap.length}');

      if (!isUnfold) {
        // 获取项目对应的路灯列表
        List<Lamp> lamp = lampMap[await marker.title];
        // 获取项目对应的电箱
        List<Ebox> ebox = eboxMap[await marker.title];
        // 添加覆盖物
        await addItems(lamp,eboxs:ebox);
      }else{
        // 展开状态
        // 跳转到路灯控制界面
        String lampInfo = await marker.object;
        Navigator.push<String>(
          _context,
          new MaterialPageRoute(
            builder: (BuildContext context) {
              //  return new OtherPage(pwd: "123456");
              return new LampPage(lampInfo);
            },
          ),
        );
      }

      return true;
    });

    // 地图移动监听
    _controller?.setMapMoveListener(
      onMapMoveStart: (move) async {
        MapMove mapMove = move;
      },
      onMapMoveEnd: (move) async {
        MapMove mapMove = move;
        print('MapMoveListener move = ${move.zoom}');

        if (move.zoom < 5) {
          if (isUnfold) {
            addItems(projects);
          }
        }
      },
    );
  }

  // 当前显示的 marker 列表
  List<Marker> _markers = new List();
  // 项目列表
  List<Project> projects;
  void addItems(List items,{eboxs}) async {
    List temporary;
    if (items != null && items.length > 0) {
      if (items[0] is Project) {
        // 克隆一份列表
        temporary = new List<Project>.from(items);
        _controller.clearMarkers(_markers);
      //  await _controller.clear();
        projects = items;
        for (int i = 0; i < items.length; ++i) {
          Project project = items[i];
          final marker = await _controller?.addMarker(
            MarkerOption(
              latLng:
                  LatLng(double.parse(project.lat), double.parse(project.lng)),
              title: project.title,
              snippet: '描述',
              iconUri: Uri.parse('images/bian.png'),
              imageConfig: createLocalImageConfiguration(_context),
              width: 48,
              height: 48,
              object: json.encode(project.lamps),
            ),
          );
          _markers.add(marker);
        }
        // 展开状态为 false
        isUnfold = false;

        // 获取项目中的路灯
        SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO)
            .then((val) async {
          if (temporary != null && temporary.length > 0) {
            // 解析 json
            var data = json.decode(val);
            LoginInfo loginInfo = LoginInfo.fromJson(data);

            for (var i = 0; i < temporary.length; ++i) {
              Project project = temporary[i];
              // 获取项目下的路灯
              await getDeviceLampList(project.title, loginInfo.data.token.token);
              // 获取项目下的电箱
              await  getDeviceEbox(project.title, loginInfo.data.token.token);
            }
          }
        });

      } else if (items[0] is Lamp) {
        _controller.clearMarkers(_markers);

        // 批量添加路灯覆盖物
        List<MarkerOption> markerOptions = List();
        for (int i = 0; i < items.length; ++i) {
          Lamp lamp = items[i];
          if (lamp.lAT == "" || lamp.lNG == "") {
            print('   ${lamp.nAME} 坐标为空');
            continue;
          }

          MarkerOption markerOption = new MarkerOption(
            latLng: new LatLng(double.parse(lamp.lAT), double.parse(lamp.lNG)),
            title: '${lamp.nAME}',
            snippet: '${lamp.pROJECT}',
            iconUri: selectImagesByType(int.parse('${lamp.tYPE}'),double.parse('${lamp.firDimming??0}')),
            imageConfig: createLocalImageConfiguration(_context),
            object:  json.encode(lamp),
          );

          markerOptions.add(markerOption);
        }

        // 批量添加电箱覆盖物
        if (eboxs != null && eboxs.length > 0) {

          for (var i = 0; i < eboxs.length; ++i) {
            Ebox ebox = eboxs[i];
            if (ebox.lAT == "" || ebox.lNG == "") {
              print('   ${ebox.nAME} 坐标为空');
              continue;
            }

            MarkerOption markerOption = new MarkerOption(
              latLng: new LatLng(double.parse(ebox.lAT), double.parse(ebox.lNG)),
              title: '${ebox.nAME}',
              snippet: '${ebox.pROJECT}',
              iconUri: selectImagesByType(int.parse('${ebox.tYPE}'),double.parse('${ebox.firDimming??0}')),
              imageConfig: createLocalImageConfiguration(_context),
              object:  json.encode(ebox),
            );
            markerOptions.add(markerOption);
          }
        }else{
          print('xxxxxxxxxxxxxxxxxxxxx  eboxs = null');
        }

       await _controller?.addMarkers(markerOptions)?.then(_markers.addAll);


        // 修改展开状态
        isUnfold = true;
        // 重新定位
        //   relocation();
        // 缩放中心点位置
        _controller?.zoomToSpan(
          [
            new LatLng(double.parse((items[0] as Lamp).lAT),
                double.parse((items[0] as Lamp).lNG))
          ],
          padding: EdgeInsets.only(
            top: 100,
          ),
        );
      }
    }
  }

  void relocation() async {
    Stream.fromIterable(_markers)
        .asyncMap((marker) => marker.location)
        .toList()
        .then((boundary) {
      debugPrint('boundary: $boundary');
      return _controller?.zoomToSpan(
        boundary,
        padding: EdgeInsets.only(
          top: 10,
        ),
      );
    });
  }

  addItem(var item) async {
    if (item is Project) {
      try {
        Project project = item;
        final marker = await _controller?.addMarker(
          MarkerOption(
            latLng:
                LatLng(double.parse(project.lat), double.parse(project.lng)),
            title: project.title,
            snippet: '描述',
            iconUri: Uri.parse('images/bian.png'),
            imageConfig: createLocalImageConfiguration(_context),
            width: 48,
            height: 48,
            object: json.encode(project.lamps),
          ),
        );
      } on Exception catch (err) {
        // Handle err
      } catch (err) {
        // other types of Exceptions
      }
    }
  }

  /**
   *  海量添加方式调用
   */
  List<PointOption> getPointOverlayList(items) {
    List<PointOption> pointList = List();
    for (int i = 0; i < items.length; ++i) {
      Lamp lamp = items[i];
      if (lamp.lAT == "" || lamp.lNG == "") {
        print('   ${lamp.nAME} 坐标为空');
        continue;
      }

      pointList.add(PointOption(
        latLng: LatLng(double.parse(lamp.lAT), double.parse(lamp.lNG)),
        id: i.toString(),
        title: '${lamp.nAME}',
        snippet: '${lamp.pROJECT}',
        object: json.encode(lamp),
      ));
    }

    return pointList;
  }

  Uri selectImagesByType(int tYPE, double brightness) {
    if (tYPE == 1) {
      // 电箱
      return Uri.parse('images/ebox.png');
    } else if (tYPE == 2) {
      // 路灯
      if(brightness != 0){
        return Uri.parse('images/light_on.png');
      }else{
        return Uri.parse('images/light_off.png');
      }
    } else if (tYPE == 3) {
      // 未知
      return Uri.parse('images/ebox.png');
    } else {
      // 报警器
      return Uri.parse('images/test_icon.png');
    }
  }

  /**
   *  获取项目下的路灯列表
   */
  getDeviceLampList(String title, token) {
    var param = "{\"where\":{\"PROJECT\":\"" + title + "\"},\"size\":1000}";

    DioUtils.requestHttp(
      servicePath['DEVICE_LAMP_LIST_URL'],
      parameters: param,
      token: token,
      method: DioUtils.POST,
      onSuccess: (String data) {
        // 解析 json
        var jsonstr = json.decode(data);
        // print('getDeviceLampList title $title = $data');
        print('getDeviceLampList title $title ');

        LampInfo lampInfo = LampInfo.fromJson(jsonstr);
        lampMap[title] = lampInfo.data.lamp;
      },
      onError: (error) {
        print(' DioUtils.requestHttp error = $error');
      },
    );
  }


  /**
   *  获取项目下的电箱
   */
  getDeviceEbox(String title, token)  {
    var param = "{\"where\":{\"PROJECT\":\"" + title + "\"},\"size\":1000}";

      DioUtils.requestHttp(
      servicePath['DEVICE_EBOX_URL'],
      parameters: param,
      token: token,
      method: DioUtils.POST,
      onSuccess: (String data) {

        try{
          // 解析 json
          var jsonstr = json.decode(data);
          EboxInfo lampInfo = EboxInfo.fromJson(jsonstr);
          if(!lampInfo.data.ebox?.isEmpty){
            eboxMap[title] = lampInfo.data.ebox;
          }
        }catch(e){
          print('解析出错 ${e.toString()}');
        }


      },
      onError: (error) {
        print(' DioUtils.requestHttp error = $error');
      },
    );
  }

}


