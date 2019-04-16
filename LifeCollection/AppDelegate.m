//
//  AppDelegate.m
//  LifeCollection
//
//  Created by gozap on 2018/12/14.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "AppDelegate.h"
#import "LCTabBarController.h"
#import "WeatherManager.h"
#import "AddViewController.h"
#import "FoundViewController.h"

#import <CoreLocation/CoreLocation.h>

@interface AppDelegate ()<CLLocationManagerDelegate>{
    CLLocationManager * _locationmanager;//定位服务
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [LCColor backgroudColor];
    
    [self getLocation];
    
    LCTabBarController * rootTabBarVC = [LCTabBarController new];
    self.window.rootViewController = rootTabBarVC;
    [LCClient sharedInstance].lcCenterTabBar = rootTabBarVC;
    [self.window makeKeyAndVisible];
    [[UITabBar appearance] setTranslucent:NO];
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
        NSString * title = @"记点 - 让生活更精彩";
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

-(void)getLocation{
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        _locationmanager = [[CLLocationManager alloc]init];
        _locationmanager.delegate = self;
//        [locationmanager requestAlwaysAuthorization];
        [_locationmanager requestWhenInUseAuthorization];
        //设置寻址精度
        _locationmanager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationmanager.distanceFilter = 100.0;
  
        [_locationmanager startUpdatingLocation];
    }
}

#pragma mark CoreLocation delegate (定位失败)
//定位失败后调用此代理方法
//-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
//    //设置提示提醒用户打开定位服务
//    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"允许定位提示"
//                                                        message:@"请在设置中打开定位"
//                                                       delegate:self
//                                              cancelButtonTitle:@"我知道了"
//                                              otherButtonTitles:nil, nil];
//    // 显示弹出框
//    [alertView show];
//}

#pragma mark 定位成功后则执行此代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *currentLocation = [locations lastObject];
    //打印当前的经度与纬度
    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    [WeatherManager sharedInstance].latitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    [WeatherManager sharedInstance].longitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    [self getWeatherInfo];
    [_locationmanager stopUpdatingHeading];
}

-(void)getWeatherInfo{
    //    NSString * url = @"https://api.seniverse.com/v3/weather/now.json?key=YA5WCX1HTU&location=beijing&language=zh-Hans&unit=c";
    NSString * url =[NSString stringWithFormat:@"https://api.caiyunapp.com/v2/TAkhjf8d1nlSlspN/%@,%@/realtime.json",[WeatherManager sharedInstance].latitude,[WeatherManager sharedInstance].longitude];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary * resultDic =  responseObject[@"result"];
        [WeatherManager sharedInstance].weatherIconIndex = resultDic[@"skycon"];
    } failure:nil];
}

@end
