//
//  EventModel.m
//  LifeCollection
//
//  Created by gozap on 2018/12/19.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "EventModel.h"
#import "EventModelTool.h"

@implementation EventModel

-(NSMutableArray *)queryWithTime{
    return [EventModelTool queryWithTime];
}

-(void)deleteTime:(int)ids{
    [EventModelTool deleteTime:ids];
}

-(void)insertTime:(EventModel *)diaryTime{
    [EventModelTool insertTime:diaryTime];
}


-(EventModel *)queryOneTime:(int)ids{
    return [EventModelTool queryOneTime:ids];
}

-(void)updataTime:(EventModel *)updataTime{
    [EventModelTool updataTime:updataTime];
}

@end
