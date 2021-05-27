import 'package:flutter/material.dart';
import 'package:flutter_study/base/utils/SpUtil.dart';
import 'package:flutter_study/base/utils/ToastUtil.dart';
import 'package:flutter_study/net/bean/AnswerBo.dart';
import 'package:flutter_study/net/bean/RegisterBo.dart';
import 'package:flutter_study/net/bean/RoomBo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_study/base/Config.dart';

class RoomDetailPage extends StatefulWidget {
  final RoomDetailBo detailBo;
  // RoomDetailPage({Key key}) : super(key: key);
  RoomDetailPage({Key key, @required this.detailBo}) : super(key: key);

  @override
  _RoomDetailState createState() => _RoomDetailState();
}

class _RoomDetailState extends State<RoomDetailPage> {
  TextEditingController answerController = TextEditingController();
  bool isShow = true;
  var userName = "";
  var student = "";
  String replyContent = "";

  @override
  void initState() {
    super.initState();
    this.userName = SpUtil.getUserName();
    if (!SpUtil.isTeacher()) {
      student = userName;
    }
    _getQuestionAnswer(widget.detailBo.questionId, student);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        appBar: AppBar(title: Text("详情"), centerTitle: true),
        body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Text(widget.detailBo.type),
                SizedBox(height: 20),
                Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("问题：" + widget.detailBo.title,
                        maxLines: 2,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  )
                ]),
                SizedBox(height: 10),
                Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.detailBo.content,
                        maxLines: 4,
                        style: TextStyle(color: Colors.black54, fontSize: 15)),
                  )
                ]),
                SizedBox(height: 10),
                Visibility(
                  visible: isShow,
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
                      controller: answerController,
                      decoration: InputDecoration(
                          //hasFloatingPlaceholder: true,
                          contentPadding: EdgeInsets.all(10),
                          //prefixIcon: Icon(Icons.search),
                          hintText: "请输入答案"),
                      autofocus: false,
                    ),
                  ),
                ),
                Visibility(
                    visible: !isShow,
                    child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "你的答案：" +
                                    (isShow
                                        ? answerController.text.trim()
                                        : replyContent),
                                style: TextStyle(
                                    color: Colors.red, fontSize: 16))))),
                SizedBox(height: 30),
                Visibility(
                    visible: isShow,
                    child: SizedBox(
                        width: 200,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            String anwser = answerController.text.trim();
                            if (anwser.isNotEmpty) {
                              _summitAnswer(
                                  widget.detailBo.questionId, userName, anwser);
                            } else {
                              ToastUtil.showToastBottom(context, "答案不能为空");
                            }
                          },
                          child: Text("提交"),
                        ))),
              ],
            )));
  }

  //学生-提交答案
  _summitAnswer(questionId, student, anwser) async {
    var api = "${Config.domain}/answer/add";
    var result = await Dio().post(api, data: {
      "questionId": questionId.toString(),
      "student": student,
      "anwser": anwser
    });
    var roomBo = RegisterBo.fromJson(result.data);
    var sucessStr = "提交完成";
    if (roomBo.code == 0) {
      setState(() {
        //显示答案
        isShow = false;
      });
    } else {
      sucessStr = "提交失败, 请稍后重试";
    }
    ToastUtil.showToastBottom(context, sucessStr);
  }

  //学生或老师拉取答案或答案列表
  _getQuestionAnswer(questionId, student) async {
    var api = "${Config.domain}/answer/list";
    print("_getQuestionAnswer==" +
        questionId.toString() +
        "---student=" +
        student);
    var result = await Dio().get(
        api + "?questionId=" + questionId.toString() + "&student=" + student);
    var answerBo = AnswerBo.fromJson(result.data);
    if (answerBo.code == 0) {
      setState(() {
        var dataList = answerBo.data;
        if (dataList.length > 0) {
          isShow = false;
          String answer = dataList[0].anwser;
          String reply = dataList[0].reply;
          //replyContent = answer + " " + reply;
          replyContent = "更新答案";
        }
      });
    } else {
      String sucessStr = "网络异常，无法获取";
      ToastUtil.showToastBottom(context, sucessStr);
    }
  }

  //老师-批改
  _updateAnswer(answerId, teacher, reply, score) async {
    var api = "${Config.domain}/answer/list";
    var result = await Dio().post(api, data: {
      "answerId": answerId.toString(),
      "teacher": teacher,
      "reply": reply,
      "score": score.toString()
    });
    var answerBo = RegisterBo.fromJson(result.data);
    if (answerBo.code == 0) {
      setState(() {
        //补充批改意见
      });
    } else {
      String sucessStr = "网络异常，请稍后重试";
      ToastUtil.showToastBottom(context, sucessStr);
    }
  }
}
