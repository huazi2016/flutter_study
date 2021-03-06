import 'package:flutter/material.dart';
import 'package:flutter_study/base/utils/SpUtil.dart';
import 'package:flutter_study/home/news/AddNewsPage.dart';
import 'package:flutter_study/home/news/NewsDetailPage.dart';
import 'package:flutter_study/home/news/NewsDiscussPage.dart';
import 'package:flutter_study/home/news/NewsSignPage.dart';
import 'package:flutter_study/net/bean/NewsBo.dart';
import 'package:toast/toast.dart';
import 'package:dio/dio.dart';
import '../base/Config.dart';
import '../net/bean/RegisterBo.dart';

class NewsSubpage extends StatefulWidget {
  NewsSubpage({Key key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<NewsSubpage> {
  List<NewsInfoBo> _newsList = [];
  TextEditingController wordController;
  bool _isTeacher = false;

  @override
  void initState() {
    wordController = TextEditingController();
    super.initState();
    print("111111111=_NewsState");
    _getMessageList("");
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
                  _getMessageList(wordController.text.trim());
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
                _navigateAddRoom(context);
              },
            ),
          ),
        ));
  }

  _navigateAddRoom(BuildContext context) async {
    final isSuccess = await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => AddNewsPage()),
    );
    if (isSuccess) {
      setState(() {
        _getMessageList("");
      });
    }
  }

  Widget _classroomWidget() {
    if (this._newsList.length > 0) {
      return RefreshIndicator(
        onRefresh: () async {
          await _getMessageList("");
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
                      if (_newsList[index].type == "互动") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDiscussPage(
                                  detailBo: this._newsList[index]),
                            ));
                      } else if (_newsList[index].type == "签到") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewsSignPage(detailBo: _newsList[index]),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetailPage(detailBo: _newsList[index]),
                            ));
                      }
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 15, right: 15),
                          child: Stack(children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("类型：" + this._newsList[index].type,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 14)),
                            ),
                            Visibility(
                                visible: _isTeacher,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: SizedBox(
                                      //width: 50,
                                      height: 25,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _deleteMessage(
                                              this._newsList[index].messageId,
                                              index);
                                        },
                                        child: Text("删除"),
                                      )),
                                ))
                          ]),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Stack(children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(this._newsList[index].title,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black,
                                      //fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ),
                          ]),
                        ),
                        SizedBox(height: 3),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Stack(children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(this._newsList[index].content,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      //fontWeight: FontWeight.bold,
                                      fontSize: 13)),
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
                              child: Text(this._newsList[index].teacher,
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 12)),
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(this._newsList[index].createTime,
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 12)))
                          ]),
                        ),
                      ],
                    ),
                  ));
            },
            itemCount: _newsList.length),
      );
    } else {
      return Text("");
    }
  }

  _getMessageList(title) async {
    var api = "${Config.domain}/message/list";
    var result = await Dio().get(api + "?title=" + title + "&talkId=" + "");
    var newsList = NewsBo.fromJson(result.data);
    if (newsList.code == 0) {
      setState(() {
        _newsList = newsList.data;
      });
    } else {
      Toast.show("获取异常, 暂无数据", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  _deleteMessage(messageId, index) async {
    var api = "${Config.domain}/message/delete";
    var result = await Dio().get(api + "?messageId=" + messageId.toString());
    var newsBo = RegisterBo.fromJson(result.data);
    if (newsBo.code == 0) {
      setState(() {
        this._newsList.removeAt(index);
      });
    } else {
      Toast.show("删除失败", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }
}
