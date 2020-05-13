import 'package:amap_core_fluttify/amap_core_fluttify.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';

import 'overlay_item.dart';

class ClusterManager<T extends OverlayItem>{

  List<T> _item ;
  AmapController _controller;



  List<T> get item => _item;

  set item(List<T> value) {
    _item = value;
  }
}