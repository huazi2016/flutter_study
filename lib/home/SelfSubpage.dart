import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_study/base/mvvm/mvvm.dart';

class SelfSubpage extends StatelessWidget {
  final _viewModel = SelfSubpageViewModel(service: SelfSubpageService());

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SelfSubpageViewModel>(
      model: _viewModel,
      builder: (context, model, child) => Scaffold(
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
                  prefixIcon: Icon(Icons.search),
                  hintText: "输入关键字搜索"),
              autofocus: false,
            ),
          ),
        ),
        body: Container(
          child: _buildBody(model),
        ),
        floatingActionButton: FloatingActionButton(child: Text("发布"),onPressed: ()=> model.push(),),
      ),
      onModelReady: (model) {
        //发起网络请求
        model.demo();
      },
    );
  }

  Widget _buildBody(SelfSubpageViewModel model) {
    switch (model.state) {
      case ViewState.Success:
        // return ListView.builder(
        //     scrollDirection: Axis.vertical,
        //     padding: EdgeInsets.only(top: 5, bottom: 15),
        //     itemBuilder: (context, index) {
        //       return Card(
        //           margin:
        //           EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        //           child: InkWell(
        //             onTap: () {
        //
        //             },
        //             child: Column(
        //               children: <Widget>[
        //                 Padding(
        //                   padding:
        //                   EdgeInsets.only(top: 10, left: 15, right: 15),
        //                   child: Stack(children: <Widget>[
        //                     Align(
        //                       alignment: Alignment.topLeft,
        //                       child: Text(this._roomList[index].type,
        //                           style: TextStyle(
        //                               color: Colors.black54, fontSize: 14)),
        //                     ),
        //                     Align(
        //                       alignment: Alignment.topRight,
        //                       child: SizedBox(
        //                         //width: 50,
        //                           height: 25,
        //                           child: ElevatedButton(
        //                             onPressed: () {
        //
        //                             },
        //                             child: Text("删除"),
        //                           )),
        //                     )
        //                   ]),
        //                 ),
        //                 //SizedBox(height: 5),
        //                 Padding(
        //                   padding: EdgeInsets.only(left: 15, right: 15),
        //                   child: Stack(children: <Widget>[
        //                     Align(
        //                       alignment: Alignment.topLeft,
        //                       child: Text(this._roomList[index].title,
        //                           maxLines: 2,
        //                           style: TextStyle(
        //                               color: Colors.black,
        //                               //fontWeight: FontWeight.bold,
        //                               fontSize: 16)),
        //                     ),
        //                   ]),
        //                 ),
        //                 SizedBox(height: 8),
        //                 Padding(
        //                   padding: EdgeInsets.only(left: 15, right: 15),
        //                   child: Stack(children: <Widget>[
        //                     Align(
        //                       alignment: Alignment.topLeft,
        //                       child: Text(this._roomList[index].content,
        //                           maxLines: 2,
        //                           style: TextStyle(
        //                               color: Colors.black87,
        //                               //fontWeight: FontWeight.bold,
        //                               fontSize: 15)),
        //                     ),
        //                   ]),
        //                 ),
        //                 SizedBox(height: 8),
        //                 Padding(
        //                   padding:
        //                   EdgeInsets.only(left: 15, right: 15, bottom: 10),
        //                   child: Stack(children: <Widget>[
        //                     Align(
        //                       alignment: Alignment.topLeft,
        //                       child: Text(this._roomList[index].teacher,
        //                           style: TextStyle(
        //                               color: Colors.black38, fontSize: 12)),
        //                     ),
        //                     Align(
        //                         alignment: Alignment.topRight,
        //                         child: Text(this._roomList[index].createTime,
        //                             style: TextStyle(
        //                                 color: Colors.black38, fontSize: 12)))
        //                   ]),
        //                 ),
        //               ],
        //             ),
        //           ));
        //     },
        //     itemCount: _roomList.length);
        // break;
      case ViewState.Failure:
      case ViewState.None:
        return Text('Empty');
        break;
      case ViewState.Loading:
      default:
        return Center(child: CircularProgressIndicator());
        break;
    }
  }
}

/// viewModel
class SelfSubpageViewModel extends BaseModel {
  SelfSubpageService _service;

  SelfSubpageViewModel({@required SelfSubpageService service})
      : _service = service;

  //region ========== 示例 ==========
  // List<> roomList;

  demo() async {
    setState(ViewState.Loading);
    // roomList = await _service.doNet();
    setState(ViewState.Success);
  }

  push() {}
//endregion

}

/// api
class SelfSubpageService {
  //接口
  Future<String> doNet() async {
    return new Future.delayed(const Duration(seconds: 2), () => "成功");
  }
}
