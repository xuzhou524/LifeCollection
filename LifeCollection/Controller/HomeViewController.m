//
//  HomeViewController.m
//  LifeCollection
//
//  Created by gozap on 2018/12/14.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import "HomeViewController.h"
#import "TimeListTableViewCell.h"
#import "AddViewController.h"
#import "TimeDetailViewController.h"
#import "EventModel.h"
#import "UserViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * eventModelLists;
@property (nonatomic, strong) EventModel * eventModel;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [UITableView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [LCColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    regClass(self.tableView, TimeListTableViewCell);
    
    UILabel * liftLabel = [UILabel new];
    liftLabel.text = @"记日子";
    liftLabel.font = LCFont(22);
    liftLabel.textColor = [LCColor LCColor_121_117_245];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:liftLabel];

    UIButton * rightBtn = [UIButton new];
    [rightBtn setImage:[UIImage imageNamed:@"ic_More"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UIImageView * addImageView = [UIImageView new];
    addImageView.image = [UIImage imageNamed:@"ic_newAdd"];
    addImageView.userInteractionEnabled = YES;
    [addImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didiAddClick)]];
    [self.view addSubview:addImageView];
    [addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-60);
        make.width.height.equalTo(@56);
    }];
}

-(EventModel *)eventModel{
    if (_eventModel == nil){
        _eventModel = [EventModel new];
    }
    return _eventModel;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.eventModelLists = [self.eventModel queryWithTime];
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.xuzhou.LifeCollection"];
    
    EventModel * eventModel = self.eventModelLists.firstObject;
    
    NSMutableDictionary * dic = [NSMutableDictionary new];
    [dic setObject:eventModel.title forKey:@"title"];
    [dic setValue:eventModel.content forKey:@"content"];
    [dic setObject:eventModel.time forKey:@"time"];
    [dic setObject:eventModel.classType forKey:@"classType"];
    [dic setObject:eventModel.tag forKey:@"tag"];
    [dic setObject:eventModel.remindType forKey:@"remindType"];
    [dic setObject:eventModel.colorType forKey:@"colorType"];

    [userDefaults setObject:dic forKey:@"widget"];
    
    [self.tableView reloadData];
}

-(void)didiAddClick{
    AddViewController * addVC = [AddViewController new];
    addVC.isEditor = NO;
    [self.navigationController presentViewController:addVC animated:true completion:nil];
}

-(void)rightBtnClick{
    UserViewController * addVC = [UserViewController new];
    [self.navigationController pushViewController:addVC animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.eventModelLists.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TimeListTableViewCell * cell = getCell(TimeListTableViewCell);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell bind:self.eventModelLists[indexPath.row]];

    cell.shareImageView.tag = indexPath.row;
    [cell.shareImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didiShareClick:)]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddViewController * addVC = [AddViewController new];
    addVC.isEditor = YES;
    addVC.eventModel = self.eventModelLists[indexPath.row];
    [self.navigationController pushViewController:addVC animated:YES];
    
//    TimeDetailViewController * timeDetailVC = [TimeDetailViewController new];
//    timeDetailVC.eventModel = self.eventModelLists[indexPath.row];
//    [self.navigationController pushViewController:timeDetailVC animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        EventModel * tempModel = self.eventModelLists[indexPath.row];
        [tempModel deleteTime:tempModel.ids];
        [self.eventModelLists removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)didiShareClick:(UITapGestureRecognizer *)tap{

    EventModel * tempModel = self.eventModelLists[tap.view.tag];
    
    
    NSString * dayStr = @"0";
    NSString * timeStr = @"起始日";
    NSString * dayTypeStr = @"已过天数";
    NSString * targetDateStr = [DateFormatter stringFromBirthday:[DateFormatter dateFromTimeStampString:tempModel.time]];
    if ([tempModel.classType isEqualToString:@"倒计日"]) {
        dayTypeStr = @"剩余天数";
        timeStr = @"下一目标日";
        NSTimeInterval  timeInterval = [[DateFormatter dateFromTimeStampString:tempModel.time] timeIntervalSinceNow];
        if (timeInterval < 0) {
            NSCalendar *gregorian = [[ NSCalendar alloc ] initWithCalendarIdentifier : NSCalendarIdentifierGregorian];
            unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
            //格式化时间
            NSDate *createDate = [DateFormatter dateFromTimeStampString:tempModel.time];
            NSDateComponents* components = [gregorian components:unitFlags fromDate:createDate];
            [components setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
            //格式化现在时间
            NSDateComponents* newDateComponent = [gregorian components:unitFlags fromDate:[NSDate date]];
            [newDateComponent setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
            
            if ([tempModel.remindType isEqualToString:@"无循环"]){
                dayStr = @"0";
            }else{
                if ([tempModel.remindType isEqualToString:@"月循环"]) {
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
                }else if ([tempModel.remindType isEqualToString:@"年循环"]){
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
    }else if ([tempModel.classType isEqualToString:@"累计日"]){
        dayTypeStr = @"已过天数";
        timeStr = @"起始日";
        NSTimeInterval  timeInterval = [[DateFormatter dateFromTimeStampString:tempModel.time] timeIntervalSinceNow];
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
    
   NSString *textToShare = [NSString stringWithFormat:@"%@ %@:%@ %@:%@\n记日子 - 拾掇生活中的点滴，记录时光的故事",tempModel.title,dayTypeStr,dayStr,timeStr,targetDateStr];
   NSArray *activityItems = @[textToShare];
   UIActivity *bookActivity = [UIActivity new];
   NSArray *applicationActivities = @[bookActivity];
   UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems
                                                                        applicationActivities: applicationActivities];
   //不出现在活动项目
   activityVC.excludedActivityTypes = @[UIActivityTypeAirDrop];
   [self.navigationController presentViewController:activityVC animated:TRUE completion:nil];
}

@end
