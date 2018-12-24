//
//  FoundListModel.h
//  LifeCollection
//
//  Created by gozap on 2018/12/24.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoundListModel : NSObject
@property(nonatomic,strong)NSString *_id;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *cover;
@property(nonatomic,strong)NSString *crawled;
@property(nonatomic,strong)NSString *created_at;
@property(nonatomic,strong)NSString *deleted;
@property(nonatomic,strong)NSString *published_at;
//@property(nonatomic,strong)NSString *raw;
//@property(nonatomic,strong)NSString *site;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *url;
@end

