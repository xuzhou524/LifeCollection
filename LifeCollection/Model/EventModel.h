//
//  EventModel.h
//  LifeCollection
//
//  Created by gozap on 2018/12/19.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventModel : NSObject

@property (nonatomic, assign) int ids;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * content;

@property (nonatomic, copy) NSString * time;

@property (nonatomic, copy) NSString * classType;

@property (nonatomic, copy) NSString * remindType;

@property (nonatomic, copy) NSString * colorType;

@property (nonatomic, copy) NSString * tag;

-(NSMutableArray *)queryWithTime;

-(void)deleteTime:(int)ids;

-(void)insertTime:(EventModel *)diaryTime;

-(EventModel *)queryOneTime:(int)ids;

-(void)updataTime:(EventModel *)updataTime;

@end

