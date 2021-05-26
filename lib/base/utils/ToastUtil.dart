import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

class ToastUtil {
  static void showToastBottom(BuildContext context,String msg) {
    Toast.show(msg, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  static void showToastCenter(BuildContext context, String msg) {
    Toast.show(msg, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
  }

  static void showToastLong(BuildContext context, String msg) {
    Toast.show(msg, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }
}
