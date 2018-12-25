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
    
    UIView * bgView = [UIView new];
    bgView.backgroundColor = [LCColor whiteColor];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
    
    _iconImageView = [UIImageView new];
    _iconImageView.image = [UIImage imageNamed:@"logo"];
    _iconImageView.layer.cornerRadius = 3;
    _iconImageView.layer.masksToBounds = YES;
    [bgView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(bgView).offset(20);
        make.right.equalTo(bgView).offset(-20);
        make.height.equalTo(@((ScreenWidth - 20 - 20)  / 1.67));
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"让生活更精彩";
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = LCFont(15);
    _titleLabel.textColor = [LCColor LCColor_77_92_127];
    [bgView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(20);
        make.left.equalTo(self.iconImageView);
        make.right.equalTo(self.iconImageView);
    }];

}

-(void)bind:(FoundListModel *)model{
    self.titleLabel.text = model.title;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
}

@end
