import 'package:flutter/widgets.dart';
import 'package:flutter_study/broswer/Broswer.dart';
import 'package:flutter_study/home/self/AddSelfPage.dart';
import 'package:flutter_study/home/self/selfStudyDetail.dart';
import 'package:flutter_study/login/LoginPage.dart';
import 'package:flutter_study/splash/splashRoutes.dart';

import '../home/MainPage.dart';

class RoutePages {
  static const String login = "login"; //登录页
  static const String splash = "SplashRoute"; //欢迎页
  static const String register = "register"; //注册页
  static const String browser = "browser"; //浏览页
  static const String main = "main"; //首页
  static const String self_detail = "self_detail"; //自学详情
  static const String addSelf = "addSelf"; //添加课程

  static Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        splash: (context) => SplashRoute(),
        login: (context) => LoginPage(),
        main: (context) => MainPage(),
        addSelf: (context) => AddSelfRoutes(),
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
