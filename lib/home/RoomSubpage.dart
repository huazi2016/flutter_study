import 'package:flutter/material.dart';
import 'package:flutter_study/home/room/RoomDetailPage.dart';
import 'package:toast/toast.dart';

class RoomSubpage extends StatefulWidget {
  RoomSubpage({Key key}) : super(key: key);

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<RoomSubpage> {
  List<String> titles = [
    'Sun',
    'Moon',
    'Star',
    'Sun',
    'Moon',
    'Star',
    'Sun',
    'Moon',
    'Star',
    "wangwu"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          alignment: Alignment.center,
          height: 36,
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                //hasFloatingPlaceholder: true,
                contentPadding: EdgeInsets.all(10),
                prefixIcon: Icon(Icons.search),
                hintText: "输入关键字"),
            autofocus: false,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: _classroomWidget(),
    );
  }

  Widget _classroomWidget() {
    return Container(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(top: 5, bottom: 15),
          itemBuilder: (context, index) {
            return Card(
                margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoomDetailPage(),
                          //传递参数
                          settings: RouteSettings(
                            arguments: titles[index],
                          ),
                        ));
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: Stack(children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(titles[index],
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 14)),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                                //width: 50,
                                height: 25,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Toast.show(
                                        "点击了" + index.toString(), context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM);
                                    setState(() {
                                      //模拟删除
                                      titles.removeAt(index);
                                    });
                                  },
                                  child: Text("删除"),
                                )),
                          )
                        ]),
                      ),
                      //SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Stack(children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("问题标题",
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.black,
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                          ),
                        ]),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        child: Stack(children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("发布人",
                                style: TextStyle(
                                    color: Colors.black38, fontSize: 12)),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text("发布日期",
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 12)))
                        ]),
                      ),
                    ],
                  ),
                ));
          },
          itemCount: titles.length),
    );
  }
}
