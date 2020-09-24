import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/entity/json/device_list.dart';
import 'package:ldfluttersmartcity2/entity/json/login_Info.dart';
import 'package:ldfluttersmartcity2/pages/lamp_page.dart';
import 'package:ldfluttersmartcity2/utils/dio_utils.dart';
import 'package:ldfluttersmartcity2/utils/shared_preference_util.dart';

class AutoComplete extends StatefulWidget {
  final String query;
  final Function popResults;
  final Function setSearchKeyword;

  var currentProject;
  SearchDelegate searchDelegate;

  /// 这里通过另外一种方式实现自组件调用父组件方法
  AutoComplete(
    this.query,
    this.popResults,
    this.setSearchKeyword,
    this.currentProject, this.searchDelegate,
  );

  @override
  State<StatefulWidget> createState() => _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  /// 加载时显示loading
  static const loadingTag = '##loadingTag##';

  // 搜索结果
  List<Device> searchDevice = [];

  // 搜索状态
  bool searchStart = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _receiveList();
    });
  }

  @override
  Widget build(BuildContext context) {

    if (searchStart) {
      // 搜索关键字
      searchKeyword();
      return Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: SizedBox(
            width: 24.0,
            height: 24.0,
            child: CircularProgressIndicator(strokeWidth: 2.0) // 加载转圈
            ),
      );
    } else {
      // 搜索关键字
      _switchState();
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Expanded(
              // ignore: missing_return
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  Device device = searchDevice[index];
                  return Container(
                      child: InkWell(
                          onTap: () {
                            print('inkwell（${deviceList.device[index].nAME}） 被点击');


                            // 跳转到路灯控制界面
                       /*     String lampInfo = json.encode(device);

                            Navigator.pushAndRemoveUntil(context, new CupertinoPageRoute(
                              builder: (BuildContext context) {
                                return new LampPage(lampInfo);
                              },
                            ), (route) => route == null);*/


                            String lampInfo = json.encode(device);
                            Navigator.of(context).pushAndRemoveUntil(
                                CupertinoPageRoute(builder: (context) => new LampPage(lampInfo)),
                                ModalRoute.withName('/AmapPage'));




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
                itemCount: searchDevice.length,
                separatorBuilder: (context, index) => Divider(
                  height: .0,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  TextSpan bold(String title, String query) {
    query = query.trim();
    int index = title.indexOf(query);
    if (index == -1 || query.length > title.length) {
      return TextSpan(
        text: title,
        style: TextStyle(color: Colors.black, fontSize: 12),
        children: null,
      );
    } else {
      /// 构建富文本，对输入的字符加粗显示
      String before = title.substring(0, index);
      String hit = title.substring(index, index + query.length);
      String after = title.substring(index + query.length);
      return TextSpan(
        text: '',
        style: TextStyle(color: Colors.black, fontSize: 12),
        children: <TextSpan>[
          TextSpan(text: before),
          TextSpan(
              text: hit,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          TextSpan(text: after),
        ],
      );
    }
  }

  DeviceList deviceList = null;
  /// 模拟网络延迟加载，需要依赖词包 english_words: ^3.1.0
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
             searchKeyword();
            //setState(() {});

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

  /**
   * 根据搜索关键字匹配路灯列表
   */
  void searchKeyword() async {
    searchDevice.clear();
    if (deviceList != null) {
      String keyword = widget.query;
      for (Device d in deviceList.device) {
        if (d.nAME.contains(keyword) || d.uUID.contains(keyword)) {
          searchDevice.add(d);
        }
      }

      Future.delayed(Duration(milliseconds: 100), (){
        setState(() {
          _switchState();
        });
      });

      // 根据字符相识度排序

    } else {
      // _receiveList();

    }
  }

  _switchState() {
    if (searchStart) {
      searchStart = false;
    } else {
      searchStart = true;
    }
  }


}
