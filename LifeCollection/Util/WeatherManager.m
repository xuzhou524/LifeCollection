//
//  WeatherManager.m
//  LifeCollection
//
//  Created by gozap on 2019/4/15.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "WeatherManager.h"

@implementation WeatherManager

-(void)setWeatherIconIndex:(NSString *)weatherIconIndex{
    if ([weatherIconIndex isEqualToString:@"CLEAR_DAY"] || [weatherIconIndex isEqualToString:@"CLEAR_NIGHT"]) {
        _weatherIconIndex =@"100";
    }else if ([weatherIconIndex isEqualToString:@"PARTLY_CLOUDY_DAY"] || [weatherIconIndex isEqualToString:@"PARTLY_CLOUDY_NIGHT"]){
        _weatherIconIndex =@"101";
    }else if ([weatherIconIndex isEqualToString:@"CLOUDY"]){
        _weatherIconIndex =@"103";
    }else if ([weatherIconIndex isEqualToString:@"RAIN"]){
        _weatherIconIndex =@"106";
    }else if ([weatherIconIndex isEqualToString:@"SNOW"]){
        _weatherIconIndex =@"114";
    }else if ([weatherIconIndex isEqualToString:@"WIND"]){
        _weatherIconIndex =@"120";
    }else if ([weatherIconIndex isEqualToString:@"HAZE"]){
        _weatherIconIndex =@"123";
    }else{
        _weatherIconIndex =@"100";
    }
    
}

+(WeatherManager *)sharedInstance{
    static WeatherManager * sharedObj =nil;
    static dispatch_once_t prdericate;
    dispatch_once(&prdericate, ^{
        sharedObj =[[self alloc]init];
        
    });
    return sharedObj;
}

@end
