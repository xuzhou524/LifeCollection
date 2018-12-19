//
//  NTDiaryTool.h
//  simple
//
//  Created by qaaaa on 2018/12/7.
//  Copyright (c) 2018 qaaaa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NTDiary;

@interface NTDiaryTool : NSObject


+(NSMutableArray *)queryWithNote;

+(void)deleteNote:(int)ids;

+(void)insertNote:(NTDiary *)diaryNote;

+(NTDiary *)queryOneNote:(int)ids;

+(void)updataNote:(NTDiary *)updataNote;

@end
