//
//  TimeListTableViewCell.m
//  LifeCollection
//
//  Created by gozap on 2018/12/17.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "TimeListTableViewCell.h"

@interface TimeListTableViewCell()

@property(nonatomic,strong)UILabel * timeStrLabel;
@property(nonatomic,strong)UILabel * dayStrLabel;

@end


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
    
    _bgView = [UIImageView new];
    _bgView.layer.cornerRadius = 8;
    _bgView.layer.masksToBounds = YES;
    _bgView.userInteractionEnabled = YES;
    _bgView.contentMode = UIViewContentModeScaleToFill;
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
    
    _timeStrLabel = [UILabel new];
    _timeStrLabel.text = @"目标日:";
    _timeStrLabel.alpha = 0.5;
    _timeStrLabel.font = LCFont2(13);
    _timeStrLabel.textColor = [LCColor whiteColor];
    [self.contentView addSubview:_timeStrLabel];
    [_timeStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.left.equalTo(self.timeStrLabel.mas_right).offset(5);
        make.centerY.equalTo(self.timeStrLabel);
    }];
    
    _dayLabel = [UILabel new];
    _dayLabel.text = @"626";
    _dayLabel.font = LCFont2(30);
    _dayLabel.alpha = 0.8;
    _dayLabel.textColor = [LCColor whiteColor];
    [self.contentView addSubview:_dayLabel];
    [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-20);
        make.bottom.equalTo(self.bgView).offset(-20);
    }];
    
    _dayStrLabel = [UILabel new];
    _dayStrLabel.text = @"剩余天数";
    _dayStrLabel.alpha = 0.5;
    _dayStrLabel.font = LCFont2(10);
    _dayStrLabel.textColor = [LCColor whiteColor];
    [self.contentView addSubview:_dayStrLabel];
    [_dayStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.dayLabel);
        make.bottom.equalTo(self.dayLabel.mas_top);
    }];
}

-(void)bind:(EventModel *)model{
    if (model.title) {
        if ([model.title isEqualToString:@"咘咕诞生"]) {
            model.title = @"记点诞生";
        }
        self.titleLabel.text = model.title;
    }else{
        self.titleLabel.text = @"请输入标题";
    }
    self.classTypeLabel.text = model.classType;
    self.remindTypeLabel.text = model.remindType;
    NSString * imageStr = LCEventBackgroundImage([model.colorType integerValue]);
    self.bgView.image = [UIImage imageNamed:imageStr];
    
    NSString * targetDateStr = [DateFormatter stringFromBirthday:[DateFormatter dateFromTimeStampString:model.time]];
    if ([model.classType isEqualToString:@"倒计日"]) {
        _timeStrLabel.text = @"目标日:";
        _dayStrLabel.text = @"剩余天数";
        NSTimeInterval  timeInterval = [[DateFormatter dateFromTimeStampString:model.time] timeIntervalSinceNow];
        if (timeInterval < 0) {
            NSCalendar *gregorian = [[ NSCalendar alloc ] initWithCalendarIdentifier : NSCalendarIdentifierGregorian];
            unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
            //格式化时间
            NSDate *createDate = [DateFormatter dateFromTimeStampString:model.time];
            NSDateComponents* components = [gregorian components:unitFlags fromDate:createDate];
            [components setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
            //格式化现在时间
            NSDateComponents* newDateComponent = [gregorian components:unitFlags fromDate:[NSDate date]];
            [newDateComponent setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
            
            if ([model.remindType isEqualToString:@"无循环"]){
                self.dayLabel.text = @"0";
            }else{
                if ([model.remindType isEqualToString:@"月循环"]) {
                    if (components.day <= newDateComponent.day) {
                        targetDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",newDateComponent.year,newDateComponent.month + 1,components.day];
                        if (newDateComponent.month == 12) {//当前月为12  显示下一年的01月
                            targetDateStr = [NSString stringWithFormat:@"%ld-%@-%ld",newDateComponent.year + 1,@"01",components.day];
                        }else{
                            targetDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",newDateComponent.year,newDateComponent.month + 1,components.day];
                            if (newDateComponent.month == 1 && (components.day == 29 || components.day == 30 || components.day == 31)) {
                                //当前月为01月  下月是2月   假如日为29、30、31 统一显示 28
                                targetDateStr = [NSString stringWithFormat:@"%ld-%ld-%@",newDateComponent.year,newDateComponent.month + 1,@"28"];
                            }else if (components.day == 31 && (newDateComponent.month + 1 == 4 || newDateComponent.month + 1 == 6 || newDateComponent.month + 1 == 9 || newDateComponent.month + 1 == 11)){
                                //目标日期为四月，六月，九月，十一月  假如日是31  统一显示 30
                                targetDateStr = [NSString stringWithFormat:@"%ld-%ld-%@",newDateComponent.year,newDateComponent.month + 1,@"30"];
                            }
                        }
                    }else{
                        targetDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",newDateComponent.year,newDateComponent.month,components.day];
                    }
                }else if ([model.remindType isEqualToString:@"年循环"]){
                    if (components.day <= newDateComponent.day) {
                        targetDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",newDateComponent.year + 1,components.month,components.day];
                    }else{
                        targetDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",newDateComponent.year,components.month,components.day];
                    }
                }
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateStyle:NSDateFormatterMediumStyle];
                [formatter setTimeStyle:NSDateFormatterShortStyle];
                [formatter setDateFormat:@"YYYY-MM-dd"];
                NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
                [formatter setTimeZone:timeZone];
                
                NSDate* date = [formatter dateFromString:targetDateStr];
                
                NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
                NSTimeInterval  timeInterval = [[DateFormatter dateFromTimeStampString:timeSp] timeIntervalSinceNow] + 24 * 60 * 60;
                long temp = 0;
                NSString *result;
                temp = fabs(timeInterval)/60;
                if((temp = temp/60) <24){
                    result= [NSString stringWithFormat:@"0"];
                }else if((temp = temp/24) <10000){
                    result = [NSString stringWithFormat:@"%ld",temp];
                }
                self.dayLabel.text = result;
            }
        }else{
            timeInterval = timeInterval + 24 * 60 * 60;
            long temp = 0;
            NSString *result;
            temp = fabs(timeInterval)/60;
            if((temp = temp/60) <24){
                result= [NSString stringWithFormat:@"0"];
            }else if((temp = temp/24) <10000){
                result = [NSString stringWithFormat:@"%ld",temp];
            }
            self.dayLabel.text = result;
        }
    }else if ([model.classType isEqualToString:@"累计日"]){
        _timeStrLabel.text = @"起始日:";
        _dayStrLabel.text = @"已过天数";
        
        NSTimeInterval  timeInterval = [[DateFormatter dateFromTimeStampString:model.time] timeIntervalSinceNow];
        if (timeInterval < 0) {
            long temp = 0;
            NSString *result;
            temp = fabs(timeInterval)/60;
            if((temp = temp/60) <24){
                result= [NSString stringWithFormat:@"0"];
            }else if((temp = temp/24) <10000){
                result = [NSString stringWithFormat:@"%ld",temp];
            }
            self.dayLabel.text = result;
        }else{
            self.dayLabel.text = @"0";
        }
    }
    self.timeLabel.text = targetDateStr;
}

@end
