import 'dart:convert';

import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ldfluttersmartcity2/entity/json/alarm_apparatus_info.dart';
import 'package:ldfluttersmartcity2/entity/json/device_list.dart';
import 'package:ldfluttersmartcity2/entity/json/ebox%20_info.dart';
import 'package:ldfluttersmartcity2/entity/json/lamp_info.dart';
import 'package:ldfluttersmartcity2/entity/json/login_Info.dart';
import 'package:ldfluttersmartcity2/entity/json/project_info.dart';
import 'package:ldfluttersmartcity2/interfaces/amap_listening.dart';
import 'package:ldfluttersmartcity2/pages/lamp_page.dart';
import 'package:ldfluttersmartcity2/utils/icon_select_util.dart';
import 'package:ldfluttersmartcity2/utils/resource_request.dart';
import 'package:ldfluttersmartcity2/utils/shared_preference_util.dart';
import 'package:oktoast/oktoast.dart';


class ClusterManager {
  static final int DEVICE_EBOX = 1; // 电箱（集中器）
  static final int DEVICE_LAMP = 2; // 路灯
  static final int DEVICE_WIRESAFE = 4; // 断缆报警器

  AmapController _controller;
  BuildContext _context;
  AMapListening listening;

  // 是否展开
  bool isUnfold = false;

  // 当前用户下的项目数量
  int _projectCount;

  // 当前被选中（点击）的项目
  String currentTitle;

  // 项目路灯集合
  var lampMap = <String, List<Device>>{};

  // 项目电箱集合
  var eboxMap = <String, List<Device>>{};

  // 报警器集合
  var alarmApparatusMap = <String, List<Device>>{};

  // 当前定位的坐标（路灯详细界面定位）
  String currentLocation;

  /**
   * context 上下文
   * controller map 控制器
   * listening 地图监听
   */
  ClusterManager(BuildContext context, AmapController controller,
      AMapListening listening) {
    this._context = context;
    this._controller = controller;
    this.listening = listening;

    init();
  }

  bool showText = false;

  Future init() async {
    // marker 点击事件
    _controller?.setMarkerClickedListener((marker) async {
      //  print('${await marker.title}, ${await marker.snippet}, ${await marker.location}, ${await marker.object} ,${lampMap.length}');

      if (!isUnfold) {
        print('marker.title = ${await marker.title}');
        await addMapMarkers(await marker.title);
      } else {
        // 展开状态

        // 跳转到路灯控制界面
        String lampInfo = await marker.object;
        Navigator.push<String>(
          _context,
          new CupertinoPageRoute(
            builder: (BuildContext context) {
              return new LampPage(lampInfo);
            },
          ),
        );
      }

      return true;
    });

    // 地图移动监听
    _controller?.setMapMoveListener(
      onMapMoveStart: (move) async {
        MapMove mapMove = move;
      },
      onMapMoveEnd: (move) async {
        MapMove mapMove = move;
        print('MapMoveListener move = ${move.zoom}');

        if (move.zoom < 5) {
          if (isUnfold) {
            addItems(projects);
          }
        }
        /*else {
          if (move.zoom >= 19.5 && currentTitle != null && !showText) {
            showText = true;
            // 地图缩放到指定大小后显示灯杆名称
            print('currentTitle = $currentTitle b = $showText');
            // 获取项目对应的路灯列表
            List<Lamp> lamp = lampMap[currentTitle];
            // 获取项目对应的电箱
            List<Ebox> ebox = eboxMap[currentTitle];
            // 获取项目对应的报警器
            List<AlarmApparatus> alarmApparatus = alarmApparatusMap[currentTitle];
            displayMarkersText(lamp, ebox, alarmApparatus);
          }
        }*/
      },
    );
  }

  Future addMapMarkers(String title) async {
    // 获取项目对应的路灯列表
    List<Device> lamp = lampMap[title];
    // 获取项目对应的电箱
    List<Device> ebox = eboxMap[title];
    // 获取项目对应的报警器
    List<Device> alarmApparatus = alarmApparatusMap[title];
    // 判断是否有路灯数据
    if (lamp == null) {
      showToast('当前${title}项目没有获取到列表~', position: ToastPosition.bottom);
    }
    // 添加覆盖物
    await addItems(lamp, eboxs: ebox, alarmApparatus: alarmApparatus);
    currentTitle = title;
  }

  // 当前显示的 marker 列表
  List<Marker> _markers = new List();
  var _markerMap = <String, Marker>{};

  // 项目列表
  List<Project> projects;

  // 键值对方式获取当前某个Marker
  Marker getMarker(String location) {
    return _markerMap[location];
  }

  // 获取当前title
  String getCurrentTitle() {
    return currentTitle;
  }

  /**
   * 添加覆盖物
   * items : 覆盖物列表
   * eboxs ： 当前项目的电箱列表
   * alarmApparatus ：当前项目的报警器列表
   */
  void addItems(List items, {eboxs, alarmApparatus}) async {
    List temporary;
    if (items != null && items.length > 0) {
      if (items[0] is Project) {
        // 克隆一份列表
        temporary = new List<Project>.from(items);
        _controller.clearMarkers(_markers);
        _markers.clear();
        _markerMap.clear();
        //  await _controller.clear();
        projects = items;
        for (int i = 0; i < items.length; ++i) {
          Project project = items[i];

          print('loginInfo = ${project.title}  ${project.lng}  ${project.lat}');

          final marker = await _controller?.addMarker(
            MarkerOption(
              latLng:
                  LatLng(double.parse(project.lat), double.parse(project.lng)),
              title: project.title,
              // snippet: '描述',
              iconUri: Uri.parse('images/bian.png'),
              imageConfig: createLocalImageConfiguration(_context),
              width: ScreenUtil().setWidth(48),
              height: ScreenUtil().setHeight(48),
              object: json.encode(project.lamps),
            ),
          );
          _markers.add(marker);
        }
        // 展开状态为 false
        isUnfold = false;

        // 获取项目中的设备列表
        getDeviceList(temporary: temporary);
      } else if (items[0] is Device) {
        // 添加地图路灯覆盖物
        await addLampMarkers(items, eboxs, alarmApparatus);
      }
    }

    // 返回 覆盖物状态回调
    if (listening != null) {
      listening.mapMarkerStartListener(isUnfold);
    }
  }

  /**
   *   获取设备列表（包含路灯、电箱、报警器）
   *   temporary 当前用户下所有的项目
   *   title 指定项目
   */
  void getDeviceList({List temporary, String title}) {
    // 获取项目中的路灯
    SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
      if (temporary != null && temporary.length > 0) {
        // 解析 json
        var data = json.decode(val);
        LoginInfo loginInfo = LoginInfo.fromJson(data);

        if (title != null) {
          // 解析当前项目设备，根据类型分类（包含电箱、路灯、控制器）
          parseDevice(val, title);
        } else {
          for (var i = 0; i < temporary.length; ++i) {
            Project project = temporary[i];

            ResourceRequest.deviceList(
                project.title, loginInfo.data.token.token, (DeviceList val) {
              // 解析当前项目设备，根据类型分类（包含电箱、路灯、控制器）
              parseDevice(val, project.title);
            });
          }
        }
      }
    });
  }

  /**
   * 解析当前项目设备，根据类型分类（包含电箱、路灯、控制器）
   */
  void parseDevice(DeviceList val, title) {
    List<Device> eboxList = new List();
    List<Device> lampList = new List();
    List<Device> alarmList = new List();

    for (Device device in val.device) {
      if (device.tYPE == 1) {
        eboxList.add(device);
      } else if (device.tYPE == 2) {
        lampList.add(device);
      } else if (device.tYPE == 4) {
        alarmList.add(device);
      }
    }

    if (eboxList.length > 0) {
      eboxMap[title] = eboxList;
    }
    if (lampList.length > 0) {
      lampMap[title] = lampList;
    }
    if (eboxList.length > 0) {
      alarmApparatusMap[title] = alarmList;
    }

    // 如果当前是唯一的项目就跳转到路灯位置
    if (_projectCount == 1) {
      addMapMarkers(title);
    }
  }

  /**
   *  添加地图路灯覆盖物
   *  item 路灯列表
   *  ebox 电箱列表
   *  alarmApparatus 报警器列表
   */
  Future addLampMarkers(List items, eboxs, alarmApparatus) async {
    _controller.clearMarkers(_markers);
    _markers.clear();

    // 中心点经纬度，在地图路灯集合中定位
    LatLng centralLatLng = null;
    // 批量添加路灯覆盖物
    List<MarkerOption> markerOptions = List();

    for (int i = 0; i < items.length; ++i) {
      Device lamp = items[i];
      if (lamp.lAT == "" || lamp.lNG == "") {
        print('   ${lamp.nAME} 坐标为空');
        continue;
      }

      if (centralLatLng == null) {
        centralLatLng =
            new LatLng(double.parse(lamp.lAT), double.parse(lamp.lNG));
      }

      MarkerOption markerOption = new MarkerOption(
        /*   widget: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('${(level <= 19.5 ? lamp.nAME:null)}'),
            Image.asset(
              "${selectImagesByType(int.parse('${lamp.tYPE}'), double.parse('${lamp.firDimming ?? 0}'), lamp.warningState ?? 0)}",
              fit: BoxFit.cover,
            ),
          ],
        ),*/
        latLng: new LatLng(double.parse(lamp.lAT), double.parse(lamp.lNG)),
        // title: '${lamp.nAME}',
        // snippet: '${lamp.pROJECT}',
        iconUri: selectImagesByType(int.parse('${lamp.tYPE}'),
            double.parse('${lamp.firDimming ?? 0}'), lamp.warningState ?? 0),
        imageConfig: createLocalImageConfiguration(_context),
        object: json.encode(lamp),
      );

      // 是否允许弹窗
      // markerOption.infoWindowEnabled;
      markerOptions.add(markerOption);
    }

    // 批量添加电箱覆盖物
    if (eboxs != null && eboxs.length > 0) {
      for (var i = 0; i < eboxs.length; ++i) {
        Device ebox = eboxs[i];
        if (ebox.lAT == "" || ebox.lNG == "") {
          print('   ${ebox.nAME} 坐标为空');
          continue;
        }

        MarkerOption markerOption = new MarkerOption(
          latLng: new LatLng(double.parse(ebox.lAT), double.parse(ebox.lNG)),
          title: '${ebox.nAME}',
          snippet: '${ebox.pROJECT}',
          iconUri: selectImagesByType(int.parse('${ebox.tYPE}'),
              double.parse('${ebox.firDimming ?? 0}'), 0),
          imageConfig: createLocalImageConfiguration(_context),
          object: json.encode(ebox),
        );
        markerOptions.add(markerOption);
      }
    } else {}

    // 批量添加报警器覆盖物
    if (alarmApparatus != null && alarmApparatus.length > 0) {
      for (var i = 0; i < alarmApparatus.length; ++i) {
        Device alarm = alarmApparatus[i];
        if (alarm.lAT == "" || alarm.lNG == "") {
          print('   ${alarm.nAME} 坐标为空');
          continue;
        }

        MarkerOption markerOption = new MarkerOption(
          latLng: new LatLng(double.parse(alarm.lAT), double.parse(alarm.lNG)),
          title: '${alarm.nAME}',
          snippet: '${alarm.pROJECT}',
          iconUri: selectImagesByType(int.parse('${alarm.tYPE}'), double.parse('${alarm.firDimming ?? 0}'), alarm.warningState ?? 0),
          imageConfig: createLocalImageConfiguration(_context),
          object: json.encode(alarm),
        );
        markerOptions.add(markerOption);
      }
    } else {}
    await _controller?.addMarkers(markerOptions)?.then(_markers.addAll);



    // 判断展开状态
    if (!isUnfold) {

      // 修改展开状态
      isUnfold = true;

      // 重新定位
      //   relocation();

      // 缩放中心点位置
      /*_controller?.zoomToSpan(
      [
        new LatLng(double.parse((items[0] as Lamp).lAT),
            double.parse((items[0] as Lamp).lNG))
      ],
      padding: EdgeInsets.only(
        top: 100,
      ),
    );*/

      // 设置中心点
      if (centralLatLng != null) {
        _controller?.setCenterCoordinate(
          centralLatLng,
          animated: false,
          zoomLevel: 19,
        );
      }

    }

    // 保存marker到键值对列表
    for (var ma in _markers) {
      LatLng latLng = await ma.location;
      _markerMap['${latLng.latitude},${latLng.longitude}'] = ma;
    }




  }


  /**
   * 修改marker图标，string地址从键值对集合中获取
   */
  updateMarkerIco(String location) async {
    List<MarkerOption> markerOptions = List();
    if (currentLocation != location) {
      // 先把上一个图标更换回来
      Marker preMarker = getMarker(currentLocation);
      if (preMarker != null) {
        Lamp l = Lamp.fromJson(json.decode(await preMarker.object));
        await preMarker.remove();
        MarkerOption preMarkerOption = new MarkerOption(
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                "${selectImagesByType(int.parse('${l.tYPE}'), double.parse('${l.firDimming ?? 0}'), l.warningState ?? 0)}",
                fit: BoxFit.contain,
                width: 38,
                height: 38,
              ),
            ],
          ),
          latLng: new LatLng(double.parse(l.lAT), double.parse(l.lNG)),
          title: '${l.nAME}',
          snippet: '${l.pROJECT}',
          // imageConfig: createLocalImageConfiguration(_context),
          object: json.encode(l),
        );
        markerOptions.add(preMarkerOption);

      }

      // 更换当前图标
      Marker cuMarker = getMarker(location);
      if (cuMarker != null) {
        Lamp l = Lamp.fromJson(json.decode(await cuMarker.object));
        await cuMarker.remove();
        MarkerOption cuMarkerOption =   MarkerOption(
          latLng: new LatLng(double.parse(l.lAT), double.parse(l.lNG)),
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              Text(
                '${l.nAME}',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Image.asset(
                "${selectIcon(int.parse('${l.tYPE}'))}",
                // "${Uri.parse('images/wiresafe_selected.png')}",
                fit: BoxFit.contain,
                width: 38,
                height: 38,
                //  fit: BoxFit.contain,
              ),

            ],
          ),
          imageConfig: createLocalImageConfiguration(_context),
          title: '${l.nAME}',
          snippet: '${l.pROJECT}',
          object: json.encode(l),
        );

        markerOptions.add(cuMarkerOption);


        MarkerOption typeop =   MarkerOption(
          latLng: new LatLng(double.parse(l.lAT), double.parse(l.lNG)),
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[


              Image.asset(
                "${selectIcon(int.parse('${l.tYPE}'))}",
                // "${Uri.parse('images/wiresafe_selected.png')}",
                fit: BoxFit.contain,
                width: 38,
                height: 38,
                //  fit: BoxFit.contain,
              ),

            ],
          ),
          imageConfig: createLocalImageConfiguration(_context),
          title: '${l.nAME}',
          visible: false,
        );
        // bug 临时添加代码，后面会更新地图代码
        List<MarkerOption> temp = List();
        temp.add(typeop);
        await _controller?.addMarkers(temp)?.then((List<Marker> ml) async {
          for (var ma in ml) {
            ma.remove();
          }
        });

      }



      // 保存当前覆盖物
     await _controller?.addMarkers(markerOptions)?.then((List<Marker> ml) async {
        // 设置当前的定位的位置
        currentLocation = location;
        _markers.addAll(ml);
        // 保存marker到键值对列表
        for (var ma in ml) {
          LatLng latLng = await ma.location;
          String key = '${latLng.latitude},${latLng.longitude}';
          _markerMap[key] = ma;

        }
      });


    }

    //_controller?.addMarkers(markerOptions);
  }




  displayMarkersText(List items, eboxs, alarmApparatus) async {
    // 批量添加路灯覆盖物
    List<MarkerOption> markerOptions = List();
    for (int i = 0; i < items.length; ++i) {
      Device lamp = items[i];
      if (lamp.lAT == "" || lamp.lNG == "") {
        print('   ${lamp.nAME} 坐标为空');
        continue;
      }

      // 清空当前地图覆盖物
      _controller.clearMarkers(_markers);
      _markers.clear();
      MarkerOption markerOption = new MarkerOption(
        widget: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '${lamp.nAME}',
              style: TextStyle(color: Color.fromARGB(255, 0, 186, 179)),
            ),
            Image.asset(
              "${selectImagesByType(int.parse('${lamp.tYPE}'), double.parse('${lamp.firDimming ?? 0}'), lamp.warningState ?? 0)}",
              fit: BoxFit.contain,
              width: 38,
              height: 38,
            ),
          ],
        ),
        latLng: new LatLng(double.parse(lamp.lAT), double.parse(lamp.lNG)),
        imageConfig: createLocalImageConfiguration(_context),
        //  title: '${lamp.nAME}',
        // snippet: '${lamp.pROJECT}',
        //iconUri: selectImagesByType(int.parse('${lamp.tYPE}'), double.parse('${lamp.firDimming ?? 0}'),lamp.warningState??0),
        // imageConfig: createLocalImageConfiguration(_context),
        object: json.encode(lamp),
      );

      markerOptions.add(markerOption);
    }

    // 批量添加电箱覆盖物
    if (eboxs != null && eboxs.length > 0) {
      for (var i = 0; i < eboxs.length; ++i) {
        Ebox ebox = eboxs[i];
        if (ebox.lAT == "" || ebox.lNG == "") {
          print('   ${ebox.nAME} 坐标为空');
          continue;
        }

        MarkerOption markerOption = new MarkerOption(
          latLng: new LatLng(double.parse(ebox.lAT), double.parse(ebox.lNG)),
          title: '${ebox.nAME}',
          snippet: '${ebox.pROJECT}',
          iconUri: selectImagesByType(int.parse('${ebox.tYPE}'),
              double.parse('${ebox.firDimming ?? 0}'), 0),
          imageConfig: createLocalImageConfiguration(_context),
          object: json.encode(ebox),
        );
        markerOptions.add(markerOption);
      }
    } else {}

    // 批量添加报警器覆盖物
    if (alarmApparatus != null && alarmApparatus.length > 0) {
      for (var i = 0; i < alarmApparatus.length; ++i) {
        AlarmApparatus alarm = alarmApparatus[i];
        if (alarm.lAT == "" || alarm.lNG == "") {
          print('   ${alarm.nAME} 坐标为空');
          continue;
        }

        MarkerOption markerOption = new MarkerOption(
          latLng: new LatLng(double.parse(alarm.lAT), double.parse(alarm.lNG)),
          title: '${alarm.nAME}',
          snippet: '${alarm.pROJECT}',
          iconUri: selectImagesByType(int.parse('${alarm.tYPE}'), 0, alarm.warningState ?? 0),
          imageConfig: createLocalImageConfiguration(_context),
          object: json.encode(alarm),
        );
        markerOptions.add(markerOption);
      }
    } else {}

    _controller?.addMarkers(markerOptions)?.then(_markers.addAll);
    // 展开状态为 true
    isUnfold = true;
  }

  /**
   * 重置
   */
  void relocation() async {
    /* Stream.fromIterable(_markers)
        .asyncMap((marker) => marker.location)
        .toList()
        .then((boundary) {
      debugPrint('boundary: $boundary');
      return _controller?.zoomToSpan(
        boundary,
        padding: EdgeInsets.only(
          top: 10,
        ),
      );
    });*/

    // 清除当前定位坐标
    currentLocation = null;
    // 回到项目界面
    if (projects != null) {
      List<LatLng> bounds = new List();
      for (int i = 0; i < projects.length; ++i) {
        Project project = projects[i];
        bounds.add(
            new LatLng(double.parse(project.lat), double.parse(project.lng)));
      }
      return _controller?.zoomToSpan(
        bounds,
        padding: EdgeInsets.all(100),
      );
    } else {
      showToast('当前没有项目列表,请检查网络！', position: ToastPosition.bottom);
    }
  }

  /**
   * 刷新
   */
  void refresh() {
    if (isUnfold) {
      // 清空当前定位
      currentLocation = null;
      // 清空列表
      _markerMap.clear();
      // 获取项目中的路灯
      getDeviceList(title: currentTitle);
      addMapMarkers(currentTitle);
    }
  }

  addItem(var item) async {
    if (item is Project) {
      try {
        Project project = item;
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
      } on Exception catch (err) {
        // Handle err
      } catch (err) {
        // other types of Exceptions
      }
    }
  }

  /**
   *  海量添加方式调用
   */
  List<PointOption> getPointOverlayList(items) {
    List<PointOption> pointList = List();
    for (int i = 0; i < items.length; ++i) {
      Lamp lamp = items[i];
      if (lamp.lAT == "" || lamp.lNG == "") {
        print('   ${lamp.nAME} 坐标为空');
        continue;
      }

      pointList.add(PointOption(
        latLng: LatLng(double.parse(lamp.lAT), double.parse(lamp.lNG)),
        id: i.toString(),
        title: '${lamp.nAME}',
        snippet: '${lamp.pROJECT}',
        object: json.encode(lamp),
      ));
    }

    return pointList;
  }


  /**
   *  当前登录用户管理的项目数量
   */
  set projectCount(int value) {
    _projectCount = value;
  }
}
