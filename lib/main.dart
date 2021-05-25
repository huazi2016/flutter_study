import 'package:flutter/material.dart';
import 'package:flutter_study/state/notifer.dart';
import 'package:provider/provider.dart';
import 'base/NavigationService.dart';
import 'base/RoutePages.dart';
import 'login/LoginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: ProfileNotifier()),
        ],
        child: MaterialApp(
          navigatorKey: NavigationService.getInstance().navigatorKey,
          //路由辅助 用于没有context操作
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            //主色调
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          routes: RoutePages.routes,
          initialRoute: RoutePages.splash,
          onUnknownRoute: (settings) {
            // if (!Global.isRelease) showToast("路由跳转未知:${settings.name}");
            return null;
          },
        ));
  }
}
