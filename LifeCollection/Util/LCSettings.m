//
//  LCSettings.m
//  LifeCollection
//
//  Created by gozap on 2018/12/26.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import "LCSettings.h"

@implementation LCSettings
+(LCSettings *) sharedInstance{
    static LCSettings * settings =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settings =[[self alloc]init];
    });
    return settings;
}
- (id)objectForKey:(NSString *)key{
    if([key isEqualToString:kLaunchScreenModel]){ //如果是自定义对象，NSData要转成对象
        if ([[NSUserDefaults standardUserDefaults] objectForKey:key]) {
//            return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:key]];
            return [NSKeyedUnarchiver unarchivedObjectOfClass:[NSData class] fromData:[[NSUserDefaults standardUserDefaults] objectForKey:key] error:nil];
        }
        return nil;
    }else{
        return [[NSUserDefaults standardUserDefaults]objectForKey:key];
    }
}
- (void)setObject:(id)object forKey:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //如果是自定义对象放在数组中，先要转成NSData再保存
   if([key isEqualToString:kLaunchScreenModel]){
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:object requiringSecureCoding:YES error:nil];
        [defaults setObject:data forKey:key];
    }else{
        [defaults setObject:object forKey:key];
    }
}

- (void)removeObjectForKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}
@end
