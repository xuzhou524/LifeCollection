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
#import "AboutDeveloperViewController.h"

@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * liftLabel = [UILabel new];
    liftLabel.text = @"咘咕";
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
    regClass(self.tableView, TitleNoRightImageTableViewCell);
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 190;
        }else{
            return 105;
        }
    }
    return 70;
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
            [cell.zanImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zanImageViewTap)]];
            [cell.tuImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tuImageView)]];
            return cell;
        }
    }else{
        if (indexPath.row == 2) {
            TitleNoRightImageTableViewCell * cell = getCell(TitleNoRightImageTableViewCell);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"咘咕版本";
            cell.summeryLabel.text = [NSString stringWithFormat:@"v%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
            return cell;
        }
        TitleTableViewCell * cell = getCell(TitleTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @[@"服务条款",@"关于开发者"][indexPath.row];
        cell.summeryLabel.text = @"";
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            LCWebViewViewController * webViewVC =[LCWebViewViewController new];
            webViewVC.titleStr = @"服务条款";
            webViewVC.urlStr = @"http://img.gozap.com/group19/M01/80/08/wKgCN1wcrJ6WDKlrAAHm_9rYe-c967.pdf";
            [self.navigationController pushViewController:webViewVC animated:YES];
        }else if (indexPath.row == 1){
            AboutDeveloperViewController * aboutDeveloperVC =[AboutDeveloperViewController new];
            [self.navigationController pushViewController:aboutDeveloperVC animated:YES];
        }
    }
}

-(void)zanImageViewTap{
#ifdef DEBUG
#else
    if([SKStoreReviewController respondsToSelector:@selector(requestReview)]){
        [SKStoreReviewController requestReview];
    }else{
        NSString  * nsStringToOpen = [NSString  stringWithFormat: @"itms-apps://itunes.apple.com/app/id%@?action=write-review",@"1447845919"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nsStringToOpen]];
    }
#endif
}

-(void)tuImageView{
    NSString *str = @"mqq://im/chat?chat_type=wpa&uin=1043037904&version=1&src_type=web";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

@end
