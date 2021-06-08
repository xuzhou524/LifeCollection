//
//  LCClient.m
//  LifeCollection
//
//  Created by gozap on 2019/1/4.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import "LCClient.h"

@implementation LCClient
+ (LCClient*) sharedInstance  //第二步：实例构造检查静态实例是否为nil
{
    static LCClient *sharedObj = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedObj = [[self alloc] init];
    });
    return sharedObj;
}
@end
