import 'package:flutter/material.dart';
import 'package:flutter_study/base/Global.dart';

//基类
class ProfileNotifier extends ChangeNotifier {

  @override
  void notifyListeners() {
    Global.saveProfile().then((value) => print("ok"), onError: (e) => print("error $e"));
    super.notifyListeners();
  }
}
