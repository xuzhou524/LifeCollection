//
//  AppDelegate.m
//  LifeCollection
//
//  Created by gozap on 2018/12/14.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "AppDelegate.h"
#import "LCNavigationViewController.h"
#import "HomeViewController.h"
#import "JinnLockViewController.h"

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [LCColor backgroudColor];
    
    LCNavigationViewController * rootTabBarVC = [[LCNavigationViewController alloc] initWithRootViewController:[HomeViewController new]];
    self.window.rootViewController = rootTabBarVC;

    [self.window makeKeyAndVisible];
    [[UITabBar appearance] setTranslucent:NO];
 
    [self verify];
    
    return YES;
}

- (void)verify{
    if ([JinnLockTool isGestureUnlockEnabled]){
        JinnLockViewController *lockViewController = [[JinnLockViewController alloc] initWithDelegate:nil
                                                                                                 type:JinnLockTypeVerify
                                                                                           appearMode:JinnLockAppearModePresent];
        
        if (![[LCClient sharedInstance].lcCenterNav.visibleViewController isKindOfClass:[JinnLockViewController class]]){
            lockViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            [[LCClient sharedInstance].lcCenterNav.visibleViewController presentViewController:lockViewController
                                                                          animated:NO
                                                                        completion:nil];
        }
    }
}

@end
