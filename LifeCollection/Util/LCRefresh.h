//
//  LCRefresh.h
//  LifeCollection
//
//  Created by gozap on 2018/12/25.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCRefresh : NSObject

+ (MJRefreshHeader *)lcRefreshHeader:(MJRefreshComponentRefreshingBlock)refreshingBlock;

+ (MJRefreshFooter *)lcRefreshFooter:(MJRefreshComponentRefreshingBlock)refreshingBlock;

@end

