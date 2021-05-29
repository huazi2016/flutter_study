import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/base/Config.dart';
import 'package:flutter_study/base/mvvm/mvvm.dart';
import 'package:flutter_study/base/utils/SpUtil.dart';
import 'package:flutter_study/home/room/StRoomDetailPage.dart';
import 'package:flutter_study/net/bean/RegisterBo.dart';
import 'package:flutter_study/net/bean/RoomBo.dart';

import 'TeRoomDetailPage.dart';

class QuestionListRoute extends StatefulWidget {
  final String title;
  final bool isPaper;

  final QuestionListViewModel viewModel;

  const QuestionListRoute(
      {Key key, this.title, this.isPaper = false, this.viewModel})
      : super(key: key);

  @override
  _QuestionListRouteState createState() => _QuestionListRouteState();
}

class _QuestionListRouteState extends State<QuestionListRoute> {
  var _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<QuestionListViewModel>(
      model: _viewModel,
      builder: (context, model, child) => _buildBody(model),
      onModelReady: (model) {
        //发起网络请求
        print("发起网络请求.>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        model.demo(widget.title, widget.isPaper);
      },
    );
  }

  bool _isTeacher = false;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModel ??
        QuestionListViewModel(service: QuestionListService());
    print("初始化.>>>>>>>>>>>>>>>${widget.title}>>>>>>>>>>>>>>>>");
    _isTeacher = SpUtil.isTeacher();
  }

  Widget _buildBody(QuestionListViewModel model) {
    switch (model.state) {
      case ViewState.Success:
        return _classroomWidget(model.roomList);
        break;
      case ViewState.Failure:
      case ViewState.None:
        return Center(child: Text('Empty'));
        break;
      case ViewState.Loading:
      default:
        return Center(child: CircularProgressIndicator());
        break;
    }
  }

  Widget _classroomWidget(List<RoomDetailBo> _roomList) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(top: 5, bottom: 15),
        itemBuilder: (context, index) {
          var roomList = _roomList[index];
          print(roomList.toJson());
          return Card(
              margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: InkWell(
                onTap: () {
                  if (_isTeacher) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return TeRoomDetailPage(detailBo: roomList);
                      },
                    ));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              StRoomDetailPage(detailBo: roomList),
                        ));
                  }
                },
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("题型：" + _roomList[index].type,
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
                                      _viewModel.deleteQuestion(
                                          _roomList[index].questionId, index);
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
                          child: Text(_roomList[index].title,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.black,
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ),
                      ]),
                    ),
                    SizedBox(height: 3),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(_roomList[index].content,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.black87,
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ),
                      ]),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(_roomList[index].teacher,
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 12)),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Text(_roomList[index].createTime,
                                style: TextStyle(
                                    color: Colors.black38, fontSize: 12)))
                      ]),
                    ),
                  ],
                ),
              ));
        },
        itemCount: _roomList.length);
  }
}

/// viewModel
class QuestionListViewModel extends BaseModel {
  QuestionListService _service;

  QuestionListViewModel({@required QuestionListService service})
      : _service = service;

  //region ========== 示例 ==========
  List<RoomDetailBo> roomList = [];

  demo(title, isPaper) async {
    setState(ViewState.Loading);
    try {
      print("获取数据L 开始 $title");
      roomList = await _service._getQuestionList(title, isPaper);
      print("获取数据L :${roomList.length}");
      if (roomList.length > 0) {
        setState(ViewState.Success);
      } else {
        setState(ViewState.Failure);
      }
    } catch (e) {
      print("获取数据L错误");
      print(e);
      setState(ViewState.Failure);
    }
  }

  deleteQuestion(questionId, index) async {
    var api = "${Config.domain}/question/delete";
    var result = await Dio().get(api + "?questionId=" + questionId.toString());
    var roomBo = RegisterBo.fromJson(result.data);
    if (roomBo.code == 0) {
      roomList.removeAt(index);
    }
    setState(ViewState.Success);
  }

//endregion

}

/// api
class QuestionListService {
  //接口
  Future<List<RoomDetailBo>> _getQuestionList(title, isPaper) async {
    var api = "${Config.domain}/question/search";
    var result;
    if (isPaper) {
      result = await Dio()
          .post(api, data: {"course": title, "isPaper": isPaper, "title": ""});
    } else {
      result = await Dio()
          .post(api, data: {"course": "", "isPaper": isPaper, "title": title});
    }
    var roomList = RoomBo.fromJson(result.data);
    return roomList.data;
  }
}
