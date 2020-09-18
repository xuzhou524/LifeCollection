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

+ (NSString*) stringFromDays:(NSString*)time remindType:(NSString *)remindType targetDateStr:(NSString *)targetDateStr{
    NSCalendar *gregorian = [[ NSCalendar alloc ] initWithCalendarIdentifier : NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    //格式化时间
    NSDate *createDate = [DateFormatter dateFromTimeStampString:time];
    NSDateComponents* components = [gregorian components:unitFlags fromDate:createDate];
    [components setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
    //格式化现在时间
    NSDateComponents* newDateComponent = [gregorian components:unitFlags fromDate:[NSDate date]];
    [newDateComponent setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
    
    if ([remindType isEqualToString:@"无循环"]){
        return @"0";
    }else{
        if ([remindType isEqualToString:@"月循环"]) {
            if (components.day <= newDateComponent.day) {
                targetDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",newDateComponent.year,newDateComponent.month + 1,components.day];
                if (newDateComponent.month == 12) {//当前月为12  显示下一年的01月
                    targetDateStr = [NSString stringWithFormat:@"%ld-%@-%ld",newDateComponent.year + 1,@"01",components.day];
                }else{
                    if (newDateComponent.month == 1 && (components.day == 29 || components.day == 30 || components.day == 31)) {
                        //当前月为01月  下月是2月   假如日为29、30、31 统一显示 28
                        targetDateStr = [NSString stringWithFormat:@"%ld-%@-%@",newDateComponent.year,@"02",@"28"];
                    }else if (components.day == 31 && (newDateComponent.month + 1 == 4 || newDateComponent.month + 1 == 6 || newDateComponent.month + 1 == 9 || newDateComponent.month + 1 == 11)){
                        //目标日期为四月，六月，九月，十一月  假如日是31  统一显示 30
                        targetDateStr = [NSString stringWithFormat:@"%ld-%ld-%@",newDateComponent.year,newDateComponent.month + 1,@"30"];
                    }
                }
            }else{
                targetDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",newDateComponent.year,newDateComponent.month,components.day];
            }
        }else if ([remindType isEqualToString:@"年循环"]){
            if (components.day <= newDateComponent.day) {
                targetDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",newDateComponent.year + 1,components.month,components.day];
            }else{
                targetDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",newDateComponent.year,components.month,components.day];
            }
        }
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
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
}

+ (NSString *) stringFromTargetDateStr:(NSString*)time remindType:(NSString *)remindType{
    NSCalendar *gregorian = [[ NSCalendar alloc ] initWithCalendarIdentifier : NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    //格式化时间
    NSDate *createDate = [DateFormatter dateFromTimeStampString:time];
    NSDateComponents* components = [gregorian components:unitFlags fromDate:createDate];
    [components setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
    //格式化现在时间
    NSDateComponents* newDateComponent = [gregorian components:unitFlags fromDate:[NSDate date]];
    [newDateComponent setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
    
    NSString * targetDateStr = @"";
    
    if ([remindType isEqualToString:@"月循环"]) {
        if (components.day <= newDateComponent.day) {
            targetDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",newDateComponent.year,newDateComponent.month + 1,components.day];
            if (newDateComponent.month == 12) {//当前月为12  显示下一年的01月
                targetDateStr = [NSString stringWithFormat:@"%ld-%@-%ld",newDateComponent.year + 1,@"01",components.day];
            }else{
                if (newDateComponent.month == 1 && (components.day == 29 || components.day == 30 || components.day == 31)) {
                    //当前月为01月  下月是2月   假如日为29、30、31 统一显示 28
                    targetDateStr = [NSString stringWithFormat:@"%ld-%@-%@",newDateComponent.year,@"02",@"28"];
                }else if (components.day == 31 && (newDateComponent.month + 1 == 4 || newDateComponent.month + 1 == 6 || newDateComponent.month + 1 == 9 || newDateComponent.month + 1 == 11)){
                    //目标日期为四月，六月，九月，十一月  假如日是31  统一显示 30
                    targetDateStr = [NSString stringWithFormat:@"%ld-%ld-%@",newDateComponent.year,newDateComponent.month + 1,@"30"];
                }
            }
        }else{
            targetDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",newDateComponent.year,newDateComponent.month,components.day];
        }
    }else if ([remindType isEqualToString:@"年循环"]){
        if (components.day <= newDateComponent.day) {
            targetDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",newDateComponent.year + 1,components.month,components.day];
        }else{
            targetDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",newDateComponent.year,components.month,components.day];
        }
    }
    
    return  targetDateStr;
}

@end
