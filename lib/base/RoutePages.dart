import 'package:flutter/widgets.dart';
import 'package:flutter_study/broswer/Broswer.dart';
import 'package:flutter_study/login/LoginPage.dart';
import 'package:flutter_study/splash/splashRoutes.dart';

class RoutePages {
  static const String login = "login"; //登录选择
  static const String splash = "SplashRoute"; //登录选择
  static const String register = "register"; //注册页面
  static const String browser = "browser"; //注册页面


  static Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        splash: (context) => SplashRoute(),
        login: (context) => LoginPage(),
        browser: (context) {
          var arguments = ModalRoute.of(context).settings.arguments;
          return Browser(map: arguments);
        },
      };
}
