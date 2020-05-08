import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/cupertino.dart';

class AmapPage extends StatefulWidget {
  @override
  createState() => AmapPageState();
}

class AmapPageState extends State<AmapPage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return AmapView(
      // 地图类型 (可选)
      mapType: MapType.Standard,
      // 是否显示缩放控件 (可选)
      showZoomControl: false,
      // 是否显示指南针控件 (可选)
      showCompass: false,
      // 是否显示比例尺控件 (可选)
      showScaleControl: false,
      // 是否使能缩放手势 (可选)
      zoomGesturesEnabled: true,
      // 缩放级别 (可选)
      zoomLevel: 4,
      // 中心点坐标 (可选)
      centerCoordinate: LatLng(34.070022, 109.617258),
      // 标记 (可选)
      markers: <MarkerOption>[],
      // 标识点击回调 (可选)
      onMarkerClicked: (Marker marker) {},
      // 地图点击回调 (可选)
      onMapClicked: (LatLng coord) {},
      // 地图创建完成回调 (可选)
      onMapCreated: (controller) async {
        // requestPermission是权限请求方法, 需要你自己实现
        // 如果不知道怎么处理, 可以参考example工程的实现, example工程依赖了`permission_handler`插件.
        /* if (await requestPermission()) {
          await controller.showMyLocation(MyLocationOption(show: true));
        }*/
      },
    );
  }
}
