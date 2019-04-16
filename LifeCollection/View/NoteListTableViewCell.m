//
//  NoteListTableViewCell.m
//  LifeCollection
//
//  Created by gozap on 2019/4/9.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "NoteListTableViewCell.h"
#import "WeatherManager.h"

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
    _dayLabel.text = [DateFormatter stringFromStringDay:[NSDate new]];
    _dayLabel.font = LCFont2(40);
    _dayLabel.textColor = [LCColor blackColor];
    [self.contentView addSubview:_dayLabel];
    [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(20);
        make.top.equalTo(self.bgView).offset(15);
    }];
    
    _weekLabel = [UILabel new];
    _weekLabel.text = [DateFormatter weekdayStringWithDate:[NSDate new]];
    _weekLabel.font = LCFont2(12);
    _weekLabel.textColor = [LCColor LCColor_110_110_110];
    [self.contentView addSubview:_weekLabel];
    [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dayLabel.mas_right).offset(15);
        make.bottom.equalTo(self.dayLabel.mas_centerY).offset(-2);
    }];
    
    _timeLabel = [UILabel new];
    _timeLabel.text = [DateFormatter stringFromStringYeayWeek:[NSDate new]];
    _timeLabel.font = LCFont2(12);
    _timeLabel.textColor = [LCColor LCColor_110_110_110];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dayLabel.mas_right).offset(15);
        make.top.equalTo(self.dayLabel.mas_centerY).offset(2);
    }];
    
    _weatherImageView = [UIImageView new];
    _weatherImageView.userInteractionEnabled = YES;
    _weatherImageView.image = [UIImage imageNamed:[WeatherManager sharedInstance].weatherIconIndex];
    [self.contentView addSubview:_weatherImageView];
    [_weatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dayLabel);
        make.right.equalTo(self.bgView).offset(-20);
        make.width.height.equalTo(@38);
    }];
    
    _coverImageView = [UIImageView new];
    _coverImageView.layer.cornerRadius = 5;
    _coverImageView.layer.masksToBounds = YES;
    _coverImageView.userInteractionEnabled = YES;
    _coverImageView.contentMode = UIViewContentModeScaleToFill;
    _coverImageView.image = [UIImage imageNamed:@"ico_fabu_tianjia"];
    [self.contentView addSubview:_coverImageView];
    [_coverImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dayLabel.mas_bottom).offset(15);
        make.left.equalTo(self.dayLabel);
        make.width.height.equalTo(@68);
    }];
    
    _contentLabel = [UILabel new];
    _contentLabel.text = @"拾掇生活中的点滴，记录时光的故事";
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
    
    NSDate * date = [NSDate new];
    if (model && model.time && model.time.length > 0) {
        date = [DateFormatter dateFromString:model.time];
    }
    self.dayLabel.text = [DateFormatter stringFromStringDay:date];
    self.weekLabel.text = [DateFormatter weekdayStringWithDate:date];
    self.timeLabel.text = [DateFormatter stringFromStringYeayWeek:date];
    
    if (model.weather) {
        self.weatherImageView.image = [UIImage imageNamed:model.weather];
    }else{
        self.weatherImageView.image = [UIImage imageNamed:[WeatherManager sharedInstance].weatherIconIndex];
    }
    
    if (model && model.content && model.content.length > 0) {
        self.contentLabel.text = model.content;
    }else{
        self.contentLabel.text = @"拾掇生活中的点滴，记录时光的故事";
    }
    if (model.coverImageData && model.coverImageData.length > 0) {
        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:model.coverImageData options:0];
        UIImage * image = [UIImage imageWithData:imageData];
        self.coverImageView.image = image;
        [_coverImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dayLabel.mas_bottom).offset(15);
            make.left.equalTo(self.dayLabel);
            make.width.height.equalTo(@68);
        }];
    }else{
        self.coverImageView.image = nil;
        [_coverImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dayLabel.mas_bottom).offset(15);
            make.left.equalTo(self.dayLabel).offset(-20);
            make.height.equalTo(@68);
            make.width.equalTo(@0);
        }];
    }
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
    _coverImageView.image = [UIImage imageNamed:@"ico_fabu_tianjia"];
    [self.contentView addSubview:_coverImageView];
    [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTextView.mas_bottom).offset(20);
        make.left.equalTo(self.contentView).offset(20);
        make.width.height.equalTo(@68);
    }];
    
//    UILabel * label = [UILabel new];
//    label.text = @"封面图";
//    label.font = LCFont2(16);
//    label.textColor = [LCColor whiteColor];
//    [self.contentView addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.coverImageView).offset(20);
//        make.centerY.equalTo(self.coverImageView);
//    }];
    
}

@end

