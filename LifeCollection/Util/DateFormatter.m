//
//  DateFormatter.m
//  LifeCollection
//
//  Created by gozap on 2018/12/20.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "DateFormatter.h"

@implementation DateFormatter

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

@end
