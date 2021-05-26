import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/net/bean/SelfBo.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SelfDetailRoute extends StatefulWidget {
  final SelfInfoBo infoBo;

  const SelfDetailRoute({Key key, this.infoBo}) : super(key: key);

  @override
  _SelfDetailRouteState createState() => _SelfDetailRouteState();
}

class _SelfDetailRouteState extends State<SelfDetailRoute> {
  SelfInfoBo infoBo;

  @override
  void initState() {
    super.initState();
    infoBo = widget.infoBo;
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${infoBo.type}详情"),
      ),
      body: Container(
        child: _buildBody(context, infoBo),
      ),
    );
  }

  bool loading = true;

  Widget _buildBody(BuildContext context, SelfInfoBo infoBo) {
    print("infoBo: ${infoBo.toJson()}");
    return Stack(
      children: [
        webView(infoBo),
        if (loading) ...{Center(child: CircularProgressIndicator())}
      ],
    );
  }

  Widget webView(SelfInfoBo infoBo) {
    var url = infoBo.video != null && infoBo.video.isNotEmpty
        ? infoBo.video
        : infoBo.file;
    return WebView(
      initialUrl: url ?? "https://www.google.com",
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: (url) {
        setState(() {
          loading = false;
        });
      },
    );
  }
}
