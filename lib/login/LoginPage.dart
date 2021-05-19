import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_study/home/MainPage.dart';
import 'package:flutter_study/login/RegisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return EditTextWidget();
  }
}

class EditTextWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditTextState();
  }
}

class EditTextState extends State<EditTextWidget> {
  //控制器
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //leading: Icon(Icons.arrow_back),
          centerTitle: true,
          //automaticallyImplyLeading: true,
          title: Text("登录"),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 30, right: 30, top: 130),
          child: Column(
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.text,
                maxLines: 1,
                controller: phoneController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    icon: Icon(Icons.account_balance),
                    labelText: "请输入账号"),
                autofocus: true,
              ),
              SizedBox(height: 12),
              TextField(
                //maxLength: 15,
                maxLines: 1,
                controller: passController,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    icon: Icon(Icons.lock),
                    labelText: "请输入密码"),
                autofocus: false,
              ),
              SizedBox(height: 22),
              //嵌套SizedBox, 设置button的宽高
              SizedBox(
                  width: 200,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: _loginClick,
                    child: Text("登录"),
                  )),
              SizedBox(height: 15),
              Container(
                  //借助GestureDetector设置Text点击事件
                  child: GestureDetector(
                child: Text("还没有账号? 去注册"),
                onTap: () {
                  //跳转注册页面
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new RegisterPage()));
                },
              )),
            ],
          ),
        ));
  }

  void _loginClick() {
    // String hint = "";
    // if (phoneController.text.length == 0) {
    //   hint = "账号不能为空";
    // } else if (phoneController.text.length < 3) {
    //   hint = "账号至少3位数";
    // } else if (passController.text.length == 0) {
    //   hint = "密码不能为空";
    // }
    // if (hint.isNotEmpty) {
    //   showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //             title: Text(hint),
    //           ));
    // }
    // phoneController.clear();
    // passController.clear();

    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => MainPage()));
  }
}
