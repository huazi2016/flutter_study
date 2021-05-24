import 'package:flutter/material.dart';
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
    SpUtils.instance.getString("headImg").then((value) => headUrl = value);
    SpUtils.instance.getString("nickname").then((value) => nickname = value);
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
                  margin: EdgeInsets.only(left: 30, right: 10),
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
          Text("test"),
          ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(10.0),
              cacheExtent:30,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.list),
                  title: Text("标题"),
                  trailing: Icon(Icons.keyboard_arrow_right),
                );
              },
              itemCount: 10)
        ],
      ),
    );
  }

  String _setHeadUrl() {
    setState(() {
      var headUrl = "";
      SpUtils.instance.getString("headImg").then((value) => headUrl = value);
      return headUrl;
    });
  }
}
