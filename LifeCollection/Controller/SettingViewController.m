//
//  SettingViewController.m
//  JiDianZhang
//
//  Created by gozap on 2021/6/2.
//  Copyright © 2021 com.longdai. All rights reserved.
//

#import "SettingViewController.h"
#import "TitleTableViewCell.h"


@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    _tableView = [UITableView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    regClass(self.tableView, TitleSwitchTableViewCell);

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TitleSwitchTableViewCell * cell = getCell(TitleSwitchTableViewCell);
    cell.titleLabel.text = @"屏蔽弹出广告";
    NSString * switchOn = [[NSUserDefaults standardUserDefaults] objectForKey:@"com.xuzhou.LifeCollection"];
    if ([switchOn intValue] == 1) {
        cell.sevenSwitch.on = YES;
    }else{
        cell.sevenSwitch.on = NO;
    }
    [cell.sevenSwitch addTarget:self action:@selector(didSwitch) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)didSwitch{
    NSString * switchOn = [[NSUserDefaults standardUserDefaults] objectForKey:@"com.xuzhou.LifeCollection"];
    if ([switchOn intValue] == 1) {
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"com.xuzhou.LifeCollection"];
    }else{
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"com.xuzhou.LifeCollection"];
    }
}

@end
