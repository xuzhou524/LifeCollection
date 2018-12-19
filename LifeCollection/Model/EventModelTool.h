//
//  EventModelTool.h
//  LifeCollection
//
//  Created by gozap on 2018/12/19.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EventModel;

@interface EventModelTool : NSObject

+(NSMutableArray *)queryWithNote;

+(void)deleteNote:(int)ids;

+(void)insertNote:(EventModel *)diaryNote;

+(EventModel *)queryOneNote:(int)ids;

+(void)updataNote:(EventModel *)updataNote;

@end

