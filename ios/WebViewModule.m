//
//  WebViewModule.m
//  IntelliProveRxPOC
//
//  Created by Dries Vanmeert on 03/01/2024.
//

#import "WebViewModule.h"
#import "AppDelegate.h"
#import "IntelliProveSDK/IntelliProveSDK-Swift.h"
#import <SwiftUI/SwiftUI.h>
#import <React/RCTBridge.h>

@interface WebViewModule () <IntelliWebViewDelegate>
@end

@implementation WebViewModule

RCT_EXPORT_MODULE();

NSString *postMessageEvent = @"IntelliWebViewPostMessage";

- (NSArray<NSString *> *)supportedEvents {
  return @[postMessageEvent];
}

RCT_EXPORT_METHOD(presentWebView:(NSString *)urlString) {
  dispatch_async(dispatch_get_main_queue(), ^{
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    UIViewController *webViewController = [IntelliWebViewFactory newWebViewWithUrlString:urlString delegate:self];
    webViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [rootViewController presentViewController:webViewController animated:YES completion:nil];
  });
}

- (void)didReceiveWithPostMessage:(NSDictionary<NSString *,id> *)postMessage {
  // Pass message to React App through an event
  [self sendEventWithName:postMessageEvent body:postMessage];
}

@end
