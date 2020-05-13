
import 'package:amap_core_fluttify/amap_core_fluttify.dart';

abstract class OverlayItem {

  // 坐标
  LatLng getPosition();

  // 图片地址
  String getBitmapPath();


}