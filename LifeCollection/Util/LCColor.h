//
//  LCColor.h
//  LifeCollection
//
//  Created by gozap on 2018/12/14.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCColor : UIColor
+ (UIColor *)colorWithR255:(NSInteger)red G255:(NSInteger)green B255:(NSInteger)blue A255:(NSInteger)alpha;
+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (UIImage *)createImageWithColor:(UIColor *)color withSize:(CGSize)size;

+ (UIColor *)backgroudColor;

+ (UIColor *)LCColor_232_229_222;

+ (UIColor *)LCColor_77_92_127;

+ (UIColor *)LCColor_113_120_150;


+ (UIColor *)LCColor_254_79_94;

+ (UIColor *)LCColor_192_108_132;

+ (UIColor *)LCColor_104_83_164;

+ (UIColor *)LCColor_0_111_247;

+ (UIColor *)LCColor_255_209_79;

+ (UIColor *)LCColor_255_129_0;

@end
