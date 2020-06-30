import 'dart:convert';

import 'package:decorated_flutter/decorated_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/entity/json/lamp_info.dart';
import 'package:ldfluttersmartcity2/utils/dio_utils.dart';
import 'package:ldfluttersmartcity2/view/discrete_Setting.dart';
import 'package:oktoast/oktoast.dart';

import '../lamp_page.dart';

class GroupingPage extends StatefulWidget {
  // 当前项目
  String currentProject;

  GroupingPage(this.currentProject);

  @override
  _MyGroupingPageState createState() => _MyGroupingPageState(currentProject);
}

class _MyGroupingPageState extends State<GroupingPage> {
  // 当前路灯数据
  List<Lamp> lamps = [];

  // 分组后的路灯
  var lampsGroup = <String, List<Lamp>>{};
  // 当前项目
  String currentProject;

  _MyGroupingPageState(this.currentProject);

  @override
  void initState() {
    super.initState();
    // 网络获取当前项目路灯数据
    getDeviceLampList(currentProject);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    // 获取传递过来的数据
  //  String projectTitle = ModalRoute.of(context).settings.arguments;
 //   print('projectTitle = $projectTitle');

    return new Scaffold(
      appBar: new AppBar(
        //自定义Drawer的按钮
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                onPressed:
                // () => Navigator.of(context).pop();
                Navigator.pop(context);
              });
        }),
        title: new Text('洛丁智慧照明'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
        decoration: new BoxDecoration(
          //color: Color.fromARGB(255, 11, 29, 77),
          color: Color.fromARGB(240, 11, 29, 77),
        ),
        child: ListView(
          children: getGroup(),
        ),
      ),
    );
  }

  // 设置标题
  Widget groupTitle(String title) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.all(5.0),
        color: Colors.transparent,
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ));
  }

  Widget _wrapList(List<Lamp> lamps) {
    if (lamps?.length != 0) {
      List<Widget> listWidget = lamps.map((val) {
        Lamp lamp = val;
        return InkWell(
      /*    onTap: () {
            showToast('${lamp.nAME}', position: ToastPosition.bottom);
            print('${lamp.nAME} lamp.lAT ： ${lamp.lAT} lamp.lNG ：${lamp.lNG}');

          },*/
          child: Container(
            //width: ScreenUtil().setWidth(150),
            color: Color.fromARGB(255, 37, 70, 131),
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                DiscreteSetting(
                  head: lamp.nAME,
                  options: ['定位', '控制'],
                  onSelected: (value) {
                    print('${lamp.nAME} ： $value');
                    switch (value) {
                      case '定位':

                        if(lamp.lNG.isNotEmpty && lamp.lNG.isNotEmpty){
                          Navigator.pop(context, json.encode(lamp));
                        }else{
                          showToast('未能找到当前设备经纬度，请重新添加',position: ToastPosition.bottom);
                        }

                        break;
                      case '控制':

                        Navigator.push<String>(
                          context,
                          new CupertinoPageRoute(
                            builder: (BuildContext context) {
                              return new LampPage(json.encode(lamp));
                            },
                          ),
                        );

                        break;
                    }
                  },
                ),

               /* Text(
                  lamp.nAME,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black, fontSize: ScreenUtil().setSp(26)),
                ),*/
              ],
            ),
          ),
        );
      }).toList();

      // 返回流式布局
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  /**
   *  获取项目下的路灯列表
   */
  getDeviceLampList(String title) {
    var param = "{\"where\":{\"PROJECT\":\"" + title + "\"},\"size\":1000}";
    DioUtils.requestHttp(
      servicePath['DEVICE_LAMP_LIST_URL'],
      parameters: param,
      // token: token,
      token: 'f2b562c0-b1d7-11ea-84e6-399675d2b894',
      method: DioUtils.POST,
      onSuccess: (String data) {
        // 解析 json
        var jsonstr = json.decode(data);
        // print('getDeviceLampList title $title = $data');
        print('getDeviceLampList title $title ');

        LampInfo lampInfo = LampInfo.fromJson(jsonstr);

        setState(() {
          lamps = lampInfo.data.lamp;
        });
      },
      onError: (error) {
        print(' DioUtils.requestHttp error = $error');
      },
    );
  }

  /**
   *  获取分组
   */
  List<Widget> getGroup() {
    lamps.forEach((lamp) {
      print('lamp.sUBGROUP = ${lamp.sUBGROUP}');
      if (lamp.sUBGROUP.isNotEmpty) {
        if (lampsGroup.containsKey(lamp.sUBGROUP)) {
          var group = lampsGroup[lamp.sUBGROUP];
          group.add(lamp);
        } else {
          lampsGroup[lamp.sUBGROUP] = [lamp];
        }
      } else {
        // 未分组
        if (lampsGroup.containsKey('未分组')) {
          var group = lampsGroup['未分组'].add(lamp);
        } else {
          lampsGroup['未分组'] = [lamp];
        }
      }
    });

    // 创建分组视图
 /*   List<Widget> list = [];
    lampsGroup.keys.map((item) {
      List<Lamp> lamps = lampsGroup[item];
      list.add(groupTitle(item));
      list.add(_wrapList(lamps));
    }).toList();
    return list;*/

    List<Widget> list =[];
    list.add(groupTitle('默认分组'));
    list.add(_wrapList(lamps));
    list.add(groupTitle('未分组'));
    list.add(_wrapList(lamps));
    return list;
  }
}
