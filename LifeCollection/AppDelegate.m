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
#import "JinnLockViewController.h"

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [LCColor backgroudColor];
    
    LCTabBarController * rootTabBarVC = [LCTabBarController new];
    self.window.rootViewController = rootTabBarVC;
    [LCClient sharedInstance].lcCenterTabBar = rootTabBarVC;
    [self.window makeKeyAndVisible];
    [[UITabBar appearance] setTranslucent:NO];
#ifdef DEBUG
#else
    [Fabric with:@[[Crashlytics class]]];
#endif
    
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
        NSString * title = @"记点 - 专注时间管理、记事本日常工具";
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

//-(void)getWeatherInfo{
//    //    NSString * url = @"https://api.seniverse.com/v3/weather/now.json?key=YA5WCX1HTU&location=beijing&language=zh-Hans&unit=c";
//    NSString * url =[NSString stringWithFormat:@"https://api.caiyunapp.com/v2/TAkhjf8d1nlSlspN/%@,%@/realtime.json",[WeatherManager sharedInstance].longitude,[WeatherManager sharedInstance].latitude];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSMutableDictionary * resultDic =  responseObject[@"result"];
//        [WeatherManager sharedInstance].weatherIconIndex = resultDic[@"skycon"];
//    } failure:nil];
//}

@end
