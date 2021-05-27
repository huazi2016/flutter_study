import 'package:flutter/material.dart';

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
                  onPressed: () {},
                  child: Text("提交"),
                ))
          ],
        ));
  }
}
