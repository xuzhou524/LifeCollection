//
//  TimeListTableViewCell.h
//  LifeCollection
//
//  Created by gozap on 2021/6/7.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventModel.h"

@interface TimeListTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * bgView;

@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UILabel * dayLabel;

@property(nonatomic,strong)UILabel * classTypeLabel;
@property(nonatomic,strong)UILabel * remindTypeLabel;

-(void)bind:(EventModel *)model;
@end

@interface TimeListTableView : UIView
@property(nonatomic,strong)UIImageView * bgView;

@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UILabel * dayLabel;

@property(nonatomic,strong)UILabel * classTypeLabel;
@property(nonatomic,strong)UILabel * remindTypeLabel;

-(void)bind:(EventModel *)model;
@end
