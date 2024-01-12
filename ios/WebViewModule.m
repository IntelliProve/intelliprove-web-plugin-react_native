//
//  WebViewModule.m
//  IntelliProveRxPOC
//
//  Created by Dries Vanmeert on 03/01/2024.
//

#import "WebViewModule.h"
#import "AppDelegate.h"
#import "IntelliProveRxPOC-Swift.h"
#import <SwiftUI/SwiftUI.h>
#import <React/RCTBridge.h>

@implementation WebViewModule

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(presentWebView:(NSString *)urlString) {
  dispatch_async(dispatch_get_main_queue(), ^{
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    UIViewController *webViewController = [IntelliWebViewFactory newWebViewWithUrlString:urlString];
    webViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [rootViewController presentViewController:webViewController animated:YES completion:nil];
  });
}

@end
