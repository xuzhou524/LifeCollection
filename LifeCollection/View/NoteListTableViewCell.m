//
//  NoteListTableViewCell.m
//  LifeCollection
//
//  Created by gozap on 2019/4/9.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "NoteListTableViewCell.h"

@interface NoteListTableViewCell()

@end

@implementation NoteListTableViewCell

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
    _bgView.backgroundColor = [LCColor whiteColor];
    [self.contentView addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(8);
        make.bottom.equalTo(self.contentView).offset(-8);
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
    }];
    
    _dayLabel = [UILabel new];
    _dayLabel.text = @"28";
    _dayLabel.font = LCFont2(45);
    _dayLabel.textColor = [LCColor blackColor];
    [self.contentView addSubview:_dayLabel];
    [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(20);
        make.top.equalTo(self.bgView).offset(10);
    }];
    
    _weekLabel = [UILabel new];
    _weekLabel.text = @"星期日";
    _weekLabel.font = LCFont2(13);
    _weekLabel.textColor = [LCColor LCColor_110_110_110];
    [self.contentView addSubview:_weekLabel];
    [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dayLabel.mas_right).offset(15);
        make.bottom.equalTo(self.dayLabel.mas_centerY).offset(-3);
    }];
    
    _timeLabel = [UILabel new];
    _timeLabel.text = @"2019年04月";
    _timeLabel.font = LCFont2(13);
    _timeLabel.textColor = [LCColor LCColor_110_110_110];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dayLabel.mas_right).offset(15);
        make.top.equalTo(self.dayLabel.mas_centerY).offset(3);
    }];
    
    _weatherImageView = [UIImageView new];
    _weatherImageView.layer.cornerRadius = 5;
    _weatherImageView.layer.masksToBounds = YES;
    _weatherImageView.userInteractionEnabled = YES;
    _weatherImageView.backgroundColor = [LCColor greenColor];
    [self.contentView addSubview:_weatherImageView];
    [_weatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dayLabel);
        make.right.equalTo(self.bgView).offset(-20);
        make.width.height.equalTo(@35);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"请输入标题";
    _titleLabel.font = LCFont2(16);
    _titleLabel.alpha = 0.8;
    _titleLabel.textColor = [LCColor LCColor_77_92_127];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(20);
        make.top.equalTo(self.dayLabel.mas_bottom).offset(5);
    }];

    _coverImageView = [UIImageView new];
    _coverImageView.layer.cornerRadius = 5;
    _coverImageView.layer.masksToBounds = YES;
    _coverImageView.userInteractionEnabled = YES;
    _coverImageView.contentMode = UIViewContentModeScaleToFill;
    _coverImageView.backgroundColor = [LCColor orangeColor];
    [self.contentView addSubview:_coverImageView];
    [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.left.equalTo(self.titleLabel);
        make.width.height.equalTo(@88);
    }];
    
    _contentLabel = [UILabel new];
    _contentLabel.text = @"生命周期感知，消息随时订阅，自动取消订阅，生命周期感知，消息随时订阅，自动取消订阅生命周期感知，消息随时订阅，自动取消订阅，生命周期感知，消息随时订阅，自动取消订阅生自动取消订阅生";
    _contentLabel.font = LCFont2(14);
    _contentLabel.numberOfLines = 5;
    _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _contentLabel.textColor = [LCColor LCColor_110_110_110];
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(20);
        make.right.equalTo(self.bgView).offset(-20);
        make.centerY.equalTo(self.coverImageView);
    }];
}

-(void)bind:(NoteModel *)model{
    
    self.titleLabel.text = model.title;
    
    self.contentLabel.text = model.content;
    
}

@end

