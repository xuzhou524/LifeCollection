//
//  HomeViewController.m
//  LifeCollection
//
//  Created by gozap on 2018/12/14.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "HomeViewController.h"
#import "TimeListTableViewCell.h"
#import "AddViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray * _iconArray;
}
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Time";

    _tableView = [UITableView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [LCColor backgroudColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    regClass(self.tableView, TimeListTableViewCell);
    
    UIButton * rightBtn = [UIButton new];
    [rightBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    _iconArray = @[[LCColor LCColor_254_79_94],[LCColor LCColor_255_209_79],[LCColor LCColor_192_108_132],[LCColor LCColor_255_129_0],[LCColor LCColor_104_83_164],[LCColor LCColor_0_111_247]];
}

-(void)rightBtnClick{
    [self.navigationController pushViewController:[AddViewController new] animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TimeListTableViewCell * cell = getCell(TimeListTableViewCell);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.bgView.backgroundColor = _iconArray[indexPath.row % 6];
    return cell;
}

@end
