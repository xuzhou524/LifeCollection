//
//  SelectColorTableViewCell.m
//  LifeCollection
//
//  Created by gozap on 2018/12/17.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "SelectColorTableViewCell.h"

@implementation SelectColorTableViewCell

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
    bgView.backgroundColor = [LCColor backgroudColor];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    UIView *selectbgView = [UIView new];
    [self.contentView addSubview:selectbgView];
    [selectbgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(bgView);
        make.right.equalTo(self.contentView).offset(-15);
        make.left.equalTo(self.contentView).offset(15);
    }];
    
    _selectColorArray = [NSMutableArray new];
    
    for (int i = 0; i < LCEventBackgroundImageArray.count; i ++) {
        UIView * colorBgView = [UIView new];
        [selectbgView addSubview:colorBgView];
        [colorBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(selectbgView).offset(((ScreenWidth - 30) * 1.00 / LCEventBackgroundImageArray.count) * i);
            make.centerY.equalTo(selectbgView);
            make.height.equalTo(@60);
            make.width.equalTo(@((ScreenWidth - 30) * 1.00 / LCEventBackgroundImageArray.count));
        }];
        
        UIImageView * colorView = [UIImageView new];
        colorView.layer.cornerRadius = 15;
        colorView.layer.masksToBounds = YES;
        colorView.userInteractionEnabled = YES;
        NSString * imageStr = LCEventBackgroundImage(i);
        colorView.image = [UIImage imageNamed:imageStr];
        [colorBgView addSubview:colorView];
        [colorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(colorBgView);
            make.width.height.equalTo(@30);
        }];
        
        [_selectColorArray addObject:colorBgView];
    }
    
}
@end
