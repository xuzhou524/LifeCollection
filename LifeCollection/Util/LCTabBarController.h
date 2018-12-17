//
//  LCTabBarController.h
//  LCTabBarController
//
//  Created by qaaaa on 2017/9/7.
//  Copyright © 2017 qaaaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCTabBarController : UITabBarController
@property (nonatomic, strong) UITabBarItem *lastItem;
@property (nonatomic, strong) NSDate *lastSelectedDate;
@end
