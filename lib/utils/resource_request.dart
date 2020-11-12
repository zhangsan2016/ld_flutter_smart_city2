

import 'dart:convert';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/entity/json/device_list.dart';
import 'dio_utils.dart';

class ResourceRequest{



  static  deviceList<T>(String title, token,Function(DeviceList) onSuccess) async{

    var param = "{\"where\":{\"PROJECT\":\"" + title + "\"},\"size\":1000}";

    DioUtils.requestHttp(
      Api.instance.getServicePath('DEVICE_LIST_URL'),
      parameters: param,
      token: token,
      method: DioUtils.POST,
      onSuccess: (String data) {

        var jsonstr = json.decode(data);
        DeviceList deviceList = DeviceList.fromJson(jsonstr);
        onSuccess(deviceList);

      },
      onError: (error) {
        print(' DioUtils.requestHttp error = $error');
      },
    );

  }







}