import 'dart:convert';
import 'dart:math';

import 'package:amap_core_fluttify/amap_core_fluttify.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/cupertino.dart';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/entity/json/lamp_info.dart';
import 'package:ldfluttersmartcity2/entity/json/login_Info.dart';
import 'package:ldfluttersmartcity2/entity/json/project_info.dart';
import 'package:ldfluttersmartcity2/utils/dio_utils.dart';
import 'package:ldfluttersmartcity2/utils/shared_preference_util.dart';

import 'overlay_item.dart';

class ClusterManager {
  AmapController _controller;
  BuildContext _context;

  // 是否展开
  bool isUnfold = false;
  var lampMap = <String, List<Lamp>>{};

  ClusterManager(BuildContext context, AmapController controller) {
    this._context = context;
    this._controller = controller;

    init();
  }

  Future init() async {
    // marker 点击事件
    _controller?.setMarkerClickedListener((marker) async {
      print(
          '${await marker.title}, ${await marker.snippet}, ${await marker.location}, ${await marker.object} ,${lampMap.length}');
      // _controller.clearMarkers(_markers);

      /*  if(!isUnfold ){
        var jsonstr = json.decode(await marker.object);
        Project project = Project.fromJson(jsonstr);
        print('project = ${project.title}   ${project is Project}   ${project is Lamp} ');
      }*/

      /*  var jsonstr = json.decode(await marker.object);
      print('setMarkerClickedListener jsonstr = ${jsonstr}  $jsonstr');*/

      /*    var jsonstr = json.decode(await marker.object);
      List<Lamp> lamp = new List<Lamp>();
      jsonstr.forEach((v) {
        lamp.add(new Lamp.fromJson(v));
      });*/

      if (!isUnfold) {
        _controller.clear(keepMyLocation: false);
        List<Lamp> lamp = lampMap[await marker.title];
        addItems(lamp);
      }


      return true;
    });

    _controller?.setMapMoveListener(
      onMapMoveStart: (move) async {
        MapMove mapMove = move;
      },
      onMapMoveEnd: (move) async {
        MapMove mapMove = move;
        print('MapMoveListener move = ${move.zoom}');

        if (move.zoom > 6) {
          if (isUnfold) {
            addItems(projects);
          }
        }
      },
    );
  }

  // 当前显示的 marker 列表
  List<Marker> _markers = [];

  // 项目列表
  List<Project> projects;

  void addItems(List items) async {
    List temporary;
    if (items != null && items.length > 0) {
      if (items[0] is Project) {
        // 克隆一份列表
        temporary = new List<Project>.from(items);
        _controller.clearMarkers(_markers);
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
              await getDeviceLampList(
                  project.title, loginInfo.data.token.token);
            }
          }
        });
      } else if (items[0] is Lamp) {
        _controller.clearMarkers(_markers);
        /*  for (int i = 0; i < items.length; ++i) {
          Lamp lamp = items[i];
          if (lamp.lAT == "" || lamp.lNG == "") {
            print('   ${lamp.nAME} 坐标为空');
            continue;
          }

         final marker = await _controller?.addMarker(
            MarkerOption(
              latLng: LatLng(double.parse(lamp.lAT), double.parse(lamp.lNG)),
              title: lamp.tYPE.toString(),
              snippet: '描述',
              iconUri: selectImagesByType(lamp.tYPE),
              imageConfig: createLocalImageConfiguration(_context),
              width: 48,
              height: 48,
              //  object: json.encode(lamp),
            ),
          );

         // _markers.add(marker);
        }*/



       /* List pointOptions = await getPointOverlayList(items);
        await _controller?.addMultiPointOverlay(
          MultiPointOption(
            pointList: pointOptions,
            iconUri: null,
            imageConfiguration: createLocalImageConfiguration(_context),
            size: Size(48, 48),
          ),
        );
        await _controller?.setMultiPointClickedListener(
          (id, title, snippet, object) async {
            print(
              'id: $id, title: $title, snippet: $snippet, object: $object',
            );
          },
        );*/
        await _controller
            ?.addMultiPointOverlay(
              MultiPointOption(
                pointList: await getPointOverlayList(items),
                iconUri: selectImagesByType(2),
                imageConfiguration: createLocalImageConfiguration(_context),
                size: Size(48, 48),
              ),
            );


        await _controller?.setMultiPointClickedListener(
          (id, title, snippet, object) async {
            print(
              'id: $id, title: $title, snippet: $snippet, object: $object',
            );
          },
        );
        isUnfold = !isUnfold;
        // 重新定位
        relocation();

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
        title: '${lamp.tYPE}',
        snippet: 'Snippet$i',
        object: 'Object$i',
      ));
    }

    return pointList;
  }

  Uri selectImagesByType(int tYPE) {
    if (tYPE == 1) {
      return Uri.parse('images/light_on.png');
    } else if (tYPE == 2) {
      return Uri.parse('images/light_on.png');
    } else {
      return Uri.parse('images/ebox.png');
    }
  }

  /**
   *  获取项目下的路灯列表
   */
  getDeviceLampList(String title, token) {
    var param = "{\"where\":{\"PROJECT\":\"" + title + "\"},\"size\":5000}";

    DioUtils.requestHttp(
      servicePath['DEVICE_LAMP_LIST_URL'],
      parameters: param,
      token: token,
      method: DioUtils.POST,
      onSuccess: (String data) {
        // 解析 json
        var jsonstr = json.decode(data);
        print('getDeviceLampList title $title = $data');

        LampInfo lampInfo = LampInfo.fromJson(jsonstr);
        lampMap[title] = lampInfo.data.lamp;
      },
      onError: (error) {
        print(' DioUtils.requestHttp error = $error');
      },
    );
  }
}
