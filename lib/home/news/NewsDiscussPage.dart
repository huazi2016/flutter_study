import 'package:flutter/material.dart';
import 'package:flutter_study/base/Config.dart';
import 'package:flutter_study/base/utils/SpUtil.dart';
import 'package:flutter_study/base/utils/ToastUtil.dart';
import 'package:flutter_study/net/bean/NewsBo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_study/net/bean/RegisterBo.dart';

class NewsDiscussPage extends StatefulWidget {
  final NewsInfoBo detailBo;

  NewsDiscussPage({Key key, @required this.detailBo}) : super(key: key);

  @override
  _NewsDiscussState createState() => _NewsDiscussState();
}

class _NewsDiscussState extends State<NewsDiscussPage> {
  List<NewsInfoBo> _discussList = [];
  bool isShow = true;
  TextEditingController discussCont = TextEditingController();
  String _userName;
  bool _isTeacher = false;

  @override
  void initState() {
    super.initState();
    _userName = SpUtil.getUserName();
    _isTeacher = SpUtil.isTeacher();

    var newsBo01 = NewsInfoBo();
    newsBo01.title = _userName;
    newsBo01.content = "我来了, 这个好看";
    this._discussList.add(newsBo01);

    var newsBo02 = NewsInfoBo();
    newsBo02.title = _userName;
    newsBo02.content = "詹姆斯牛逼";
    this._discussList.add(newsBo02);

    var newsBo03 = NewsInfoBo();
    newsBo03.title = _userName;
    newsBo03.content = "夏侯惇打不死";
    this._discussList.add(newsBo03);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        appBar:
            AppBar(title: Text(widget.detailBo.type + "详情"), centerTitle: true),
        body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("发布人：" + widget.detailBo.teacher,
                      style: TextStyle(color: Colors.black54, fontSize: 14)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("日期：" + widget.detailBo.createTime,
                      style: TextStyle(color: Colors.black54, fontSize: 12)),
                ),
                SizedBox(height: 20),
                Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.detailBo.title,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  )
                ]),
                SizedBox(height: 10),
                Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.detailBo.content,
                        style: TextStyle(color: Colors.black54, fontSize: 15)),
                  )
                ]),
                SizedBox(height: 18),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("全部评论",
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                ),
                Expanded(child: _discussWidget()),
                Visibility(
                  visible: !_isTeacher,
                  child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    alignment: Alignment.center,
                    height: 36,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: discussCont,
                      decoration: InputDecoration(
                          //hasFloatingPlaceholder: true,
                          contentPadding: EdgeInsets.all(10),
                          //prefixIcon: Icon(Icons.search),
                          hintText: "请输入评论"),
                      autofocus: false,
                    ),
                  ),
                ),
                //SizedBox(height: 30),
                Visibility(
                    visible: !_isTeacher,
                    child: SizedBox(
                        width: 200,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            String discuss = discussCont.text.trim();
                            if (discuss.isNotEmpty) {
                              // _summitAnswer(
                              //     widget.detailBo.questionId, userName, anwser);
                              setState(() {
                                var newsBo = NewsInfoBo();
                                newsBo.title = _userName;
                                newsBo.content = "发布评论369";
                                this._discussList.add(newsBo);
                                discussCont.clear();
                              });
                            } else {
                              ToastUtil.showToastBottom(context, "评论不能为空");
                            }
                          },
                          child: Text("发布"),
                        ))),
              ],
            )));
  }

  Widget _discussWidget() {
    if (this._discussList.length > 0) {
      return Container(
        margin: EdgeInsets.only(left: 12),
        child: ListView.builder(
            //reverse: true,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(top: 5, bottom: 0),
            itemBuilder: (context, index) {
              return Text(_discussList[index].title +
                  ":  " +
                  _discussList[index].content);
            },
            itemCount: _discussList.length),
      );
    } else {
      return Text("");
    }

    //获取评论列表
    _getDiscussList(title) async {
      var api = "${Config.domain}/message/list";
      var result = await Dio().get(api + "?title=" + title);
      var newsList = NewsBo.fromJson(result.data);
      if (newsList.code == 0) {
        setState(() {
          //_discussList = newsList.data;
        });
      } else {
        //ToastUtil.showToastBottom(context, "获取异常, 暂无数据");
      }
    }

    //学生-提交评论
    _submitDiscuss(messageId, index) async {
      var api = "${Config.domain}/message/add";
      var result = await Dio().get(api + "?messageId=" + messageId.toString());
      var newsBo = RegisterBo.fromJson(result.data);
      if (newsBo.code == 0) {
        setState(() {
          //this._discussList.removeAt(index);
        });
      } else {
        ToastUtil.showToastBottom(context, "提交失败, 请稍后重试");
      }
    }
  }
}
