import 'package:flutter/material.dart';
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
    return MaterialApp(
      //去除debug标签
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
