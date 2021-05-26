import 'package:flutter/material.dart';
import 'package:flutter_study/home/SelfSubpage.dart';
import 'package:lazy_indexed_stack/lazy_indexed_stack.dart';
import 'NewsSubpage.dart';
import 'RoomSubpage.dart';
import 'MineSubpage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomTabs();
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
        top: false,
        child: Scaffold(
          body: LazyIndexedStack(
            itemBuilder: (context, index) => this._pageList[this._currentIndex],
            itemCount: this._pageList.length,
            index: this._currentIndex,
          ),
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
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text("课程")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), title: Text("自学")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message), title: Text("消息")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people), title: Text("我的")),
            ],
          ),
          resizeToAvoidBottomInset: false,
        ));
  }
}
