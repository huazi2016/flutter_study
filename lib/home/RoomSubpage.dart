import 'package:flutter/material.dart';
import 'package:flutter_study/base/utils/SpUtil.dart';
import 'package:flutter_study/home/room/AddRoomPage.dart';
import 'package:flutter_study/home/room/questionList.dart';
import 'package:flutter_study/net/bean/RoomBo.dart';

class RoomSubpage extends StatefulWidget {
  RoomSubpage({Key key}) : super(key: key);

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<RoomSubpage> {
  List<RoomDetailBo> _roomList = [];
  TextEditingController wordController;
  bool _isTeacher = false;
  String title = "";
  QuestionListViewModel _viewModel =
      QuestionListViewModel(service: QuestionListService());

  @override
  void initState() {
    wordController = TextEditingController();
    super.initState();
    print("111111111=_RoomState");
    _isTeacher = SpUtil.isTeacher();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            margin: EdgeInsets.only(left: 15, right: 5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            alignment: Alignment.center,
            height: 36,
            child: TextField(
              controller: wordController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  //hasFloatingPlaceholder: true,
                  contentPadding: EdgeInsets.only(top: 0.1),
                  prefixIcon: Icon(Icons.search),
                  hintText: "输入关键字"),
              autofocus: false,
            ),
          ),
          actions: <Widget>[
            InkWell(
              child: Container(
                  margin: EdgeInsets.only(right: 15),
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Text("搜索",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  )),
              onTap: () {
                this.title = (wordController.text.trim());
                _viewModel.demo(title, false);
              },
            )
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: RefreshIndicator(
          onRefresh: () async {
            this.title = "";
            _viewModel.demo(title, false);
          },
          child: QuestionListRoute(
            title: this.title,
            isPaper: false,
            viewModel: _viewModel,
          ),
        ),
        floatingActionButton: Container(
          child: Visibility(
            visible: _isTeacher,
            child: FloatingActionButton(
              child: Text("发布"),
              onPressed: () {
                _navigateAddRoom(context);
              },
            ),
          ),
        ));
  }

  _navigateAddRoom(BuildContext context) async {
    final isSuccess = await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => AddRoomPage()),
    );
    if (isSuccess) {
      this.title = ("");
      _viewModel.demo(title, false);
    }
  }
}
