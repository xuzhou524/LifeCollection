//
//  AccountAndPswListViewController.m
//  LifeCollection
//
//  Created by gozap on 2019/4/30.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "AccountAndPswListViewController.h"
#import "UserViewTableViewCell.h"
#import "TitleTableViewCell.h"
#import "LCWebViewViewController.h"
#import "AboutDeveloperViewController.h"

@interface AccountAndPswListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation AccountAndPswListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账号密码本";
    
    _tableView = [UITableView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [LCColor backgroudColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    regClass(self.tableView, UserViewTableViewCell);
    regClass(self.tableView, TitleTableViewCell);
    regClass(self.tableView, UserHeadViewTableViewCell);
    regClass(self.tableView, TitleNoRightImageTableViewCell);
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TitleTableViewCell * cell = getCell(TitleTableViewCell);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = @[@"用易房贷",@"随时笔记",@"OnePai",@"蓝牙通",@"用易天气"][indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

@end
