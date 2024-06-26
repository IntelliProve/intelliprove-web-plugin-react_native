#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>
#import <React/RCTBridge.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.moduleName = @"IntelliProveRxPOC";
  // You can add your custom initial props in the dictionary below.
  // They will be passed down to the ViewController used by React Native.
  self.initialProps = @{};

  BOOL result = [super application:application didFinishLaunchingWithOptions:launchOptions];

  [self registerWebViewModule];

  return result;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  return [self getBundleURL];
}

- (NSURL *)getBundleURL
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

- (void)registerWebViewModule
{
  RCTBridge *bridge = self.bridge;

  if (bridge) {
    [bridge moduleForName:@"WebViewModule"];
  }
}

@end
