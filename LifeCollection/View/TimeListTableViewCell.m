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
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"还房贷⑤";
    _titleLabel.font = LCFont(17);
    _titleLabel.alpha = 0.8;
    _titleLabel.textColor = [LCColor whiteColor];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.bgView).offset(20);
    }];
    
    UIView * classbgView = [UIView new];
    classbgView.layer.cornerRadius = 3;
    classbgView.backgroundColor = [LCColor whiteColor];
    classbgView.alpha = 0.5;
    [self.contentView addSubview:classbgView];
    _classTypeLabel = [UILabel new];
    _classTypeLabel.text = @"倒计日";
    _classTypeLabel.font = LCFont(8);
    _classTypeLabel.alpha = 0.8;
    _classTypeLabel.textColor = [LCColor whiteColor];
    [self.contentView addSubview:_classTypeLabel];
    [_classTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel).offset(5);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
    }];
    [classbgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.classTypeLabel).offset(-4);
        make.top.equalTo(self.classTypeLabel).offset(-2);
        make.bottom.equalTo(self.classTypeLabel).offset(2);
        make.right.equalTo(self.classTypeLabel).offset(4);
    }];
    
    UIView * remindbgView = [UIView new];
    remindbgView.layer.cornerRadius = 3;
    remindbgView.backgroundColor = [LCColor whiteColor];
    remindbgView.alpha = 0.5;
    [self.contentView addSubview:remindbgView];
    _remindTypeLabel = [UILabel new];
    _remindTypeLabel.text = @"月循环";
    _remindTypeLabel.font = LCFont(8);
    _remindTypeLabel.alpha = 0.8;
    _remindTypeLabel.textColor = [LCColor whiteColor];
    [self.contentView addSubview:_remindTypeLabel];
    [_remindTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.classTypeLabel.mas_right).offset(15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
    }];
    [remindbgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.remindTypeLabel).offset(-4);
        make.top.equalTo(self.remindTypeLabel).offset(-2);
        make.bottom.equalTo(self.remindTypeLabel).offset(2);
        make.right.equalTo(self.remindTypeLabel).offset(4);
    }];
    
    UILabel * timeStrLabel = [UILabel new];
    timeStrLabel.text = @"目标日:";
    timeStrLabel.alpha = 0.5;
    timeStrLabel.font = LCFont2(13);
    timeStrLabel.textColor = [LCColor whiteColor];
    [self.contentView addSubview:timeStrLabel];
    [timeStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.bgView).offset(-20);
    }];
    
    _timeLabel = [UILabel new];
    _timeLabel.text = @"2018-12-18";
    _timeLabel.alpha = 0.5;
    _timeLabel.font = LCFont2(14);
    _timeLabel.textColor = [LCColor whiteColor];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeStrLabel.mas_right).offset(5);
        make.centerY.equalTo(timeStrLabel);
    }];
    
    _dayLabel = [UILabel new];
    _dayLabel.text = @"365";
    _dayLabel.font = LCFont2(30);
    _dayLabel.alpha = 0.8;
    _dayLabel.textColor = [LCColor whiteColor];
    [self.contentView addSubview:_dayLabel];
    [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-20);
        make.bottom.equalTo(self.bgView).offset(-20);
    }];
    
    UILabel * dayStrLabel = [UILabel new];
    dayStrLabel.text = @"剩余天数";
    dayStrLabel.alpha = 0.5;
    dayStrLabel.font = LCFont2(10);
    dayStrLabel.textColor = [LCColor whiteColor];
    [self.contentView addSubview:dayStrLabel];
    [dayStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.dayLabel);
        make.bottom.equalTo(self.dayLabel.mas_top);
    }];
    
}

-(void)bind:(EventModel *)model{
    self.titleLabel.text = model.title;
    self.classTypeLabel.text = model.classType;
    self.remindTypeLabel.text = model.remindType;
    self.timeLabel.text = [DateFormatter stringFromBirthday:[DateFormatter dateFromTimeStampString:model.time]];
    self.bgView.backgroundColor = LCEventBackgroundColor([model.colorType integerValue]);
}

@end
