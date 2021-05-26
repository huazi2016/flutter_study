import 'package:flutter/widgets.dart';
import 'package:flutter_study/broswer/Broswer.dart';
import 'package:flutter_study/home/selfStudyDetail.dart';
import 'package:flutter_study/login/LoginPage.dart';
import 'package:flutter_study/splash/splashRoutes.dart';

class RoutePages {
  static const String login = "login"; //登录页
  static const String splash = "SplashRoute"; //欢迎页
  static const String register = "register"; //注册页
  static const String browser = "browser"; //浏览页
  static const String main = "main"; //浏览页
  static const String self_detail = "self_detail"; //自学详情

  static Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        splash: (context) => SplashRoute(),
        login: (context) => LoginPage(),
        //main: (context) => MainPage(),
        self_detail: (context) {
          var arguments = ModalRoute.of(context).settings.arguments;
          return SelfDetailRoute(infoBo: arguments);
        },
        browser: (context) {
          var arguments = ModalRoute.of(context).settings.arguments;
          return Browser(map: arguments);
        },
      };
}
