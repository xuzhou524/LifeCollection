//
//  FoundTableViewCell.h
//  LifeCollection
//
//  Created by gozap on 2018/12/24.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoundListModel.h"

@interface FoundTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView * iconImageView;
@property(nonatomic,strong)UILabel * titleLabel;

-(void)bind:(FoundListModel *)model;

@end

