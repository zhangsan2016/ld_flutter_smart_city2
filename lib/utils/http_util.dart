// 通用网络获取数据方法
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ldfluttersmartcity2/config/service_url.dart';

Future request(url, {formData}) async {
  try {
    print('开始获取数据......');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = "application/x-www-form-urlencoded";
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常。');
    }
  } catch (e) {
    return print('Error: ==============${e}');
  }
}

