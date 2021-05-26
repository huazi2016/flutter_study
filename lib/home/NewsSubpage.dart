import 'package:flutter/material.dart';
import 'package:flutter_study/home/room/RoomDetailPage.dart';
import 'package:flutter_study/net/bean/NewsBo.dart';
import 'package:flutter_study/net/bean/SelfBo.dart';
import 'package:flutter_study/net/bean/RoomBo.dart';
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

  @override
  void initState() {
    wordController = TextEditingController();
    super.initState();
    _getQuestionList("");
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
                _getQuestionList(wordController.text.trim());
              });
            },
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: _classroomWidget(),
      floatingActionButton: FloatingActionButton(
        child: Text("发布"),
        onPressed: () {},
      ),
    );
  }

  Widget _classroomWidget() {
    if (this._newsList.length > 0) {
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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => RoomDetailPage(detailBo: _newsList[index]),
                      //     ));
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
                            Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                  //width: 50,
                                  height: 25,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // setState(() {
                                      //   //模拟删除
                                      //   this._newsList.removeAt(index);
                                      // });
                                      _deleteQuestion(
                                          this._newsList[index].messageId,
                                          index);
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
                              child: Text(this._newsList[index].title,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black,
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

  _getQuestionList(title) async {
    var api = "${Config.domain}/message/list";
    var result = await Dio().get(api + "?title=" + title);
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

  _deleteQuestion(questionId, index) async {
    var api = "${Config.domain}/question/delete";
    var result = await Dio().get(api + "?questionId=" + questionId.toString());
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
