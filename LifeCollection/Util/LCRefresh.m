//
//  LCRefresh.m
//  LifeCollection
//
//  Created by gozap on 2018/12/25.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "LCRefresh.h"

@implementation LCRefresh

+ (MJRefreshHeader *)lcRefreshHeader:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    MJRefreshStateHeader * header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        refreshingBlock();
    }];
    //    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    //    [header setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    //    [header setTitle:@"正在刷新中" forState:MJRefreshStateRefreshing];
    return header;
}

+ (MJRefreshFooter *)lcRefreshFooter:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    MJRefreshBackStateFooter * footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        refreshingBlock();
    }];
    return footer;
}

@end
