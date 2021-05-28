import 'package:flutter/material.dart';
import 'package:flutter_study/base/Config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_study/base/utils/SpUtil.dart';
import 'package:flutter_study/base/utils/ToastUtil.dart';
import 'package:flutter_study/net/bean/RegisterBo.dart';

class UserInfoPage extends StatefulWidget {
  UserInfoPage({Key key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfoPage> {
  String img01 =
      "http://www.icosky.com/icon/png/Kids/The%20Batman%20Vol.%201/Alfred%20Pennyworth.png";
  String img02 =
      "http://www.icosky.com/icon/png/Kids/The%20Batman%20Vol.%201/Detective%20Ellen%20Yen.png";
  String img03 =
      "http://www.icosky.com/icon/png/Kids/The%20Batman%20Vol.%201/young%20Bruce%20Wayne.png";
  var num = 80.0;
  TextEditingController headCont = TextEditingController();
  TextEditingController nameCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("修改信息"),
        ),
        body: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                child: Row(
                    //均分
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: num,
                        height: num,
                        child: Image.network(img01, fit: BoxFit.fill),
                      ),
                      Container(
                        width: num,
                        height: num,
                        child: Image.network(img02, fit: BoxFit.fill),
                      ),
                      Container(
                        width: num,
                        height: num,
                        child: Image.network(img03, fit: BoxFit.fill),
                      )
                    ])),
            Stack(children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Text("头像（以上图片从左边往右，编号1、2、3）",
                        style: TextStyle(color: Colors.black, fontSize: 14))),
              )
            ]),
            SizedBox(height: 3),
            Container(
              margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              alignment: Alignment.center,
              height: 36,
              child: TextField(
                keyboardType: TextInputType.text,
                controller: headCont,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10), hintText: "请输入对应的编号"),
                autofocus: false,
              ),
            ),
            Stack(children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    margin: EdgeInsets.only(top: 28, left: 20, right: 20),
                    child: Text("昵称",
                        style: TextStyle(color: Colors.black, fontSize: 14))),
              )
            ]),
            SizedBox(height: 3),
            Container(
              margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              alignment: Alignment.center,
              height: 36,
              child: TextField(
                keyboardType: TextInputType.text,
                controller: nameCont,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10), hintText: "请输入昵称"),
                autofocus: false,
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
                width: 200,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    String imgIndex = headCont.text.trim();
                    String imgUrl = "";
                    if (imgIndex == "1") {
                      imgUrl = img01;
                    } else if (imgIndex == "2") {
                      imgUrl = img02;
                    } else if (imgIndex == "3") {
                      imgUrl = img03;
                    }
                    String nickName = nameCont.text.trim();
                    if (imgIndex.isEmpty && nickName.isEmpty) {
                      ToastUtil.showToastCenter(context, "内容不能为空");
                    }
                    _changeUserInfo(imgUrl, nickName);
                  },
                  child: Text("提交"),
                ))
          ],
        ));
  }

  //获取课堂表信息
  _changeUserInfo(String avatar, String nickname) async {
    var userId = SpUtil.getUserId();
    var api = "${Config.domain}/user/modify";
    print("_changeUserInfo" + userId + avatar + nickname);
    var result = await Dio().post(api,
        data: {"userId": userId, "avatar": avatar, "nickname": nickname});
    var classList = RegisterBo.fromJson(result.data);
    if (classList.code == 0) {
      setState(() {
        var isFlag = false;
        if (avatar.isNotEmpty) {
          isFlag = true;
          SpUtil.putString(SpKeys.SP_HEADURL, avatar);
        }
        if (nickname.isNotEmpty) {
          isFlag = true;
          SpUtil.putString(SpKeys.SP_NickName, nickname);
        }
        Navigator.pop(context, isFlag);
      });
    } else {
      ToastUtil.showToastCenter(context, "修改失败, 请稍后重试");
    }
  }
}
