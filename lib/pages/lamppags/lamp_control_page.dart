

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_seekbar/seekbar/seekbar.dart';

import 'area_type_view.dart';

class LampControlPage extends StatefulWidget {
  @override
  _LampControlPageState createState() => _LampControlPageState();
}

class _LampControlPageState extends State<LampControlPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _controlView(),
    );;
  }




  final uuidController = TextEditingController(); //输入监听
  final projectController = TextEditingController(); //输入监听
  /**
   * 单灯控制界面
   */
  Widget _controlView() {
    num textSzie = ScreenUtil().setSp(26);
    num childTopSpace = ScreenUtil().setHeight(45);
    String radioalue = '普通';
    return new Container(
      width: ScreenUtil().setWidth(double.infinity),
      height: ScreenUtil().setHeight(2000),
      padding: EdgeInsets.all(20),
      decoration: new BoxDecoration(
        color: Color.fromARGB(240, 11, 29, 77),
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, childTopSpace, 0, 0),
            child: Row(
              children: <Widget>[
                _getText('预警状态     ', textSzie),
                _getText('离线', textSzie),
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
                      if (uuidController.text.length > 0) {
                        print('开${uuidController.text}');
                      } else {
                        print('开失败');
                      }
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
                      if (uuidController.text.length > 0) {
                        print('关${uuidController.text}');
                      } else {
                        print('关失败');
                      }
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
                          print('当前进度：${v.progress} ，当前的取值：${v.value.ceil()}');
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
                          print('当前进度：${v.progress} ，当前的取值：${v.value.ceil()}');
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
                          print('当前进度：${v.progress} ，当前的取值：${v.value.ceil()}');
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
                      if (uuidController.text.length > 0) {
                        print('清除报警${uuidController.text}');
                      } else {
                        print('清除报警失败');
                      }
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
                      if (uuidController.text.length > 0) {
                        print('灯光告警关闭${uuidController.text}');
                      } else {
                        print('灯光告警关闭失败');
                      }
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
                      if (uuidController.text.length > 0) {
                        print('灯光告警闪烁${uuidController.text}');
                      } else {
                        print('灯光告警关闭闪烁');
                      }
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
                      if (uuidController.text.length > 0) {
                        print('红外设置关${uuidController.text}');
                      } else {
                        print('红外设置关失败');
                      }
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
                      if (uuidController.text.length > 0) {
                        print('红外设置开${uuidController.text}');
                      } else {
                        print('红外设置开失败');
                      }
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
                      if (uuidController.text.length > 0) {
                        print('获取状态${uuidController.text}');
                      } else {
                        print('获取状态失败');
                      }
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
                      if (uuidController.text.length > 0) {
                        print('获取状态${uuidController.text}');
                      } else {
                        print('获取状态失败');
                      }
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
                  width: 200,
                  child: new TextField(
                    maxLines: 5, //最大行数
                    decoration: InputDecoration(
                      hintText: '',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(26), color: Colors.white),
                    //输入文本的样式
                    cursorColor: Colors.purple,
                  ),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Container(
                margin:  EdgeInsets.fromLTRB(0.0, 10, 50.0, 0),
                alignment: Alignment.centerRight,
                height: ScreenUtil().setHeight(50),
                width: ScreenUtil().setWidth(180),
                child: RaisedButton(
                  child: _getText('发送指令', textSzie),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    if (uuidController.text.length > 0) {
                      print('发送${uuidController.text}');
                    } else {
                      print('发送失败');
                    }
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




