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
    LCTabBarController * rootTabBarVC = [LCTabBarController new];
    self.window.rootViewController = rootTabBarVC;
    [LCClient sharedInstance].lcCenterTabBar = rootTabBarVC;
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
        if ([LCClient sharedInstance].lcCenterTabBar.selectedIndex != 0) {
            [LCClient sharedInstance].lcCenterTabBar.selectedIndex = 0;
        }
    } else if ([typeName isEqualToString:kLifeCollectionTimeAdd]) {
        [[LCClient sharedInstance].lcCenterNav pushViewController:[AddViewController new] animated:YES];
    } else if ([typeName isEqualToString:kLifeCollectionFound]) {
        [LCClient sharedInstance].lcCenterTabBar.selectedIndex = 1;
    } else if ([typeName isEqualToString:kLifeCollectionShare]) {
        NSString * title = @"咘咕 - 让生活更精彩";
        NSString * url = @"https://www.gezhipu.com";
        NSString * image = @"http://img.gozap.com/group19/M01/B4/0F/wKgCOFwvGqnXXzibAACN7VDmKvQ248.png";
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:image]];
        UIImage *imageToShare = [UIImage imageWithData:data];
        
        NSString *textToShare = [NSString stringWithFormat:@"%@ %@",title,url];
        NSURL *urlToShare = [NSURL URLWithString:url];
        
        NSArray *activityItems = @[textToShare,imageToShare,urlToShare];
        UIActivity *bookActivity = [UIActivity new];
        NSArray *applicationActivities = @[bookActivity];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems
                                                
                                                                                applicationActivities: applicationActivities];
        [[LCClient sharedInstance].lcCenterNav presentViewController:activityVC animated:TRUE completion:nil];
    }
}

@end
