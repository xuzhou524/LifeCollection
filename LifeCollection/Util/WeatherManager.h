//
//  WeatherManager.h
//  LifeCollection
//
//  Created by gozap on 2019/4/15.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherManager : NSObject

+ (WeatherManager*) sharedInstance;

@property (nonatomic,strong) NSString * latitude;
@property (nonatomic,strong) NSString * longitude;


@property (nonatomic,strong) NSString * weatherIconIndex;
@end
