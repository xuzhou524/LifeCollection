//
//  LCCompassManage.h
//  LifeCollection
//
//  Created by gozap on 2019/3/12.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <CoreLocation/CLHeading.h>
#import <CoreMotion/CoreMotion.h>


@interface LCCompassManage : NSObject
+ (instancetype)shared;
- (void)startSensor;
- (void)stopSensor;
- (void)startGyroscope;

@property (nonatomic, copy) void (^didUpdateHeadingBlock)(CLLocationDirection theHeading);
@property (nonatomic, copy) void (^updateDeviceMotionBlock)(CMDeviceMotion *data);
@end

