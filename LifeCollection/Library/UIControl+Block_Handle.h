//
//  UIControl+Category.h
//  TestProject
//
//  Created by LY on 2017/1/19.
//  Copyright © 2017 LY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIControlActionBlock)(UIControlEvents events);


@interface UIControl (Block_Handle)

- (void)handleControlEvents:(UIControlEvents)events withBlock:(UIControlActionBlock)block;

- (void)removeHandleForControlEvents:(UIControlEvents)events;

- (UIControlEvents)checkEventsClash:(UIControlEvents)events;

@end



