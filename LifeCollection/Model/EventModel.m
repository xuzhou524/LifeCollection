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

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
        
        self.classType = [aDecoder decodeObjectForKey:@"classType"];
        self.remindType = [aDecoder decodeObjectForKey:@"remindType"];
        self.colorType = [aDecoder decodeObjectForKey:@"colorType"];
        
        self.ids = [aDecoder decodeIntForKey:@"ids"];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.time forKey:@"time"];
    
    [aCoder encodeObject:self.classType forKey:@"classType"];
    [aCoder encodeObject:self.remindType forKey:@"remindType"];
    [aCoder encodeObject:self.colorType forKey:@"colorType"];
    
    [aCoder encodeInt:self.ids forKey:@"ids"];
}

@end
