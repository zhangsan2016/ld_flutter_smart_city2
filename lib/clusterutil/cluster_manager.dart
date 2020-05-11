import 'package:amap_core_fluttify/amap_core_fluttify.dart';

import 'cluster_item.dart';

class ClusterManager<T extends ClusterItem>{
  List<ClusterItem> item ;

  final LatLng mPosition;
  final String bitmapPath;

  ClusterManager(this.mPosition, this.bitmapPath);

  @override
  LatLng getPosition() {
    return  mPosition;
  }

  @override
  String getBitmapPath() {
    return bitmapPath;
  }


}