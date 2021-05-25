import 'package:flutter/widgets.dart';

///不需要要 BuildContext 路由
class NavigationService {
  factory NavigationService.getInstance() => _getInstance();

  NavigationService._internal();

  static NavigationService _instance;

  static NavigationService _getInstance() {
    if (_instance == null) {
      _instance = new NavigationService._internal();
    }
    return _instance;
  }

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> pushNamed(
    String routeName, {
    Object arguments,
  }) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  void pop<T extends Object>([T result]) {
    return navigatorKey.currentState.pop(result);
  }

  BuildContext getCurrentContext() {
    return navigatorKey.currentContext;
  }
}
