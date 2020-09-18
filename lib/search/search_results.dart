import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/entity/json/device_list.dart';
import 'package:ldfluttersmartcity2/entity/json/login_Info.dart';
import 'package:ldfluttersmartcity2/pages/lamp_page.dart';
import 'package:ldfluttersmartcity2/provide/device_search_provide.dart';
import 'package:ldfluttersmartcity2/utils/dio_utils.dart';
import 'package:ldfluttersmartcity2/utils/shared_preference_util.dart';
import 'package:provider/provider.dart';

class SearchResults extends StatefulWidget {
  final String query;
  String currentProject;

  SearchResults(this.query, this.currentProject);

  @override
  State<StatefulWidget> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  void initState() {
    super.initState();
    // 搜索关键字
    searchKeyword();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<DeviceSearchProvide>(builder: (context, counter, _) {

      print('Consumer = Consumer<DeviceSearchProvide>(builder: (context, counter, _) 执行');

      List<Device> searchList = Provider.of<DeviceSearchProvide>(context, listen: false).searchList;
      print('searchList = ${searchList.length}');


      if (searchList != null) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    Device device = searchList[index];
                    return Container(
                        child: InkWell(
                            onTap: () {
                              print('inkwell（${device.nAME}） 被点击');
                              // json.decode(await cuMarker.object)

                              // 跳转到路灯控制界面
                              String lampInfo = json.encode(device);
                              Navigator.push<String>(
                                context,
                                new CupertinoPageRoute(
                                  builder: (BuildContext context) {
                                    return new LampPage(lampInfo);
                                  },
                                ),
                              );
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 30.0,
                                  width: 30.0,
                                  margin: const EdgeInsets.all(16.0),
                                  child: Image.asset(
                                      "${selectImagesByType(device.tYPE, device.firDimming ?? 0, device.warningState ?? 0)}",
                                      fit: BoxFit.fill),
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text('${index + 1}.' + device.nAME),
                                    Text(device.uUID),
                                  ],
                                ),
                              ],
                            )));
                  },
                  itemCount: searchList.length,
                  separatorBuilder: (context, index) => Divider(
                    height: .0,
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: SizedBox(
              width: 24.0,
              height: 24.0,
              child: CircularProgressIndicator(strokeWidth: 2.0) // 加载转圈
          ),
        );
      }


    });
  }

  void searchKeyword() async {
    await Provider.of<DeviceSearchProvide>(context, listen: false).receiveList(widget.currentProject, widget.query);
  }
}

/**
 *  根据条件设置图标类型
 */
Uri selectImagesByType(int tYPE, double brightness, int warningState) {
  if (tYPE == 1) {
    // 电箱
    return Uri.parse('images/ebox.png');
  } else if (tYPE == 2) {
    // 路灯
    // 检查报警
    if (warningState != 0) {
      return Uri.parse('images/light_warning.png');
    }
    // 检查亮灯
    if (brightness != 0) {
      return Uri.parse('images/light_on.png');
    } else {
      return Uri.parse('images/light_off.png');
    }
  } else if (tYPE == 3) {
    // 未知
    return Uri.parse('images/ebox.png');
  } else {
    // 报警器
    return Uri.parse('images/test_icon.png');
  }
}
