import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_wechat_qrcode_method_channel.dart';

abstract class FlutterWechatQrcodePlatform extends PlatformInterface {
  /// Constructs a FlutterWechatQrcodePlatform.
  FlutterWechatQrcodePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterWechatQrcodePlatform _instance = MethodChannelFlutterWechatQrcode();

  /// The default instance of [FlutterWechatQrcodePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterWechatQrcode].
  static FlutterWechatQrcodePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterWechatQrcodePlatform] when
  /// they register themselves.
  static set instance(FlutterWechatQrcodePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<List<String>> scanImage(String path) async {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String> scanCamera() async {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
