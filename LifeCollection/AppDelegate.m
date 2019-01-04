//
//  AppDelegate.m
//  LifeCollection
//
//  Created by gozap on 2018/12/14.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "AppDelegate.h"
#import "LCTabBarController.h"

#import "AddViewController.h"
#import "FoundViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [LCTabBarController new];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
#ifdef DEBUG
#else
    [Fabric with:@[[Crashlytics class]]];
#endif
    
    return YES;
}

-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    NSString *typeName = shortcutItem.type;
    if ([typeName isEqualToString:kLifeCollectionTimeHome]) {
        
    } else if ([typeName isEqualToString:kLifeCollectionTimeAdd]) {
        [[LCClient sharedInstance].lcCenterNav pushViewController:[AddViewController new] animated:YES];
    } else if ([typeName isEqualToString:kLifeCollectionFound]) {
        [[LCClient sharedInstance].lcCenterNav pushViewController:[FoundViewController new] animated:YES];
    } else if ([typeName isEqualToString:kLifeCollectionShare]) {

    }
}

@end
