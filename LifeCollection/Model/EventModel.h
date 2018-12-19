//
//  EventModel.h
//  LifeCollection
//
//  Created by gozap on 2018/12/19.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventModel : NSObject

@property (nonatomic, assign) int ids;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * content;

@property (nonatomic, copy) NSString * time;

@property (nonatomic, copy) NSString * classType;

@property (nonatomic, copy) NSString * remindType;


-(NSMutableArray *)queryWithNote;

-(void)deleteNote:(int)ids;

-(void)insertNote:(EventModel *)diaryNote;

-(EventModel *)queryOneNote:(int)ids;

-(void)updataNote:(EventModel *)updataNote;

@end

