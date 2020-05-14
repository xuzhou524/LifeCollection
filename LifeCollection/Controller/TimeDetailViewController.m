//
//  TimeDetailViewController.m
//  LifeCollection
//
//  Created by gozap on 2020/5/11.
//  Copyright © 2020 com.longdai. All rights reserved.
//

#import "TimeDetailViewController.h"
#import "TimeListTableViewCell.h"
#import "AddViewController.h"

@interface TimeDetailViewController ()
@property(nonatomic,strong)LDNavigationTapView *topView;
@end

@implementation TimeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [LCColor backgroudColor];
    self.fd_prefersNavigationBarHidden = YES;
    
    [self subEnoughViews];
    [self subViews];

}

-(void)liftNavigationClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)subEnoughViews{
    UIImageView * backgroundImageView = [UIImageView new];
    NSString * imageStr = LCEventBackgroundImage([self.eventModel.colorType integerValue]);
    backgroundImageView.image = [UIImage imageNamed:imageStr];
    [self.view addSubview:backgroundImageView];
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    //模糊的效果
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    visualEffectView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    visualEffectView.alpha = 0.6;
    [backgroundImageView addSubview:visualEffectView];
    
    [self.view addSubview:self.topView];
    
}

-(void)subViews{
    UIView * bgView = [UIView new];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 8;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-((ScreenWidth - 50) * 0.27));
        make.width.equalTo(@(ScreenWidth - 50));
        make.height.equalTo(@((ScreenWidth - 50) * 0.55));
    }];
    
    TimeListTableView* timeView = [TimeListTableView new];
    timeView.bgView.backgroundColor = [UIColor clearColor];
    [bgView addSubview:timeView];
    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(bgView);
    }];
    [timeView bind:self.eventModel];
    
    UIButton * editorButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    editorButton.layer.cornerRadius = 8;
    editorButton.layer.masksToBounds = YES;
    NSString * imageStr = LCEventBackgroundImage([self.eventModel.colorType integerValue]);
    [editorButton setBackgroundImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    
    [editorButton setBackgroundColor:[UIColor whiteColor]];
    editorButton.alpha = 0.3;
    [self.view addSubview:editorButton];
    [editorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-30);
        make.top.equalTo(bgView.mas_bottom).offset(50);
        make.width.equalTo(@((ScreenWidth - 50) / 2.0));
        make.height.equalTo(@35);
    }];
    [editorButton addTarget:self action:@selector(didiEditorClick) forControlEvents:UIControlEventTouchUpInside];
    UILabel * label = [UILabel new];
    label.text = @"编辑";
    label.font = LCFont2(15);
    label.alpha = 0.8;
    label.textColor = [LCColor whiteColor];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(editorButton);
    }];
    
    UIButton * shareButton = [UIButton new];
    shareButton.layer.cornerRadius = 8;
    shareButton.layer.masksToBounds = YES;
    [shareButton setBackgroundImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    shareButton.alpha = 0.3;
    [self.view addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-30);
        make.top.equalTo(editorButton.mas_bottom).offset(20);
        make.width.equalTo(@((ScreenWidth - 50) / 4.0));
        make.height.equalTo(@35);
    }];
    [shareButton addTarget:self action:@selector(didiShareClick) forControlEvents:UIControlEventTouchUpInside];
    UILabel * label1 = [UILabel new];
    label1.text = @"分享";
    label1.font = LCFont2(15);
    label1.alpha = 0.8;
    label1.textColor = [LCColor whiteColor];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(shareButton);
    }];
}

-(void)didiEditorClick{
    AddViewController * addVC = [AddViewController new];
    addVC.eventModel = self.eventModel;
    [self.navigationController pushViewController:addVC animated:YES];
}

-(void)didiShareClick{
    
    NSString * dayStr = @"0";
    NSString * timeStr = @"起始日";
    NSString * dayTypeStr = @"已过天数";
    NSString * targetDateStr = [DateFormatter stringFromBirthday:[DateFormatter dateFromTimeStampString:self.eventModel.time]];
    if ([self.eventModel.classType isEqualToString:@"倒计日"]) {
        dayTypeStr = @"剩余天数";
        timeStr = @"下一目标日";
        NSTimeInterval  timeInterval = [[DateFormatter dateFromTimeStampString:self.eventModel.time] timeIntervalSinceNow];
        if (timeInterval < 0) {
            NSCalendar *gregorian = [[ NSCalendar alloc ] initWithCalendarIdentifier : NSCalendarIdentifierGregorian];
            unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
            //格式化时间
            NSDate *createDate = [DateFormatter dateFromTimeStampString:self.eventModel.time];
            NSDateComponents* components = [gregorian components:unitFlags fromDate:createDate];
            [components setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
            //格式化现在时间
            NSDateComponents* newDateComponent = [gregorian components:unitFlags fromDate:[NSDate date]];
            [newDateComponent setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
            
            if ([self.eventModel.remindType isEqualToString:@"无循环"]){
                dayStr = @"0";
            }else{
                if ([self.eventModel.remindType isEqualToString:@"月循环"]) {
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
                }else if ([self.eventModel.remindType isEqualToString:@"年循环"]){
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
                dayStr = result;
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
            dayStr = result;
        }
    }else if ([self.eventModel.classType isEqualToString:@"累计日"]){
        dayTypeStr = @"已过天数";
        timeStr = @"起始日";
        NSTimeInterval  timeInterval = [[DateFormatter dateFromTimeStampString:self.eventModel.time] timeIntervalSinceNow];
        if (timeInterval < 0) {
            long temp = 0;
            NSString *result;
            temp = fabs(timeInterval)/60;
            if((temp = temp/60) <24){
                result= [NSString stringWithFormat:@"0"];
            }else if((temp = temp/24) <10000){
                result = [NSString stringWithFormat:@"%ld",temp];
            }
            dayStr = result;
        }else{
            dayStr = @"0";
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
    
   NSString *textToShare = [NSString stringWithFormat:@"%@ %@:%@ %@:%@\n记点 - 拾掇生活中的点滴，记录时光的故事",self.eventModel.title,dayTypeStr,dayStr,timeStr,targetDateStr];
   NSArray *activityItems = @[textToShare];
   UIActivity *bookActivity = [UIActivity new];
   NSArray *applicationActivities = @[bookActivity];
   UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems
                                                                        applicationActivities: applicationActivities];
   //不出现在活动项目
   activityVC.excludedActivityTypes = @[UIActivityTypeAirDrop];
   [self.navigationController presentViewController:activityVC animated:TRUE completion:nil];
}

- (UIView *)topView{
    if (_topView == nil) {
        _topView = [[LDNavigationTapView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
        if(LCiPhoneX){
            _topView.frame = CGRectMake(0, 0, ScreenWidth, 64 + 22);
        }
        _topView.titleLabel.text = @"";
        _topView.leftImageView.image = [[UIImage imageNamed:@"guanbi"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _topView.leftImageView.tintColor = [UIColor whiteColor];
        [_topView.tapLeftView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(liftNavigationClick)]];
    }
    return _topView;
}
@end


@implementation LDNavigationTapView
- (instancetype)init{
    self = [super init];
    if (self) {
        [self sebView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self sebView];
    }
    return self;
}

-(void)sebView{
    _bgView = [UIImageView new];
    _bgView.backgroundColor = [UIColor clearColor];
    _bgView.userInteractionEnabled = YES;
    [self addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = LCFont2(18);
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-13);
    }];
    
    _leftImageView = [UIImageView new];
    _leftImageView.userInteractionEnabled = YES;
    [self addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(25);
        make.bottom.equalTo(self).offset(-13);
        make.width.height.equalTo(@22);
    }];

    _tapLeftView = [UIView new];
    _tapLeftView.backgroundColor = [UIColor clearColor];
    [self addSubview:_tapLeftView];
    [_tapLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageView).offset(-10);
        make.right.equalTo(_leftImageView).offset(60);
        make.bottom.equalTo(_leftImageView).offset(10);
        make.top.equalTo(_leftImageView).offset(-10);
    }];
    
    _rightImageView = [UIImageView new];
    _rightImageView.userInteractionEnabled = YES;
    [self addSubview:_rightImageView];
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-13);
        make.width.height.equalTo(@20);
    }];
}
@end

