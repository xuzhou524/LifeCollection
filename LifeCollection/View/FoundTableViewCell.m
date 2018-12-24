//
//  FoundTableViewCell.m
//  LifeCollection
//
//  Created by gozap on 2018/12/24.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "FoundTableViewCell.h"

@implementation FoundTableViewCell

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
    _iconImageView.layer.cornerRadius = 3;
    _iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
        make.right.equalTo(self.contentView).offset(-15);
        make.width.equalTo(@175);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"让生活更精彩";
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.numberOfLines = 3;
    _titleLabel.font = LCFont(15);
    _titleLabel.textColor = [LCColor LCColor_77_92_127];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView).offset(5);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.iconImageView.mas_left).offset(-20);
    }];
    
    _typeLabel = [UILabel new];
    _typeLabel.text = @"公司";
    _typeLabel.font = LCFont2(13);
    _typeLabel.textColor = [LCColor LCColor_113_120_150];
    [self.contentView addSubview:_typeLabel];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconImageView);
        make.left.equalTo(self.titleLabel);
    }];
    
    _timeLabel = [UILabel new];
    _timeLabel.text = @"12月21日";
    _timeLabel.font = LCFont2(13);
    _timeLabel.textColor = [LCColor LCColor_113_120_150];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel);
        make.left.equalTo(self.typeLabel.mas_right).offset(15);
    }];
    
    UIImageView * sepImageView = [UIImageView new];
    sepImageView.backgroundColor = [LCColor LCColor_232_229_222];
    [self.contentView addSubview:sepImageView];
    [sepImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.iconImageView);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(@0.6);
    }];
}

-(void)bind:(FoundListModel *)model{
    self.titleLabel.text = model.title;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
}

@end
