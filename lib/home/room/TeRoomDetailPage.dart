import 'package:flutter/material.dart';
import 'package:flutter_study/base/utils/SpUtil.dart';
import 'package:flutter_study/base/utils/ToastUtil.dart';
import 'package:flutter_study/net/bean/AnswerBo.dart';
import 'package:flutter_study/net/bean/RegisterBo.dart';
import 'package:flutter_study/net/bean/RoomBo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_study/base/Config.dart';

class TeRoomDetailPage extends StatefulWidget {
  final RoomDetailBo detailBo;
  // RoomDetailPage({Key key}) : super(key: key);
  TeRoomDetailPage({Key key, @required this.detailBo}) : super(key: key);

  @override
  _TeRoomDetailState createState() => _TeRoomDetailState();
}

class _TeRoomDetailState extends State<TeRoomDetailPage> {
  List<AnswerInfoBo> _answerList = [];
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
                Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("正确答案：" + widget.detailBo.anwser,
                            style:
                                TextStyle(color: Colors.red, fontSize: 16)))),
                SizedBox(height: 25),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("学生答题:",
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                ),
                Expanded(child: _answerListWidget()),
                // Visibility(
                //   visible: isShow,
                //   child: Container(
                //     margin: EdgeInsets.only(top: 20, bottom: 10),
                //     decoration: BoxDecoration(
                //         border: Border.all(color: Colors.grey, width: 1),
                //         color: Colors.white,
                //         borderRadius: BorderRadius.all(Radius.circular(5))),
                //     alignment: Alignment.center,
                //     height: 36,
                //     child: TextField(
                //       keyboardType: TextInputType.text,
                //       controller: answerController,
                //       decoration: InputDecoration(
                //           //hasFloatingPlaceholder: true,
                //           contentPadding: EdgeInsets.all(10),
                //           //prefixIcon: Icon(Icons.search),
                //           hintText: "请输入批改答案"),
                //       autofocus: false,
                //     ),
                //   ),
                // ),
                // SizedBox(height: 30),
                // Visibility(
                //     visible: isShow,
                //     child: SizedBox(
                //         width: 200,
                //         height: 45,
                //         child: ElevatedButton(
                //           onPressed: () {
                //             String anwser = answerController.text.trim();
                //             if (anwser.isNotEmpty) {
                //               _updateAnswer(
                //                   widget.detailBo.questionId, userName, anwser);
                //             } else {
                //               ToastUtil.showToastCenter(context, "批改答案不能为空");
                //             }
                //           },
                //           child: Text("提交"),
                //         ))),
              ],
            )));
  }

  Widget _answerListWidget() {
    if (this._answerList.length > 0) {
      return Container(
        margin: EdgeInsets.only(left: 12),
        child: ListView.builder(
            //reverse: true,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(top: 5, bottom: 0),
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(_answerList[index].student +
                      ":  " +
                      _answerList[index].anwser));
            },
            itemCount: _answerList.length),
      );
    } else {
      return Text("暂无", style: TextStyle(color: Colors.black54, fontSize: 15));
    }
  }

  //老师-批改
  // _updateAnswer(answerId, teacher, reply) async {
  //   var api = "${Config.domain}/answer/update";
  //   print("_updateAnswer==" +
  //       answerId.toString() +
  //       "====" +
  //       teacher +
  //       "===" +
  //       reply);
  //   var result = await Dio().post(api, data: {
  //     "answerId": answerId.toString(),
  //     "teacher": teacher,
  //     "reply": reply, //答案
  //     "score": "20", //先模拟,待删除
  //   });
  //   var roomBo = RegisterBo.fromJson(result.data);
  //   var sucessStr = "提交完成";
  //   if (roomBo.code == 0) {
  //     setState(() {
  //       //显示答案
  //       isShow = false;
  //       //刷新学生答案列表
  //       _getQuestionAnswer(answerId, "");
  //     });
  //   } else {
  //     sucessStr = "提交失败, 请稍后重试";
  //   }
  //   ToastUtil.showToastBottom(context, sucessStr);
  // }

  //获取学生答案列表
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
        if (answerBo.data.length > 0) {
          isShow = false;
          _answerList = answerBo.data;
          replyContent = answerBo.data[0].anwser;
        }
      });
    } else {
      String sucessStr = "网络异常，无法获取";
      ToastUtil.showToastBottom(context, sucessStr);
    }
  }
}
