import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_wechat_qrcode_platform_interface.dart';

/// An implementation of [FlutterWechatQrcodePlatform] that uses method channels.
class MethodChannelFlutterWechatQrcode extends FlutterWechatQrcodePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_wechat_qrcode');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

   @override
  Future<List<String>> scanImage(String path) async {
    final List<dynamic> result = await methodChannel.invokeMethod("scanImage", {'path': path});
    return Future.value(result.cast());
  }


   @override
  Future<List<String>> scanCamera() async {
    final List<dynamic>? result = await methodChannel.invokeMethod("scanCamera");
    if (result == null) return Future.value([]);
    return Future.value(result.cast());
  }

}
