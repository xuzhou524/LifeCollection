//
//  LCClient.h
//  LifeCollection
//
//  Created by gozap on 2019/1/4.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LCClient : NSObject

@property(nonatomic,weak)UINavigationController * lcCenterNav;
@property(nonatomic,weak)UITabBarController * lcCenterTabBar;

+ (LCClient *) sharedInstance;


@end
