import 'package:flutter/material.dart';
import 'package:flutter_study/base/utils/ToastUtil.dart';
import 'package:flutter_study/net/bean/RegisterBo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_study/base/Config.dart';

class AddRoomPage extends StatefulWidget {
  AddRoomPage({Key key}) : super(key: key);

  @override
  _AddRoomState createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoomPage> {
  TextEditingController courseCont = TextEditingController();
  TextEditingController titleCont = TextEditingController();
  TextEditingController contentCont = TextEditingController();
  TextEditingController answerCont = TextEditingController();
  TextEditingController scoreCont = TextEditingController();
  //选中默认值
  int groupValue = 0;
  String _selectText = "单选题";
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    //ToastUtil.showToastBottom(context, widget.detailBo.title);
    return Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        appBar: AppBar(title: Text("发布课堂题目"), centerTitle: true),
        body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("发布人：杨文老师",
                      style: TextStyle(color: Colors.black54, fontSize: 12)),
                ),
                SizedBox(height: 20),
                Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("科目(譬如:语文/数学等)",
                        style: TextStyle(color: Colors.black87, fontSize: 14)),
                  )
                ]),
                SizedBox(height: 3),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  alignment: Alignment.center,
                  height: 36,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: courseCont,
                    decoration: InputDecoration(
                        //hasFloatingPlaceholder: true,
                        contentPadding: EdgeInsets.all(10),
                        //prefixIcon: Icon(Icons.search),
                        hintText: "请输入科目"),
                    autofocus: false,
                  ),
                ),
                _RadioWidget(),
                Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("标题",
                        style: TextStyle(color: Colors.black87, fontSize: 14)),
                  )
                ]),
                SizedBox(height: 3),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  alignment: Alignment.center,
                  height: 36,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: titleCont,
                    decoration: InputDecoration(
                        //hasFloatingPlaceholder: true,
                        contentPadding: EdgeInsets.all(10),
                        //prefixIcon: Icon(Icons.search),
                        hintText: "请输入标题"),
                    autofocus: false,
                  ),
                ),
                Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("内容",
                        style: TextStyle(color: Colors.black87, fontSize: 14)),
                  )
                ]),
                SizedBox(height: 3),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  alignment: Alignment.center,
                  height: 36,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: contentCont,
                    decoration: InputDecoration(
                        //hasFloatingPlaceholder: true,
                        contentPadding: EdgeInsets.all(10),
                        //prefixIcon: Icon(Icons.search),
                        hintText: "请输入内容"),
                    autofocus: false,
                  ),
                ),
                Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("答案",
                        style: TextStyle(color: Colors.black87, fontSize: 14)),
                  )
                ]),
                SizedBox(height: 3),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  alignment: Alignment.center,
                  height: 36,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: answerCont,
                    decoration: InputDecoration(
                        //hasFloatingPlaceholder: true,
                        contentPadding: EdgeInsets.all(10),
                        //prefixIcon: Icon(Icons.search),
                        hintText: "请输入答案"),
                    autofocus: false,
                  ),
                ),
                Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("分数",
                        style: TextStyle(color: Colors.black87, fontSize: 14)),
                  )
                ]),
                SizedBox(height: 3),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  alignment: Alignment.center,
                  height: 36,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: scoreCont,
                    decoration: InputDecoration(
                        //hasFloatingPlaceholder: true,
                        contentPadding: EdgeInsets.all(10),
                        //prefixIcon: Icon(Icons.search),
                        hintText: "请输入分数"),
                    autofocus: false,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                    width: 200,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        String course = courseCont.text.trim();
                        String title = titleCont.text.trim();
                        String content = contentCont.text.trim();
                        String anwser = answerCont.text.trim();
                        String score = scoreCont.text.trim();
                        if (course.isEmpty) {
                          ToastUtil.showToastCenter(context, "科目不能为空");
                          return;
                        }
                        if (title.isEmpty) {
                          ToastUtil.showToastCenter(context, "标题不能为空");
                          return;
                        }
                        if (content.isEmpty) {
                          ToastUtil.showToastCenter(context, "内容不能为空");
                          return;
                        }
                        if (anwser.isEmpty) {
                          ToastUtil.showToastCenter(context, "答案不能为空");
                          return;
                        }
                        if (score.isEmpty) {
                          ToastUtil.showToastCenter(context, "分数不能为空");
                          return;
                        }
                        _summitAnswer(course, title, this._selectText, content, anwser,
                            "杨文老师", score);
                      },
                      child: Text("提交"),
                    ))
              ],
            )));
  }

  Row _RadioWidget() {
    return Row(children: [
      Text("类型："),
      Row(mainAxisSize: MainAxisSize.min, children: [
        Radio(
            value: 0,
            groupValue: groupValue,
            onChanged: (v) {
              setState(() {
                this.groupValue = v;
                this._selectText = "单选题";
              });
            }),
        Text("单选题")
      ]),
      Row(mainAxisSize: MainAxisSize.min, children: [
        Radio(
            value: 1,
            groupValue: groupValue,
            onChanged: (v) {
              setState(() {
                this.groupValue = v;
                this._selectText = "多选题";
              });
            }),
        Text("多选题")
      ]),
      Row(mainAxisSize: MainAxisSize.min, children: [
        Radio(
            value: 2,
            groupValue: groupValue,
            onChanged: (v) {
              setState(() {
                this.groupValue = v;
                this._selectText = "填空题";
              });
            }),
        Text("填空题")
      ]),
    ]);
  }

  _summitAnswer(course, title, type, content, anwser, teacher, score) async {
    var api = "${Config.domain}/question/add";
    var result = await Dio().post(api, data: {
      "course": course, //数学
      "isPaper": false, //true:试卷  false:课堂作业
      "title": title, //标题
      "type": type, //选择题...
      "content": content, //内容
      "anwser": anwser, //答案
      "teacher": teacher, //发布老师
      "score": score, //分数
    });
    var roomBo = RegisterBo.fromJson(result.data);
    var sucessStr = "发布完成";
    if (roomBo.code == 0) {
      //返回上一页, 刷新列表

    } else {
      sucessStr = "发布失败, 请稍后重试";
    }
    ToastUtil.showToastBottom(context, sucessStr);
  }
}
