//
//  KKQRCodeScannerController.m
//  WeChatQRCodeScanner_Example
//
//  Created by king on 2021/2/3.
//  Copyright © 2021 0x1306a94. All rights reserved.
//

#import "KKQRCodeScannerController.h"

#import <WeChatQRCodeScanner/KKQRCodeScannerResult.h>
#import <WeChatQRCodeScanner/KKQRCodeScannerView.h>

@interface KKQRCodeScannerController () <KKQRCodeScannerViewDelegate>
@property (nonatomic, strong) KKQRCodeScannerView *scannerView;

@end

@implementation KKQRCodeScannerController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.scannerView = [[KKQRCodeScannerView alloc] initWithFrame:self.view.bounds];

	self.scannerView.backgroundColor = UIColor.whiteColor;

	[self.view insertSubview:self.scannerView atIndex:0];

	self.scannerView.translatesAutoresizingMaskIntoConstraints = NO;
	[NSLayoutConstraint activateConstraints:@[
		[self.scannerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
		[self.scannerView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
		[self.scannerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
		[self.scannerView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
	]];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	self.scannerView.delegate = self;
	[self.scannerView startScanner:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	self.scannerView.delegate = nil;
	[self.scannerView stopScanner];
}

#pragma mark - clear
- (void)clearMarkLayers {

}

#pragma mark - KKQRCodeScannerViewDelegate
- (BOOL)qrcodeScannerView:(KKQRCodeScannerView *)scannerView didScanner:(NSArray<KKQRCodeScannerResult *> *)results elapsedTime:(NSTimeInterval)elapsedTime {
	[self clearMarkLayers];
	if (!results || results.count == 0) {
		return NO;
	}

// 假设我们只关心第一个扫描结果
   KKQRCodeScannerResult *firstResult = results.firstObject;
   NSString *content = firstResult.content;

    [self dismissViewControllerAnimated:YES completion:^{
        // 调用completionHandler，并传递content
        if (self.completionHandler) {
            self.completionHandler(content);
        }
    }];
   
    
	return NO;
}

@end

