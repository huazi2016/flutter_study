import 'package:flutter/material.dart';
import 'package:flutter_study/base/utils/SpUtil.dart';
import 'package:flutter_study/base/utils/ToastUtil.dart';
import 'package:flutter_study/net/bean/RegisterBo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_study/base/Config.dart';

class AddSelfRoutes extends StatefulWidget {
  const AddSelfRoutes({Key key}) : super(key: key);

  @override
  _AddSelfRoutesState createState() => _AddSelfRoutesState();
}

class _AddSelfRoutesState extends State<AddSelfRoutes> {
  TextEditingController titleCont = TextEditingController();
  TextEditingController contentCont = TextEditingController();
  TextEditingController answerCont = TextEditingController();
  TextEditingController imageCont = TextEditingController();

  //选中默认值
  int groupValue = 0;
  int groupExamValue = 0;
  String _selectText = "导学案";
  bool isShow = true;
  String _userName = "";

  @override
  void initState() {
    super.initState();
    _userName = SpUtil.getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        appBar: AppBar(title: Text("发布课程"), centerTitle: true),
        body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("发布人：${this._userName}",
                      style: TextStyle(color: Colors.black54, fontSize: 12)),
                ),
                _QuestionRadioWidget(),
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
                    child: Text("封面图片",
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
                    controller: imageCont,
                    decoration: InputDecoration(
                        //hasFloatingPlaceholder: true,
                        contentPadding: EdgeInsets.all(10),
                        //prefixIcon: Icon(Icons.search),
                        hintText: "请输入链接"),
                    autofocus: false,
                  ),
                ),
                Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("链接(文档仅支持Pdf,视频建议使用mp4)",
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
                        hintText: "请输入链接"),
                    autofocus: false,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                    width: 200,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        String title = titleCont.text.trim();
                        String content = contentCont.text.trim();
                        String url = answerCont.text.trim();
                        String image = imageCont.text.trim();

                        if (title.isEmpty) {
                          ToastUtil.showToastCenter(context, "标题不能为空");
                          return;
                        }
                        if (content.isEmpty) {
                          ToastUtil.showToastCenter(context, "内容不能为空");
                          return;
                        }
                        if (url.isEmpty) {
                          ToastUtil.showToastCenter(context, "链接不能为空");
                          return;
                        }
                        _summitQuestion(this._selectText, title, content, url,
                            image, this._userName);
                      },
                      child: Text("提交"),
                    ))
              ],
            )));
  }

  Row _QuestionRadioWidget() {
    return Row(children: [
      Text("类型："),
      Row(mainAxisSize: MainAxisSize.min, children: [
        Radio(
            value: 0,
            groupValue: groupValue,
            onChanged: (v) {
              setState(() {
                this.groupValue = v;
                this._selectText = "导学案";
              });
            }),
        Text("导学案")
      ]),
      Row(mainAxisSize: MainAxisSize.min, children: [
        Radio(
            value: 1,
            groupValue: groupValue,
            onChanged: (v) {
              setState(() {
                this.groupValue = v;
                this._selectText = "授课包";
              });
            }),
        Text("授课包")
      ]),
      Row(mainAxisSize: MainAxisSize.min, children: [
        Radio(
            value: 2,
            groupValue: groupValue,
            onChanged: (v) {
              setState(() {
                this.groupValue = v;
                this._selectText = "微课";
              });
            }),
        Text("微课")
      ]),
    ]);
  }

  _summitQuestion(type, title, content, url, image, teacher) async {
    var api = "${Config.domain}/course/add";
    var result = await Dio().post(api, data: {
      "type": type, //数学
      "title": title,
      "image": image,
      "video": url,
      "file": url,
      "content": content, //内容
      "teacher": teacher, //发布老师
    });
    var roomBo = RegisterBo.fromJson(result.data);
    var sucessStr = "发布完成";
    if (roomBo.code == 0) {
      //返回上一页, 刷新列表
      Navigator.pop(context, true);
    } else {
      sucessStr = "发布失败, 请稍后重试";
    }
    ToastUtil.showToastBottom(context, sucessStr);
  }
}
