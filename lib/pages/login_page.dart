import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ldfluttersmartcity2/config/service_url.dart';
import 'package:ldfluttersmartcity2/dialog/progress_dialog.dart';
import 'package:ldfluttersmartcity2/entity/json/login_Info.dart';
import 'package:ldfluttersmartcity2/pages/amap_page.dart';
import 'package:ldfluttersmartcity2/utils/dio_utils.dart';
import 'package:ldfluttersmartcity2/utils/http_util.dart';
import 'package:ldfluttersmartcity2/utils/shared_preference_util.dart';
import 'package:oktoast/oktoast.dart';

class LoginPage extends StatefulWidget {
  // 是否是重新登录
  bool isAfresh;

  //  根据 token 判断是否需要登录
  bool isLogin = false;

  LoginPage(this.isAfresh);

  @override
  _LoginPageState createState() => _LoginPageState(isAfresh);
}

class _LoginPageState extends State<LoginPage> {
  //焦点
  FocusNode _focusNodeUserName = new FocusNode();
  FocusNode _focusNodePassWord = new FocusNode();
  FocusNode _focusNodeServerAddress = new FocusNode();

  //用户名输入框控制器，此控制器可以监听用户名输入框操作
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _userPassController = new TextEditingController();

  //表单状态
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey _serverKey = new GlobalKey(); //用来标记控件

  List _services =[]; //历史服务器地址

  var _password = ''; //用户名
  var _username = ''; //密码
  var _serviceAddress; // 服务器地址
  var _isShowPwd = false; //是否显示密码
  var _isShowClear = false;

  bool isAfresh;
  bool _expand = false; //是否展示历史服务器地址下拉列表

  _LoginPageState(this.isAfresh); //是否显示输入框尾部的清除按钮

  @override
  void initState() {
    //设置焦点监听
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);

    // 获取保存的登录信息
    getUserInfo();

    // 获取服务器登录信息
    _gainServiceAddress();

    //监听用户名框的输入改变
    _userNameController.addListener(() {
      print(_userNameController.text);

      // 监听文本框输入变化，当有内容的时候，显示尾部清除按钮，否则不显示
      if (_userNameController.text.length > 0) {
        _isShowClear = true;
      } else {
        _isShowClear = false;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // 移除焦点监听
    _focusNodeUserName.removeListener(_focusNodeListener);
    _focusNodePassWord.removeListener(_focusNodeListener);
    _userNameController.dispose();
    super.dispose();
  }

  // 监听焦点
  Future<Null> _focusNodeListener() async {
    if (_focusNodeUserName.hasFocus) {
      print("用户名框获取焦点");
      // 取消密码框的焦点状态
      _focusNodePassWord.unfocus();
    }
    if (_focusNodePassWord.hasFocus) {
      print("密码框获取焦点");
      // 取消用户名框焦点状态
      _focusNodeUserName.unfocus();
    }
  }

  /**
   * 验证用户名
   */
  String validateUserName(value) {
    // 正则匹配手机号
    /*  RegExp exp = RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    if (value.isEmpty) {
      return '用户名不能为空!';
    } else if (!exp.hasMatch(value)) {
      return '请输入正确用户名';
    }
    return null;*/
    if (value.isEmpty) {
      return '用户名不能为空!';
    }
    return null;
  }

  /**
   * 验证密码
   */
  String validatePassWord(value) {
    if (value.isEmpty) {
      return '密码不能为空';
    } else if (value.trim().length < 6 || value.trim().length > 18) {
      return '密码长度不正确';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // 使用flutter界面尺寸框架
    ScreenUtil.init(context, width: 750, height: 1334);
    print(ScreenUtil().scaleHeight);

    // logo 图片区域
    Widget logoImageArea = new Container(
      alignment: Alignment.topCenter,
      // 设置图片为圆形
      child: Image.asset(
        "images/login_logo.png",
        fit: BoxFit.cover,
      ),
    );

    //输入文本框区域
    Widget inputTextArea = new Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      child: new Form(
        key: _formKey,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _userNameController,
              focusNode: _focusNodeUserName,
              //设置键盘类型
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "用户名",
                hintText: "请输入帐号",
                prefixIcon: Icon(Icons.person),
                //尾部添加清除按钮
                suffixIcon: (_isShowClear)
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          // 清空输入框内容
                          _userNameController.clear();
                        },
                      )
                    : null,
              ),
              //验证用户名
              //  validator: validateUserName,
              //保存数据
              onSaved: (String value) {
                _username = value;
              },
            ),
            new TextFormField(
              controller: _userPassController,
              focusNode: _focusNodePassWord,
              //设置键盘类型
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "请输入密码",
                  prefixIcon: Icon(Icons.lock),
                  // 是否显示密码
                  suffixIcon: IconButton(
                    icon: Icon(
                        (_isShowPwd) ? Icons.visibility : Icons.visibility_off),
                    // 点击改变显示或隐藏密码
                    onPressed: () {
                      setState(() {
                        _isShowPwd = !_isShowPwd;
                      });
                    },
                  )),
              obscureText: !_isShowPwd,
              //密码验证
              //  validator: validatePassWord,
              //保存数据
              onSaved: (String value) {
                _password = value;
              },
            )
          ],
        ),
      ),
    );

    // 登录按钮区域
    Widget loginButtonArea = new Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 45.0,
      width: double.infinity,
      child: new RaisedButton(
        color: Colors.blue[300],
        child: Text(
          "登录",
          style: Theme.of(context).primaryTextTheme.headline,
        ),
        // 设置按钮圆角
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onPressed: () {
          // 显示加载框
          ProgressDialog.showProgress(context);

          //点击登录按钮，解除焦点，回收键盘
          _focusNodePassWord.unfocus();
          _focusNodeUserName.unfocus();
          _focusNodeServerAddress.unfocus();

          if (_formKey.currentState.validate()) {
            //只有输入通过验证，才会执行这里
            _formKey.currentState.save();

            if (!_username.isEmpty && !_password.isEmpty) {
              // 登录
              var formData = {'username': _username, 'password': _password};
              String url = _serviceAddress + Api.PROFILE + Api.CONTENT_TYPE_USER_LOGIN;
              logtinRequest(url, formData: formData).then((val) {
                print("loginInfo = " + val.toString());
                if (val == null) {
                  // 关闭加载框
                  ProgressDialog.hideProgress(context);
                  showToast('请检查您的网络设置！', position: ToastPosition.bottom);
                  return;
                }

                // 关闭加载框
                ProgressDialog.hideProgress(context);

                // 解析 json
                var data = json.decode(val.toString());
                LoginInfo loginInfo = LoginInfo.fromJson(data);


                if (loginInfo.errno == 0) {
                  // 登录成功
                  print("loginInfo = " + loginInfo.toString());
                  print("loginInfo.data.token = " + loginInfo.data.token.token);

                  // 设置当前服务器地址
                  Api.instance.urlBase = _serviceAddress;

                  // 登录成功保存当前服务地址
                  if(_services != null){
                    if(!_services.contains(_serviceAddress)){
                      _services.insert(0, _serviceAddress);
                    }else{
                      _services.remove(_serviceAddress);
                      _services.insert(0, _serviceAddress);
                    }
                  }else{
                 //   _services = new List<String>()..add(_serviceAddress);
                    _services = [] ;
                    _services.add(_serviceAddress);
                  }
                  SharedPreferenceUtil.set(
                      SharedPreferenceUtil.SERVICE_IP, json.encode(_services))
                      .then((val) {
                    print('服务器地址保存 = $val');
                  });

                  // 保存登录信息
                  // SharedPreferenceUtil.set('username', _userNameController.text);
                  SharedPreferenceUtil.set(
                          SharedPreferenceUtil.LOGIN_INFO, json.encode(loginInfo))
                      .then((val) {
                    print('登录信息保存 = $val');
                  });

                  //导航到新路由，并关闭当前界面
                  //跳转并关闭当前页面
                  //跳转并关闭当前页面
                  Navigator.pushAndRemoveUntil(
                    context,
                    new MaterialPageRoute(
                        settings: RouteSettings(name: "/AmapPage"),
                        builder: (context) => new AmapPage()),
                    (route) => route == null,
                  );
                } else {
                  // 登录失败
                  showToast(loginInfo.errmsg, position: ToastPosition.bottom);
                }
              });
            } else {
              // 关闭加载框
              ProgressDialog.hideProgress(context);
              showToast('用户名或密码不能为空！', position: ToastPosition.bottom);
              //   showToast("hello world");  // 可选属性看自己需求
              // toast('用户名或密码不能为空！');
            }
          }
        },
      ),
    );

    return Scaffold(
      // backgroundColor: Colors.amberAccent,

      // 外层添加一个手势，用于点击空白部分，回收键盘
      body: new GestureDetector(
          onTap: () {
            // 点击空白区域，回收键盘
            print("点击了空白区域");
            _focusNodePassWord.unfocus();
            _focusNodeUserName.unfocus();
            _focusNodeServerAddress.unfocus();
            // 服务器历史下拉列表状体设置为 flse;
            setState(() {
              _expand = false;
            });
          },
          child: DecoratedBox(
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/catalog_lighting_bg.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(0.0),
            ),
            position: DecorationPosition.background,
//            position: DecorationPosition.background,
            child: Container(
              padding: EdgeInsets.all(50.0),
              child: new ListView(
                children: <Widget>[
                  new SizedBox(
                    height: ScreenUtil().setHeight(160),
                  ),
                  logoImageArea,
                  getLoginItem(inputTextArea, loginButtonArea),
                ],
              ),
            ),
          )),
    );
  }

  /**
   *  获取保存的登录信息
   */
  void getUserInfo() {
    // 设置默认值
    //  _userNameController.text = "ld";
    // _userPassController.text = "ld9102";

    // 获取上一次登录信息
    SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
      if (val == null) {
        showLogin();
        return;
      }

      // 判断是否是重新登录，如果是重新登录不许要校验 token
      if (isAfresh) {
        showLogin();
        return;
      }


      // 解析 json
      var data = json.decode(val);
      LoginInfo loginInfo = LoginInfo.fromJson(data);

      if (loginInfo != null) {
        // 设置当前用户名
        _userNameController.text = loginInfo.data.token.username;

        DioUtils.requestHttp(
          Api.instance.getServicePath('CONTENT_TYPE_USER_TOKEN'),
          token: loginInfo.data.token.token,
          method: DioUtils.POST,
          onSuccess: (String data) async {
            // 解析 json
            if ('OK' == data) {
              //跳转并关闭当前页面
              Navigator.pushAndRemoveUntil(
                context,
                new MaterialPageRoute(
                    settings: RouteSettings(name: "/AmapPage"),
                    builder: (context) => new AmapPage()),
                (route) => route == null,
              );
            } else {
              showLogin();
            }
          },
          onError: (error) {
            showLogin();
            print(' DioUtils.requestHttp error = $error');
          },
        );
      }
    });


  }

  void showLogin() {
    setState(() {
      widget.isLogin = true;
    });
  }

  /**
   *   根据当前登陆状态返回登录界面
   */
  Widget getLoginItem(Widget inputTextArea, Widget loginButtonArea) {
    if (widget.isLogin) {
      return Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              _buildServerAddress(),
              new SizedBox(
                height: ScreenUtil().setHeight(0),
              ),
              inputTextArea,
              new SizedBox(
                height: ScreenUtil().setHeight(80),
              ),
              loginButtonArea,
            ],
          ),
          Offstage(
            child: downView(),
            offstage: !_expand,
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.fromLTRB(
                0.0, ScreenUtil().setSp(65.0), 0.0, ScreenUtil().setSp(10.0)),
            child: new Center(
              child: SpinKitFadingCircle(
                color: Colors.blueAccent,
                size: 40.0,
              ),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: new Center(
              child: new Text('正在加载中~',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(36), color: Colors.white)),
            ),
          ),
        ],
      );
    }
  }


  Widget downView() {
    if (_expand) {
      List<Widget> children = _buildServiceItems();
      if (children.length > 0) {
        // 获取控件的坐标
        RenderBox renderObject = _serverKey.currentContext.findRenderObject();

        final position = renderObject.localToGlobal(Offset.zero);
        double screenW = MediaQuery.of(context).size.width;
        double currentW = renderObject.paintBounds.size.width;
        double currentH = renderObject.paintBounds.size.height;
        double margin = (screenW - currentW) / 2;
        double offsetY = position.dy;
        double itemHeight = renderObject.paintBounds.size.width;
        double dividerHeight = 2;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.blue, width: 2),
          ),
          child: ListView(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
            children: children,
          ),
          width: currentW,
          //  height:  children.length < 10?(children.length * itemHeight + (children.length - 1) * dividerHeight):(10 * itemHeight + (children.length - 1)* dividerHeight ),
          height:  itemHeight,
          //  margin: EdgeInsets.fromLTRB(20, currentH - dividerHeight+20, 0, 0),
          // margin: EdgeInsets.fromLTRB(20, currentH - dividerHeight-5, 20, 0),
          margin: EdgeInsets.fromLTRB(20, currentH - 7, 20, 0),
        );
      }
    }
    return null;
  }

  /**
   * 构建历史记录items
   */
  List<Widget> _buildServiceItems() {
    List<Widget> list = new List();
    for (int i = 0; i < _services.length; i++) {
      if (_services[i] != _serviceAddress) {
        //增加账号记录
        list.add(_buildItem(_services[i]));
        //增加分割线
        /*   list.add(Divider(
          color: Colors.grey,
          height: 2,
        ));*/
      }
    }
    return list;
  }

  /**
   * 构建单个历史记录item
   */
  Widget _buildItem(String serviceip) {

    return Container(
      child: GestureDetector(
        child: Column(
          children: <Widget>[
            Container(
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child:  Text(serviceip, maxLines: 3),
                    ),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.highlight_off,
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _services.remove(serviceip);
                        // SharedPreferenceUtil.delUser(user);
                        SharedPreferenceUtil.set(SharedPreferenceUtil.SERVICE_IP, json.encode(_services));
                        //处理最后一个数据，假如最后一个被删掉，将Expand置为false
                        if (!(_services.length > 1 ||
                            _services[0] != serviceip)) {
                          //如果个数大于1个或者唯一一个账号跟当前账号不一样才弹出历史账号
                          _expand = false;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 2,
            )
          ],
        ),
        onTap: () {
          setState(() {
            _serviceAddress = serviceip;
            _expand = false;
          });
        },
      ),
    );
  }

  /**
   * 创建服务器地址输入框
   */
  Widget _buildServerAddress() {
    return Container(
      key: _serverKey,
      margin: EdgeInsets.only(left: 20, right: 20,top: 20,bottom: 5),
      decoration: new BoxDecoration(
          borderRadius:BorderRadius.all(Radius.circular(10)),
          //BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      child: TextFormField(
        focusNode: _focusNodeServerAddress,
        decoration: InputDecoration(
          hintText: "服务器地址",
          //    border: OutlineInputBorder(borderSide: BorderSide()),
          //  contentPadding: EdgeInsets.only(top: 8,bottom: 8),
          fillColor: Colors.white,
          // filled: true,
          prefixIcon: Icon(Icons.language),
          suffixIcon: GestureDetector(
            onTap: () {
              // 点击禁止跳出输入法
              // Unfocus all focus nodes
              _focusNodeServerAddress.unfocus();
              // Disable text field's focus node request
              _focusNodeServerAddress.canRequestFocus = false;
              //Enable the text field's focus node request after some delay
              Future.delayed(Duration(milliseconds: 100), () {
                _focusNodeServerAddress.canRequestFocus = true;
              });

              //如果个数大于1个或者唯一一个账号跟当前账号不一样才弹出历史账号
              setState(() {
                _expand = !_expand;
              });
            },
            child: _expand
                ? Icon(
              Icons.arrow_drop_up,
              color: Colors.red,
            )
                : Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            ),
          ),
        ),
        controller: TextEditingController.fromValue(
          TextEditingValue(
            text: _serviceAddress,
            selection: TextSelection.fromPosition(
              TextPosition(
                affinity: TextAffinity.downstream,
                offset: _serviceAddress == null ? 0 : _serviceAddress.length,
              ),
            ),
          ),
        ),
        onChanged: (value) {
          _serviceAddress = value;
        },
      ),);
  }



  /**
   * 获取服务器地址历史
   */
  void _gainServiceAddress() async {

    SharedPreferenceUtil.get(SharedPreferenceUtil.SERVICE_IP).then((val) {

      _services.clear();
      if(val != null){
        _services = json.decode(val);
      }else{
        _services.add('https://iot2.sz-luoding.com:2888');
      }

      //默认加载第一个账号
      if (_services.length > 0) {
        _serviceAddress = _services[0];
      }
      print('服务器地址获取 = $val');
    });

  }

}
