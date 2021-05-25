import 'dart:ui';

import 'package:flutter/material.dart';

/// 黄金色
class _GoldenColors {
  /// [FFC991]
  Color normal = const Color(0xFFF8E765);

  /// [6C5B48]
  Color light = const Color(0xFFC19E69);
}

/// 渐变色集合
class _Gradient {
  /// 黄金渐变色
  /// [左下]-[右上]
  LinearGradient golden = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xFFCFB381),
      const Color(0xFFC09D67),
    ],
  );

  LinearGradient lightGolden = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xFFF1E38B),
      const Color(0xFFEBCC6E),
      const Color(0xFFE6B34E),
    ],
  );

  /// 紫色渐变色
  /// [左下]-[右上]
  LinearGradient purple = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xFF6B3DC8),
      const Color(0xFFAF3FBE),
      const Color(0xFFF241B5),
    ],
  );

  /// 绿色渐变色
  /// [左下]-[右上]
  LinearGradient success = const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0, 0.17, 1],
    colors: [
      const Color(0xFF0B732D),
      const Color(0xFF0B732D),
      const Color(0xFF90CF6E)
    ],
  );

  /// 红色渐变色
  /// [左下]-[右上]
  LinearGradient error = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0, 0.17, 1],
    colors: [
      const Color(0xFF730B0B),
      const Color(0xFF730B0B),
      const Color(0xFFFE3E2B)
    ],
  );

  /// 蓝色渐变色
  /// [左下]-[右上]
  LinearGradient superLike = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [const Color(0xFF008EE3), const Color(0xFF7CD3F3)],
  );

  /// 橘色渐变
  /// [左下]-[右上]
  LinearGradient orange = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [const Color(0xFFFF5D00), const Color(0xFFFFAE25)],
  );
}

/// 文字颜色
class _Content {
  /// [B4B4B4]
  Color title = Color(0xFFB4B4B4);

  /// [646464]
  Color subTitle = Color(0xFF646464);

  /// [323232]
  Color dartText = Color(0xFF323232);

  /// [FFFFFF]
  Color light = Colors.white;

  Color primary = Color(0xFF333333);
}

/// 背景色
class _Background {
  /// [1E1E1E]
  Color normal = const Color(0xFF121A42);

  /// [323232]
  Color light = const Color(0xFF323232);

  /// [000000]
  Color dark = Colors.black;

  /// [141414]
  Color edit = const Color(0xFF141414);
}

class _Button {
  /// [FF5D00]
  Color primary = Color(0XFFFF5D00);

  /// [323232]
  Color secondary = Color(0xFF323232);

  //注册页面
  BoxDecoration get customBtn => new BoxDecoration(
        borderRadius: BorderRadius.circular(56),
        shape: BoxShape.rectangle,
        color: Colors.white,
      );

  BoxDecoration get colorBtn => new BoxDecoration(
        borderRadius: BorderRadius.circular(56),
        shape: BoxShape.rectangle,
        gradient: MainColors.gradient.golden,
      );
}

class MainColors {
  static const Color mainColor = Color(0xFF008EE3);
  static const Color txtColor = Color(0xff848087);
  static const Color grayTxt = Color(0xff3D3C3F);
  static const Color line = Color(0xff3A383C);

  static _GoldenColors golden = _GoldenColors();
  static _Gradient gradient = _Gradient();
  static _Content content = _Content();
  static _Background background = _Background();
  static _Button button = _Button();
}

class Texts {
  static TextStyle title1 = TextStyle(
    color: MainColors.content.light,
    fontSize: 18,
  );
  static TextStyle text1 = TextStyle(
    color: MainColors.content.title,
    fontSize: 14,
  );
}
