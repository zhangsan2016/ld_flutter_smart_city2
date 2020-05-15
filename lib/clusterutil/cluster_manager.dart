import 'dart:convert';
import 'dart:ffi';

import 'package:amap_core_fluttify/amap_core_fluttify.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/cupertino.dart';
import 'package:ldfluttersmartcity2/entity/lamp_info.dart';
import 'package:ldfluttersmartcity2/entity/project_info.dart';

import 'overlay_item.dart';

class ClusterManager {
  AmapController _controller;
  BuildContext _context;
  bool isUnfold = false; // 是否展开

  ClusterManager(BuildContext context, AmapController controller) {
    this._context = context;
    this._controller = controller;

    init();
  }

  Future init() async {

    // marker 点击事件
    _controller?.setMarkerClickedListener((marker) async {
      print(
          '${await marker.title}, ${await marker.snippet}, ${await marker.location}, ${await marker.object}');
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


     List  jsonstr = json.decode(await marker.object);
      List<Lamp> lamps = jsonstr.map((m) => new Lamp.fromJson(m)).toList();


     print('xxxx');

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
          if (!isUnfold) {
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
    if (items != null && items.length > 0) {
      if (items[0] is Project) {
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
      } else if (items[0] is Lamp) {
        for (int i = 0; i < items.length; ++i) {
          Lamp lamp = items[i];
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
          _markers.add(marker);
        }
      }
    }
  }

  Uri selectImagesByType(int tYPE) {
    if (tYPE == 1) {
      return Uri.parse('images/light_on.png');
    } else if (tYPE == 2) {
      return Uri.parse('images/ebox.png');
    } else {
      return Uri.parse('images/light_on.png');
    }
  }
}
