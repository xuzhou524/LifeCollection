//
//  DateFormatter.h
//  LifeCollection
//
//  Created by gozap on 2018/12/20.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatter : NSObject

+ (NSDate *)dateFromTimeStampString:(NSString *)timeStamp;  //时间戳 转 Data

+ (NSString*) stringFromBirthday:(NSDate*)date;//Data 转 时间字符串  yyyy-MM-dd

@end


