import 'package:flutter_study/net/Net.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _key_profile = "_key_profile";

class Global {
  static SharedPreferences _prefs;

  static SharedPreferences get prefs => _prefs; //登录用户信息

  // 是否为release版
  static bool get isRelease => true;

  static Future init() async {
    final stopwatch = Stopwatch()..start();
    try {
      //kv存储
      _prefs = await SharedPreferences.getInstance();
      var jsonString = _prefs.getString(_key_profile);
      print("历史存储$jsonString");
      //网络库初始化
      GitNet.init();
    } catch (e) {
      print(e);
    }
    var diff = 3 * 1000 - stopwatch.elapsedMilliseconds;
    diff = diff < 0 ? 0 : diff;
    print("初始化耗时:$diff");
    return Future.delayed(Duration(milliseconds: diff));
  }

  // 持久化Profile信息
  static Future saveProfile() async {
    // _prefs ??= await SharedPreferences.getInstance();
    // var encode = jsonEncode(profile.toMap());
    // _prefs.setString(_key_profile, encode);
    // print("更新数据成功 $encode");
  }
}
