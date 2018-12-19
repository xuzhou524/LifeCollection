//
//  NTDiary.m
//  simple
//
//  Created by qaaaa on 2018/12/7.
//  Copyright (c) 2018 qaaaa. All rights reserved.
//

#import "NTDiary.h"
#import "NTDiaryTool.h"

@implementation NTDiary

-(NSMutableArray *)queryWithNote{
   return [NTDiaryTool queryWithNote];
}

-(void)deleteNote:(int)ids{
    [NTDiaryTool deleteNote:ids];
}

-(void)insertNote:(NTDiary *)diaryNote{
    [NTDiaryTool insertNote:diaryNote];
}


-(NTDiary *)queryOneNote:(int)ids{
    return [NTDiaryTool queryOneNote:ids];
}

-(void)updataNote:(NTDiary *)updataNote{
    [NTDiaryTool updataNote:updataNote];
}


@end
