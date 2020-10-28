

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/entity/json/device_list.dart';
import 'package:ldfluttersmartcity2/entity/json/login_Info.dart';
import 'package:ldfluttersmartcity2/utils/dio_utils.dart';
import 'package:ldfluttersmartcity2/utils/shared_preference_util.dart';

class DeviceSearchProvide with ChangeNotifier {
  DeviceList deviceList = null;
  // 搜索结果
  List<Device> searchList = [];
  // 当前项目名称
  String currentProject;


  void receiveList(String project,String query) async {

    if(currentProject != project){
      currentProject = project;
      deviceList = null;
    }

    if(deviceList == null){
      SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
        // 解析 json
        var data = json.decode(val);
        LoginInfo loginInfo = LoginInfo.fromJson(data);

        var param = "{\"where\":{\"PROJECT\":\"" +
            currentProject +
            "\"},\"size\":1000}";

        DioUtils.requestHttp(
          Api.instance.getServicePath('DEVICE_LIST_URL'),
          parameters: param,
          token: loginInfo.data.token.token,
          method: DioUtils.POST,
          onSuccess: (String data) {
            try {
              var jsonstr = json.decode(data);
              deviceList = DeviceList.fromJson(jsonstr);
              searchCurrentProject(query);
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
    }else{
      searchCurrentProject(query);
    }

  }


  /**
   *  根据关键字
   */
  searchCurrentProject(String query) {
      searchList.clear();
      String keyword = query;
      for (Device d in deviceList.device) {
        if (d.nAME.contains(keyword) || d.uUID.contains(keyword)) {
          searchList.add(d);
        }
      }
      notifyListeners();
    }

}