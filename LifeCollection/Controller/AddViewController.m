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
#import "SelectColorTableViewCell.h"
#import "EventModel.h"

#import "LCDatePickerWindow.h"
#import "DoActionSheet.h"

@interface AddViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)PreviewTableViewCell * previewcell;

@property (nonatomic, strong) LCDatePickerWindow * pickerWindow;

@property (nonatomic, strong) EventModel * eventModel;
@property (nonatomic, strong) NSString * originalDate;

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
    regClass(self.tableView, SelectColorTableViewCell);
    
    UIButton * rightBtn = [UIButton new];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = LCFont(16);
    [rightBtn setTitleColor:[LCColor LCColor_77_92_127] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backupgroupTap:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGestureRecognizer]; //只需要点击非文字输入区域就会响应
    [tapGestureRecognizer setCancelsTouchesInView:NO];
    
}

- (void)backupgroupTap:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

-(EventModel *)eventModel{
    if (_eventModel == nil){
        _eventModel = [EventModel new];
    }
    return _eventModel;
}

- (LCDatePickerWindow *)pickerWindow {
    if (!_pickerWindow) {
        _pickerWindow = [LCDatePickerWindow new];
        [_pickerWindow.cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [_pickerWindow.enterButton addTarget:self action:@selector(enterClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pickerWindow;
}

-(void)rightBtnClick{
    
}

-(void)cancelClick{
    
}

-(void)enterClick{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 160;
    }else if (indexPath.row == 1 || indexPath.row == 2 ||indexPath.row == 3 ||indexPath.row == 4){
        return 60;
    }else if (indexPath.row == 5){
        return 70;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        _previewcell = getCell(PreviewTableViewCell);
        _previewcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return _previewcell;
    }else if (indexPath.row == 1){
        TextFieldTableViewCell * cell = getCell(TextFieldTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"标题";
        return cell;
    }else if (indexPath.row == 2){
        TitleTableViewCell * cell = getCell(TitleTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"时间";
        cell.summeryLabel.text = @"2018-12-18";
        return cell;
    }else if (indexPath.row == 3){
        TitleTableViewCell * cell = getCell(TitleTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"类型";
        cell.summeryLabel.text = @"倒计日";
        return cell;
    }else if (indexPath.row == 4){
        TitleTableViewCell * cell = getCell(TitleTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"提醒";
        cell.summeryLabel.text = @"无提醒";
        return cell;
    }else if (indexPath.row == 5){
        SelectColorTableViewCell * cell = getCell(SelectColorTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (int i=0; i < cell.selectColorArray.count; i ++) {
            UIView * tempView = cell.selectColorArray[i];
            tempView.tag = i + 100;
            [tempView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectColorClick:)]];
        }
        return cell;
    }
    return [UITableViewCell new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2){
        [self.pickerWindow show];
    }else if (indexPath.row == 3){
        [self doActionSheetShow];
    }
}

-(void)selectColorClick:(UITapGestureRecognizer *)tap{
    _previewcell.bgView.backgroundColor = LCEventBackgroundColor(tap.view.tag - 100);
}

-(void)doActionSheetShow{
    DoActionSheet *vActionSheet = [[DoActionSheet alloc] init];
    
    vActionSheet.doButtonColor = DO_RGB(52, 152, 219);
    vActionSheet.doCancelColor = DO_RGB(231, 76, 60);
    
    
    vActionSheet.doTitleFont = LCFont(15);
    vActionSheet.doButtonFont = LCFont(15);
    vActionSheet.doCancelFont = LCFont(15);
    
    vActionSheet.doButtonHeight = 45.0f;
    
    vActionSheet.dRound = 5;
    vActionSheet.dButtonRound = 2;
    
    [vActionSheet showC:@"提醒循环"
                 cancel:@"取消"
                buttons:@[@"无提醒", @"按月循环", @"按年循环"]
                 result:^(int nResult) {
                     NSLog(@"---------------> result : %d", nResult);
                 }
     ];

}

@end
