import 'package:flutter/material.dart';
import 'package:flutter_study/base/utils/SpUtil.dart';
import 'package:flutter_study/base/utils/ToastUtil.dart';
import 'package:dio/dio.dart';
import 'package:flutter_study/base/Config.dart';
import 'package:flutter_study/net/bean/RegisterBo.dart';

class AddNewsPage extends StatefulWidget {
  AddNewsPage({Key key}) : super(key: key);

  @override
  _AddNewsState createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNewsPage> {
  TextEditingController courseCont = TextEditingController();
  TextEditingController titleCont = TextEditingController();
  TextEditingController contentCont = TextEditingController();
  TextEditingController answerCont = TextEditingController();
  TextEditingController scoreCont = TextEditingController();
  //选中默认值
  int groupValue = 0;
  String _selectText = "公告";
  bool isShow = true;
  String userName = "";

  @override
  void initState() {
    super.initState();
    userName = SpUtil.getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        appBar: AppBar(title: Text("发布"), centerTitle: true),
        body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("发布人：" + userName + "老师",
                      style: TextStyle(color: Colors.black54, fontSize: 12)),
                ),
                SizedBox(height: 20),
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
                SizedBox(height: 20),
                SizedBox(
                    width: 200,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        String title = titleCont.text.trim();
                        String content = contentCont.text.trim();
                        if (title.isEmpty) {
                          ToastUtil.showToastCenter(context, "标题不能为空");
                          return;
                        }
                        if (content.isEmpty) {
                          ToastUtil.showToastCenter(context, "内容不能为空");
                          return;
                        }
                        _summitMessage(title, this._selectText, content);
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
                this._selectText = "公告";
              });
            }),
        Text("公告")
      ]),
      Row(mainAxisSize: MainAxisSize.min, children: [
        Radio(
            value: 1,
            groupValue: groupValue,
            onChanged: (v) {
              setState(() {
                this.groupValue = v;
                this._selectText = "签到";
              });
            }),
        Text("签到")
      ]),
      Row(mainAxisSize: MainAxisSize.min, children: [
        Radio(
            value: 2,
            groupValue: groupValue,
            onChanged: (v) {
              setState(() {
                this.groupValue = v;
                this._selectText = "互动";
              });
            }),
        Text("互动")
      ]),
      Row(mainAxisSize: MainAxisSize.min, children: [
        Radio(
            value: 3,
            groupValue: groupValue,
            onChanged: (v) {
              setState(() {
                this.groupValue = v;
                this._selectText = "签到";
              });
            }),
        Text("通知")
      ]),
    ]);
  }

  //学生-新增题目
  _summitMessage(title, type, content) async {
    var api = "${Config.domain}/message/add";
    var result = await Dio().post(api, data: {
      "title": title, //标题
      "type": type, //选择题...
      "content": content, //内容
      "teacher": userName, //发布老师
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
