//
//  LCColor.m
//  LifeCollection
//
//  Created by gozap on 2018/12/14.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "LCColor.h"

@implementation LCColor

+ (UIColor *)colorWithR255:(NSInteger)red G255:(NSInteger)green B255:(NSInteger)blue A255:(NSInteger)alpha{
    return ([UIColor colorWithRed:((CGFloat) red / 255) green:((CGFloat) green / 255) blue:((CGFloat) blue / 255) alpha:((CGFloat) alpha / 255)]);
}

+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)createImageWithColor:(UIColor *)color withSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


+ (UIColor *)backgroudColor {
    return [LCColor colorWithR255:244 G255:244 B255:247 A255:255];
}




+ (UIColor *)LCColor_232_229_222{
    return [LCColor colorWithR255:234 G255:234 B255:242 A255:255];
}

+ (UIColor *)LCColor_77_92_127{
    return [LCColor colorWithR255:77 G255:92 B255:127 A255:255];
}

+ (UIColor *)LCColor_113_120_150{
    return [LCColor colorWithR255:173 G255:180 B255:200 A255:255];
}


//列表背景色
+ (UIColor *)LCColor_254_79_94{
    return [LCColor colorWithR255:254 G255:79 B255:94 A255:255];
}

+ (UIColor *)LCColor_192_108_132{
    return [LCColor colorWithR255:192 G255:108 B255:132 A255:255];
}

+ (UIColor *)LCColor_104_83_164{
    return [LCColor colorWithR255:104 G255:83 B255:164 A255:255];
}

+ (UIColor *)LCColor_0_111_247{
    return [LCColor colorWithR255:0 G255:111 B255:247 A255:255];
}

+ (UIColor *)LCColor_255_209_79{
    return [LCColor colorWithR255:255 G255:209 B255:79 A255:255];
}

+ (UIColor *)LCColor_255_129_0{
    return [LCColor colorWithR255:255 G255:129 B255:0 A255:255];
}

@end
