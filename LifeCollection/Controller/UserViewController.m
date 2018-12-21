//
//  UserViewController.m
//  LifeCollection
//
//  Created by gozap on 2018/12/17.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "UserViewController.h"
#import "UserViewTableViewCell.h"
#import "TitleTableViewCell.h"
#import "LCWebViewViewController.h"

@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * liftLabel = [UILabel new];
    liftLabel.text = @"我的";
    liftLabel.font = LCFont(25);
    liftLabel.textColor = [LCColor LCColor_77_92_127];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:liftLabel];
    
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
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 220;
        }else{
            return 105;
        }
    }
    return 65;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UserViewTableViewCell * cell = getCell(UserViewTableViewCell);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            UserHeadViewTableViewCell * cell = getCell(UserHeadViewTableViewCell);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }

    TitleTableViewCell * cell = getCell(TitleTableViewCell);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = @[@"分享给朋友",@"服务条款",@"关于开发者",@"咘咕app"][indexPath.row];
    cell.summeryLabel.text = @"";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            LCWebViewViewController * webViewVC =[LCWebViewViewController new];
            [self.navigationController pushViewController:webViewVC animated:YES];
        }
    }
}

@end
