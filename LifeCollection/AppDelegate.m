//
//  AppDelegate.m
//  LifeCollection
//
//  Created by gozap on 2018/12/14.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import "AppDelegate.h"
#import "LCNavigationViewController.h"
#import "HomeViewController.h"
@import GoogleMobileAds;

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
#ifdef DEBUG
#else
    [[GADMobileAds sharedInstance] startWithCompletionHandler:nil];
#endif
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [LCColor backgroudColor];
    
    LCNavigationViewController * rootTabBarVC = [[LCNavigationViewController alloc] initWithRootViewController:[HomeViewController new]];
    self.window.rootViewController = rootTabBarVC;

    [self.window makeKeyAndVisible];
    [[UITabBar appearance] setTranslucent:NO];
    
    return YES;
}

@end
