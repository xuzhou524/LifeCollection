//
//  UserViewTableViewCell.h
//  LifeCollection
//
//  Created by gozap on 2018/12/21.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UserViewTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView * iconImageView;
@property(nonatomic,strong)UILabel * titleLabel;

@end


@interface UserHeadViewTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView * zanImageView;
@property(nonatomic,strong)UILabel * zanLabel;

@property(nonatomic,strong)UIImageView * tuImageView;
@property(nonatomic,strong)UILabel * tuLabel;

@end

