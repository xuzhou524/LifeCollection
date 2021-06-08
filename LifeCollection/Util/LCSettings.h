//
//  LCSettings.h
//  LifeCollection
//
//  Created by gozap on 2018/12/26.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCSettings : NSObject
+(LCSettings *) sharedInstance;

- (id) objectForKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;
- (void) setObject:(id)object forKey:(NSString*)key;
@end
