import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/entity/json/lamp_info.dart';
import 'package:ldfluttersmartcity2/entity/json/login_Info.dart';
import 'package:ldfluttersmartcity2/utils/dio_utils.dart';
import 'package:ldfluttersmartcity2/utils/shared_preference_util.dart';

class LampHistoryPage extends StatefulWidget {
  final String lampInfo;
  LampHistoryPage(this.lampInfo);

  @override
  _LampHistoryPageState createState() => _LampHistoryPageState(lampInfo);
}

class _LampHistoryPageState extends State<LampHistoryPage> {
  String lampInfo;
  Lamp _lamp;
  List<String> historys =[];

  _LampHistoryPageState(this.lampInfo);

  @override
  void initState() {

    if (lampInfo != null) {
      _lamp = Lamp.fromJson(json.decode(lampInfo));
    }
    _getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: new BoxDecoration(
        color: Color.fromARGB(240, 11, 29, 77),
      ),
     child: ListView.builder(
        // scrollDirection: Axis.horizontal,
       padding: EdgeInsets.only(top: 20.0),
         itemCount: historys.length,
         itemBuilder: (context, index) {
           return Container(
             padding: EdgeInsets.only(left: 15.0,right: 5.0,bottom: 15.0),
             child: Text(historys[index],style: TextStyle(fontSize: ScreenUtil().setSp(26),color: Colors.white),),
           );
         }),

    );
  }



  void _getHistory() async {
    // 获取项目中的路灯
    SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO)
        .then((val) async {

      var data = json.decode(val);
      LoginInfo loginInfo = LoginInfo.fromJson(data);

      var param = "{\"UUID\": \"${_lamp.uUID}\"}";

      DioUtils.requestHttp(
        servicePath['HISTORY_METRICS_URL'],
        parameters: param,
        token: loginInfo.data.token.token,
        method: DioUtils.POST,
        onSuccess: (String data) {
          // 解析 json
          var jsonstr = json.decode(data);
          if (jsonstr['data'] != null) {
            List list = new List<String>();
            jsonstr['data'].forEach((v) {
            //  print('v.toString() = ${v.toString()}');
              list.add(v.toString());
            });
            setState(() {
              historys = list;
            });
          }

        },
        onError: (error) {
          print(' DioUtils.requestHttp error = $error');
        },
      );

    });
  }



}
