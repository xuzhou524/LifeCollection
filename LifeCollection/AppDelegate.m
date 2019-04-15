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

#import <CoreLocation/CoreLocation.h>

@interface AppDelegate ()<CLLocationManagerDelegate>{
    CLLocationManager *locationmanager;//定位服务
    NSString *strlatitude;//经度
    NSString *strlongitude;//纬度
}

//@property(nonatomic,strong)NSString *currentCity;//当前城市

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

-(void)getLocation{
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationmanager = [[CLLocationManager alloc]init];
        locationmanager.delegate = self;
        [locationmanager requestAlwaysAuthorization];
//        _currentCity = [NSString new];
        [locationmanager requestWhenInUseAuthorization];

        //设置寻址精度
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        locationmanager.distanceFilter = 5.0;
        [locationmanager startUpdatingLocation];
    }
}

#pragma mark CoreLocation delegate (定位失败)
//定位失败后调用此代理方法
//-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
//    //设置提示提醒用户打开定位服务
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:nil];
//
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [alert addAction:okAction];
//    [alert addAction:cancelAction];
//    [self presentViewController:alert animated:YES completion:nil];
//}

#pragma mark 定位成功后则执行此代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [locationmanager stopUpdatingHeading];
    //旧址
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //打印当前的经度与纬度
    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    
    //反地理编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
//            self.currentCity = placeMark.locality;
//            if (!self.currentCity) {
//                self.currentCity = @"无法定位当前城市";
//            }
            /*看需求定义一个全局变量来接收赋值*/
            NSLog(@"----%@",placeMark.country);//当前国家
//            NSLog(@"%@",self.currentCity);//当前的城市
            NSLog(@"%@",placeMark.subLocality);//当前的位置
            NSLog(@"%@",placeMark.thoroughfare);//当前街道
            NSLog(@"%@",placeMark.name);//具体地址
        }
    }];
}

@end
