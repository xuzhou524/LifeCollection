//
//  AccountAndPasswordTableViewCell.m
//  LifeCollection
//
//  Created by gozap on 2019/4/30.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "AccountAndPasswordTableViewCell.h"

@implementation AccountAndPasswordTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self sebViews];
    }
    return self;
}

-(void)sebViews{
    self.contentView.backgroundColor = [LCColor backgroudColor];
    
    _bgView = [UIImageView new];
    _bgView.layer.cornerRadius = 8;
    _bgView.layer.masksToBounds = YES;
    _bgView.userInteractionEnabled = YES;
    _bgView.image = [UIImage imageNamed:@"AccountAndPassword_bg"];
    _bgView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(8);
        make.bottom.equalTo(self.contentView).offset(-8);
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"账号密码本";
    _titleLabel.font = LCFont(16);
    _titleLabel.alpha = 0.8;
    _titleLabel.textColor = [LCColor whiteColor];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(20);
         make.centerY.equalTo(self.bgView);
    }];
}
@end
