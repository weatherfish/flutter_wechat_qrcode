#import "FlutterWechatQrcodePlugin.h"
#import "KKQRCodeScannerController.h"

@implementation FlutterWechatQrcodePlugin
+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel
            methodChannelWithName:@"flutter_wechat_qrcode"
                  binaryMessenger:[registrar messenger]];
    FlutterWechatQrcodePlugin *instance = [[FlutterWechatQrcodePlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if ([@"scanImage" isEqualToString:call.method]) {
        
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if ([@"scanCamera" isEqualToString:call.method]) {
        KKQRCodeScannerController* qrController = [[KKQRCodeScannerController alloc] init];
        qrController.completionHandler = ^(NSString* data) {
             result(data);
       };
       UIViewController* rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
       [rootViewController presentViewController:qrController animated:YES completion:nil];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
