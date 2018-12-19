//
//  EventModelTool.m
//  LifeCollection
//
//  Created by gozap on 2018/12/19.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "EventModelTool.h"
#import "EventModel.h"
#import "FMDB.h"

@implementation EventModelTool

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
    __block EventModel * datanote;
    __block NSMutableArray *diaryArray = nil;
    [_queue inDatabase:^(FMDatabase *db){
        diaryArray = [NSMutableArray array];
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select * from LifeCollection_Tab"];
        while (rs.next){
            datanote = [[EventModel alloc]init];
            datanote.ids = [rs intForColumn:@"ids"];
            datanote.title = [rs stringForColumn:@"title"];
            datanote.content = [rs stringForColumn:@"content"];
            datanote.time = [rs stringForColumn:@"time"];
            datanote.classType = [rs stringForColumn:@"classType"];
            datanote.remindType = [rs stringForColumn:@"remindType"];
            datanote.colorType = [rs stringForColumn:@"colorType"];
            [diaryArray addObject:datanote];
        }
    }];
    return diaryArray;
}

+(void)deleteNote:(int)ids{
    [_queue inDatabase:^(FMDatabase *db){
        [db executeUpdate:@"delete from LifeCollection_Tab where ids = ?", [NSNumber numberWithInt:ids]];
    }];
}

+(void)insertNote:(EventModel *)diaryNote{
    [_queue inDatabase:^(FMDatabase *db){
        [db executeUpdate:@"insert into LifeCollection_Tab(title, content, time, classType, remindType, colorType) values (?, ?, ?, ?, ?)",diaryNote.title, diaryNote.content, diaryNote.time, diaryNote.classType, diaryNote.remindType, diaryNote.colorType];
    }];
}

+(EventModel *)queryOneNote:(int)ids{
    __block EventModel * datanote;
    [_queue inDatabase:^(FMDatabase *db){
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select * from LifeCollection_Tab where ids = ?",[NSNumber numberWithInt:ids]];
        while (rs.next){
            datanote = [[EventModel alloc]init];
            datanote.ids = [rs intForColumn:@"ids"];
            datanote.title = [rs stringForColumn:@"title"];
            datanote.content = [rs stringForColumn:@"content"];
            datanote.time = [rs stringForColumn:@"time"];
            datanote.classType = [rs stringForColumn:@"classType"];
            datanote.remindType = [rs stringForColumn:@"remindType"];
            datanote.colorType = [rs stringForColumn:@"colorType"];
        }
    }];
    return datanote;
}

+(void)updataNote:(EventModel *)updataNote{
    [_queue inDatabase:^(FMDatabase *db){
        [db executeUpdate:@"update LifeCollection_Tab set title = ? , content = ?, time = ?, classType = ? , remindType = ? , colorType = ? where ids = ? ;",updataNote.title, updataNote.content, updataNote.time, updataNote.classType, updataNote.remindType, updataNote.colorType, [NSNumber numberWithInt:updataNote.ids]];
    }];
}

@end
