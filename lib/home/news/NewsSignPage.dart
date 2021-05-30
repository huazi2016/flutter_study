import 'package:flutter/material.dart';
import 'package:flutter_study/base/Config.dart';
import 'package:flutter_study/base/utils/SpUtil.dart';
import 'package:flutter_study/base/utils/ToastUtil.dart';
import 'package:flutter_study/net/bean/NewsBo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_study/net/bean/RegisterBo.dart';

class NewsSignPage extends StatefulWidget {
  final NewsInfoBo detailBo;

  NewsSignPage({Key key, @required this.detailBo}) : super(key: key);

  @override
  _NewsSignState createState() => _NewsSignState();
}

class _NewsSignState extends State<NewsSignPage> {
  List<NewsInfoBo> _discussList = [];
  bool isShow = true;
  String _userName;
  bool _isTeacher = false;

  @override
  void initState() {
    super.initState();
    _userName = SpUtil.getUserName();
    _isTeacher = SpUtil.isTeacher();
    _getDiscussList("", widget.detailBo.talkId);
  }

  @override
  Widget build(BuildContext context) {
    //widget.detailBo.talkId
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
                  child: Text("全部签到",
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                ),
                Expanded(child: _discussWidget()),
                //SizedBox(height: 30),
                Visibility(
                    visible: !_isTeacher,
                    child: SizedBox(
                        width: 200,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            _submitDiscuss("", widget.detailBo.talkId);
                          },
                          child: Text("签到"),
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
              return Text(_discussList[index].student.toString());
            },
            itemCount: _discussList.length),
      );
    } else {
      return Text("暂无数据");
    }
  }

  //获取签到列表
  _getDiscussList(title, talkId) async {
    var api = "${Config.domain}/message/list";
    print("_getDiscussList--" + talkId);
    var result = await Dio().get(api + "?title=" + title + "&talkId=" + talkId);
    var newsList = NewsBo.fromJson(result.data);
    if (newsList.code == 0) {
      setState(() {
        _discussList.clear();
        _discussList = newsList.data;
        _discussList.removeAt(0);
      });
    } else {
      //ToastUtil.showToastBottom(context, "获取异常, 暂无数据");
    }
  }

  //学生-签到
  _submitDiscuss(content, talkId) async {
    print("_getDiscussList--" + _userName + "--" + content + "--" + talkId);
    var api = "${Config.domain}/message/add";
    var result = await Dio().post(api, data: {
      "type": "互动",
      "title": "-",
      "teacher": "-",
      "content": content,
      "talkId": talkId,
      "student": _userName
    });
    var newsBo = RegisterBo.fromJson(result.data);
    if (newsBo.code == 0) {
      setState(() {
        _getDiscussList("", talkId);
      });
    } else {
      ToastUtil.showToastBottom(context, "提交失败, 请稍后重试");
    }
  }
}
