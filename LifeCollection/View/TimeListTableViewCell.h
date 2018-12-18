//
//  TimeListTableViewCell.h
//  LifeCollection
//
//  Created by gozap on 2018/12/17.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeListTableViewCell : UITableViewCell
@property(nonatomic,strong)UIView * bgView;

@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UILabel * dayLabel;

@property(nonatomic,strong)UILabel * classTypeLabel;
@property(nonatomic,strong)UILabel * remindTypeLabel;
@end
