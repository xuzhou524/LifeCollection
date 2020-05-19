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
    _iconImageView.image = [UIImage imageNamed:@"logo"];
    _iconImageView.layer.cornerRadius = 10;
    _iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-50);
        make.centerX.equalTo(self.contentView);
        make.width.height.equalTo(@88);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"专注时间管理、记事本日常工具";
    _titleLabel.font = LCFont(14);
    _titleLabel.textColor = [LCColor LCColor_77_92_127];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(15);
        make.centerX.equalTo(self.contentView);
    }];
}

@end

@implementation UserHeadViewTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self sebViews];
    }
    return self;
}

-(void)sebViews{
    self.contentView.backgroundColor = [LCColor backgroudColor];
    
    UIView * oneView = [UIView new];
    oneView.backgroundColor = [LCColor backgroudColor];
    [self.contentView addSubview:oneView];
    [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-15);
        make.right.equalTo(self.contentView.mas_centerX).offset(-0);
    }];
    
    _zanImageView = [UIImageView new];
    _zanImageView.image = [UIImage imageNamed:@"about_praise"];
    _zanImageView.layer.cornerRadius = 20;
    _zanImageView.userInteractionEnabled = YES;
    _zanImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_zanImageView];
    [_zanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(oneView);
        make.top.equalTo(oneView).offset(10);
        make.width.height.equalTo(@40);
    }];
    
    _zanLabel = [UILabel new];
    _zanLabel.text = @"给个赞";
    _zanLabel.font = LCFont(14);
    _zanLabel.textColor = [LCColor LCColor_77_92_127];
    [self.contentView addSubview:_zanLabel];
    [_zanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(oneView);
        make.top.equalTo(self.zanImageView.mas_bottom).offset(5);
    }];
    
    UIView * twoView = [UIView new];
    twoView.backgroundColor = [LCColor backgroudColor];
    [self.contentView addSubview:twoView];
    [twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-15);
        make.left.equalTo(self.contentView.mas_centerX).offset(0);
    }];
    
    _tuImageView = [UIImageView new];
    _tuImageView.image = [UIImage imageNamed:@"about_criticism"];
    _tuImageView.userInteractionEnabled = YES;
    _tuImageView.layer.cornerRadius = 20;
    _tuImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_tuImageView];
    [_tuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(twoView);
        make.top.equalTo(twoView).offset(12);
        make.width.height.equalTo(@40);
    }];
    
    _tuLabel = [UILabel new];
    _tuLabel.text = @"出个槽";
    _tuLabel.font = LCFont(15);
    _tuLabel.textColor = [LCColor LCColor_77_92_127];
    [self.contentView addSubview:_tuLabel];
    [_tuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(twoView);
        make.top.equalTo(self.zanImageView.mas_bottom).offset(8);
    }];
    
}

@end
