//
//  AddViewController.m
//  LifeCollection
//
//  Created by gozap on 2018/12/17.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "AddViewController.h"
#import "PreviewTableViewCell.h"
#import "TextFieldTableViewCell.h"
#import "TitleTableViewCell.h"

@interface AddViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加";
    self.view.backgroundColor = [LCColor backgroudColor];
    _tableView = [UITableView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [LCColor backgroudColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    regClass(self.tableView, PreviewTableViewCell);
    regClass(self.tableView, TextFieldTableViewCell);
    regClass(self.tableView, TitleTableViewCell);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 170;
    }else if (indexPath.row == 1 || indexPath.row == 2 ||indexPath.row == 3 ||indexPath.row == 4){
        return 60;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        PreviewTableViewCell * cell = getCell(PreviewTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1){
        TextFieldTableViewCell * cell = getCell(TextFieldTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"标题";
        return cell;
    }else if (indexPath.row == 2){
        TitleTableViewCell * cell = getCell(TitleTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"类型";
        return cell;
    }else if (indexPath.row == 3){
        TextFieldTableViewCell * cell = getCell(TextFieldTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"时间";
        return cell;
    }else if (indexPath.row == 4){
        TitleTableViewCell * cell = getCell(TitleTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"提醒";
        return cell;
    }
    return [UITableViewCell new];
}

@end
