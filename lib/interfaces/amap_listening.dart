
import 'package:amap_map_fluttify/amap_map_fluttify.dart';

abstract class AMapListening{
  // 触摸监听
  void mapMoveListener(MapMove move);
  // 覆盖物状态监听 （展开状态）
  void mapMarkerStartListener(bool isUnfold);
}