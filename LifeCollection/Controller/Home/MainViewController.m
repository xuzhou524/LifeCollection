//
//  MainViewController.m
//  LifeCollection
//
//  Created by gozap on 2021/6/7.
//  Copyright © 2021 com.longdai. All rights reserved.
//

#import "MainViewController.h"
#import "TimeListTableViewCell.h"
#import "AddViewController.h"
#import "TimeDetailViewController.h"
#import "EventModel.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * eventModelLists;
@property (nonatomic, strong) EventModel * eventModel;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [LCColor backgroudColor];
    UIImageView * summeryImageView = [UIImageView new];
    summeryImageView.image = [UIImage imageNamed:@"summery"];
    [self.view addSubview:summeryImageView];
    [summeryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(10);
        make.width.equalTo(@154);
        make.height.equalTo(@34);
    }];

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
    liftLabel.text = @"Time";
    liftLabel.font = LCFont(28);
    liftLabel.textColor = [LCColor LCColor_77_92_127];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:liftLabel];

    UIButton * rightBtn = [UIButton new];
    UIImage * addIamge = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    rightBtn.tintColor = [LCColor LCColor_77_92_127];
    [rightBtn setImage:addIamge forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
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
    [dic setObject:eventModel.remindType forKey:@"remindType"];
    [dic setObject:eventModel.colorType forKey:@"colorType"];

    [userDefaults setObject:dic forKey:@"widget"];
    
    [self.tableView reloadData];
}

-(void)rightBtnClick{
    AddViewController * addVC = [AddViewController new];
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
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TimeDetailViewController * timeDetailVC = [TimeDetailViewController new];
    timeDetailVC.eventModel = self.eventModelLists[indexPath.row];
    [self.navigationController pushViewController:timeDetailVC animated:YES];
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

@end
