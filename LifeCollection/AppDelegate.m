//
//  AppDelegate.m
//  LifeCollection
//
//  Created by gozap on 2018/12/14.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "AppDelegate.h"
#import "LCTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [LCTabBarController new];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}

@end
