//
//  WidgetModel.m
//  LifeCollection
//
//  Created by gozap on 2020/9/17.
//  Copyright © 2020 com.longdai. All rights reserved.
//

#import "WidgetModel.h"

@implementation WidgetModel
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
