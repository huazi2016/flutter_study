import 'package:flutter/material.dart';
import 'package:flutter_study/base/RoutePages.dart';
import 'package:flutter_study/base/utils/SpUtil.dart';
import 'package:flutter_study/net/bean/RoomBo.dart';
import 'package:flutter_study/net/bean/SelfBo.dart';
import 'package:toast/toast.dart';
import 'package:dio/dio.dart';
import '../base/Config.dart';
import '../net/bean/RegisterBo.dart';

class SelfSubpage extends StatefulWidget {
  SelfSubpage({Key key}) : super(key: key);

  @override
  _SelfState createState() => _SelfState();
}

class _SelfState extends State<SelfSubpage> {
  List<SelfInfoBo> _selfList = [];
  TextEditingController wordController;
  bool _isTeacher = false;

  @override
  void initState() {
    wordController = TextEditingController();
    super.initState();
    print("111111111=_SelfState");
    _getSelfList("");
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
                setState(() {
                  _getSelfList(wordController.text.trim());
                });
              },
            )
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: _classroomWidget(),
        floatingActionButton: Container(
          child: Visibility(
            visible: _isTeacher,
            child: FloatingActionButton(
              child: Text("发布"),
              onPressed: () {
                Navigator.pushNamed(context, RoutePages.addSelf);
              },
            ),
          ),
        ));
  }

  List<RoomDetailBo> _roomList = [];

  Widget _classroomWidget() {
    if (this._selfList.length > 0) {
      return RefreshIndicator(
        onRefresh: () async {
          await _getSelfList("");
          setState(() {});
        },
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(top: 5, bottom: 15),
            itemBuilder: (context, index) {
              return Card(
                  margin:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutePages.self_detail,
                          arguments: _selfList[index]);
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 15, right: 15),
                          child: Stack(children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("类型：" + this._selfList[index].type,
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
                                      if (_isTeacher) {
                                        _deleteSelf(
                                            this._selfList[index].courseId,
                                            index);
                                      } else {
                                        queryScore(
                                          SpUtil.getUserName(),
                                          this._selfList[index].title,
                                        );
                                      }
                                    },
                                    child: Text(_isTeacher ? "删除" : "查分"),
                                  )),
                            )
                          ]),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Stack(children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(this._selfList[index].title,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black,
                                      //fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                          ]),
                        ),
                        SizedBox(height: 3),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Stack(children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(this._selfList[index].content,
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
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Stack(children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 100,
                                child: Image.network(
                                    this._selfList[index].image,
                                    fit: BoxFit.fill),
                              ),
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
                              child: Text(this._selfList[index].teacher,
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 12)),
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(this._selfList[index].createTime,
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 12)))
                          ]),
                        ),
                      ],
                    ),
                  ));
            },
            itemCount: this._selfList.length),
      );
    } else {
      return Text("");
    }
  }

  _getSelfList(title) async {
    var api = "${Config.domain}/course/search";
    var result = await Dio().post(api, data: {"title": title});
    var selfList = SelfBo.fromJson(result.data);
    if (selfList.code == 0) {
      setState(() {
        this._selfList = selfList.data;
      });
    } else {
      Toast.show("获取异常, 暂无数据", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  _deleteSelf(courseId, index) async {
    var api = "${Config.domain}/course/delete";
    var result = await Dio().get(api + "?courseId=" + courseId.toString());
    var selfBo = RegisterBo.fromJson(result.data);
    if (selfBo.code == 0) {
      setState(() {
        this._selfList.removeAt(index);
      });
    } else {
      Toast.show("删除失败", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  void queryScore(String userName, String title) async {
    var api = "${Config.domain}/answer/score";
    var result = await Dio().get(api + "?student=$userName&course=$title");
    var selfBo = RegisterBo.fromJson(result.data);
    if (selfBo.code == 0) {
      print("成绩结果 ${selfBo.toJson()}");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('当前试卷分数'),
            content: Text(
                '''${SpUtil.getUserName()},您当前已经获得: ${selfBo.data??0} 分!'''),
            actions: <Widget>[
              FlatButton(
                child: Text('ok'),
                onPressed: () {
                  Navigator.of(context).pop('cancel');
                },
              ),
            ],
          );
        },
      );
    } else {
      Toast.show("删除失败", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }
}
