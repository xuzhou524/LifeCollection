//
//  EventModelTool.h
//  LifeCollection
//
//  Created by gozap on 2018/12/19.
//  Copyright © 2018 com.xuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EventModel;

@interface EventModelTool : NSObject

+(NSMutableArray *)queryWithTime;

+(void)deleteTime:(int)ids;

+(void)insertTime:(EventModel *)diaryTime;

+(EventModel *)queryOneTime:(int)ids;

+(void)updataTime:(EventModel *)updataTime;

@end

