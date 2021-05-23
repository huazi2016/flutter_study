import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_study/net/bean/RegisterBo.dart';
import 'package:toast/toast.dart';
import '../base/Config.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<RegisterPage> {
  //控制器
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController pass2Controller = TextEditingController();

  ///默认选中的单选框的值
  int groupValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_startRegister();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
        centerTitle: true,
        // actions: <Widget>[
        //   IconButton(
        //       icon: Icon(Icons.arrow_back),
        //       onPressed: () {
        //         Navigator.canPop(context);
        //       })
        // ],
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
            TextField(
              maxLines: 1,
              controller: pass2Controller,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  icon: Icon(Icons.lock),
                  labelText: "再次输入密码"),
              autofocus: false,
            ),
            SizedBox(height: 12),
            _RadioWidget(),
            SizedBox(height: 22),
            SizedBox(
              width: 200,
              height: 45,
              child: ElevatedButton(
                onPressed: _registerClick,
                child: Text("注册"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _RadioWidget() {
    return Row(children: [
      Text("角色选择："),
      Row(mainAxisSize: MainAxisSize.min, children: [
        Radio(
            value: 0,
            groupValue: groupValue,
            onChanged: (v) {
              setState(() {
                this.groupValue = v;
              });
            }),
        Text("学生")
      ]),
      Row(mainAxisSize: MainAxisSize.min, children: [
        Radio(
            value: 1,
            groupValue: groupValue,
            onChanged: (v) {
              setState(() {
                this.groupValue = v;
              });
            }),
        Text("老师")
      ]),
    ]);
  }

//去注册
  _startRegister(username, pwd) async {
    var role = "学生";
    if (groupValue == 1) {
      role = "老师";
    }
    var result = await Dio().post("${Config.domain}/user/register",
        data: {'username': username, 'password': pwd, 'role': role});
    var registerBo = RegisterBo.fromJson(result.data);
    if (registerBo.code == 0) {
      Toast.show("注册成功", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      Navigator.pop(context);
    } else {
      Toast.show(registerBo.msg, context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    }
  }

  void _registerClick() {
    String hint = "";
    var userName = phoneController.text.trim();
    var pwd = passController.text.trim();
    var pwd02 = pass2Controller.text.trim();
    if (userName.length == 0) {
      hint = "账号不能为空";
    } else if (userName.length < 3) {
      hint = "账号至少3位数";
    } else if (pwd.length == 0) {
      hint = "密码不能为空";
    } else if (pass2Controller.text.length == 0) {
      hint = "确认密码不能为空";
    } else if (pwd != pwd02) {
      hint = "两次密码不一致";
    }
    if (hint.isNotEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(hint),
              ));
      return;
    }
    //返回上个页面
    //Navigator.pop(context);
    _startRegister(userName, pwd);
  }
}
