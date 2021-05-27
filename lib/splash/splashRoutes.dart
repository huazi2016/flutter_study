import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_study/base/Global.dart';
import 'package:flutter_study/base/RoutePages.dart';
import 'package:flutter_study/base/mvvm/mvvm.dart';
import 'package:flutter_study/styles/colors.dart';

class SplashRoute extends StatelessWidget {
  final _viewModel = SplashViewModel();

  @override
  Widget build(BuildContext context) {
    // ToastUtil.showToastCenter(
    //     context, "role==" + NewSpUtil.getString(SpKeys.SP_ROLE));
    return BaseWidget<SplashViewModel>(
      model: _viewModel,
      builder: (context, model, child) => Scaffold(
        body: Container(
          child: _buildBody(model),
        ),
      ),
      onModelReady: (model) async {
        //发起网络请求
        await model.doInit();
        //此处可以判断防止重复登录
        Navigator.of(context).pushNamedAndRemoveUntil(
            RoutePages.login,
            (Route<dynamic> route) => false);
      },
    );
  }

  Widget _buildBody(SplashViewModel model) {
    return Container(
      color: MainColors.mainColor,
      child: Center(
        child: Icon(
          Icons.wifi_outlined,
          size: 70,
        ),
      ),
    );
  }
}

/// viewModel
class SplashViewModel extends BaseModel {
  //region ========== 示例 ==========
  doInit() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    await Global.init();
  }
//endregion

}
