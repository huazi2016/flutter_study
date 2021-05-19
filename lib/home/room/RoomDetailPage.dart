import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class RoomDetailPage extends StatefulWidget {
  RoomDetailPage({Key key}) : super(key: key);

  @override
  _RoomDetailState createState() => _RoomDetailState();
}

class _RoomDetailState extends State<RoomDetailPage> {
   TextEditingController answerController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context).settings.arguments as String;
    // Toast.show("收到参数=" + title, context,
    //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    return Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        appBar: AppBar(title: Text("详情"), centerTitle: true),
        body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Text("多选题"),
                SizedBox(height: 20),
                Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(title,
                        maxLines: 2,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  )
                ]),
                SizedBox(height: 10),
                Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("具体内容",
                        maxLines: 4,
                        style: TextStyle(color: Colors.black54, fontSize: 15)),
                  )
                ]),
                SizedBox(height: 10),
                Container(
                  margin:
                      EdgeInsets.only(top: 20, bottom: 10),
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
                SizedBox(height: 30),
                SizedBox(
                    width: 200,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        Toast.show("收到参数=" + answerController.text.toString(), context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.CENTER);
                      },
                      child: Text("提交"),
                    )),
              ],
            )));
  }
}
