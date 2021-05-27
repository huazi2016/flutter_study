import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

class SpKeys {
  static const SP_HEADURL = "spHeadUrl";
  static const SP_ROLE = "spRole";
  static const SP_USERNAME = "spUserName";
  static const SP_USERID= "spUserId";
  static const SP_NickName = "spNickName";
}

class SpUtil {
  static SpUtil _singleton;
  static SharedPreferences _prefs;
  static Lock _lock = Lock();

  static Future<SpUtil> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          //保持本地实例直到完全初始化。
          var singleton = SpUtil._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  SpUtil._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //String型存储及获取
  static String getString(String key) {
    if (_prefs == null) return null;
    var status = _prefs.getString(key);
    if (status == null) return "";
    return status;
  }

  static Future<bool> putString(String key, String value) {
    if (_prefs == null) return null;
    return _prefs.setString(key, value);
  }

  static String getUserId() {
    var userId = getString(SpKeys.SP_USERID);
    return userId;
  }

  static String getNickName() {
    var nickName = getString(SpKeys.SP_NickName);
    return nickName;
  }

  static String getUserName() {
    var userName = getString(SpKeys.SP_USERNAME);
    return userName;
  }

  static bool isLogin() {
    var role = getString(SpKeys.SP_ROLE);
    return role.isNotEmpty;
  }

  static bool isTeacher() {
    var role = getString(SpKeys.SP_ROLE);
    print("isTeacher == " + role);
    return role == "老师";
  }
}
