//
//  HomeViewController.m
//  LifeCollection
//
//  Created by gozap on 2018/12/14.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "HomeViewController.h"
#import "TimeListTableViewCell.h"
#import "AddViewController.h"
#import "EventModel.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * eventModelLists;
@property (nonatomic, strong) EventModel * eventModel;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Time";

    _tableView = [UITableView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [LCColor backgroudColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    regClass(self.tableView, TimeListTableViewCell);
    
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
    
    self.eventModelLists = [self.eventModel queryWithNote];
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
    return 135;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TimeListTableViewCell * cell = getCell(TimeListTableViewCell);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    EventModel * model = self.eventModelLists[indexPath.row];
    [cell bind:model];
    return cell;
}

@end
