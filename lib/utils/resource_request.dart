

import 'dart:convert';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/entity/json/device_list.dart';
import 'dio_utils.dart';

class ResourceRequest{



  static  deviceList<T>(String title, token,Function(DeviceList) onSuccess) async{

    var param = "{\"where\":{\"PROJECT\":\"" + title + "\"},\"size\":1000}";

    DioUtils.requestHttp(
      servicePath['DEVICE_LIST_URL'],
      parameters: param,
      token: token,
      method: DioUtils.POST,
      onSuccess: (String data) {

        try {

          var jsonstr = json.decode(data);
          DeviceList deviceList = DeviceList.fromJson(jsonstr);
          onSuccess(deviceList);

        } catch (e) {
          throw e;
          print('解析出错 ${e.toString()}');
        }
      },
      onError: (error) {
        print(' DioUtils.requestHttp error = $error');
      },
    );

  }







}