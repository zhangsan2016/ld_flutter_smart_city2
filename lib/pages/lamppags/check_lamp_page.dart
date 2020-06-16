
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:ldfluttersmartcity2/entity/json/lamp_info.dart';

class CheckLampPage extends StatefulWidget {
  final String lampInfo;
  CheckLampPage(this.lampInfo);

  @override
  _CheckLampPageState createState() => _CheckLampPageState(lampInfo);
}

class _CheckLampPageState extends State<CheckLampPage> {
   String lampInfo;
   Lamp _lamp;
  _CheckLampPageState(this.lampInfo);

  @override
  Widget build(BuildContext context) {

    if(lampInfo!=null){
      _lamp =  Lamp.fromJson(json.decode(lampInfo));
      print('_lamp= ${_lamp.toString()}');
    }

    return SingleChildScrollView(
      child: checkLampPage(),
    );
  }


  Widget checkLampPage() {
    num textSzie = ScreenUtil().setSp(22);
    return new Container(
      width: ScreenUtil().setWidth(double.infinity),
      padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
      decoration: new BoxDecoration(
        color: Color.fromARGB(240, 11, 29, 77),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('UUID', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText(
                    _lamp.uUID, textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('名称', textSzie),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText(_lamp.nAME, textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('在线', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('版本号', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('电压', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('电压', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('电流', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('功率', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('电能', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('漏电电流', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('预警状态', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('传感器错', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('全局亮度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('主灯亮度值', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('副灯亮度值', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('灯光告警模式', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('汇报时间', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('照度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.illu.toString() == null?'':_lamp.illu.toString()), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('温度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('${_lamp?.temp}', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('湿度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('频率', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('照度锁', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('GPS开灯时间', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('GPS关灯时间', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('分组', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('Gprs csq', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.gprsCsq.toString() == null?'':_lamp.gprsCsq.toString()), textSzie),
              ),
            ],
          ),

          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('基站经度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('GPS经度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('GPS纬度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('类型', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.tYPE.toString() == null?'':_lamp.tYPE.toString()), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('经度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.lNG == null?'':_lamp.lNG), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('纬度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.lAT == null?'':_lamp.lAT), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('主一时间', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.firTtFir == null?'':_lamp.firTtFir), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('主一亮度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('${_lamp?.firTpFir}', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('主二时间', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('${_lamp?.secTtFir}', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('主二亮度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('${_lamp?.secTpFir}', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('主三时间', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.thirTtFir == null?'':_lamp.thirTtFir), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('主三亮度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.thirTpFir.toString() == null?'':_lamp.thirTpFir.toString()), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('主四时间', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.fourTtFir == null?'':_lamp.fourTtFir), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('主四亮度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.fourTpFir.toString() == null?'':_lamp.fourTpFir.toString()), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('主五时间', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.fifTtFir == null?'':_lamp.fifTtFir), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('主五亮度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText(_lamp.fifTpFir.toString(), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('主六时间', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText(_lamp.fifTpFir.toString(), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('主六亮度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText(_lamp.sixTpFir.toString(), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('辅一时间', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText(_lamp.firTtSec.toString(), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('辅一亮度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText( _lamp.firTpSec.toString(), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('辅二时间', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText(_lamp.secTtSec.toString(), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('辅二亮度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('${_lamp?.secTpSec?.toString()} ', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('辅三时间', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('${_lamp?.thirTtSec?.toString() }', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('辅三亮度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('${_lamp?.thirTpSec?.toString() }', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('辅四时间', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('${_lamp?.fourTtSec?.toString() }', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('辅四亮度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('${_lamp?.fourTpSec?.toString() }', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('辅五时间', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('${_lamp?.fifTtSec?.toString() }', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('辅五亮度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('${_lamp?.fifTpSec?.toString() }', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('辅六时间', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('${_lamp?.sixTtSec?.toString() }', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('辅六亮度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText('${_lamp?.sixTpSec?.toString() }', textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('项目', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.pROJECT == null?'':_lamp.pROJECT), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('父设备UUID', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.fUUID == null?'':_lamp.fUUID), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('灯杆直径', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.lampDiameter == null?'':_lamp.lampDiameter), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('电源出厂商', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.powerManufacturer == null?'':_lamp.powerManufacturer),textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('灯具额定电流', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.lampRatedCurrent == null?'':_lamp.lampRatedCurrent), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('灯具额定电压', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.lampRatedvoltage == null?'':_lamp.lampRatedvoltage), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('灯具类型', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.lampType == null?'':_lamp.lampType), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('灯具出厂商', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.lampManufacturer == null?'':_lamp.lampManufacturer), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('灯具数', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.lampNum == null?'':_lamp.lampNum), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('灯具出厂时间', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.poleProductionDate == null?'':_lamp.poleProductionDate ), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('灯杆高度', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.poleHeight == null?'':_lamp.poleHeight ), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('总额定功率', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.ratedPower == null?'':_lamp.ratedPower ), textSzie),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('通讯方式', textSzie),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: _getText((_lamp?.subcommunicateMode == null?'':_lamp.subcommunicateMode ) , textSzie),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _getText(String text, num textSzie) {
    return Text(text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            decorationStyle: TextDecorationStyle.solid,
            fontSize: textSzie,
            color: Colors.white));
  }



}


