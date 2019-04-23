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
#import <StoreKit/StoreKit.h>
#import "SetingViewController.h"
#import "ToolViewController.h"

@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * rightBtn = [UIButton new];
    [rightBtn setImage:[UIImage imageNamed:@"shezhi"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
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

-(void)rightBtnClick{
    SetingViewController * aboutDeveloperVC =[SetingViewController new];
    [self.navigationController pushViewController:aboutDeveloperVC animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 150;
        }else{
            return 95;
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
        if (indexPath.row == 4) {
            TitleNoRightImageTableViewCell * cell = getCell(TitleNoRightImageTableViewCell);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"当前版本";
            cell.summeryLabel.text = [NSString stringWithFormat:@"v%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
            return cell;
        }
        TitleTableViewCell * cell = getCell(TitleTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @[@"日常工具",@"服务条款",@"分享记点",@"关于开发者"][indexPath.row];
        cell.summeryLabel.text = @"";
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0){
            ToolViewController * toolVC =[ToolViewController new];
            [self.navigationController pushViewController:toolVC animated:YES];
        }else if (indexPath.row == 1) {
            LCWebViewViewController * webViewVC =[LCWebViewViewController new];
            webViewVC.titleStr = @"服务条款";
            webViewVC.urlStr = @"http://img.gozap.com/group19/M00/0F/E5/wKgCN1y1mYvZp1H6AAIFAVCycb8814.pdf";
            [self.navigationController pushViewController:webViewVC animated:YES];
        }else if (indexPath.row == 2){
            NSString * title = @"记点 - 让生活更精彩";
            NSString * url = @"https://itunes.apple.com/us/app//id1447845919?l=zh&ls=1&mt=8";
            NSString * image = @"http://img.gozap.com/group19/M01/B4/0F/wKgCOFwvGqnXXzibAACN7VDmKvQ248.png";
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:image]];
            UIImage *imageToShare = [UIImage imageWithData:data];
            NSString *textToShare = [NSString stringWithFormat:@"%@ %@",title,url];
            NSURL *urlToShare = [NSURL URLWithString:url];
            
            NSArray *activityItems = @[textToShare,imageToShare,urlToShare];
            UIActivity *bookActivity = [UIActivity new];
            NSArray *applicationActivities = @[bookActivity];
            UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems
                                                                                    applicationActivities: applicationActivities];
            [[LCClient sharedInstance].lcCenterNav presentViewController:activityVC animated:TRUE completion:nil];
        }else if (indexPath.row == 3){
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
