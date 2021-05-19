import 'package:flutter/material.dart';

class NewsSubpage extends StatefulWidget {
  NewsSubpage({Key key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<NewsSubpage> {
  @override
  Widget build(BuildContext context) {
    return Text("消息");
  }
}
