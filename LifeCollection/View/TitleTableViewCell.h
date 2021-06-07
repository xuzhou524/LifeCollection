//
//  TitleTableViewCell.h
//  LifeCollection
//
//  Created by gozap on 2021/6/7.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * summeryLabel;
@end

@interface TitleAndImageTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * iconImageView;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * summeryLabel;
@end


@interface TitleNoRightImageTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * summeryLabel;
@end

@interface TitleSwitchTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UISwitch * sevenSwitch;
@end

