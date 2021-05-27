import 'package:flutter/material.dart';
import 'package:flutter_study/base/utils/ToastUtil.dart';
import 'package:flutter_study/net/bean/ClassScheBo.dart';
import 'package:dio/dio.dart';
import '../base/Config.dart';

class ClassSchedulePage extends StatefulWidget {
  ClassSchedulePage({Key key}) : super(key: key);

  @override
  _ClassSchedule createState() => _ClassSchedule();
}

class _ClassSchedule extends State<ClassSchedulePage> {
  List<ScheBo> _classList = [];

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
    if (_classList.length > 0) {
      return ListView.builder(
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index01) {
          return Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10),
            height: 368,
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(_classList[index01].week,
                        style: TextStyle(fontSize: 16, color: Colors.black87))),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index02) {
                      return Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          padding: EdgeInsets.only(left: 15, right: 15),
                          color: Colors.black12,
                          alignment: Alignment.center,
                          child: Row(
                            children: <Widget>[
                              Text(_classList[index01].infobo[index02].time),
                              SizedBox(width: 36),
                              Text(_classList[index01].infobo[index02].course),
                              SizedBox(width: 36),
                              Text(_classList[index01].infobo[index02].teacher),
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
    } else {
      return Text("暂无数据");
    }
  }

  //获取课堂表信息
  _getClassScheList(planId) async {
    var api = "${Config.domain}/plan/info";
    var result = await Dio().get(api + "?planId=" + planId.toString());
    var classList = ClassScheBo.fromJson(result.data);
    if (classList.code == 0) {
      setState(() {
        _classList = classList.data;
      });
    } else {
      ToastUtil.showToastCenter(context, "获取异常, 请稍后重试");
    }
  }
}
