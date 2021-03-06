//
//  TitleTableViewCell.m
//  LifeCollection
//
//  Created by gozap on 2021/6/7.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import "TitleTableViewCell.h"

@implementation TitleTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self sebViews];
    }
    return self;
}

-(void)sebViews{
    self.contentView.backgroundColor = [LCColor backgroudColor];
    self.clipsToBounds = YES;
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [LCColor itemBackgroudColor];
    bgView.layer.cornerRadius = 16;
    bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = LCFont(15);
    _titleLabel.textColor = [LCColor LCColor_77_92_127];
    [bgView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(15);
        make.centerY.equalTo(bgView);
    }];
    
    UIImageView *iconImageView = [UIImageView new];
    UIImage * iconIamge = [[UIImage imageNamed:@"circleright"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    iconImageView.tintColor = [LCColor LCColor_77_92_127];
    iconImageView.image=iconIamge;
    [self.contentView addSubview:iconImageView];
    [iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-15);
        make.centerY.equalTo(bgView);
        make.height.equalTo(@12);
        make.width.equalTo(@8);
    }];
    
    _summeryLabel = [UILabel new];
    _summeryLabel.textColor = [LCColor LCColor_113_120_150];
    _summeryLabel.font = LCFont(15);
    [self.contentView addSubview:_summeryLabel];
    [_summeryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(iconImageView.mas_left).offset(-10);
        make.centerY.equalTo(self.titleLabel);
    }];
    
}
@end

@implementation TitleAndImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self sebViews];
    }
    return self;
}

-(void)sebViews{
    self.contentView.backgroundColor = [LCColor backgroudColor];
    
    UIView *bgView = [UIView new];
    bgView.layer.cornerRadius = 16;
    bgView.layer.masksToBounds = YES;
    bgView.backgroundColor = [LCColor itemBackgroudColor];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    _iconImageView = [UIImageView new];
    [bgView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(15);
        make.centerY.equalTo(bgView);
        make.width.height.equalTo(@28);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = LCFont(15);
    _titleLabel.textColor = [LCColor LCColor_77_92_127];
    [bgView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.centerY.equalTo(bgView);
    }];
    
    UIImageView *imageView = [UIImageView new];
    UIImage * iconIamge = [[UIImage imageNamed:@"circleright"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    imageView.tintColor = [LCColor LCColor_77_92_127];
    imageView.image=iconIamge;
    [self.contentView addSubview:imageView];
    [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-15);
        make.centerY.equalTo(bgView);
        make.height.equalTo(@12);
        make.width.equalTo(@8);
    }];
    
    _summeryLabel = [UILabel new];
    _summeryLabel.textColor = [LCColor LCColor_77_92_127];
    _summeryLabel.font = LCFont(15);
    [self.contentView addSubview:_summeryLabel];
    [_summeryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imageView.mas_left).offset(-10);
        make.centerY.equalTo(self.titleLabel);
    }];
    
}
@end


@implementation TitleNoRightImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self sebViews];
    }
    return self;
}

-(void)sebViews{
    self.contentView.backgroundColor = [LCColor backgroudColor];
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [LCColor itemBackgroudColor];
    bgView.layer.cornerRadius = 16;
    bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = LCFont(15);
    _titleLabel.textColor = [LCColor LCColor_77_92_127];
    [bgView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(15);
        make.centerY.equalTo(bgView);
    }];
    
    _summeryLabel = [UILabel new];
    _summeryLabel.textColor = [LCColor LCColor_77_92_127];
    _summeryLabel.font = LCFont(15);
    [self.contentView addSubview:_summeryLabel];
    [_summeryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-15);
        make.centerY.equalTo(self.titleLabel);
    }];
    
}
@end

@implementation TitleSwitchTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self sebViews];
    }
    return self;
}

-(void)sebViews{
    self.contentView.backgroundColor = [LCColor backgroudColor];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = LCFont(15);
    _titleLabel.textColor = [LCColor LCColor_77_92_127];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.centerY.equalTo(self.contentView);
    }];
    
    _sevenSwitch = [UISwitch new];
    // 设置控件开启状态填充色
    _sevenSwitch.onTintColor = [LCColor LCColor_113_120_150];
    // 设置控件关闭状态填充色
    _sevenSwitch.tintColor = [LCColor LCColor_113_120_150];
    // 设置控件开关按钮颜色
    _sevenSwitch.thumbTintColor = [LCColor LCColor_77_92_127];
    [self.contentView addSubview:_sevenSwitch];
    [_sevenSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-16);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];
    
}
@end
