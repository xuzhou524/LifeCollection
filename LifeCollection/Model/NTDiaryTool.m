//
//  NTDiaryTool.m
//  simple
//
//  Created by qaaaa on 2018/12/7.
//  Copyright (c) 2018 qaaaa. All rights reserved.
//

#import "NTDiaryTool.h"
#import "NTDiary.h"
#import "FMDB.h"

@implementation NTDiaryTool

static FMDatabaseQueue *_queue;

+ (void)initialize{
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentFolderPath = [searchPaths objectAtIndex:0];
    NSString *path  = [documentFolderPath stringByAppendingPathComponent:@"LifeCollection.sqlite"];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isExist = [fm fileExistsAtPath:path];
    if (!isExist){
        NSString *backupDbPath = [[NSBundle mainBundle]pathForResource:@"LifeCollection.sqlite" ofType:nil];
        [fm copyItemAtPath:backupDbPath toPath:path error:nil];
    }
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
}

+(NSMutableArray *)queryWithNote{
    __block NTDiary * datanote;
    __block NSMutableArray *diaryArray = nil;
    [_queue inDatabase:^(FMDatabase *db){
         diaryArray = [NSMutableArray array];
         FMResultSet *rs = nil;
         rs = [db executeQuery:@"select * from LifeCollection"];
         while (rs.next){
             datanote = [[NTDiary alloc]init];
             datanote.ids = [rs intForColumn:@"ids"];
             datanote.title = [rs stringForColumn:@"title"];
             datanote.content = [rs stringForColumn:@"content"];
             datanote.time = [rs stringForColumn:@"time"];
             datanote.classType = [rs stringForColumn:@"classType"];
             datanote.remindType = [rs stringForColumn:@"remindType"];
             [diaryArray addObject:datanote];
         }
     }];
    return diaryArray;
}

+(void)deleteNote:(int)ids{
    [_queue inDatabase:^(FMDatabase *db){
      [db executeUpdate:@"delete from LifeCollection where ids = ?", [NSNumber numberWithInt:ids]];
     }];
}

+(void)insertNote:(NTDiary *)diaryNote{
    [_queue inDatabase:^(FMDatabase *db){
         [db executeUpdate:@"insert into LifeCollection(title, content, time, classType, remindType) values (?, ?, ?, ?, ?)",diaryNote.title, diaryNote.content, diaryNote.time, diaryNote.classType, diaryNote.remindType];
     }];
}

+(NTDiary *)queryOneNote:(int)ids{
    __block NTDiary * datanote;
    [_queue inDatabase:^(FMDatabase *db){
         FMResultSet *rs = nil;
         rs = [db executeQuery:@"select * from LifeCollection where ids = ?",[NSNumber numberWithInt:ids]];
         while (rs.next){
             datanote = [[NTDiary alloc]init];
             datanote.ids = [rs intForColumn:@"ids"];
             datanote.title = [rs stringForColumn:@"title"];
             datanote.content = [rs stringForColumn:@"content"];
             datanote.time = [rs stringForColumn:@"time"];
             datanote.classType = [rs stringForColumn:@"classType"];
             datanote.remindType = [rs stringForColumn:@"remindType"];
         }
     }];
    return datanote;
}

+(void)updataNote:(NTDiary *)updataNote{
    [_queue inDatabase:^(FMDatabase *db){
         [db executeUpdate:@"update LifeCollection set title = ? , content = ?, time = ?, classType = ? , remindType = ? where ids = ? ;",updataNote.title, updataNote.content, updataNote.time, updataNote.classType, updataNote.remindType, [NSNumber numberWithInt:updataNote.ids]];
     }];
}
@end
