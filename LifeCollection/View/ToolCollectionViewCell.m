//
//  ToolCollectionViewCell.m
//  LifeCollection
//
//  Created by gozap on 2019/3/11.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "ToolCollectionViewCell.h"

@implementation ToolCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self sebView];
    
    }
    return self;
}

-(void)sebView{
    _bgImageView = [UIImageView new];
    _bgImageView.layer.cornerRadius = 8;
    _bgImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_bgImageView];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(8);
        make.right.equalTo(self.contentView).offset(-8);
        make.bottom.equalTo(self.contentView).offset(-6);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"指南针";
    _titleLabel.font = LCFont(18);
    _titleLabel.textColor = [LCColor whiteColor];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgImageView);
        make.left.equalTo(self.bgImageView.mas_centerX);
    }];
    
    _iconImageView = [UIImageView new];
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgImageView);
        make.right.equalTo(self.titleLabel.mas_left).offset(-15);
        make.width.height.equalTo(@28);
    }];
}

@end
