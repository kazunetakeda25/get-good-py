//
//  AppDelegate.m
//  getgood
//
//  Created by Md Aminuzzaman on 11/6/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@import UserNotifications;
@import UIKit;
@import Firebase;
@import FirebaseMessaging;

#define SYSTEM_VERSION_LESS_THAN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface AppDelegate () <UIApplicationDelegate,UNUserNotificationCenterDelegate>
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [FIRApp configure];
    
    [self registerForNotification];
    
    [NSTimer scheduledTimerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [RestClient online];
    }];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    return YES;
}
    
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                              openURL:url
                                                    sourceApplication:sourceApplication
                                                           annotation:annotation];
}
    
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

    if([[userInfo allKeys] containsObject:@"dialog"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TypingNotification" object:userInfo];
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    if([[notification.request.content.userInfo allKeys] containsObject:@"dialog"])
    {
        return;
    }
    NSLog(@"User Info = %@",notification.request.content.userInfo);
   
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification" object:nil];
    
    UINavigationController* vc = (UINavigationController*) [AppDelegate topMostController];
    
    NSArray* arVCs = [vc viewControllers];
    if(!([[arVCs lastObject] isKindOfClass:[GroupDetailsController class]] && [Temp onGroupChat]) && ![[arVCs lastObject] isKindOfClass:[PlayerChatController class]] &&  ![[arVCs lastObject] isKindOfClass:[ChatController class]])
    {
        NSString* pushText = [[[notification.request.content.userInfo objectForKey:@"aps"] objectForKey:@"alert"] objectForKey:@"body"];
        
        [[[iToast makeText:pushText] setDuration:iToastDurationNormal] show];
    }

//    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound);
}

+ (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    return topController;
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    
    NSLog(@"User Info = %@",response.notification.request.content.userInfo);
    completionHandler();
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"DEVICE_TOKEN :: %@", deviceToken);
    
    const unsigned *tokenBytes = [deviceToken bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    
    NSLog(@"%@", hexToken);
    
    [[NSUserDefaults standardUserDefaults] setObject:hexToken forKey:@"push_token"];
    
    NSString* token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if(token != nil)
    {
        [RestClient updatePushToken:hexToken callback:^(bool result, NSDictionary *data) {
            
        }];
    }
}
-(void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FBSDKAppEvents activateApp];
}

-(void)registerForNotification{
    
    if ([UNUserNotificationCenter class] != nil) {
        // iOS 10 or later
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
        UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter]
         requestAuthorizationWithOptions:authOptions
         completionHandler:^(BOOL granted, NSError * _Nullable error) {             // ...
             dispatch_async(dispatch_get_main_queue(), ^{
                 [[UIApplication sharedApplication] registerForRemoteNotifications];
             });
         }];
    } else {
        // iOS 10 notifications aren't available; fall back to iOS 8-9 notifications.
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
