import 'package:flutter/material.dart';

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

  void _registerClick() {
    // String hint = "";
    // if (phoneController.text.length == 0) {
    //   hint = "账号不能为空";
    // } else if (phoneController.text.length < 3) {
    //   hint = "账号至少3位数";
    // } else if (passController.text.length == 0) {
    //   hint = "密码不能为空";
    // } else if (pass2Controller.text.length == 0) {
    //   hint = "确认密码不能为空";
    // }
    // if (hint.isNotEmpty) {
    //   showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //             title: Text(hint),
    //           ));
    // }

    //返回上个页面
    Navigator.pop(context);
  }
}
