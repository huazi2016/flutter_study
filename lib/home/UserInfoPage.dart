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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("修改信息"),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
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
    );
  }
}
