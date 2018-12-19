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

-(NSMutableArray *)queryWithNote{
    return [EventModelTool queryWithNote];
}

-(void)deleteNote:(int)ids{
    [EventModelTool deleteNote:ids];
}

-(void)insertNote:(EventModel *)diaryNote{
    [EventModelTool insertNote:diaryNote];
}


-(EventModel *)queryOneNote:(int)ids{
    return [EventModelTool queryOneNote:ids];
}

-(void)updataNote:(EventModel *)updataNote{
    [EventModelTool updataNote:updataNote];
}

@end
