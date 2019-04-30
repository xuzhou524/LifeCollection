//
//  NoteListViewController.m
//  LifeCollection
//
//  Created by gozap on 2019/4/8.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "NoteListViewController.h"
#import "NoteListTableViewCell.h"
#import "AddViewController.h"
#import "NoteModel.h"
#import "AddNoteViewController.h"

#import "AccountAndPasswordTableViewCell.h"
#import "AccountAndPswListViewController.h"

@interface NoteListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * noteModelLists;
@property (nonatomic, strong) NoteModel * noteModel;
@end

@implementation NoteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [LCColor backgroudColor];
    
    _tableView = [UITableView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [LCColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    regClass(self.tableView, NoteListTableViewCell);
    regClass(self.tableView, AccountAndPasswordTableViewCell);
    
    UILabel * liftLabel = [UILabel new];
    liftLabel.text = @"小记";
    liftLabel.font = LCFont(23);
    liftLabel.textColor = [LCColor LCColor_77_92_127];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:liftLabel];
    
    UIButton * rightBtn = [UIButton new];
    UIImage * addIamge = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    rightBtn.tintColor = [LCColor LCColor_77_92_127];
    [rightBtn setImage:addIamge forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

-(NoteModel *)noteModel{
    if (_noteModel == nil){
        _noteModel = [NoteModel new];
    }
    return _noteModel;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.noteModelLists = [self.noteModel queryWithNote];
    [self.tableView reloadData];
}

-(void)rightBtnClick{
    AddNoteViewController * addNoteVC = [AddNoteViewController new];
    [self.navigationController pushViewController:addNoteVC animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
       return self.noteModelLists.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }
    return 160;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        AccountAndPasswordTableViewCell * cell = getCell(AccountAndPasswordTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    NoteListTableViewCell * cell = getCell(NoteListTableViewCell);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell bind:self.noteModelLists[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        AddNoteViewController * addNoteVC = [AddNoteViewController new];
        addNoteVC.noteModel = self.noteModelLists[indexPath.row];
        [self.navigationController pushViewController:addNoteVC animated:YES];
    }else{
        
        AccountAndPswListViewController * accountAndPswListVC = [AccountAndPswListViewController new];
        [self.navigationController pushViewController:accountAndPswListVC animated:YES];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && editingStyle == UITableViewCellEditingStyleDelete){
        NoteModel * tempModel = self.noteModelLists[indexPath.row];
        [tempModel deleteNote:tempModel.ids];
        [self.noteModelLists removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1){
        return @"删除";
    }
    return @"";
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1){
        return YES;
    }
    return NO;
}

@end

