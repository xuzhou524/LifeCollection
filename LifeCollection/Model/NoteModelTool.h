//
//  NoteModelTool.h
//  LifeCollection
//
//  Created by gozap on 2019/4/9.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NoteModel;
@interface NoteModelTool : NSObject

+(NSMutableArray *)queryWithNote;

+(void)deleteNote:(int)ids;

+(void)insertNote:(NoteModel *)diaryNote;

+(NoteModel *)queryOneNote:(int)ids;

+(void)updataNote:(NoteModel *)updataNote;
@end
