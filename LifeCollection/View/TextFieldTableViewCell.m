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
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"标题";
    _titleLabel.font = LCFont(15);
    [bgView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(bgView);
    }];

}

@end
