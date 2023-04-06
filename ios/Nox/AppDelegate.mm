#import "AppDelegate.h"

#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <React/RCTLinkingManager.h>
#import <React/RCTConvert.h>

#import <React/RCTAppSetupUtils.h>

#if RCT_NEW_ARCH_ENABLED
#import <React/CoreModulesPlugins.h>
#import <React/RCTCxxBridgeDelegate.h>
#import <React/RCTFabricSurfaceHostingProxyRootView.h>
#import <React/RCTSurfacePresenter.h>
#import <React/RCTSurfacePresenterBridgeAdapter.h>
#import <ReactCommon/RCTTurboModuleManager.h>

#import <react/config/ReactNativeConfig.h>

static NSString *const kRNConcurrentRoot = @"concurrentRoot";

@interface AppDelegate () <RCTCxxBridgeDelegate, RCTTurboModuleManagerDelegate> {
  RCTTurboModuleManager *_turboModuleManager;
  RCTSurfacePresenterBridgeAdapter *_bridgeAdapter;
  std::shared_ptr<const facebook::react::ReactNativeConfig> _reactNativeConfig;
  facebook::react::ContextContainer::Shared _contextContainer;
}
@end
#endif

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

  RCTAppSetupPrepareApp(application);
  
  // @generated begin react-native-maps-init - expo prebuild (DO NOT MODIFY) sync-607df307b5717d6803df0afc81918eb130b39513
#if __has_include(<GoogleMaps/GoogleMaps.h>)
  [GMSServices provideAPIKey:@"AIzaSyAzxQoipsJfFgBAusTjBfQkTEmt8EqcEGs"];
#endif
 // @generated end react-native-maps-init

  RCTBridge *bridge = [self.reactDelegate createBridgeWithDelegate:self launchOptions:launchOptions];
  
#if RCT_NEW_ARCH_ENABLED
  _contextContainer = std::make_shared<facebook::react::ContextContainer const>();
  _reactNativeConfig = std::make_shared<facebook::react::EmptyReactNativeConfig const>();
  _contextContainer->insert("ReactNativeConfig", _reactNativeConfig);
  _bridgeAdapter = [[RCTSurfacePresenterBridgeAdapter alloc] initWithBridge:bridge contextContainer:_contextContainer];
  bridge.surfacePresenter = _bridgeAdapter.surfacePresenter;
#endif

  NSDictionary *initProps = [self prepareInitialProps];
  UIView *rootView = [self.reactDelegate createRootViewWithBridge:bridge moduleName:@"main" initialProperties:initProps];

  rootView.backgroundColor = [UIColor whiteColor];
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [self.reactDelegate createRootViewController];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  
  [super application:application didFinishLaunchingWithOptions:launchOptions];
  
  NSDictionary *defaults = @{
    @"keepAppAwakeNotificationTitle": @"⏰ Please keep the Nox App open!",
    @"keepAppAwakeNotificationBody": @"The app must be running in the background to wake you up in the morning",
    @"shouldKeepAppAwake": @(NO),
  };
  [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];

  UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
  [center removeDeliveredNotificationsWithIdentifiers:@[@"keepAppAwakeNotification"]];

  
  return YES;
}

- (NSArray<id<RCTBridgeModule>> *)extraModulesForBridge:(RCTBridge *)bridge
{
  // If you'd like to export some custom RCTBridgeModules, add them here!
  return @[];
}

/// This method controls whether the `concurrentRoot`feature of React18 is turned on or off.
///
/// @see: https://reactjs.org/blog/2022/03/29/react-v18.html
/// @note: This requires to be rendering on Fabric (i.e. on the New Architecture).
/// @return: `true` if the `concurrentRoot` feture is enabled. Otherwise, it returns `false`.
- (BOOL)concurrentRootEnabled
{
  // Switch this bool to turn on and off the concurrent root
  return true;
}

- (NSDictionary *)prepareInitialProps
{
  NSMutableDictionary *initProps = [NSMutableDictionary new];
#if RCT_NEW_ARCH_ENABLED
  initProps[kRNConcurrentRoot] = @([self concurrentRootEnabled]);
#endif
  return initProps;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

// Linking API
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
  
  return [super application:application openURL:url options:options] || [RCTLinkingManager application:application openURL:url options:options];
}

// Universal Links
- (BOOL)application:(UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
  
  BOOL result = [RCTLinkingManager application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
  return [super application:application continueUserActivity:userActivity restorationHandler:restorationHandler] || result;
}

// Explicitly define remote notification delegates to ensure compatibility with some third-party libraries
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
  return [super application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

// Explicitly define remote notification delegates to ensure compatibility with some third-party libraries
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
  return [super application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

// Explicitly define remote notification delegates to ensure compatibility with some third-party libraries
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
  return [super application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // NSLog(@"App is about to be terminated."); // -> if needed to debug in future
  
  BOOL shouldKeepAppAwake = [[NSUserDefaults standardUserDefaults] boolForKey:@"shouldKeepAppAwake"];
  if (shouldKeepAppAwake) {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = [[NSUserDefaults standardUserDefaults] stringForKey:@"keepAppAwakeNotificationTitle"];
    content.body = [[NSUserDefaults standardUserDefaults] stringForKey:@"keepAppAwakeNotificationBody"];
    content.sound = [UNNotificationSound defaultSound];
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"keepAppAwakeNotification" content:content trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
  }
}

- (void) applicationWillResignActive:(UIApplication *)application {
  //  NSLog(@"applicationWillResignActive"); // -> if needed to debug in future
  BOOL shouldKeepAppAwake = [[NSUserDefaults standardUserDefaults] boolForKey:@"shouldKeepAppAwake"];
  if (shouldKeepAppAwake) {
    [self activateAudio];
    NSURL *soundFileURL = [[NSBundle mainBundle] URLForResource:@"silence" withExtension:@"wav"];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    // Schedule the sound to play every 1 second
    self.soundTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(playSound) userInfo:nil repeats:YES];
  }
}

- (void) applicationDidBecomeActive:(UIApplication *)application {
  // NSLog(@"applicationDidBecomeActive"); // -> if needed to debug in future
  [self clearTimer];
  [self stopSound];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"AlarmIsPlayingSound" object:nil];
}

- (void)handleNotification:(NSNotification *)notification {
  // NSString *name = notification.name;
  // NSLog(@"Received notification with name: %@", name); // -> if needed to debug in future
  [self clearTimer];
  [self stopSound];
}

- (void)activateAudio {
  NSError *setCategoryErr = nil;
  NSError *activationErr  = nil;
  [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:&setCategoryErr];
  [[AVAudioSession sharedInstance] setActive:YES error:&activationErr];
}

- (void)playSound {
  [self activateAudio];
  [self.audioPlayer play];
  // NSLog(@"KeepAppAwake: Playing sound"); // -> if needed to debug in future
}

- (void)stopSound {
  [self.audioPlayer stop];
  // NSLog(@"KeepAppAwake: Stopping sound"); // -> if needed to debug in future
}

- (void)clearTimer {
  [self.soundTimer invalidate];
  self.soundTimer = nil;
  // NSLog(@"KeepAppAwake: Clearing timer"); // -> if needed to debug in future
}

#if RCT_NEW_ARCH_ENABLED

#pragma mark - RCTCxxBridgeDelegate

- (std::unique_ptr<facebook::react::JSExecutorFactory>)jsExecutorFactoryForBridge:(RCTBridge *)bridge
{
  _turboModuleManager = [[RCTTurboModuleManager alloc] initWithBridge:bridge
                                                             delegate:self
                                                            jsInvoker:bridge.jsCallInvoker];
  return RCTAppSetupDefaultJsExecutorFactory(bridge, _turboModuleManager);
}

#pragma mark RCTTurboModuleManagerDelegate

- (Class)getModuleClassFromName:(const char *)name
{
  return RCTCoreModulesClassProvider(name);
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const std::string &)name
jsInvoker:(std::shared_ptr<facebook::react::CallInvoker>)jsInvoker
{
  return nullptr;
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const std::string &)name
initParams:
(const facebook::react::ObjCTurboModule::InitParams &)params
{
  return nullptr;
}

- (id<RCTTurboModule>)getModuleInstanceFromClass:(Class)moduleClass
{
  return RCTAppSetupDefaultModuleFromClass(moduleClass);
}

#endif

@end
