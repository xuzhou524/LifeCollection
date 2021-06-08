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

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    // 删除字符串中的空格
    NSString * colorStr = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([colorStr length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    // 如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([colorStr hasPrefix:@"0X"]) {
        colorStr = [colorStr substringFromIndex:2];
    }
    
    // 如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([colorStr hasPrefix:@"#"]) {
        colorStr = [colorStr substringFromIndex:1];
    }
    
    // 除去所有开头字符后 再判断字符串长度
    if ([colorStr length] != 6) {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //red
    NSString * redStr = [colorStr substringWithRange:range];
    //green
    range.location = 2;
    NSString * greenStr = [colorStr substringWithRange:range];
    //blue
    range.location = 4;
    NSString * blueStr = [colorStr substringWithRange:range];
    
    // Scan values 将十六进制转换成二进制
    unsigned int r, g, b;
    [[NSScanner scannerWithString:redStr] scanHexInt:&r];
    [[NSScanner scannerWithString:greenStr] scanHexInt:&g];
    [[NSScanner scannerWithString:blueStr] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
    
}

+ (UIColor *) colorWithHexString:(NSString *)color{
    return [self colorWithHexString:color alpha:1.0f];
}

//#494E69
+ (UIColor *)backgroudColor {
    return [UIColor colorWithLightColorStr:@"#EBEBEB" DarkColor:@"191919"];
}



+ (UIColor *)itemBackgroudColor {
    return [UIColor colorWithLightColorStr:@"ffffff" DarkColor:@"1E1E1E"];
}
+ (UIColor *)LCColor_232_229_222{
    return [UIColor colorWithLightColorStr:@"EAEAF2" DarkColor:@"1E1E1E"];
}



+ (UIColor *)LCColor_235_235_235{
    return [LCColor colorWithR255:235 G255:235 B255:235 A255:255];
}



+ (UIColor *)LCColor_77_92_127{
    return [LCColor colorWithR255:77 G255:92 B255:127 A255:255];
}

+ (UIColor *)LCColor_113_120_150{
    return [LCColor colorWithR255:173 G255:180 B255:200 A255:255];
}

+ (UIColor *)LCColor_110_110_110{
    return [LCColor colorWithR255:110 G255:110 B255:110 A255:255];
}

+ (UIColor *)LCColor_243_90_93{
    return [LCColor colorWithR255:243 G255:90 B255:93 A255:255];
}

@end
