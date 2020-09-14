//
//  StickerTableViewCell.m
//  LifeCollectioniMessage MessagesExtension
//
//  Created by gozap on 2019/5/29.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "StickerTableViewCell.h"
#import "DateFormatter.h"

#define LCEventBackgroundImagesArray     @[@"01",@"07",@"02",@"48",@"38",@"28",@"55"]
#define LCEventBackgroundImages(index)   LCEventBackgroundImagesArray[index]

@interface StickerTableViewCell()

@property(nonatomic,strong)UILabel * timeStrLabel;
@property(nonatomic,strong)UILabel * dayStrLabel;

@end


@implementation StickerTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self sebViews];
    }
    return self;
}

-(void)sebViews{
    self.contentView.backgroundColor = [LCColor backgroudColor];
    
    _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 8, [UIScreen mainScreen].bounds.size.width - 24, 120)];
    _bgView.layer.cornerRadius = 8;
    _bgView.layer.masksToBounds = YES;
    _bgView.userInteractionEnabled = YES;
    _bgView.contentMode = UIViewContentModeScaleToFill;
    _bgView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_bgView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 17)];
    _titleLabel.text = @"还房贷⑤";
    _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:(17)];
    _titleLabel.alpha = 0.8;
    _titleLabel.textColor = [UIColor whiteColor];
    [_bgView addSubview:_titleLabel];


    UIView * classbgView = [UIView new];
    classbgView.layer.cornerRadius = 3;
    classbgView.backgroundColor = [UIColor whiteColor];
    classbgView.alpha = 0.5;
    [_bgView addSubview:classbgView];
    _classTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x + 5,
                                                                _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 10,
                                                                24,
                                                                10)];
    _classTypeLabel.text = @"倒计日";
    _classTypeLabel.font = [UIFont fontWithName:@"Helvetica" size:(8)];
    _classTypeLabel.alpha = 0.8;
    _classTypeLabel.textColor = [UIColor whiteColor];
    [_bgView addSubview:_classTypeLabel];
    classbgView.frame = CGRectMake(_classTypeLabel.frame.origin.x - 4,
                                    _classTypeLabel.frame.origin.y - 3,
                                    _classTypeLabel.frame.size.width + 8,
                                    _classTypeLabel.frame.size.height + 6);

    UIView * remindbgView = [UIView new];
    remindbgView.layer.cornerRadius = 3;
    remindbgView.backgroundColor = [UIColor whiteColor];
    remindbgView.alpha = 0.5;
    [_bgView addSubview:remindbgView];
    _remindTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(classbgView.frame.origin.x + classbgView.frame.size.width + 10,
                                                                 _classTypeLabel.frame.origin.y,
                                                                 24,
                                                                 10)];
    _remindTypeLabel.text = @"月循环";
    _remindTypeLabel.font = [UIFont fontWithName:@"Helvetica" size:(8)];
    _remindTypeLabel.alpha = 0.8;
    _remindTypeLabel.textColor = [UIColor whiteColor];
    [_bgView addSubview:_remindTypeLabel];
    remindbgView.frame = CGRectMake(_remindTypeLabel.frame.origin.x - 4,
                                   _remindTypeLabel.frame.origin.y - 3,
                                   _remindTypeLabel.frame.size.width + 8,
                                   _remindTypeLabel.frame.size.height + 6);

    _timeStrLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x,
                                                              _bgView.frame.origin.y + _bgView.frame.size.height - 20 - 20,
                                                              50,
                                                              13)];
    _timeStrLabel.text = @"目标日:";
    _timeStrLabel.alpha = 0.5;
    _timeStrLabel.font = [UIFont fontWithName:@"Helvetica" size:(13)];
    _timeStrLabel.textColor = [UIColor whiteColor];
    [_bgView addSubview:_timeStrLabel];


    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_timeStrLabel.frame.origin.x + _timeStrLabel.frame.size.width,
                                                           _bgView.frame.origin.y + _bgView.frame.size.height - 20 - 20,
                                                           150,
                                                           14)];
    _timeLabel.text = @"2018-12-18";
    _timeLabel.alpha = 0.5;
    _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:(14)];
    _timeLabel.textColor = [UIColor whiteColor];
    [_bgView addSubview:_timeLabel];


    _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(_bgView.frame.origin.x + _bgView.frame.size.width - 80,
                                                          _bgView.frame.origin.y + _bgView.frame.size.height / 2.0 - 10,
                                                          55,
                                                          30)];
    _dayLabel.text = @"626";
    _dayLabel.font = [UIFont fontWithName:@"Helvetica" size:(30)];
    _dayLabel.alpha = 0.8;
    _dayLabel.textColor = [UIColor whiteColor];
    [_bgView addSubview:_dayLabel];


    _dayStrLabel = [[UILabel alloc] initWithFrame:CGRectMake(_dayLabel.frame.origin.x,
                                                             _dayLabel.frame.origin.y - 15,
                                                             40,
                                                             10)];
    _dayStrLabel.text = @"剩余天数";
    _dayStrLabel.alpha = 0.5;
    _dayStrLabel.font = [UIFont fontWithName:@"Helvetica" size:(10)];
    _dayStrLabel.textColor = [UIColor whiteColor];
    [_bgView addSubview:_dayStrLabel];
 
}

-(void)bind:(EventModel *)model{
    if (model.title) {
        if ([model.title isEqualToString:@"咘咕诞生"]) {
            model.title = @"我的时间诞生";
        }
        self.titleLabel.text = model.title;
    }else{
        self.titleLabel.text = @"请输入标题";
    }
    self.classTypeLabel.text = model.classType;
    self.remindTypeLabel.text = model.remindType;
    NSString * imageStr = LCEventBackgroundImages([model.colorType integerValue]);
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

