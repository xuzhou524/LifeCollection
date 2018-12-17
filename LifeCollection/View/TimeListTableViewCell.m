//
//  TimeListTableViewCell.m
//  LifeCollection
//
//  Created by gozap on 2018/12/17.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "TimeListTableViewCell.h"

@implementation TimeListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self sebViews];
    }
    return self;
}

-(void)sebViews{
    self.contentView.backgroundColor = [LCColor backgroudColor];
    
    _bgView = [UIView new];
    _bgView.layer.cornerRadius = 8;
    _bgView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(8);
        make.bottom.equalTo(self.contentView).offset(-8);
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
    }];
}

@end
