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
    _dayLabel.font = LCFont2(40);
    _dayLabel.textColor = [LCColor blackColor];
    [self.contentView addSubview:_dayLabel];
    [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(20);
        make.top.equalTo(self.bgView).offset(15);
    }];
    
    _weekLabel = [UILabel new];
    _weekLabel.text = @"星期日";
    _weekLabel.font = LCFont2(12);
    _weekLabel.textColor = [LCColor LCColor_110_110_110];
    [self.contentView addSubview:_weekLabel];
    [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dayLabel.mas_right).offset(15);
        make.bottom.equalTo(self.dayLabel.mas_centerY).offset(-2);
    }];
    
    _timeLabel = [UILabel new];
    _timeLabel.text = @"2019年04月";
    _timeLabel.font = LCFont2(12);
    _timeLabel.textColor = [LCColor LCColor_110_110_110];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dayLabel.mas_right).offset(15);
        make.top.equalTo(self.dayLabel.mas_centerY).offset(2);
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
        make.width.height.equalTo(@30);
    }];
    
    _coverImageView = [UIImageView new];
    _coverImageView.layer.cornerRadius = 5;
    _coverImageView.layer.masksToBounds = YES;
    _coverImageView.userInteractionEnabled = YES;
    _coverImageView.contentMode = UIViewContentModeScaleToFill;
    _coverImageView.backgroundColor = [LCColor orangeColor];
    [self.contentView addSubview:_coverImageView];
    [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dayLabel.mas_bottom).offset(15);
        make.left.equalTo(self.dayLabel);
        make.width.height.equalTo(@68);
    }];
    
    _contentLabel = [UILabel new];
    _contentLabel.text = @"生命周期感知，消息随时订阅，自动取消订阅，生命周期感知，消息随时订阅，自动取消订阅生命周期感知，消息随时订阅，自动取消订阅，生命周期感知，消息随时订阅，自动取消订阅生自动取消订阅生";
    _contentLabel.font = LCFont2(13);
    _contentLabel.numberOfLines = 4;
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

    self.contentLabel.text = model.content;
    
}

@end


@implementation AddNoteTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self sebViews];
    }
    return self;
}

-(void)sebViews{
    self.contentView.backgroundColor = [LCColor backgroudColor];

    _contentTextView = [UITextView new];
    _contentTextView.text = @"写下你的描述";
    _contentTextView.font = LCFont2(15);
    _contentTextView.textColor = [LCColor LCColor_110_110_110];
    _contentTextView.backgroundColor = [LCColor whiteColor];
    [self.contentView addSubview:_contentTextView];
    [_contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.top.equalTo(self.contentView).offset(20);
        make.height.equalTo(@120);
    }];
    
    _coverImageView = [UIImageView new];
    _coverImageView.layer.cornerRadius = 5;
    _coverImageView.layer.masksToBounds = YES;
    _coverImageView.userInteractionEnabled = YES;
    _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    _coverImageView.backgroundColor = [LCColor orangeColor];
    [self.contentView addSubview:_coverImageView];
    [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTextView.mas_bottom).offset(20);
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.equalTo(@120);
    }];
    
    UILabel * label = [UILabel new];
    label.text = @"封面图";
    label.font = LCFont2(16);
    label.textColor = [LCColor whiteColor];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView).offset(20);
        make.centerY.equalTo(self.coverImageView);
    }];
    
}

@end

