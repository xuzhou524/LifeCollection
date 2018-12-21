//
//  UserViewTableViewCell.m
//  LifeCollection
//
//  Created by gozap on 2018/12/21.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "UserViewTableViewCell.h"

@implementation UserViewTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self sebViews];
    }
    return self;
}

-(void)sebViews{
    self.contentView.backgroundColor = [LCColor backgroudColor];
    
    _iconImageView = [UIImageView new];
    _iconImageView.backgroundColor = [LCColor orangeColor];
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30);
        make.centerX.equalTo(self.contentView);
        make.width.height.equalTo(@100);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"标题8888888";
    _titleLabel.font = LCFont(15);
    _titleLabel.textColor = [LCColor LCColor_77_92_127];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(15);
        make.centerX.equalTo(self.contentView);
    }];

}

@end
