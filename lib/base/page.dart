import 'package:flutter/material.dart';

/// 封装的基类
abstract class BaseRoutePageState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    onInit(context);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    onDestroy();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onResume(context);
    } else if (state == AppLifecycleState.paused) {
      onPause(context);
    }
  }

  onInit(BuildContext context) async {
    print('init func');
  }

  onResume(BuildContext context) async {
    print('onResume func');
  }

  onPause(BuildContext context) async {
    print('onPause func');
  }

  onDestroy() async {
    print('destroy func');
  }
}
