//
//  UserViewController.m
//  LifeCollection
//
//  Created by gozap on 2018/12/17.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import "UserViewController.h"
#import "UserViewTableViewCell.h"
#import "TitleTableViewCell.h"
#import <StoreKit/StoreKit.h>
#import "SetingViewController.h"

@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIButton *_rightBtn;
}

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation UserViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _rightBtn.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     self.navigationController.navigationBar.hidden = NO;
    _rightBtn.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    UILabel * liftLabel = [UILabel new];
    liftLabel.text = @"我的时间";
    liftLabel.font = LCFont(23);
    liftLabel.textColor = [LCColor LCColor_77_92_127];
    [self .view addSubview:liftLabel];
    [liftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(54);
    }];
    
    _rightBtn = [UIButton new];
    [_rightBtn setImage:[UIImage imageNamed:@"Settings~iphone"] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self .view addSubview:_rightBtn];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(liftLabel);
        make.right.equalTo(self.view).offset(-20);
        make.width.equalTo(@25);
        make.height.equalTo(@27);
    }];
    
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
            return 210;
        }else{
            return 95;
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
        cell.titleLabel.text = @[@"日常工具",@"服务条款",@"分享我的时间",@"关于开发者"][indexPath.row];
        cell.summeryLabel.text = @"";
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0){

        }else if (indexPath.row == 1) {

        }else if (indexPath.row == 2){
            NSString * title = @"我的时间 - 专注时间管理、记事本日常工具";
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

        }
    }
}

-(void)zanImageViewTap{
#ifdef DEBUG
#else
    if([SKStoreReviewController respondsToSelector:@selector(requestReview)]){
        [SKStoreReviewController requestReview];
    }else{
        NSString  * nsStringToOpen = [NSString  stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",@"1447845919"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nsStringToOpen]];
    }
#endif
}

-(void)tuImageView{
    NSString *str = @"mqq://im/chat?chat_type=wpa&uin=1043037904&version=1&src_type=web";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
}

@end
