import 'package:flutter/material.dart';
import 'package:flutter_study/base/utils/ToastUtil.dart';
import 'package:flutter_study/net/bean/RegisterBo.dart';
import 'package:dio/dio.dart';
import '../base/Config.dart';

class ClassSchedulePage extends StatefulWidget {
  ClassSchedulePage({Key key}) : super(key: key);

  @override
  _ClassSchedule createState() => _ClassSchedule();
}

class _ClassSchedule extends State<ClassSchedulePage> {
  @override
  void initState() {
    super.initState();
    //待补充登录之后 planId=1
    _getClassScheList(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("课程表"),
        ),
        body: _classScheList());
  }

  Widget _classScheList() {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10),
          height: 368,
          child: Column(
            children: <Widget>[
              Text('星期${index + 1}',
                  style: TextStyle(fontSize: 16, color: Colors.black87)),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.only(left: 10, right: 10),
                        padding: EdgeInsets.only(left: 15, right: 15),
                        color: Colors.black12,
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            Text("9:00"),
                            SizedBox(width: 36),
                            Text("语文"),
                            SizedBox(width: 36),
                            Text("余华老师"),
                          ],
                        ));
                  },
                  itemCount: 8,
                ),
              )
            ],
          ),
        );
      },
      itemCount: 5,
    );
  }

  //获取课堂表信息
  _getClassScheList(planId) async {
    var api = "${Config.domain}/plan/info";
    var result = await Dio().get(api + "?planId=" + planId.toString());
    var classList = RegisterBo.fromJson(result.data);
    if (classList.code == 0) {
      setState(() {
        //_roomList = roomList.data;
      });
    } else {
      ToastUtil.showToastCenter(context, "获取异常, 暂无数据");
    }
  }
}
