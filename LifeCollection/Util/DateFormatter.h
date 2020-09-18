//
//  DateFormatter.h
//  LifeCollection
//
//  Created by gozap on 2018/12/20.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatter : NSObject

+ (NSString *)weekdayStringWithDate:(NSDate *)date;  //获取星期几

+ (NSDate *)dateFromTimeStampString:(NSString *)timeStamp;  //时间戳 转 Data

+ (NSString*) stringFromBirthday:(NSDate*)date;//Date 转 时间字符串  yyyy-MM-dd
+ (NSString*) stringFromStringYeayWeek:(NSDate*)date;//Date 转 时间字符串  yyyy年MM月
+ (NSString*) stringFromStringDay:(NSDate*)date;//Date 转 时间字符串  dd

+ (NSDate *)dateFromString:(NSString *)dateString; //时间字符串 转 Date yyyy-MM-dd



+ (NSString*) stringFromStringtargetDateStr:(NSString*)targetDateStr;

+ (NSString*) stringFromDays:(NSString*)time remindType:(NSString *)remindType targetDateStr:(NSString *)targetDateStr;

+ (NSString*) stringFromTargetDateStr:(NSString*)time remindType:(NSString *)remindType;
@end


