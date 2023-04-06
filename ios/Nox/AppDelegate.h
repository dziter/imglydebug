#import <Foundation/Foundation.h>
#import <React/RCTBridgeDelegate.h>
#import <UIKit/UIKit.h>

#import <Expo/Expo.h>

@interface AppDelegate : EXAppDelegateWrapper <RCTBridgeDelegate>

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) NSTimer *soundTimer;

@end
