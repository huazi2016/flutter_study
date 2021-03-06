import 'package:flutter/material.dart';
import 'package:flutter_study/base/RoutePages.dart';
import 'package:flutter_study/base/utils/SpUtil.dart';
import 'package:flutter_study/home/mine/ClassSchedulePage.dart';
import 'package:flutter_study/home/mine/UserInfoPage.dart';
import 'package:package_info/package_info.dart';

class MineSubpage extends StatefulWidget {
  MineSubpage({Key key}) : super(key: key);

  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<MineSubpage> {
  var headUrl = "";
  var nickname = "";
  bool _isTeacher = false;

  @override
  void initState() {
    super.initState();
    headUrl = SpUtil.getString(SpKeys.SP_HEADURL);
    nickname = SpUtil.getNickName();
    _isTeacher = SpUtil.isTeacher();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 30, right: 20),
                      width: 68,
                      height: 68,
                      child: InkWell(
                          child: CircleAvatar(
                            radius: 36,
                            //child: CachedNetworkImage(imageUrl: headUrl),
                            backgroundImage: NetworkImage(headUrl),
                          ),
                          onTap: () {
                            _navigateUserInfo(context);
                          })),
                  InkWell(
                      child: Text(
                        nickname,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      onTap: () {
                        _navigateUserInfo(context);
                      }),
                  Spacer(flex: 1,),
                  Padding(
                    padding: EdgeInsets.only(right: 18),
                    //??????GestureDetector??????Text????????????
                      child: GestureDetector(
                        child: Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,),
                        onTap: () {
                          _navigateUserInfo(context);
                        },
                      ))
                ],
              )),
          ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(10.0),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Card(
                  child: ListTile(
                      leading: Icon(Icons.info),
                      title: Text(
                        "????????????",
                        style: TextStyle(color: Colors.black87),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black87,
                      ),
                      onTap: () => {
                            PackageInfo.fromPlatform()
                                .then((packageInfo) => showDialog(
                                      context: context,
                                      builder: (context) {
                                        String appName = packageInfo.appName;
                                        String packageName =
                                            packageInfo.packageName;
                                        String version = packageInfo.version;
                                        String buildNumber =
                                            packageInfo.buildNumber;
                                        return AlertDialog(
                                          title: Text('????????????'),
                                          content: Text(
                                              '''app??????:$appName\napp??????:$packageName\napp??????:$version\napp?????????:$buildNumber'''),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('ok'),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop('cancel');
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    )),
                          })),
              Visibility(
                  visible: !_isTeacher,
                  child: Card(
                      child: ListTile(
                    leading: Icon(Icons.list),
                    title: Text(
                      "?????????",
                      style: TextStyle(color: Colors.black87),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black87,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClassSchedulePage(),
                          ));
                    },
                  ))),
              Card(
                  child: ListTile(
                leading: Icon(Icons.verified_user),
                title: Text(
                  "????????????",
                  style: TextStyle(color: Colors.black87),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black87,
                ),
                onTap: () {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("???????????????????????????"),
                  ));
                },
              )),
              Card(
                  child: ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  "????????????",
                  style: TextStyle(color: Colors.black87),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black87,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('??????'),
                          content: Text('????????????????????????'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('??????'),
                              onPressed: () {
                                Navigator.of(context).pop('cancel');
                              },
                            ),
                            FlatButton(
                              child: Text('??????'),
                              onPressed: () {
                                SpUtil.putString(SpKeys.SP_HEADURL, "");
                                SpUtil.putString(SpKeys.SP_ROLE, "");
                                SpUtil.putString(SpKeys.SP_USERNAME, "");
                                SpUtil.putString(SpKeys.SP_NickName, "");
                                SpUtil.putString(SpKeys.SP_USERID, "");
                                Navigator.of(context).pop('ok');
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    RoutePages.login,
                                    (Route<dynamic> route) => false);
                              },
                            ),
                          ],
                        );
                      });
                },
              )),
            ],
          )
        ],
      ),
    );
  }

  //???????????????, ????????????????????????
  _navigateUserInfo(BuildContext context) async {
    final isChange = await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new UserInfoPage()),
    );
    if (isChange) {
      setState(() {
        nickname = SpUtil.getNickName();
        headUrl = SpUtil.getString(SpKeys.SP_HEADURL);
      });
    }
  }
}
