/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnLockCircle.h
 **  Description: 圆圈
 **
 **  Author:  jinnchang
 **  Date:    2016/9/22
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JinnLockCircleState)
{
    JinnLockCircleStateNormal = 0,
    JinnLockCircleStateSelected,
    JinnLockCircleStateFill,
    JinnLockCircleStateError
};

@interface JinnLockCircle : UIView

@property (nonatomic, assign) JinnLockCircleState state;
@property (nonatomic, assign) CGFloat diameter;

- (instancetype)initWithDiameter:(CGFloat)diameter;
- (void)updateCircleState:(JinnLockCircleState)state;

@end
