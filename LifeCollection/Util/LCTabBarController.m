//
//  LCTabBarController.m
//  LCTabBarController
//
//  Created by qaaaa on 2017/9/7.
//  Copyright © 2017 qaaaa. All rights reserved.
//

#import "LCTabBarController.h"
#import "LCTabBar.h"
#import "LCNavigationViewController.h"

#import "HomeViewController.h"
#import "UserViewController.h"

@interface LCTabBarController ()<UITabBarControllerDelegate>

@end

@implementation LCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setValue:[LCTabBar new] forKey:@"tabBar"];
    
    NSMutableArray * controllerArray = [NSMutableArray new];
    
    [controllerArray addObject:[self addChildViewControllerWith:@"HomeViewController" title:@"" normalImage:@"tab_bar_home_icon_cu"]];
    [controllerArray addObject:[self addChildViewControllerWith:@"UserViewController" title:@"" normalImage:@"tab_bar_user_icon_cu"]];
    
    self.viewControllers = controllerArray;
    self.delegate = self;
}

-(LCNavigationViewController *)addChildViewControllerWith:(NSString *)className title:(NSString *)title  normalImage:(NSString *)normalImage{
    
    Class class = NSClassFromString(className);
    UIViewController * controller  = [class new];

    controller.title = title;
    controller.tabBarItem.image = [[UIImage imageNamed:normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSString * selectedImage = [normalImage stringByAppendingString:@"_no"];
    UIImage * image = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = image;
    
//    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:LCCoror(130, 130, 130),NSFontAttributeName:NTFont(12)} forState:UIControlStateNormal];
//    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:LCCoror(221, 168, 100),NSFontAttributeName:NTFont(12)} forState:UIControlStateSelected];

    LCNavigationViewController * ldNav = [[LCNavigationViewController alloc] initWithRootViewController:controller];
    return ldNav;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
