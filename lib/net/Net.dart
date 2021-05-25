import 'package:dio/dio.dart';

///网络错误提示
const String networkError = 'Check the network connection';
//一般采用单例
var dio = Dio(BaseOptions(
    receiveTimeout: 15 * 1000,
    connectTimeout: 15 * 1000,
    sendTimeout: 10 * 1000));

class GitNet {
  static init() {
    //缓存拦截器
    dio.interceptors.add(LogInterceptor(responseBody: true)); //开启请求日志
    //登录授权标记
    // dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile?.token;

    //证书处理
//     if (!Global.isRelease) {
//       (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//           (client) {
//         client.findProxy = (uri) {
//           return "PROXY 10.1.10.250:8888";
//         };
//    代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
//         client.badCertificateCallback =
//             (X509Certificate cert, String host, int port) => true;
//       };
//     }
  }

// Future<UploadImg> uploadImg(String localImagePath) async {
//   print('图片 $localImagePath');
//   var fileDio = Dio(BaseOptions(
//       headers: {
//         HttpHeaders.contentTypeHeader: "multipart/form-data",
//       },
//       receiveTimeout: 15 * 1000,
//       connectTimeout: 15 * 1000,
//       sendTimeout: 10 * 1000));
//   fileDio.interceptors.add(LogInterceptor(responseBody: true));
//   String upUrl = "";
//   Map<String, dynamic> map = Map();
//   map["file"] = await MultipartFile.fromFile(localImagePath);
//
//   ///通过FormData
//   FormData formData = FormData.fromMap(map);
//   var response =
//       await fileDio.post(upUrl, data: formData, queryParameters: {});
//   assert(response.statusCode == 200);
//   return UploadImg.fromJson(response.data);
// }

}
