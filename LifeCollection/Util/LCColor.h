//
//  LCColor.h
//  LifeCollection
//
//  Created by gozap on 2018/12/14.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCColor : UIColor
+ (UIColor *)colorWithR255:(NSInteger)red G255:(NSInteger)green B255:(NSInteger)blue A255:(NSInteger)alpha;
+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (UIImage *)createImageWithColor:(UIColor *)color withSize:(CGSize)size;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
+ (UIColor *) colorWithHexString:(NSString *)color;

+ (UIColor *)backgroudColor;
+ (UIColor *)itemBackgroudColor;


+ (UIColor *)LCColor_235_235_235;
+ (UIColor *)LCColor_232_229_222;

+ (UIColor *)LCColor_77_92_127;

+ (UIColor *)LCColor_113_120_150;

+ (UIColor *)LCColor_255_221_124;
+ (UIColor *)LCColor_110_110_110;

+ (UIColor *)LCColor_121_117_245;

+ (UIColor *)LCColor_243_90_93;
@end
