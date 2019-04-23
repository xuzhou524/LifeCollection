//
//  SetingViewController.m
//  LifeCollection
//
//  Created by gozap on 2019/4/22.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "SetingViewController.h"
#import "TitleTableViewCell.h"

@interface SetingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation SetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    
    _tableView = [UITableView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [LCColor backgroudColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    regClass(self.tableView, TitleSwitchTableViewCell);
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TitleSwitchTableViewCell * cell = getCell(TitleSwitchTableViewCell);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = @[@"手势密码",@"指纹密码"][indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
}

@end

