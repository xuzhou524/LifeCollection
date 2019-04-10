//
//  AddNoteViewController.m
//  LifeCollection
//
//  Created by gozap on 2019/4/10.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "AddNoteViewController.h"
#import "NoteListTableViewCell.h"
#import "PreviewTableViewCell.h"

@interface AddNoteViewController ()

@end

@interface AddNoteViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation AddNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加";
    self.view.backgroundColor = [LCColor backgroudColor];
    
    UIButton * rightBtn = [UIButton new];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = LCFont(16);
    [rightBtn setTitleColor:[LCColor LCColor_77_92_127] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    _tableView = [UITableView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [LCColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    regClass(self.tableView, PreviewTableViewCell);
    regClass(self.tableView, NoteListTableViewCell);
    regClass(self.tableView, AddNoteTableViewCell);
    
}

-(void)rightBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 35;
    }else if (indexPath.row == 1){
        return 200;
    }else if (indexPath.row == 2 || indexPath.row == 3 ||indexPath.row == 4 ||indexPath.row == 5){
        return 200;
    }else if (indexPath.row == 6){
        return 70;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        PreviewTableViewCell * previewCell = getCell(PreviewTableViewCell);
        previewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return previewCell;
    }else if (indexPath.row == 1){
        NoteListTableViewCell * cell = getCell(NoteListTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 2){
        AddNoteTableViewCell * cell = getCell(AddNoteTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

@end
