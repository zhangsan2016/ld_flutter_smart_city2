import 'dart:convert';

import 'package:amap_core_fluttify/amap_core_fluttify.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/cupertino.dart';
import 'package:ldfluttersmartcity2/entity/lamp_info.dart';
import 'package:ldfluttersmartcity2/entity/project_info.dart';

import 'overlay_item.dart';

class ClusterManager<T extends OverlayItem>{

  AmapController _controller;
  BuildContext _context;
  bool unfold = false;  // 是否展开

  ClusterManager(BuildContext context,AmapController controller){
    this._context = context;
    this._controller = controller;

    _controller?.setMarkerClickedListener((marker) async {

      print(
          '${await marker.title}, ${await marker.snippet}, ${await marker.location}, ${await marker.object}');
     // _controller.clearMarkers(_markers);

      var jsonstr =  json.decode(await marker.object);
      Project  project = Project.fromJson(jsonstr);
      print('project = ${project.title}   ${project is Project}   ${project is Lamp} ');

      return true;
    });
  }


  // 当前显示的 marker 列表
  List<Marker> _markers = [];

  void addItem(List<Project> projects) async {

    for (int i = 0; i < projects.length; ++i) {
      Project project = projects[i];


      final marker =  await _controller?.addMarker(
        MarkerOption(
          latLng: LatLng(double.parse(project.lat), double.parse(project.lng)),
          title: project.title,
          snippet: '描述',
          iconUri: Uri.parse('images/bian.png'),
          imageConfig: createLocalImageConfiguration(_context),
          width: 48,
          height: 48,
          object:json.encode(project),
        ),
      );

       _markers.add(marker);
    }
  }



}