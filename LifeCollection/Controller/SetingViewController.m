//
//  SetingViewController.m
//  LifeCollection
//
//  Created by gozap on 2019/4/22.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "SetingViewController.h"
#import "TitleTableViewCell.h"

#import "JinnLockViewController.h"

@interface SetingViewController ()<UITableViewDelegate,UITableViewDataSource,JinnLockViewControllerDelegate>

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

    if (![JinnLockTool isGestureUnlockEnabled]){
        return 1;
    }else{
        return 2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TitleSwitchTableViewCell * cell = getCell(TitleSwitchTableViewCell);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = @[@"手势密码",@"指纹密码"][indexPath.row];
    if (indexPath.row == 0) {
        [cell.sevenSwitch setOn:[JinnLockTool isGestureUnlockEnabled]];
        [cell.sevenSwitch addTarget:self action:@selector(gestureUnLockSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    }else{
        [cell.sevenSwitch setOn:[JinnLockTool isTouchIdUnlockEnabled]];
        [cell.sevenSwitch addTarget:self action:@selector(touchIdUnLockSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
}

#pragma mark - Private

- (void)gestureUnLockSwitchChanged:(UISwitch *)sender{
    if (sender.on){
        JinnLockViewController *lockViewController = [[JinnLockViewController alloc] initWithDelegate:self type:JinnLockTypeCreate appearMode:JinnLockAppearModePush];
        [self.navigationController pushViewController:lockViewController animated:YES];
    }else{
        JinnLockViewController *lockViewController = [[JinnLockViewController alloc] initWithDelegate:self type:JinnLockTypeRemove appearMode:JinnLockAppearModePush];
        [self.navigationController pushViewController:lockViewController animated:YES];
    }
    [self.tableView reloadData];
}

- (void)touchIdUnLockSwitchChanged:(UISwitch *)sender{
    [JinnLockTool setTouchIdUnlockEnabled:sender.on];
}

#pragma mark - JinnLockViewControllerDelegate

- (void)passcodeDidCreate:(NSString *)passcode{
    [self.tableView reloadData];
}

- (void)passcodeDidRemove{
    [self.tableView reloadData];
}

@end

