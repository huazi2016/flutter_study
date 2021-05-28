import 'package:flutter/material.dart';
import 'package:flutter_study/base/utils/SpUtil.dart';
import 'package:flutter_study/net/bean/NewsBo.dart';

class NewsDetailPage extends StatefulWidget {
  final NewsInfoBo detailBo;
  NewsDetailPage({Key key, @required this.detailBo}) : super(key: key);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetailPage> {
  TextEditingController answerController = TextEditingController();
  bool isShow = true;
  bool _isTeacher = true;

  @override
  void initState() {
    super.initState();
    _isTeacher = SpUtil.isTeacher();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        appBar: AppBar(title: Text(widget.detailBo.type + "详情"), centerTitle: true),
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
              ],
            )));
  }
}
