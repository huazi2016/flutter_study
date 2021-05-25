import 'package:flutter/material.dart';
import 'package:flutter_study/home/room/RoomDetailPage.dart';
import 'package:flutter_study/net/bean/ClassRoomBo.dart';
import 'package:toast/toast.dart';
import 'package:dio/dio.dart';
import '../base/Config.dart';

class RoomSubpage extends StatefulWidget {
  RoomSubpage({Key key}) : super(key: key);

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<RoomSubpage> {
  List<RoomInfoBo> _roomList = [];

  @override
  void initState() {
    super.initState();
    _getTestNet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          alignment: Alignment.center,
          height: 36,
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                //hasFloatingPlaceholder: true,
                prefixIcon: Icon(Icons.search),
                hintText: "输入关键字"),
            autofocus: false,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: _classroomWidget(),
    );
  }

  Widget _classroomWidget() {
    if (this._roomList.length > 0) {
      return Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(top: 5, bottom: 15),
            itemBuilder: (context, index) {
              return Card(
                  margin:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RoomDetailPage(),
                            //传递参数
                            // settings: RouteSettings(
                            //   arguments: this._roomList[index],
                            // ),
                          ));
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 15, right: 15),
                          child: Stack(children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(this._roomList[index].type,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 14)),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                  //width: 50,
                                  height: 25,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        //模拟删除
                                        this._roomList.removeAt(index);
                                      });
                                    },
                                    child: Text("删除"),
                                  )),
                            )
                          ]),
                        ),
                        //SizedBox(height: 5),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Stack(children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(this._roomList[index].title,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black,
                                      //fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                          ]),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Stack(children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(this._roomList[index].content,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      //fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ),
                          ]),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 10),
                          child: Stack(children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(this._roomList[index].teacher,
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 12)),
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(this._roomList[index].createTime,
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 12)))
                          ]),
                        ),
                      ],
                    ),
                  ));
            },
            itemCount: _roomList.length),
      );
    } else {
      return Text("");
    }
  }

  _getTestNet() async {
    var api = "${Config.domain}/course/search";
    var result = await Dio().post(api, data: {"title": "语文"});
    var roomList = ClassRoomBo.fromJson(result.data);
    // Toast.show("获取到了" + _roomList.length.toString(), context,
    //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    setState(() {
      _roomList = roomList.data;
      Toast.show("获取到了" + _roomList.length.toString(), context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      //print("获取到了" + _roomList.length.toString());
    });
  }
}
