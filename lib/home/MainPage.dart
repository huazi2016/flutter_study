import 'package:flutter/material.dart';
import 'package:flutter_study/home/SelfSubpage.dart';
import 'RoomSubpage.dart';
import 'SelfSubpage.dart';
import 'NewsSubpage.dart';
import 'MineSubpage.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainState();
  }
}

class MainState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: 22),
      child: Scaffold(
        body: BottomTabs(),
      ),
    );
  }
}

class BottomTabs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomTabState();
  }
}

class BottomTabState extends State<BottomTabs> {
  int _currentIndex = 0;

  List _pageList = [RoomSubpage(), SelfSubpage(), NewsSubpage(), MineSubpage()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // appBar: AppBar(
      //   title: Text("我是标题"),
      // ),
      body: this._pageList[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndex,
        onTap: (index) {
          setState(() {
            print(index.toString());
            this._currentIndex = index;
          });
        },
        //超过2个以上, 务必设置type
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("课程")),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text("自学")),
          BottomNavigationBarItem(icon: Icon(Icons.message), title: Text("消息")),
          BottomNavigationBarItem(icon: Icon(Icons.people), title: Text("我的")),
        ],
      ),
      resizeToAvoidBottomInset: false,
    ));
  }
}
