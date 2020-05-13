


import 'package:amap_core_fluttify/amap_core_fluttify.dart';

import 'overlay_item.dart';

class LampOverlay extends OverlayItem {
  LatLng mPosition;
  String bitmapPath;
  Object _info;


  LampOverlay(this.mPosition, this.bitmapPath);

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
}