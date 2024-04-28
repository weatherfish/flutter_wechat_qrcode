import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_wechat_qrcode/flutter_wechat_qrcode.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _scanResult = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await FlutterWechatQrcode.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(children: [
            ElevatedButton(onPressed: _onPressSelectCamera, child: const Text("拍照")),
            ElevatedButton(onPressed: _onPressSelectPhoto, child: const Text("图片")),
            Text(_scanResult),
          ],),
        ),
      ),
    );
  }

  _onPressSelectPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null){
      setState(() {
        _scanResult = "scan photo: ";
      });
      return;
    }
    final result = await FlutterWechatQrcode.scanImage(image.path);
    print("scan photo: $result");
    setState(() {
      _scanResult = "scan photo: $result";
    });
  }

  _onPressSelectCamera() async {
    print("开始扫描摄像头");
    final result = await FlutterWechatQrcode.scanCamera();
    print("scan camera: $result");
    setState(() {
      _scanResult = "scan camera: $result";
    });
  }
}
