import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/entity/json/lamp_info.dart';
import 'package:ldfluttersmartcity2/entity/json/login_Info.dart';
import 'package:ldfluttersmartcity2/seekbar/seekbar.dart';
import 'package:ldfluttersmartcity2/utils/dio_utils.dart';
import 'package:ldfluttersmartcity2/utils/shared_preference_util.dart';
import 'package:oktoast/oktoast.dart';

import 'area_type_view.dart';

class LampControlPage extends StatefulWidget {
  final String lampInfo;

  LampControlPage(this.lampInfo);

  @override
  _LampControlPageState createState() => _LampControlPageState(lampInfo);
}

class _LampControlPageState extends State<LampControlPage>
    with AutomaticKeepAliveClientMixin {
  String lampInfo;
  Lamp _lamp;

  _LampControlPageState(this.lampInfo);

  @override
  Widget build(BuildContext context) {
    if (lampInfo != null) {
      _lamp = Lamp.fromJson(json.decode(lampInfo));
      print('EditLampPage _lamp= ${_lamp.toString()}');
    }
    return SingleChildScrollView(
      child: _controlView(),
    );
  }

  // 让新界面重新点击不刷新
  @override
  bool get wantKeepAlive => true;

  final uuidController = TextEditingController(); //输入监听
  final projectController = TextEditingController(); //输入监听
  final TextEditingController accuracyController = TextEditingController(); // 角度校准监听
  final TextEditingController orderCodeController = TextEditingController(); // 指令码监听
  final TextEditingController orderController = TextEditingController(); // 指令监听

  /**
   * 单灯控制界面
   */
  Widget _controlView() {
    num textSzie = ScreenUtil().setSp(26);
    num childTopSpace = ScreenUtil().setHeight(45);
    String radioalue = '普通';
    return new Container(
      width: ScreenUtil().setWidth(double.infinity),
      // height: ScreenUtil().setHeight(2000),
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 50.0),
      decoration: new BoxDecoration(
        color: Color.fromARGB(240, 11, 29, 77),
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(
                0, childTopSpace, 0, ScreenUtil().setHeight(20)),
            //  margin: EdgeInsets.fromLTRB(0, childTopSpace, 0, 0),
            child: Row(
              children: <Widget>[
                _getText('预警状态     ', textSzie),
                _getText('离线${_lamp.warningState}', textSzie),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, childTopSpace, 0, 0),
            child: Row(
              children: <Widget>[
                _getText('整体开关     ', textSzie),
                new Container(
                  height: ScreenUtil().setHeight(50),
                  width: ScreenUtil().setWidth(100),
                  child: RaisedButton(
                    child: Text('开'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
                        // 解析 json
                        var data = json.decode(val);
                        LoginInfo loginInfo = LoginInfo.fromJson(data);

                        var param = "{\"UUID\": \"${_lamp.uUID}\",\"Confirm\": 260,\"options\": {\"Dimming\": 100}}";

                        DioUtils.requestHttp(
                          Api.instance.getServicePath('DEVICE_CONTROL_URL'),
                          parameters: param,
                          token: loginInfo.data.token.token,
                          method: DioUtils.POST,
                          onSuccess: (String data) {

                            showToast('指令已发送', position: ToastPosition.bottom);

                            /*  if(data.toString() == 'OK'){
                                  showToast('指令发送成功！',position: ToastPosition.bottom);
                                }*/
                          },
                          onError: (error) {
                            print(' DEVICE_CONTROL_URL DioUtils.requestHttp error = $error');
                          },
                        );
                      });

                    },
                  ),
                ),
                new Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  height: ScreenUtil().setHeight(50),
                  width: ScreenUtil().setWidth(100),
                  child: RaisedButton(
                    child: Text('关'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {

                      SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
                        // 解析 json
                        var data = json.decode(val);
                        LoginInfo loginInfo = LoginInfo.fromJson(data);

                        var param = "{\"UUID\": \"${_lamp.uUID}\",\"Confirm\": 260,\"options\": {\"Dimming\": 0}}";

                        DioUtils.requestHttp(
                          Api.instance.getServicePath('DEVICE_CONTROL_URL'),
                          parameters: param,
                          token: loginInfo.data.token.token,
                          method: DioUtils.POST,
                          onSuccess: (String data) {

                            showToast('指令已发送', position: ToastPosition.bottom);

                            /*  if(data.toString() == 'OK'){
                                  showToast('指令发送成功！',position: ToastPosition.bottom);
                                }*/
                          },
                          onError: (error) {
                            print(' DEVICE_CONTROL_URL DioUtils.requestHttp error = $error');
                          },
                        );
                      });

                    },
                  ),
                ),
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(0, childTopSpace, 0, 0),
            child: Row(
              children: <Widget>[
                _getText('快速调灯       ', textSzie),
                Container(
                    width: 200,
                    child: SeekBar(
                        afterDragShowSectionText: true,
                        bubbleRadius: 14,
                        value: 0,
                        min: 0,
                        max: 100,
                        hideBubble: false,
                        onValueChanged: (v) {

                          // 获取项目中的路灯
                          SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
                            // 解析 json
                            var data = json.decode(val);
                            LoginInfo loginInfo = LoginInfo.fromJson(data);

                            //     var param =  "{\"UUID\": \"83140000862285035977879\",\"Confirm\": 260,\"options\": {\"FirDimming\": 0}}";
                            var param = "{\"UUID\": \"${_lamp.uUID}\",\"Confirm\": 260,\"options\": {\"Dimming\": ${v.value.ceil()}}}";

                            DioUtils.requestHttp(
                              Api.instance.getServicePath('DEVICE_CONTROL_URL'),
                              parameters: param,
                              token: loginInfo.data.token.token,
                              method: DioUtils.POST,
                              onSuccess: (String data) {

                                showToast('指令已发送', position: ToastPosition.bottom);

                                /*  if(data.toString() == 'OK'){
                                  showToast('指令发送成功！',position: ToastPosition.bottom);
                                }*/
                              },
                              onError: (error) {
                                print(' DEVICE_CONTROL_URL DioUtils.requestHttp error = $error');
                              },
                            );
                          });

                        })),
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(0, childTopSpace, 0, 0),
            child: Row(
              children: <Widget>[
                _getText('        主灯       ', textSzie),
                Container(
                    width: 200,
                    child: SeekBar(
                        afterDragShowSectionText: true,
                        bubbleRadius: 14,
                        value: 0,
                        min: 0,
                        max: 100,
                        hideBubble: false,
                        onValueChanged: (v) {
                          // 主灯控制

                          // 获取项目中的路灯
                          SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
                            // 解析 json
                            var data = json.decode(val);
                            LoginInfo loginInfo = LoginInfo.fromJson(data);

                            //     var param =  "{\"UUID\": \"83140000862285035977879\",\"Confirm\": 260,\"options\": {\"FirDimming\": 0}}";
                            var param = "{\"UUID\": \"${_lamp.uUID}\",\"Confirm\": 260,\"options\": {\"FirDimming\": ${v.value.ceil()}}}";

                            print('param = ${param.toString()}');

                            DioUtils.requestHttp(
                              Api.instance.getServicePath('DEVICE_CONTROL_URL'),
                              parameters: param,
                              token: loginInfo.data.token.token,
                              method: DioUtils.POST,
                              onSuccess: (String data) {

                                showToast('指令已发送', position: ToastPosition.bottom);

                                /*  if(data.toString() == 'OK'){
                                  showToast('指令发送成功！',position: ToastPosition.bottom);
                                }*/
                              },
                              onError: (error) {
                                print(' DEVICE_CONTROL_URL DioUtils.requestHttp error = $error');
                              },
                            );
                          });
                        })),
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(0, childTopSpace, 0, 0),
            child: Row(
              children: <Widget>[
                _getText('        辅灯       ', textSzie),
                Container(
                    width: 200,
                    child: SeekBar(
                        afterDragShowSectionText: true,
                        bubbleRadius: 14,
                        value: 0,
                        min: 0,
                        max: 100,
                        hideBubble: false,
                        onValueChanged: (v) {

                          SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
                            // 解析 json
                            var data = json.decode(val);
                            LoginInfo loginInfo = LoginInfo.fromJson(data);

                            //     var param =  "{\"UUID\": \"83140000862285035977879\",\"Confirm\": 260,\"options\": {\"FirDimming\": 0}}";
                            var param = "{\"UUID\": \"${_lamp.uUID}\",\"Confirm\": 260,\"options\": {\"SecDimming\": ${v.value.ceil()}}}";

                            DioUtils.requestHttp(
                              Api.instance.getServicePath('DEVICE_CONTROL_URL'),
                              parameters: param,
                              token: loginInfo.data.token.token,
                              method: DioUtils.POST,
                              onSuccess: (String data) {

                                showToast('指令已发送', position: ToastPosition.bottom);

                                /*  if(data.toString() == 'OK'){
                                  showToast('指令发送成功！',position: ToastPosition.bottom);
                                }*/
                              },
                              onError: (error) {
                                print(' DEVICE_CONTROL_URL DioUtils.requestHttp error = $error');
                              },
                            );
                          });

                        })),
              ],
            ),
          ),
          new AreaType(
            textSzie: textSzie,
            childTopSpace: 0.0,
          ),
          Container(
            child: Row(
              children: <Widget>[
                _getText(' 清除报警    ', textSzie),
                new Container(
                  height: ScreenUtil().setHeight(50),
                  width: ScreenUtil().setWidth(120),
                  child: RaisedButton(
                    child: _getText('清除', textSzie),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {

                      SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
                        // 解析 json
                        var data = json.decode(val);
                        LoginInfo loginInfo = LoginInfo.fromJson(data);

                        //     var param =  "{\"UUID\": \"83140000862285035977879\",\"Confirm\": 260,\"options\": {\"FirDimming\": 0}}";
                        var param = "{\"UUID\": \"${_lamp.uUID}\"}";

                        DioUtils.requestHttp(
                          Api.instance.getServicePath('CLEAN_ALARM_URL'),
                          parameters: param,
                          token: loginInfo.data.token.token,
                          method: DioUtils.POST,
                          onSuccess: (String data) {

                            showToast('指令已发送', position: ToastPosition.bottom);

                            /*  if(data.toString() == 'OK'){
                                  showToast('指令发送成功！',position: ToastPosition.bottom);
                                }*/
                          },
                          onError: (error) {
                            print(' DEVICE_CONTROL_URL DioUtils.requestHttp error = $error');
                          },
                        );
                      });


                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, childTopSpace, 0, 0),
            child: Row(
              children: <Widget>[
                _getText(' 灯光告警    ', textSzie),
                new Container(
                  height: ScreenUtil().setHeight(50),
                  width: ScreenUtil().setWidth(120),
                  child: RaisedButton(
                    child: _getText('关闭', textSzie),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {

                      SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
                        // 解析 json
                        var data = json.decode(val);
                        LoginInfo loginInfo = LoginInfo.fromJson(data);

                        //     var param =  "{\"UUID\": \"83140000862285035977879\",\"Confirm\": 260,\"options\": {\"FirDimming\": 0}}";
                        var param = "{\"UUID\": \"${_lamp.uUID}\",\"Confirm\": 270,\"options\": {\"Alarm_Light_Mode\": \"OFF\"}}";

                        DioUtils.requestHttp(
                          Api.instance.getServicePath('DEVICE_CONTROL_URL'),
                          parameters: param,
                          token: loginInfo.data.token.token,
                          method: DioUtils.POST,
                          onSuccess: (String data) {

                            showToast('指令已发送', position: ToastPosition.bottom);

                            /*  if(data.toString() == 'OK'){
                                  showToast('指令发送成功！',position: ToastPosition.bottom);
                                }*/
                          },
                          onError: (error) {
                            print(' DEVICE_CONTROL_URL DioUtils.requestHttp error = $error');
                          },
                        );
                      });

                    },
                  ),
                ),
                new Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  height: ScreenUtil().setHeight(50),
                  width: ScreenUtil().setWidth(120),
                  child: RaisedButton(
                    child: _getText('闪烁', textSzie),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {

                      SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
                        // 解析 json
                        var data = json.decode(val);
                        LoginInfo loginInfo = LoginInfo.fromJson(data);

                        //     var param =  "{\"UUID\": \"83140000862285035977879\",\"Confirm\": 260,\"options\": {\"FirDimming\": 0}}";
                        var param = "{\"UUID\": \"${_lamp.uUID}\",\"Confirm\": 270,\"options\": {\"Alarm_Light_Mode\": \"FLASH\"}}";

                        DioUtils.requestHttp(
                          Api.instance.getServicePath('DEVICE_CONTROL_URL'),
                          parameters: param,
                          token: loginInfo.data.token.token,
                          method: DioUtils.POST,
                          onSuccess: (String data) {

                            showToast('指令已发送', position: ToastPosition.bottom);

                            /*  if(data.toString() == 'OK'){
                                  showToast('指令发送成功！',position: ToastPosition.bottom);
                                }*/
                          },
                          onError: (error) {
                            print(' DEVICE_CONTROL_URL DioUtils.requestHttp error = $error');
                          },
                        );
                      });

                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, childTopSpace, 0, 0),
            child: Row(
              children: <Widget>[
                _getText('红外设置     ', textSzie),
                new Container(
                  height: ScreenUtil().setHeight(50),
                  width: ScreenUtil().setWidth(120),
                  child: RaisedButton(
                    child: Text('关'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {

                      SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
                        // 解析 json
                        var data = json.decode(val);
                        LoginInfo loginInfo = LoginInfo.fromJson(data);

                        //     var param =  "{\"UUID\": \"83140000862285035977879\",\"Confirm\": 260,\"options\": {\"FirDimming\": 0}}";
                        var param = "{\"UUID\": \"${_lamp.uUID}\",\"Confirm\": 234,\"options\": {\"IR_Dimming_en\": 0}}";

                        DioUtils.requestHttp(
                          Api.instance.getServicePath('DEVICE_CONTROL_URL'),
                          parameters: param,
                          token: loginInfo.data.token.token,
                          method: DioUtils.POST,
                          onSuccess: (String data) {

                            showToast('指令已发送', position: ToastPosition.bottom);

                            /*  if(data.toString() == 'OK'){
                                  showToast('指令发送成功！',position: ToastPosition.bottom);
                                }*/
                          },
                          onError: (error) {
                            print(' DEVICE_CONTROL_URL DioUtils.requestHttp error = $error');
                          },
                        );
                      });

                    },
                  ),
                ),
                new Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  height: ScreenUtil().setHeight(50),
                  width: ScreenUtil().setWidth(120),
                  child: RaisedButton(
                    child: Text('开'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {

                      SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
                        // 解析 json
                        var data = json.decode(val);
                        LoginInfo loginInfo = LoginInfo.fromJson(data);

                        //     var param =  "{\"UUID\": \"83140000862285035977879\",\"Confirm\": 260,\"options\": {\"FirDimming\": 0}}";
                        var param = "{\"UUID\": \"${_lamp.uUID}\",\"Confirm\": 234,\"options\": {\"IR_Dimming_en\": 1}}";

                        DioUtils.requestHttp(
                          Api.instance.getServicePath('DEVICE_CONTROL_URL'),
                          parameters: param,
                          token: loginInfo.data.token.token,
                          method: DioUtils.POST,
                          onSuccess: (String data) {

                            showToast('指令已发送', position: ToastPosition.bottom);

                            /*  if(data.toString() == 'OK'){
                                  showToast('指令发送成功！',position: ToastPosition.bottom);
                                }*/
                          },
                          onError: (error) {
                            print(' DEVICE_CONTROL_URL DioUtils.requestHttp error = $error');
                          },
                        );
                      });

                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, childTopSpace, 0, 0),
            child: Row(
              children: <Widget>[
                _getText('获取状态     ', textSzie),
                new Container(
                  height: ScreenUtil().setHeight(50),
                  width: ScreenUtil().setWidth(120),
                  child: RaisedButton(
                    child: _getText('获取', textSzie),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {

                      SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
                        // 解析 json
                        var data = json.decode(val);
                        LoginInfo loginInfo = LoginInfo.fromJson(data);

                        //     var param =  "{\"UUID\": \"83140000862285035977879\",\"Confirm\": 260,\"options\": {\"FirDimming\": 0}}";
                        var param = "{\"UUID\": \"${_lamp.uUID}\",\"Confirm\": 232}";

                        DioUtils.requestHttp(
                          Api.instance.getServicePath('DEVICE_CONTROL_URL'),
                          parameters: param,
                          token: loginInfo.data.token.token,
                          method: DioUtils.POST,
                          onSuccess: (String data) {

                            showToast('指令已发送', position: ToastPosition.bottom);

                          },
                          onError: (error) {
                            print(' DEVICE_CONTROL_URL DioUtils.requestHttp error = $error');
                          },
                        );
                      });


                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, childTopSpace, 0, 0),
            child: Row(
              children: <Widget>[
                _getText('角度校准     ', textSzie),
                Container(
                  width: 50,
                  child: new TextField(
                    controller: accuracyController,
                    decoration: InputDecoration(
                      hintText: '0',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    cursorColor: Colors.purple,
                    cursorWidth: 6,
                    cursorRadius: Radius.elliptical(2, 8),
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(26), color: Colors.white),
                  ),
                ),
                new Container(
                  height: ScreenUtil().setHeight(50),
                  width: ScreenUtil().setWidth(120),
                  child: RaisedButton(
                    child: _getText('校准', textSzie),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {

                      SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
                        // 解析 json
                        var data = json.decode(val);
                        LoginInfo loginInfo = LoginInfo.fromJson(data);

                        var param = "{\"UUID\": \"${_lamp.uUID}\",\"Confirm\": 297,\"options\": {\"accuracy\": ${accuracyController.value}}";

                        DioUtils.requestHttp(
                          Api.instance.getServicePath('DEVICE_CONTROL_URL'),
                          parameters: param,
                          token: loginInfo.data.token.token,
                          method: DioUtils.POST,
                          onSuccess: (String data) {

                            showToast('指令已发送', position: ToastPosition.bottom);

                            /*  if(data.toString() == 'OK'){
                                  showToast('指令发送成功！',position: ToastPosition.bottom);
                                }*/
                          },
                          onError: (error) {
                            print(' DEVICE_CONTROL_URL DioUtils.requestHttp error = $error');
                          },
                        );
                      });

                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, childTopSpace, 0, 0),
            child: Row(
              children: <Widget>[
                _getText('   指令码       ', textSzie),
                Container(
                  width: 50,
                  child: new TextField(
                    controller: orderCodeController,
                    decoration: InputDecoration(
                      hintText: '0',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    cursorColor: Colors.purple,
                    cursorWidth: 6,
                    cursorRadius: Radius.elliptical(2, 8),
                    style: TextStyle(fontSize: ScreenUtil().setSp(26), color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, childTopSpace, 0, 0),
            child: Row(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(minWidth: 0, maxHeight: 75),
                  alignment: Alignment.topLeft,
                  child: _getText('      指令        ', textSzie),
                ),
                Container(
                  width: ScreenUtil().setWidth(460),
                  child: TextField(
                    controller: orderController,
                    maxLines: 8,
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
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.fromLTRB(0.0, 10, ScreenUtil().setWidth(70), 0),
                alignment: Alignment.centerRight,
                height: ScreenUtil().setHeight(50),
                width: ScreenUtil().setWidth(180),
                child: RaisedButton(
                  child: _getText('发送指令', textSzie),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {

                    SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
                      // 解析 json
                      var data = json.decode(val);
                      LoginInfo loginInfo = LoginInfo.fromJson(data);

                      var param = "{\"UUID\": \"${_lamp.uUID}\",\"Confirm\": ${orderCodeController.value}｝,\"options\": ${orderController.value}}";

                      DioUtils.requestHttp(
                        Api.instance.getServicePath('DEVICE_CONTROL_URL'),
                        parameters: param,
                        token: loginInfo.data.token.token,
                        method: DioUtils.POST,
                        onSuccess: (String data) {

                          showToast('指令已发送', position: ToastPosition.bottom);

                          /*  if(data.toString() == 'OK'){
                                  showToast('指令发送成功！',position: ToastPosition.bottom);
                                }*/
                        },
                        onError: (error) {
                          print(' DEVICE_CONTROL_URL DioUtils.requestHttp error = $error');
                        },
                      );
                    });

                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getText(String text, num textSzie) {
    return Text(text,
        style: TextStyle(
            decorationStyle: TextDecorationStyle.solid,
            fontSize: textSzie,
            color: Colors.white));
  }
}
