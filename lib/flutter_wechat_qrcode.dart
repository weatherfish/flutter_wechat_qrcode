import 'flutter_wechat_qrcode_platform_interface.dart';

class FlutterWechatQrcode {

  static Future<String?> get platformVersion async {
    final String? version = await FlutterWechatQrcodePlatform.instance.getPlatformVersion();
    return version;
  }

  static Future<String?> getPlatformVersion() {
    return FlutterWechatQrcodePlatform.instance.getPlatformVersion();
  }

  static Future<List<String>> scanImage(String path) {
    return FlutterWechatQrcodePlatform.instance.scanImage(path);
  }

  static Future<List<String>> scanCamera() {
    return FlutterWechatQrcodePlatform.instance.scanCamera();
  }
}
