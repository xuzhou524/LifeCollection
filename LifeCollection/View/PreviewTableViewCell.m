//
//  PreviewTableViewCell.m
//  LifeCollection
//
//  Created by gozap on 2021/6/7.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import "PreviewTableViewCell.h"

@implementation PreviewTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self sebViews];
    }
    return self;
}

-(void)sebViews{
    self.contentView.backgroundColor = [LCColor backgroudColor];
    
    UILabel * label = [UILabel new];
    label.text = @"效果预览";
    label.font = LCFont2(14);
    label.textColor = [LCColor LCColor_77_92_127];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16);
        make.left.equalTo(self.contentView).offset(16);
    }];
}

@end
