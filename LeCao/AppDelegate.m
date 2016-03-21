//
//  AppDelegate.m
//  LeCao
//
//  Created by Mr. Feng on 11/20/15.
//  Copyright © 2015 YX. All rights reserved.
//

#import "AppDelegate.h"
#import "PPTabBarController.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[PPTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    [self launchAnimateImage];

    [AVOSCloud setApplicationId:@"x0Apk2lowN0163E7DjGUomxI"
                      clientKey:@"d6Nhq5lwvVmSMd7qNqolH8DX"];
    
    return YES;
}
- (void)launchAnimateImage
{
    UIImageView *v = [[UIImageView alloc] initWithFrame:self.window.bounds];
    v.image = [UIImage imageNamed:@"screen"];
    v.contentMode = UIViewContentModeScaleAspectFill;
    v.alpha = 0.0;
    [self.window addSubview:v];
    [UIView animateWithDuration:0.2 animations:^{
        v.alpha = 0.99;
    } completion:^(BOOL finished) {
    }];
    [UIView animateWithDuration:0.2 delay:2.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        v.alpha = 0.0;
    } completion:^(BOOL finished) {
        [v removeFromSuperview];
    }];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [AVOSCloudSNS handleOpenURL:url];
}

// When Build with IOS 9 SDK
// For application on system below ios 9
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [AVOSCloudSNS handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
