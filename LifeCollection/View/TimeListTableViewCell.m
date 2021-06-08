//
//  TimeListTableViewCell.m
//  LifeCollection
//
//  Created by gozap on 2021/6/7.
//  Copyright © 2021 com.xuzhou. All rights reserved.
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
    self.clipsToBounds = YES;
    
    _bgView = [UIImageView new];
    _bgView.layer.cornerRadius = 16;
    _bgView.layer.masksToBounds = YES;
    _bgView.userInteractionEnabled = YES;
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    _typeImageView = [UIImageView new];
    _typeImageView.layer.cornerRadius = 16;
    _typeImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_typeImageView];
    [_typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.bgView);
        make.width.equalTo(@50);
    }];

    _tagLabel = [UILabel new];
    _tagLabel.font = LCFont(15);
    _tagLabel.alpha = 0.8;
    _tagLabel.textColor = [LCColor whiteColor];
    [self.contentView addSubview:_tagLabel];
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.typeImageView);
    }];
    
    _classTypeView = [UIView new];
    _classTypeView.layer.cornerRadius = 16;
    _classTypeView.layer.masksToBounds = YES;
    _classTypeView.backgroundColor = [UIColor orangeColor];
    [self.bgView addSubview:_classTypeView];
    [_classTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView.mas_right);
        make.centerY.equalTo(self.bgView.mas_top);
        make.width.equalTo(@30);
        make.height.equalTo(@40);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"还房贷⑤";
    _titleLabel.font = LCFont(17);
    _titleLabel.alpha = 0.8;
    _titleLabel.textColor = [LCColor LCColor_77_92_127];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(20);
        make.left.equalTo(self.typeImageView.mas_right).offset(15);
    }];
    
//    UIView * classbgView = [UIView new];
//    classbgView.layer.cornerRadius = 3;
//    classbgView.backgroundColor = [LCColor LCColor_77_92_127];
//    classbgView.alpha = 0.5;
//    [self.contentView addSubview:classbgView];
//    _classTypeLabel = [UILabel new];
//    _classTypeLabel.text = @"倒计日";
//    _classTypeLabel.font = LCFont(8);
//    _classTypeLabel.alpha = 0.8;
//    _classTypeLabel.textColor = [LCColor whiteColor];
//    [self.contentView addSubview:_classTypeLabel];
//    [_classTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.titleLabel).offset(5);
//        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
//    }];
//    [classbgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.classTypeLabel).offset(-4);
//        make.top.equalTo(self.classTypeLabel).offset(-2);
//        make.bottom.equalTo(self.classTypeLabel).offset(2);
//        make.right.equalTo(self.classTypeLabel).offset(4);
//    }];
    
//    UIView * remindbgView = [UIView new];
//    remindbgView.layer.cornerRadius = 3;
//    remindbgView.backgroundColor = [LCColor LCColor_77_92_127];
//    remindbgView.alpha = 0.5;
//    [self.contentView addSubview:remindbgView];
//    _remindTypeLabel = [UILabel new];
//    _remindTypeLabel.text = @"月循环";
//    _remindTypeLabel.font = LCFont(8);
//    _remindTypeLabel.alpha = 0.8;
//    _remindTypeLabel.textColor = [LCColor whiteColor];
//    [self.contentView addSubview:_remindTypeLabel];
//    [_remindTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.classTypeLabel.mas_right).offset(15);
//        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
//    }];
//    [remindbgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.remindTypeLabel).offset(-4);
//        make.top.equalTo(self.remindTypeLabel).offset(-2);
//        make.bottom.equalTo(self.remindTypeLabel).offset(2);
//        make.right.equalTo(self.remindTypeLabel).offset(4);
//    }];
    
    _timeStrLabel = [UILabel new];
    _timeStrLabel.text = @"目标日:";
    _timeStrLabel.alpha = 0.5;
    _timeStrLabel.font = LCFont2(13);
    _timeStrLabel.textColor = [LCColor LCColor_77_92_127];
    [self.contentView addSubview:_timeStrLabel];
    [_timeStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.bgView).offset(-20);
    }];
    
    _timeLabel = [UILabel new];
    _timeLabel.text = @"2018-12-18";
    _timeLabel.alpha = 0.5;
    _timeLabel.font = LCFont2(14);
    _timeLabel.textColor = [LCColor LCColor_77_92_127];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeStrLabel.mas_right).offset(5);
        make.centerY.equalTo(self.timeStrLabel);
    }];
    
    UILabel * dayLabel = [UILabel new];
    dayLabel.text = @"天";
    dayLabel.alpha = 0.5;
    dayLabel.font = LCFont2(12);
    dayLabel.textColor = [LCColor LCColor_77_92_127];
    [self.contentView addSubview:dayLabel];
    [dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-20);
        make.bottom.equalTo(self.bgView).offset(-60);
    }];
    
    _dayLabel = [UILabel new];
    _dayLabel.text = @"626";
    _dayLabel.font = LCFont(30);
    _dayLabel.alpha = 0.8;
    _dayLabel.textColor = [LCColor LCColor_77_92_127];
    [self.contentView addSubview:_dayLabel];
    [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(dayLabel.mas_left).offset(-5);
        make.bottom.equalTo(self.bgView).offset(-55);
    }];
    
    _dayStrLabel = [UILabel new];
    _dayStrLabel.text = @"剩余";
    _dayStrLabel.alpha = 0.5;
    _dayStrLabel.font = LCFont2(12);
    _dayStrLabel.textColor = [LCColor LCColor_77_92_127];
    [self.contentView addSubview:_dayStrLabel];
    [_dayStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.dayLabel.mas_left).offset(-5);
        make.bottom.equalTo(self.dayLabel).offset(-5);
    }];
    
    UIView * editorView = [UIView new];
    editorView.layer.cornerRadius = 16;
    editorView.layer.masksToBounds = YES;
    editorView.backgroundColor = [LCColor backgroudColor];
    [self.bgView addSubview:editorView];
    [editorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView.mas_right);
        make.centerY.equalTo(self.bgView.mas_bottom);
        make.width.equalTo(@160);
        make.height.equalTo(@80);
    }];
    
    _shareImageView = [UIImageView new];
    _shareImageView.layer.cornerRadius = 16;
    _shareImageView.layer.masksToBounds = YES;
    _shareImageView.userInteractionEnabled = YES;
    _shareImageView.image = [UIImage imageNamed:@"ic_share"];
    [self.contentView addSubview:_shareImageView];
    [_shareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right);
        make.bottom.equalTo(self.bgView);
        make.width.equalTo(@32);
        make.height.equalTo(@32);
    }];
    
    UIImageView * editorImageView = [UIImageView new];
    editorImageView.layer.cornerRadius = 16;
    editorImageView.layer.masksToBounds = YES;
    editorImageView.image = [UIImage imageNamed:@"ic_editor"];
    [self.contentView addSubview:editorImageView];
    [editorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shareImageView.mas_left).offset(-5);
        make.bottom.equalTo(self.bgView);
        make.width.equalTo(@32);
        make.height.equalTo(@32);
    }];
}

-(void)bind:(EventModel *)model{
    if (model.title) {
        self.titleLabel.text = model.title;
    }else{
        self.titleLabel.text = @"请输入标题";
    }
    
    if ([model.classType isEqualToString:@"倒计日"]) {
        _classTypeView.backgroundColor = [LCColor LCColor_121_117_245];
    }else if ([model.classType isEqualToString:@"累计日"]) {
        _classTypeView.backgroundColor = [LCColor LCColor_255_221_124];
    }else{
        _classTypeView.backgroundColor = [LCColor whiteColor];
    }
    self.tagLabel.text = model.tag;
    
//    self.classTypeLabel.text = model.classType;
//    self.remindTypeLabel.text = model.remindType;
    
    NSString * imageStr = LCEventBackgroundImage([model.colorType integerValue]);
    self.typeImageView.image = [UIImage imageNamed:imageStr];
    
    NSString * targetDateStr = [DateFormatter stringFromBirthday:[DateFormatter dateFromTimeStampString:model.time]];
    if ([model.classType isEqualToString:@"倒计日"]) {
        _timeStrLabel.text = @"目标日:";
        _dayStrLabel.text = @"剩余";
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
                            if (newDateComponent.month == 1 && (components.day == 29 || components.day == 30 || components.day == 31)) {
                                //当前月为01月  下月是2月   假如日为29、30、31 统一显示 28
                                targetDateStr = [NSString stringWithFormat:@"%ld-%@-%@",newDateComponent.year,@"02",@"28"];
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
        _dayStrLabel.text = @"已过";
        
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
    if (targetDateStr) {
        NSArray * arr = [targetDateStr componentsSeparatedByString:@"-"];
        if (arr.count > 2) {
            NSString * str = arr[1];
            if (str.length == 1) {
                targetDateStr = [NSString stringWithFormat:@"%@-0%@-%@",arr.firstObject,arr[1],arr.lastObject];
            }
        }
    }
    self.timeLabel.text = targetDateStr;
}

@end


@interface TimeListTableView()
@property(nonatomic,strong)UILabel * timeStrLabel;
@property(nonatomic,strong)UILabel * dayStrLabel;
@end

@implementation TimeListTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self sebViews];
    }
    return self;
}

-(void)sebViews{
    self.backgroundColor = [LCColor backgroudColor];
    
    _bgView = [UIImageView new];
    _bgView.layer.cornerRadius = 8;
    _bgView.layer.masksToBounds = YES;
    _bgView.userInteractionEnabled = YES;
    _bgView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.equalTo(self);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"还房贷⑤";
    _titleLabel.font = LCFont(17);
    _titleLabel.alpha = 0.8;
    _titleLabel.textColor = [LCColor whiteColor];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.bgView).offset(30);
    }];
    
//    UIView * classbgView = [UIView new];
//    classbgView.layer.cornerRadius = 3;
//    classbgView.backgroundColor = [LCColor whiteColor];
//    classbgView.alpha = 0.5;
//    [self addSubview:classbgView];
//    _classTypeLabel = [UILabel new];
//    _classTypeLabel.text = @"倒计日";
//    _classTypeLabel.font = LCFont(8);
//    _classTypeLabel.alpha = 0.8;
//    _classTypeLabel.textColor = [LCColor whiteColor];
//    [self addSubview:_classTypeLabel];
//    [_classTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.titleLabel).offset(5);
//        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
//    }];
//    [classbgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.classTypeLabel).offset(-4);
//        make.top.equalTo(self.classTypeLabel).offset(-2);
//        make.bottom.equalTo(self.classTypeLabel).offset(2);
//        make.right.equalTo(self.classTypeLabel).offset(4);
//    }];
    
//    UIView * remindbgView = [UIView new];
//    remindbgView.layer.cornerRadius = 3;
//    remindbgView.backgroundColor = [LCColor whiteColor];
//    remindbgView.alpha = 0.5;
//    [self addSubview:remindbgView];
//    _remindTypeLabel = [UILabel new];
//    _remindTypeLabel.text = @"月循环";
//    _remindTypeLabel.font = LCFont(8);
//    _remindTypeLabel.alpha = 0.8;
//    _remindTypeLabel.textColor = [LCColor whiteColor];
//    [self addSubview:_remindTypeLabel];
//    [_remindTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.classTypeLabel.mas_right).offset(15);
//        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
//    }];
//    [remindbgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.remindTypeLabel).offset(-4);
//        make.top.equalTo(self.remindTypeLabel).offset(-2);
//        make.bottom.equalTo(self.remindTypeLabel).offset(2);
//        make.right.equalTo(self.remindTypeLabel).offset(4);
//    }];
    
    _timeStrLabel = [UILabel new];
    _timeStrLabel.text = @"目标日:";
    _timeStrLabel.alpha = 0.5;
    _timeStrLabel.font = LCFont2(13);
    _timeStrLabel.textColor = [LCColor whiteColor];
    [self addSubview:_timeStrLabel];
    [_timeStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.bgView).offset(-30);
    }];
    
    _timeLabel = [UILabel new];
    _timeLabel.text = @"2018-12-18";
    _timeLabel.alpha = 0.5;
    _timeLabel.font = LCFont2(14);
    _timeLabel.textColor = [LCColor whiteColor];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeStrLabel.mas_right).offset(5);
        make.centerY.equalTo(self.timeStrLabel);
    }];
    
    _dayStrLabel = [UILabel new];
    _dayStrLabel.text = @"剩余天数";
    _dayStrLabel.alpha = 0.5;
    _dayStrLabel.font = LCFont2(10);
    _dayStrLabel.textColor = [LCColor whiteColor];
    [self addSubview:_dayStrLabel];
    [_dayStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.equalTo(self.bgView).offset(-30);
         make.top.equalTo(self.titleLabel);
     }];
    
    _dayLabel = [UILabel new];
    _dayLabel.text = @"626";
    _dayLabel.font = LCFont(45);
    _dayLabel.alpha = 0.8;
    _dayLabel.textColor = [LCColor whiteColor];
    [self addSubview:_dayLabel];
    [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.dayStrLabel);
        make.top.equalTo(self.dayStrLabel.mas_bottom);
    }];
}

-(void)bind:(EventModel *)model{
    if (model.title) {
        self.titleLabel.text = model.title;
    }else{
        self.titleLabel.text = @"请输入标题";
    }
    
//    self.classTypeLabel.text = model.classType;
//    self.remindTypeLabel.text = model.remindType;
    
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
                            if (newDateComponent.month == 1 && (components.day == 29 || components.day == 30 || components.day == 31)) {
                                //当前月为01月  下月是2月   假如日为29、30、31 统一显示 28
                                targetDateStr = [NSString stringWithFormat:@"%ld-%@-%@",newDateComponent.year,@"02",@"28"];
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
    if (targetDateStr) {
        NSArray * arr = [targetDateStr componentsSeparatedByString:@"-"];
        if (arr.count > 2) {
            NSString * str = arr[1];
            if (str.length == 1) {
                targetDateStr = [NSString stringWithFormat:@"%@-0%@-%@",arr.firstObject,arr[1],arr.lastObject];
            }
        }
    }
    self.timeLabel.text = targetDateStr;
}

@end
