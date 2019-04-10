//
//  NoteModelTool.m
//  LifeCollection
//
//  Created by gozap on 2019/4/9.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "NoteModelTool.h"
#import "NoteModel.h"
#import "FMDB.h"

@implementation NoteModelTool

static FMDatabaseQueue *_queue;

+ (void)initialize{
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentFolderPath = [searchPaths objectAtIndex:0];
    NSString *path  = [documentFolderPath stringByAppendingPathComponent:@"LifeCollectionNote.sqlite"];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isExist = [fm fileExistsAtPath:path];
    if (!isExist){
        NSString *backupDbPath = [[NSBundle mainBundle]pathForResource:@"LifeCollectionNote.sqlite" ofType:nil];
        [fm copyItemAtPath:backupDbPath toPath:path error:nil];
    }
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
}

+(NSMutableArray *)queryWithNote{
    __block NoteModel * datanote;
    __block NSMutableArray *diaryArray = nil;
    [_queue inDatabase:^(FMDatabase *db){
        diaryArray = [NSMutableArray array];
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select * from LifeCollectionNote"];
        while (rs.next){
            datanote = [[NoteModel alloc]init];
            datanote.ids = [rs intForColumn:@"ids"];
            datanote.title = [rs stringForColumn:@"title"];
            datanote.content = [rs stringForColumn:@"content"];
            datanote.time = [rs stringForColumn:@"time"];
            datanote.weather = [rs stringForColumn:@"weather"];
            datanote.mood = [rs stringForColumn:@"mood"];
            datanote.coverImageUrl = [rs stringForColumn:@"coverImageUrl"];
            [diaryArray addObject:datanote];
        }
    }];
    return diaryArray;
}

+(void)deleteNote:(int)ids{
    [_queue inDatabase:^(FMDatabase *db){
        [db executeUpdate:@"delete from LifeCollectionNote where ids = ?", [NSNumber numberWithInt:ids]];
    }];
}

+(void)insertNote:(NoteModel *)diaryNote{
    [_queue inDatabase:^(FMDatabase *db){
        [db executeUpdate:@"insert into LifeCollectionNote(title, content, time, weather, mood, coverImageUrl) values (?, ?, ?, ?, ?, ?)",diaryNote.title, diaryNote.content, diaryNote.time, diaryNote.weather, diaryNote.mood, diaryNote.coverImageUrl];
    }];
}

+(NoteModel *)queryOneNote:(int)ids{
    __block NoteModel * datanote;
    [_queue inDatabase:^(FMDatabase *db){
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select * from LifeCollectionNote where ids = ?",[NSNumber numberWithInt:ids]];
        while (rs.next){
            datanote = [[NoteModel alloc]init];
            datanote.ids = [rs intForColumn:@"ids"];
            datanote.title = [rs stringForColumn:@"title"];
            datanote.content = [rs stringForColumn:@"content"];
            datanote.time = [rs stringForColumn:@"time"];
            datanote.weather = [rs stringForColumn:@"weather"];
            datanote.mood = [rs stringForColumn:@"mood"];
            datanote.coverImageUrl = [rs stringForColumn:@"coverImageUrl"];
        }
    }];
    return datanote;
}

+(void)updataNote:(NoteModel *)updataNote{
    [_queue inDatabase:^(FMDatabase *db){
        [db executeUpdate:@"update LifeCollectionNote set title = ? , content = ?, time = ?, weather = ? , mood = ? , coverImageUrl = ? where ids = ? ;",updataNote.title, updataNote.content, updataNote.time, updataNote.weather, updataNote.mood, updataNote.coverImageUrl, [NSNumber numberWithInt:updataNote.ids]];
    }];
}
@end
