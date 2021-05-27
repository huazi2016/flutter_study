import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/net/bean/SelfBo.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class SelfDetailRoute extends StatefulWidget {
  final SelfInfoBo infoBo;

  const SelfDetailRoute({Key key, this.infoBo}) : super(key: key);

  @override
  _SelfDetailRouteState createState() => _SelfDetailRouteState();
}

class _SelfDetailRouteState extends State<SelfDetailRoute> {
  SelfInfoBo infoBo;
  VideoPlayerController _controller;
  PdfController pdfController;

  @override
  void initState() {
    super.initState();
    infoBo = widget.infoBo;
    if (infoBo.video != null && infoBo.video.isNotEmpty) {
      _controller = VideoPlayerController.network(
        infoBo.video,
      )..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          _controller.play();
          setState(() {
            loading = false;
          });
        });
    }
    downFunction();
  }

  void downFunction() async {
    try {
      if (infoBo.file != null && infoBo.file.isNotEmpty) {
        /// 申请写文件权限
        String dir = (await getApplicationDocumentsDirectory()).path;
        File file = File('$dir/temp.pdf');
        if (file.existsSync()) {
          file.deleteSync();
        }
        file.createSync();

        ///创建DIO
        Dio dio = new Dio();
        await dio.download(infoBo.file, "${file.path}",
            onReceiveProgress: (received, total) {
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "%");
          }
          if (received >= total) {
            pdfController = PdfController(
              document: PdfDocument.openFile(file.path),
            );
            print("下载文档 ${file.path}");
            setState(() {});
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
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
    return Column(children: [
      if (infoBo.video != null && infoBo.video.isNotEmpty) ...{
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              VideoPlayer(_controller),
              _ControlsOverlay(controller: _controller),
              VideoProgressIndicator(_controller, allowScrubbing: true),
            ],
          ),
        )
      },
      if (pdfController != null) ...{
        Expanded(
          flex: 1,
          child: PdfView(
            controller: pdfController,
          ),
        )
      }
    ]);
  }
}

class _ControlsOverlay extends StatefulWidget {
  final VideoPlayerController controller;

  const _ControlsOverlay({Key key, this.controller}) : super(key: key);

  @override
  __ControlsOverlayState createState() => __ControlsOverlayState(controller);
}

class __ControlsOverlayState extends State<_ControlsOverlay> {
  static const _examplePlaybackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];
  final VideoPlayerController controller;

  __ControlsOverlayState(this.controller);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
            setState(() {});
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (context) {
              return [
                for (final speed in _examplePlaybackRates)
                  PopupMenuItem(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}
