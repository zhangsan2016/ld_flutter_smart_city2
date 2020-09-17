import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/entity/json/device_list.dart';
import 'package:ldfluttersmartcity2/entity/json/login_Info.dart';
import 'package:ldfluttersmartcity2/utils/dio_utils.dart';
import 'package:ldfluttersmartcity2/utils/shared_preference_util.dart';

class SearchResults extends StatefulWidget {
  final String query;
  var currentProject;

  SearchResults(this.query, this.currentProject);

  @override
  State<StatefulWidget> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  DeviceList deviceList = null;

  // 搜索结果
  List<Device> searchList = [];

  @override
  void initState() {
    super.initState();
    search();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[

        /*  Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: SizedBox(
                width: 24.0,
                height: 24.0,
                child: CircularProgressIndicator(strokeWidth: 2.0) // 加载转圈
                ),
          ),*/
          Expanded(
            // ignore: missing_return
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                Device device = searchList[index];
                return Container(
                    child: InkWell(
                        onTap: () {
                          print(
                              'inkwell（${device.nAME}） 被点击');
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
  }

  void search() async {
    if (deviceList == null) {
      _receiveList();
    } else {
      searchList.clear();
        String keyword = widget.query;
        for (Device d in deviceList.device) {
          if (d.nAME.contains(keyword) || d.uUID.contains(keyword)) {
            searchList.add(d);
          }
        }
        setState(() {});
    }
  }

  void _receiveList() async {
    SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
      // 解析 json
      var data = json.decode(val);
      LoginInfo loginInfo = LoginInfo.fromJson(data);

      var param = "{\"where\":{\"PROJECT\":\"" +
          widget.currentProject +
          "\"},\"size\":1000}";


      DioUtils.requestHttp(
        servicePath['DEVICE_LIST_URL'],
        parameters: param,
        token: loginInfo.data.token.token,
        method: DioUtils.POST,
        onSuccess: (String data) {
          try {
            var jsonstr = json.decode(data);
            deviceList = DeviceList.fromJson(jsonstr);
            search();
          } catch (e) {
            throw e;
            print('解析出错 ${e.toString()}');
          }
        },
        onError: (error) {
          print(' DioUtils.requestHttp error = $error');
        },
      );
    });
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


}
