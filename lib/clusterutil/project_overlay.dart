import 'package:amap_core_fluttify/src/facade/models.dart';

import 'lamp_overlay.dart';
import 'overlay_item.dart';


class ProjectOverlay extends OverlayItem {
  LatLng mPosition;
  String bitmapPath;
  Object _info;
  // 路灯集
  List<LampOverlay> lampOverlays = List();


  ProjectOverlay(this.mPosition, this.bitmapPath);

  @override
  String getBitmapPath() {
    return bitmapPath;
  }

  @override
  LatLng getPosition() {
    return mPosition;
  }

  Object get info => _info;

  set info(Object value) {
    _info = value;
  }

  setlampOverlays(List<LampOverlay> lampOverlays){
    this.lampOverlays = lampOverlays;
  }

}