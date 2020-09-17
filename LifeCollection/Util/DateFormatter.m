//
//  DateFormatter.m
//  LifeCollection
//
//  Created by gozap on 2018/12/20.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "DateFormatter.h"

@implementation DateFormatter

+ (NSString *)weekdayStringWithDate:(NSDate *)date {
    //获取星期几
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekday = [componets weekday];//1代表星期日，2代表星期一，后面依次
    NSArray *weekArray = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSString *weekStr = weekArray[weekday-1];
    return weekStr;
}

+ (NSDate *)dateFromTimeStampString:(NSString *)timeStamp{
    NSTimeInterval time;
    if (timeStamp.length == 10) {
        time=[timeStamp doubleValue];
    }else{
        time=[timeStamp doubleValue]/1000;
    }
    NSDate *destDate= [NSDate dateWithTimeIntervalSince1970:time];
    return destDate;
}

+ (NSString*) stringFromBirthday:(NSDate*)date{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *result = [dateFormatter stringFromDate:date];
    return result;
}

+ (NSString*) stringFromStringYeayWeek:(NSDate*)date{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
    [dateFormatter setDateFormat:@"yyyy年MM月"];
    NSString *result = [dateFormatter stringFromDate:date];
    return result;
}

+ (NSString*) stringFromStringDay:(NSDate*)date{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
    [dateFormatter setDateFormat:@"dd"];
    NSString *result = [dateFormatter stringFromDate:date];
    return result;
}


+ (NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}





+ (NSString*) stringFromStringtargetDateStr:(NSString*)targetDateStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYYMMdd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:targetDateStr];
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSTimeInterval  timeInterval = [[DateFormatter dateFromTimeStampString:timeSp] timeIntervalSinceNow] + 24 * 60 * 60;
    long temp = 0;
    NSString *result;
    temp = fabs(timeInterval)/60;
    if((temp = temp/60) <24){
        result= [NSString stringWithFormat:@"0"];
    }else if((temp = temp/24) <10000){
        result = [NSString stringWithFormat:@"%ld",temp];
    }
    return result;
}

@end
