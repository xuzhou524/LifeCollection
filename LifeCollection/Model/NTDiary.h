//
//  NTDiary.h
//  simple
//
//  Created by qaaaa on 2018/12/7.
//  Copyright (c) 2018 qaaaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTDiary : NSObject

@property (nonatomic, assign) int ids;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * content;

@property (nonatomic, copy) NSString * time;

@property (nonatomic, copy) NSString * weather;

@property (nonatomic, copy) NSString * mood;

-(NSMutableArray *)queryWithNote;

-(void)deleteNote:(int)ids;

-(void)insertNote:(NTDiary *)diaryNote;

-(NTDiary *)queryOneNote:(int)ids;

-(void)updataNote:(NTDiary *)updataNote;

@end
