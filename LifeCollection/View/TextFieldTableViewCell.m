//
//  TextFieldTableViewCell.m
//  LifeCollection
//
//  Created by gozap on 2018/12/17.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "TextFieldTableViewCell.h"

@implementation TextFieldTableViewCell

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
    bgView.backgroundColor = [LCColor whiteColor];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    _iconImageView = [UIImageView new];
    _iconImageView.image = [UIImage imageNamed:@"edit_title"];
    [bgView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.centerY.equalTo(bgView);
        make.width.height.equalTo(@20);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"标题";
    _titleLabel.font = LCFont(15);
    _titleLabel.textColor = [LCColor LCColor_77_92_127];
    [bgView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.centerY.equalTo(bgView);
    }];
    
    UIImageView *iconImageView = [UIImageView new];
    UIImage * iconIamge = [[UIImage imageNamed:@"circleright"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    iconImageView.tintColor = [LCColor LCColor_113_120_150];
    iconImageView.image=iconIamge;
    [self.contentView addSubview:iconImageView];
    [iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(bgView);
        make.height.equalTo(@12);
        make.width.equalTo(@8);
    }];
    
    _titleTextField = [UITextField new];
    _titleTextField.placeholder = @"请输入标题";
    _titleTextField.textColor = [LCColor LCColor_113_120_150];
    _titleTextField.font = LCFont(15);
    _titleTextField.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_titleTextField];
    [_titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bgView);
        make.right.equalTo(iconImageView.mas_left).offset(-10);
        make.left.equalTo(self.contentView.mas_centerX).offset(-20);
    }];

}

@end
