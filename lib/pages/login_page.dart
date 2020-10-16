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

  //用户名输入框控制器，此控制器可以监听用户名输入框操作
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _userPassController = new TextEditingController();

  //表单状态
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _password = ''; //用户名
  var _username = ''; //密码
  var _isShowPwd = false; //是否显示密码
  var _isShowClear = false;

  bool isAfresh;

  _LoginPageState(this.isAfresh); //是否显示输入框尾部的清除按钮

  @override
  void initState() {
    //设置焦点监听
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);

     getUserInfo();

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
            new TextFormField(
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

          if (_formKey.currentState.validate()) {
            //只有输入通过验证，才会执行这里
            _formKey.currentState.save();

            if (!_username.isEmpty && !_password.isEmpty) {
              // 登录
              var formData = {'username': _username, 'password': _password};
              request('LOGIN_URl', formData: formData).then((val) {
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

                  // 保存登录信息
                  // SharedPreferenceUtil.set('username', _userNameController.text);
                  SharedPreferenceUtil.set(
                          SharedPreferenceUtil.LOGIN_INFO, val.toString())
                      .then((val) {
                    print('登录信息保存 = $val');
                  });


                  //导航到新路由，并关闭当前界面
                  //跳转并关闭当前页面
                  //跳转并关闭当前页面
                  Navigator.pushAndRemoveUntil(
                    context,
                    new MaterialPageRoute(
                        settings: RouteSettings(name:"/AmapPage"),
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
              child:
               new ListView(
                children: <Widget>[
                  new SizedBox(
                    height: ScreenUtil().setHeight(160),
                  ),
                  logoImageArea,

                  getLoginItem(inputTextArea,loginButtonArea),



                ],
              ),
            ),
          )),
    );
  }

  void getUserInfo() {
    // 设置默认值
    //  _userNameController.text = "ld";
    // _userPassController.text = "ld9102";

    // 获取上一次登录信息
    SharedPreferenceUtil.get(SharedPreferenceUtil.LOGIN_INFO).then((val) async {
      if (val == null) {
        return;
      }
      // 解析 json
      var data = json.decode(val);
      LoginInfo loginInfo = LoginInfo.fromJson(data);

      if (loginInfo != null) {
        // 设置当前用户名
        _userNameController.text = loginInfo.data.token.username;

        // 判断是否是重新登录，如果是重新登录不许要校验 token
        if (isAfresh) {
          return;
        }
        DioUtils.requestHttp(
          servicePath['CONTENT_TYPE_USER_TOKEN'],
          token: loginInfo.data.token.token,
          method: DioUtils.POST,
          onSuccess: (String data) async {
            // 解析 json
            if ('OK' == data) {
              //跳转并关闭当前页面
              Navigator.pushAndRemoveUntil(
                context,
                new MaterialPageRoute(
                    settings: RouteSettings(name:"/AmapPage"),
                    builder: (context) => new AmapPage()),
                (route) => route == null,
              );
            }else{
              widget.isLogin = true;
            }
          },
          onError: (error) {
            print(' DioUtils.requestHttp error = $error');
          },
        );
      }
    });
  }


  /**
   *   根据当前登陆状态返回登录界面
   */
  Widget getLoginItem(Widget inputTextArea, Widget loginButtonArea) {

    if(widget.isLogin){
     return Column(children: <Widget>[
       new SizedBox(
         height: ScreenUtil().setHeight(70),
       ),
       inputTextArea,
       new SizedBox(
         height: ScreenUtil().setHeight(80),
       ),
       loginButtonArea,
     ],);
    }else{
      return  Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize:MainAxisSize.min,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, ScreenUtil().setSp(65.0), 0.0,ScreenUtil().setSp(10.0)),
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
              child: new Text('正在加载中~',style: TextStyle(fontSize: ScreenUtil().setSp(36),color: Colors.white)),
            ),
          ),
        ],
      );
    }


  }

}
