import 'package:flutter/material.dart';
import 'package:flutter_study/base/RoutePages.dart';
import 'package:flutter_study/base/SpUtils.dart';

class MineSubpage extends StatefulWidget {
  MineSubpage({Key key}) : super(key: key);

  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<MineSubpage> {
  var headUrl = "";
  var nickname = "";

  @override
  void initState() {
    super.initState();
    init().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30, right: 20),
                  width: 80,
                  height: 80,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(headUrl),
                  ),
                ),
                Text(
                  nickname,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
          ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(10.0),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              ListTile(
                leading: Icon(Icons.info),
                title: Text(
                  "软件信息",
                  style: TextStyle(color: Colors.black54),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black38,
                ),
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text(
                  "课程表",
                  style: TextStyle(color: Colors.black54),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black38,
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.verified_user),
                title: Text(
                  "版本信息",
                  style: TextStyle(color: Colors.black54),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black38,
                ),
                onTap: () {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("当前已经是最新版本"),
                  ));
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  "退出登录",
                  style: TextStyle(color: Colors.black54),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black38,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('提示'),
                          content: Text('确认退出登录吗？'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('取消'),
                              onPressed: () {
                                Navigator.of(context).pop('cancel');
                              },
                            ),
                            FlatButton(
                              child: Text('确认'),
                              onPressed: () {
                                SpUtils.instance.saveString("headImg", "");
                                SpUtils.instance.saveString("nickname", "");
                                Navigator.of(context).pop('ok');
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    RoutePages.login,
                                    (Route<dynamic> route) => false);
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Future init() async {
    headUrl = await SpUtils.instance.getString("headImg");
    nickname = await SpUtils.instance.getString("nickname");
  }
}
