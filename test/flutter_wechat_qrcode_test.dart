import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wechat_qrcode/flutter_wechat_qrcode.dart';
import 'package:flutter_wechat_qrcode/flutter_wechat_qrcode_platform_interface.dart';
import 'package:flutter_wechat_qrcode/flutter_wechat_qrcode_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterWechatQrcodePlatform
    with MockPlatformInterfaceMixin
    implements FlutterWechatQrcodePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<List<String>> scanCamera() {
    // TODO: implement scanCamera
    throw UnimplementedError();
  }

  @override
  Future<List<String>> scanImage(String path) {
    // TODO: implement scanImage
    throw UnimplementedError();
  }
}

void main() {
  final FlutterWechatQrcodePlatform initialPlatform = FlutterWechatQrcodePlatform.instance;

  test('$MethodChannelFlutterWechatQrcode is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterWechatQrcode>());
  });

  test('getPlatformVersion', () async {
    MockFlutterWechatQrcodePlatform fakePlatform = MockFlutterWechatQrcodePlatform();
    FlutterWechatQrcodePlatform.instance = fakePlatform;

    expect(await FlutterWechatQrcode.getPlatformVersion(), '42');
  });
}
