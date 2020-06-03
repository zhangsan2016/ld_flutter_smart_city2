
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:ldfluttersmartcity2/entity/json/lamp_info.dart';

class EditLampPage extends StatefulWidget {

  final String lampInfo;
  EditLampPage(this.lampInfo);

  @override
  _EditLampPageState createState() => _EditLampPageState(lampInfo);
}

class _EditLampPageState extends State<EditLampPage> with AutomaticKeepAliveClientMixin {
  String lampInfo;
  Lamp _lamp;
  _EditLampPageState(this.lampInfo);

  @override
  Widget build(BuildContext context) {
    if(lampInfo!=null){
      _lamp =  Lamp.fromJson(json.decode(lampInfo));
      print('EditLampPage _lamp= ${_lamp.toString()}');
    }
    return  SingleChildScrollView(
      child: editLampPage(),
    );
  }

  // 让新界面重新点击不刷新
  @override
  bool get wantKeepAlive => true;



  TextEditingController _lampUUid = TextEditingController();
  TextEditingController _lampName = TextEditingController();
  TextEditingController _lampLongitude = TextEditingController();
  TextEditingController _lampLatitude = TextEditingController();
  TextEditingController _lampProject = TextEditingController();
  TextEditingController _lampSuperUUID = TextEditingController();
  TextEditingController _lampDiameter = TextEditingController();
  // 电源出厂商
  TextEditingController _powerManufacturers = TextEditingController();
  // 额定电流
  TextEditingController _lampRatedCurrent = TextEditingController();
  // 额定电压
  TextEditingController _lampNominalVoltage  = TextEditingController();
  // 额定类型
  TextEditingController _lampType = TextEditingController();
  // 灯具出厂商
  TextEditingController _lampTheVendor = TextEditingController();
  // 灯具数
  TextEditingController _lampNum  = TextEditingController();
  // 灯具出厂日期
  TextEditingController _lampDateOfProduction = TextEditingController();
  // 灯具高度
  TextEditingController _lampHeight = TextEditingController();
  // 灯具总额定功率
  TextEditingController _lampTotalFixedPower= TextEditingController();
  // 灯具出厂日期
  TextEditingController _lampCommunicationMode= TextEditingController();
  Widget editLampPage() {
    num textSzie = ScreenUtil().setSp(22);
    return new Container(
        width: ScreenUtil().setWidth(double.infinity),
        padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
        decoration: new BoxDecoration(
          color: Color.fromARGB(240, 11, 29, 77),
        ),
        child: Column(children: <Widget>[

          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: _getText('UUID', textSzie),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                width: ScreenUtil().setWidth(500),
                alignment: Alignment.centerLeft,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 30,
                  ),
                  child: TextField(
                    controller: _lampUUid,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5.0),
                        enabledBorder: OutlineInputBorder(
                          /*边角*/
                          borderRadius: BorderRadius.all(
                            Radius.circular(5), //边角为5
                          ),
                          borderSide: BorderSide(
                            color: Colors.white, //边线颜色为白色
                            width: 1, //边线宽度为2
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(25), color: Colors.white),
                    cursorColor: Colors.blue,
                  ),
                ),
              ),
            ],
          ),


          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  width: ScreenUtil().setWidth(150),
                  child: _getText('名称', textSzie),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  width: ScreenUtil().setWidth(500),
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                    ),
                    child: TextField(
                      controller: _lampName,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          enabledBorder: OutlineInputBorder(
                            /*边角*/
                            borderRadius: BorderRadius.all(
                              Radius.circular(5), //边角为5
                            ),
                            borderSide: BorderSide(
                              color: Colors.white, //边线颜色为白色
                              width: 1, //边线宽度为2
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          color: Colors.white),
                      cursorColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),



          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  width: ScreenUtil().setWidth(150),
                  child: _getText('类型', textSzie),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  width: ScreenUtil().setWidth(500),
                  alignment: Alignment.centerLeft,
                  child:_getText('  2',textSzie),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  width: ScreenUtil().setWidth(150),
                  child: _getText('经度', textSzie),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  width: ScreenUtil().setWidth(500),
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                    ),
                    child: TextField(
                      controller: _lampLongitude,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          enabledBorder: OutlineInputBorder(
                            /*边角*/
                            borderRadius: BorderRadius.all(
                              Radius.circular(5), //边角为5
                            ),
                            borderSide: BorderSide(
                              color: Colors.white, //边线颜色为白色
                              width: 1, //边线宽度为2
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          color: Colors.white),
                      cursorColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),



          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  width: ScreenUtil().setWidth(150),
                  child: _getText('纬度', textSzie),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  width: ScreenUtil().setWidth(500),
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                    ),
                    child: TextField(
                      controller: _lampLatitude,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          enabledBorder: OutlineInputBorder(
                            /*边角*/
                            borderRadius: BorderRadius.all(
                              Radius.circular(5), //边角为5
                            ),
                            borderSide: BorderSide(
                              color: Colors.white, //边线颜色为白色
                              width: 1, //边线宽度为2
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          color: Colors.white),
                      cursorColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),


          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  width: ScreenUtil().setWidth(150),
                  child: _getText('项目', textSzie),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  width: ScreenUtil().setWidth(500),
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                    ),
                    child: TextField(
                      controller: _lampProject,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          enabledBorder: OutlineInputBorder(
                            /*边角*/
                            borderRadius: BorderRadius.all(
                              Radius.circular(5), //边角为5
                            ),
                            borderSide: BorderSide(
                              color: Colors.white, //边线颜色为白色
                              width: 1, //边线宽度为2
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          color: Colors.white),
                      cursorColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  width: ScreenUtil().setWidth(150),
                  child: _getText('父设备UUID', textSzie),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  width: ScreenUtil().setWidth(500),
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                    ),
                    child: TextField(
                      controller: _lampSuperUUID,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          enabledBorder: OutlineInputBorder(
                            /*边角*/
                            borderRadius: BorderRadius.all(
                              Radius.circular(5), //边角为5
                            ),
                            borderSide: BorderSide(
                              color: Colors.white, //边线颜色为白色
                              width: 1, //边线宽度为2
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          color: Colors.white),
                      cursorColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),


          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  width: ScreenUtil().setWidth(150),
                  child: _getText('灯杆直径', textSzie),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  width: ScreenUtil().setWidth(500),
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                    ),
                    child: TextField(
                      controller: _lampDiameter,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          enabledBorder: OutlineInputBorder(
                            /*边角*/
                            borderRadius: BorderRadius.all(
                              Radius.circular(5), //边角为5
                            ),
                            borderSide: BorderSide(
                              color: Colors.white, //边线颜色为白色
                              width: 1, //边线宽度为2
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          color: Colors.white),
                      cursorColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),


          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  width: ScreenUtil().setWidth(150),
                  child: _getText('电源出厂商', textSzie),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  width: ScreenUtil().setWidth(500),
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                    ),
                    child: TextField(
                      controller: _powerManufacturers,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          enabledBorder: OutlineInputBorder(
                            /*边角*/
                            borderRadius: BorderRadius.all(
                              Radius.circular(5), //边角为5
                            ),
                            borderSide: BorderSide(
                              color: Colors.white, //边线颜色为白色
                              width: 1, //边线宽度为2
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          color: Colors.white),
                      cursorColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),


          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  width: ScreenUtil().setWidth(150),
                  child: _getText('灯具额定电流', textSzie),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  width: ScreenUtil().setWidth(500),
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                    ),
                    child: TextField(
                      controller: _lampRatedCurrent,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          enabledBorder: OutlineInputBorder(
                            /*边角*/
                            borderRadius: BorderRadius.all(
                              Radius.circular(5), //边角为5
                            ),
                            borderSide: BorderSide(
                              color: Colors.white, //边线颜色为白色
                              width: 1, //边线宽度为2
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          color: Colors.white),
                      cursorColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),


          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  width: ScreenUtil().setWidth(150),
                  child: _getText('灯具额定电压', textSzie),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  width: ScreenUtil().setWidth(500),
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                    ),
                    child: TextField(
                      controller: _lampNominalVoltage,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          enabledBorder: OutlineInputBorder(
                            /*边角*/
                            borderRadius: BorderRadius.all(
                              Radius.circular(5), //边角为5
                            ),
                            borderSide: BorderSide(
                              color: Colors.white, //边线颜色为白色
                              width: 1, //边线宽度为2
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          color: Colors.white),
                      cursorColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),


          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  width: ScreenUtil().setWidth(150),
                  child: _getText('灯具类型', textSzie),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  width: ScreenUtil().setWidth(500),
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                    ),
                    child: TextField(
                      controller: _lampType,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          enabledBorder: OutlineInputBorder(
                            /*边角*/
                            borderRadius: BorderRadius.all(
                              Radius.circular(5), //边角为5
                            ),
                            borderSide: BorderSide(
                              color: Colors.white, //边线颜色为白色
                              width: 1, //边线宽度为2
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          color: Colors.white),
                      cursorColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),


          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  width: ScreenUtil().setWidth(150),
                  child: _getText('灯具出厂商', textSzie),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  width: ScreenUtil().setWidth(500),
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                    ),
                    child: TextField(
                      controller: _lampTheVendor,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          enabledBorder: OutlineInputBorder(
                            /*边角*/
                            borderRadius: BorderRadius.all(
                              Radius.circular(5), //边角为5
                            ),
                            borderSide: BorderSide(
                              color: Colors.white, //边线颜色为白色
                              width: 1, //边线宽度为2
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          color: Colors.white),
                      cursorColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),



          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  width: ScreenUtil().setWidth(150),
                  child: _getText('灯具数', textSzie),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  width: ScreenUtil().setWidth(500),
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                    ),
                    child: TextField(
                      controller: _lampNum,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          enabledBorder: OutlineInputBorder(
                            /*边角*/
                            borderRadius: BorderRadius.all(
                              Radius.circular(5), //边角为5
                            ),
                            borderSide: BorderSide(
                              color: Colors.white, //边线颜色为白色
                              width: 1, //边线宽度为2
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          color: Colors.white),
                      cursorColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),


          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  width: ScreenUtil().setWidth(150),
                  child: _getText('灯具出厂日期', textSzie),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  width: ScreenUtil().setWidth(500),
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                    ),
                    child: TextField(
                      controller: _lampDateOfProduction,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          enabledBorder: OutlineInputBorder(
                            /*边角*/
                            borderRadius: BorderRadius.all(
                              Radius.circular(5), //边角为5
                            ),
                            borderSide: BorderSide(
                              color: Colors.white, //边线颜色为白色
                              width: 1, //边线宽度为2
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          color: Colors.white),
                      cursorColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),


          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  width: ScreenUtil().setWidth(150),
                  child: _getText('灯具高度', textSzie),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  width: ScreenUtil().setWidth(500),
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                    ),
                    child: TextField(
                      controller: _lampHeight,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          enabledBorder: OutlineInputBorder(
                            /*边角*/
                            borderRadius: BorderRadius.all(
                              Radius.circular(5), //边角为5
                            ),
                            borderSide: BorderSide(
                              color: Colors.white, //边线颜色为白色
                              width: 1, //边线宽度为2
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          color: Colors.white),
                      cursorColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),



          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  width: ScreenUtil().setWidth(150),
                  child: _getText('总额定功率', textSzie),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  width: ScreenUtil().setWidth(500),
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                    ),
                    child: TextField(
                      controller: _lampTotalFixedPower,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          enabledBorder: OutlineInputBorder(
                            /*边角*/
                            borderRadius: BorderRadius.all(
                              Radius.circular(5), //边角为5
                            ),
                            borderSide: BorderSide(
                              color: Colors.white, //边线颜色为白色
                              width: 1, //边线宽度为2
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          color: Colors.white),
                      cursorColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),


          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  width: ScreenUtil().setWidth(150),
                  child: _getText('通讯方式', textSzie),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  width: ScreenUtil().setWidth(500),
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 30,
                    ),
                    child: TextField(
                      controller: _lampCommunicationMode,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5.0),
                          enabledBorder: OutlineInputBorder(
                            /*边角*/
                            borderRadius: BorderRadius.all(
                              Radius.circular(5), //边角为5
                            ),
                            borderSide: BorderSide(
                              color: Colors.white, //边线颜色为白色
                              width: 1, //边线宽度为2
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          color: Colors.white),
                      cursorColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),



          new Container(
            margin: EdgeInsets.fromLTRB(10, 15, 0, 0),
            height: ScreenUtil().setHeight(70),
            width: ScreenUtil().setWidth(600),
            child: RaisedButton(
              child: Text('保存'),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {

                /*  TextEditingController _lampUUid = TextEditingController();
                TextEditingController _lampName = TextEditingController();
                TextEditingController _lampLongitude = TextEditingController();
                TextEditingController _lampLatitude = TextEditingController();
                TextEditingController _lampProject = TextEditingController();
                TextEditingController _lampSuperUUID = TextEditingController();
                TextEditingController _lampDiameter = TextEditingController();
                // 电源出厂商
                TextEditingController _powerManufacturers = TextEditingController();
                // 额定电流
                TextEditingController _lampRatedCurrent = TextEditingController();
                // 额定电压
                TextEditingController _lampNominalVoltage  = TextEditingController();
                // 额定类型
                TextEditingController _lampType = TextEditingController();
                // 灯具出厂商
                TextEditingController _lampTheVendor = TextEditingController();
                // 灯具数
                TextEditingController _lampNum  = TextEditingController();
                // 灯具出厂日期
                TextEditingController _lampDateOfProduction = TextEditingController();
                // 灯具高度
                TextEditingController _lampHeight = TextEditingController();
                // 灯具总额定功率
                TextEditingController _lampTotalFixedPower= TextEditingController();
                // 灯具出厂日期
                TextEditingController _lampCommunicationMode= TextEditingController();*/

                print('== ${_lampUUid.text}     ${_lampName.text}    ${_lampLongitude.text}');
                if (true) {
                  print('保存成功！');
                } else {
                  print('保存失败');
                }
              },
            ),
          ),
        ]));

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








