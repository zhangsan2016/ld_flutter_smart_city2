import 'package:amap_core_fluttify/src/facade/models.dart';

import 'cluster_item.dart';

/**
 * 每个Marker点，包含Marker点坐标以及图标
 */
 class MyItem extends  ClusterItem {
    final LatLng mPosition;
    final String bitmapPath;

  MyItem(this.mPosition, this.bitmapPath);

  @override
  LatLng getPosition() {
    return  mPosition;
  }

  @override
  String getBitmapPath() {
    return bitmapPath;
  }



}