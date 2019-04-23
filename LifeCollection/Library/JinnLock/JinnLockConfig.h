/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnLockConfig.h
 **  Description: 配置文件
 **
 **  Author:  jinnchang
 **  Date:    2016/9/22
 **  Version: 1.0.0
 **  Remark:  Create New File
 **************************************************************************************************/

#import <UIKit/UIKit.h>

#ifndef JinnLockConfig_h
#define JinnLockConfig_h

// 背景颜色
#define JINN_LOCK_COLOR_BACKGROUND [UIColor whiteColor]

// 正常主题颜色
#define JINN_LOCK_COLOR_NORMAL [UIColor blackColor]

// 错误提示颜色
#define JINN_LOCK_COLOR_ERROR [UIColor redColor]

// 重设按钮颜色
#define JINN_LOCK_COLOR_BUTTON [UIColor grayColor]

/**
 *  指示器大小
 */
static const CGFloat kIndicatorSideLength = 30.f;

/**
 *  九宫格大小
 */
static const CGFloat kSudokoSideLength = 300.f;

/**
 *  圆圈边框粗细(指示器和九宫格的一样粗细)
 */
static const CGFloat kCircleWidth = 0.5f;

/**
 *  指示器轨迹粗细
 */
static const CGFloat kIndicatorTrackWidth = 0.5f;

/**
 *  九宫格轨迹粗细
 */
static const CGFloat kSudokoTrackWidth = 4.f;

/**
 *  圆圈选中效果中心点和圆圈比例
 */
static const CGFloat kCircleCenterRatio = 0.4f;

/**
 *  最少连接个数
 */
static const NSInteger kConnectionMinNum = 3;

/**
 *  指示器标签基数(不建议更改)
 */
static const NSInteger kIndicatorLevelBase = 1000;

/**
 *  九宫格标签基数(不建议更改)
 */
static const NSInteger kSudokoLevelBase = 2000;

/**
 *  手势解锁开关键(不建议更改)
 */
static NSString * const kJinnLockGestureUnlockEnabled = @"JinnLockGestureUnlockEnabled";

/**
 *  指纹解锁开关键(不建议更改)
 */
static NSString * const kJinnLockTouchIdUnlockEnabled = @"JinnLockTouchIdUnlockEnabled";

/**
 *  手势密码键(不建议更改)
 */
static NSString * const kJinnLockPasscode = @"JinnLockPasscode";

/**
 *  提示文本
 */
static NSString * const kJinnLockTouchIdText  = @"指纹验证";
static NSString * const kJinnLockResetText    = @"重新设置";
static NSString * const kJinnLockNewText      = @"请设置新密码";
static NSString * const kJinnLockVerifyText   = @"请输入密码";
static NSString * const kJinnLockAgainText    = @"请再次确认新密码";
static NSString * const kJinnLockNotMatchText = @"两次密码不匹配";
static NSString * const kJinnLockReNewText    = @"请重新设置新密码";
static NSString * const kJinnLockReVerifyText = @"请重新输入密码";
static NSString * const kJinnLockOldText      = @"请输入旧密码";
static NSString * const kJinnLockOldErrorText = @"密码不正确";
static NSString * const kJinnLockReOldText    = @"请重新输入旧密码";

#define JINN_LOCK_NOT_ENOUGH [NSString stringWithFormat:@"最少连接%ld个点，请重新输入", (long)kConnectionMinNum]

#endif
