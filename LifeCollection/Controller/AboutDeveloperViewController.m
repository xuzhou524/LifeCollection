//
//  AboutDeveloperViewController.m
//  LifeCollection
//
//  Created by gozap on 2018/12/21.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "AboutDeveloperViewController.h"
#import "UserViewTableViewCell.h"
#import "TitleTableViewCell.h"
#import "LCWebViewViewController.h"
#import "AboutDeveloperViewController.h"
#import "AppListViewController.h"
#import "AppreciatesViewController.h"

@interface AboutDeveloperViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation AboutDeveloperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于开发者";

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
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 1) {
//        if (indexPath.row == 2) {
//            return 0;
//        }
//    }
    return 65;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 15;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * bgView = [UIView new];
    bgView.backgroundColor = [LCColor backgroudColor];
    return bgView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        TitleTableViewCell * cell = getCell(TitleTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @[@"简介",@"gitHub",@"微博",@"微信"][indexPath.row];
        cell.summeryLabel.text = @[@"周周",@"xuzhou524",@"徐_Aaron",@"xu-zhou524"][indexPath.row];
        return cell;
    }else{
        TitleTableViewCell * cell = getCell(TitleTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @[@"ShareHub",@"开发者app集锦",@"支持开发者"][indexPath.row];
        cell.summeryLabel.text = @[@"资源和工具的集合",@"",@""][indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LCWebViewViewController * webViewVC =[LCWebViewViewController new];
            webViewVC.titleStr = @"简介";
            webViewVC.urlStr = @"http://www.xzzai.com";
            [self.navigationController pushViewController:webViewVC animated:YES];
        }else if (indexPath.row == 1){
            LCWebViewViewController * webViewVC =[LCWebViewViewController new];
            webViewVC.titleStr = @"gitHub";
            webViewVC.urlStr = @"https://github.com/xuzhou524";
            [self.navigationController pushViewController:webViewVC animated:YES];
        }
    }else{
        if (indexPath.row == 0) {
            LCWebViewViewController * webViewVC =[LCWebViewViewController new];
            webViewVC.titleStr = @"ShareHub";
            webViewVC.urlStr = @"https://www.gezhipu.com";
            [self.navigationController pushViewController:webViewVC animated:YES];
        }else if (indexPath.row == 1){
            AppListViewController * appListVC =[AppListViewController new];
            [self.navigationController pushViewController:appListVC animated:YES];
        }else if (indexPath.row == 2){
            AppreciatesViewController * appreciatesVC =[AppreciatesViewController new];
            [self.navigationController pushViewController:appreciatesVC animated:YES];
        }
    }
}

@end
