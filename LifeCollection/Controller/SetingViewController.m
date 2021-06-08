//
//  SetingViewController.m
//  LifeCollection
//
//  Created by gozap on 2019/4/22.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import "SetingViewController.h"
#import "TitleTableViewCell.h"

#import "JinnLockViewController.h"

@interface SetingViewController ()<UITableViewDelegate,UITableViewDataSource,JinnLockViewControllerDelegate>

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation SetingViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_tableView) {
        [self.tableView reloadData];
    }
}

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
    regClass(self.tableView, UITableViewCell);
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (![JinnLockTool isGestureUnlockEnabled]){
        return 2;
    }else{
        return 3;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 65;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((![JinnLockTool isGestureUnlockEnabled] && indexPath.row == 1) || ([JinnLockTool isGestureUnlockEnabled] && indexPath.row == 2)) {
        UITableViewCell * cell =getCell(UITableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [LCColor backgroudColor];
        
        UILabel * label = [UILabel new];
        label.textColor = [LCColor LCColor_243_90_93];
        label.font = LCFont2(11);
        label.numberOfLines = 0;
        label.text = @"* 一定要谨记自己设置的手势密码，忘记无法找回，导致app打不开。谨记、谨记、谨记 重要的事情说三遍；";
        [cell.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(20);
            make.right.equalTo(cell.contentView).offset(-20);
            make.centerY.equalTo(cell.contentView);
        }];
        
        return cell;
    }else{
        TitleSwitchTableViewCell * cell = getCell(TitleSwitchTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([JinnLockTool isFaceID]) {
            cell.titleLabel.text = @[@"手势密码",@"面容密码"][indexPath.row];
        }else{
            cell.titleLabel.text = @[@"手势密码",@"指纹密码"][indexPath.row];
        }
        if (indexPath.row == 0) {
            [cell.sevenSwitch setOn:[JinnLockTool isGestureUnlockEnabled]];
            [cell.sevenSwitch addTarget:self action:@selector(gestureUnLockSwitchChanged:) forControlEvents:UIControlEventValueChanged];
        }else{
            [cell.sevenSwitch setOn:[JinnLockTool isTouchIdUnlockEnabled]];
            [cell.sevenSwitch addTarget:self action:@selector(touchIdUnLockSwitchChanged:) forControlEvents:UIControlEventValueChanged];
        }
         return cell;
    }
    return [UITableViewCell new];
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

