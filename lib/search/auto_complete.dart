import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/entity/json/device_list.dart';
import 'package:ldfluttersmartcity2/entity/json/login_Info.dart';
import 'package:ldfluttersmartcity2/utils/dio_utils.dart';
import 'package:ldfluttersmartcity2/utils/shared_preference_util.dart';

class AutoComplete extends StatefulWidget {
  final String query;
  final Function popResults;
  final Function setSearchKeyword;

  var currentProject;

  /// 这里通过另外一种方式实现自组件调用父组件方法
  AutoComplete(this.query, this.popResults, this.setSearchKeyword, this.currentProject);

  @override
  State<StatefulWidget> createState() => _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  /// 加载时显示loading
  static const loadingTag = '##loadingTag##';

  @override
  void initState() {
    super.initState();
    _receiveList();
  }

  @override
  Widget build(BuildContext context) {
    if (deviceList == null) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: SizedBox(
            width: 24.0,
            height: 24.0,
            child: CircularProgressIndicator(strokeWidth: 2.0) // 加载转圈
            ),
      );
    }
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Expanded(
            // ignore: missing_return
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        print('inkwell（${deviceList.device[index].nAME}） 被点击');
                      },
                      child: Row(children: <Widget>[
                      Container(
                        height:30.0,
                        width: 30.0,
                        margin: const EdgeInsets.all(16.0),
                        child: Image.asset('images/light_on.png', fit: BoxFit.fill),),
                        Column(
                          children: <Widget>[
                            Text(deviceList.device[index].nAME),
                            Text(deviceList.device[index].uUID),
                          ],
                        ),
                      ],)
                    ));
              },
              itemCount: deviceList.device.length,
              separatorBuilder: (context, index) => Divider(
                height: .0,
              ),
            ),
          ),
        ],
      ),
    );
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
  void _receiveList() {

    SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
      // 解析 json
      var data = json.decode(val);
      LoginInfo loginInfo = LoginInfo.fromJson(data);

    var param = "{\"where\":{\"PROJECT\":\"" + widget.currentProject + "\"},\"size\":1000}";
    DioUtils.requestHttp(
      servicePath['DEVICE_LIST_URL'],
      parameters: param,
      token: loginInfo.data.token.token,
      method: DioUtils.POST,
      onSuccess: (String data) {
        try {
          var jsonstr = json.decode(data);
          deviceList = DeviceList.fromJson(jsonstr);

          setState(() {});
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

/*   searchList.insertAll(0,
        ['洛丁光电','洛丁','苹果','苹果派','柠檬苹果派','海鲜','北海道海鲜','海鲜自助餐']
    );
    setState(() {
    });*/
  }
}
