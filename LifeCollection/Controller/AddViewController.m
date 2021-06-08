//
//  AddViewController.m
//  LifeCollection
//
//  Created by gozap on 2018/12/17.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import "AddViewController.h"
#import "PreviewTableViewCell.h"
#import "TextFieldTableViewCell.h"
#import "TitleTableViewCell.h"
#import "SelectColorTableViewCell.h"
#import "TimeListTableViewCell.h"

#import "LCDatePickerWindow.h"
#import "DoActionSheet.h"

@interface AddViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)TimeListTableViewCell * timeCell ;
@property(nonatomic,strong)TextFieldTableViewCell * textFieldCell;

@property (nonatomic, strong) LCDatePickerWindow * pickerWindow;


@property (nonatomic, strong) NSString * originalDate;

@property (nonatomic, strong) NSString * selectColorTypeStr;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加";
    self.view.backgroundColor = [LCColor backgroudColor];
    if (_eventModel) {
        self.navigationItem.title = @"编辑";
    }
    
    //初始化默认值
    if (!_eventModel) {
        self.eventModel.classType = @"倒计日";
        self.eventModel.remindType = @"无循环";
        int x = arc4random() % 7;
        self.eventModel.colorType = [NSString stringWithFormat:@"%d",x];
        self.eventModel.tag = @"生日";
        self.eventModel.time = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    }

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
    regClass(self.tableView, TitleAndImageTableViewCell);
    regClass(self.tableView, SelectColorTableViewCell);
    regClass(self.tableView, TimeListTableViewCell);
    
    UIButton * rightBtn = [UIButton new];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = LCFont(17);
    [rightBtn setTitleColor:[LCColor LCColor_121_117_245] forState:UIControlStateNormal];
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
        [_pickerWindow.enterButton addTarget:self action:@selector(enterClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pickerWindow;
}

-(void)rightBtnClick{
    if (_textFieldCell.titleTextField.text.length <= 0) {
        return;
    }
    self.eventModel.title = _textFieldCell.titleTextField.text;
    if (self.eventModel.ids > 0) {
        //编辑状态  更新数据
        [self.eventModel updataTime:self.eventModel];
    }else{
        [self.eventModel insertTime:self.eventModel];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];

}

-(void)enterClick{
    NSString * str = [DateFormatter stringFromBirthday:_pickerWindow.datePicker.date];
    self.eventModel.time = [NSString stringWithFormat:@"%ld", (long)[[DateFormatter dateFromString:str] timeIntervalSince1970]];
    [self.tableView reloadData];
    [_pickerWindow hide];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 0;
    }else if (indexPath.row == 1){
        return 0;
    }else if (indexPath.row == 2 || indexPath.row == 3 ||indexPath.row == 4 ||indexPath.row == 5||indexPath.row == 6){
        return 74;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        PreviewTableViewCell * previewCell = getCell(PreviewTableViewCell);
        previewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return previewCell;
    }else if (indexPath.row == 1){
        _timeCell = getCell(TimeListTableViewCell);
        _timeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [_timeCell bind:self.eventModel];
        return _timeCell;
    }else if (indexPath.row == 2){
        _textFieldCell = getCell(TextFieldTableViewCell);
        _textFieldCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _textFieldCell.titleLabel.text = @"标题";
        _textFieldCell.titleTextField.delegate = self;
        _textFieldCell.titleTextField.text = self.eventModel.title;
        return _textFieldCell;
    }else if (indexPath.row == 3){
        TitleAndImageTableViewCell * cell = getCell(TitleAndImageTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.iconImageView.image = [UIImage imageNamed:@"shijian"];
        cell.titleLabel.text = @"时间";
        if (_timeCell.timeLabel.text && _timeCell.timeLabel.text.length > 0) {
            cell.summeryLabel.text = _timeCell.timeLabel.text;
        }else{
            cell.summeryLabel.text = [DateFormatter stringFromBirthday:[DateFormatter dateFromTimeStampString:self.eventModel.time]];
        }
        return cell;
    }else if (indexPath.row == 4){
        TitleAndImageTableViewCell * cell = getCell(TitleAndImageTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.iconImageView.image = [UIImage imageNamed:@"leixing"];
        cell.titleLabel.text = @"类型";
        cell.summeryLabel.text = self.eventModel.classType;
        return cell;
    }else if (indexPath.row == 5){
        TitleAndImageTableViewCell * cell = getCell(TitleAndImageTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.iconImageView.image = [UIImage imageNamed:@"tixing"];
        cell.titleLabel.text = @"循环";
        cell.summeryLabel.text = self.eventModel.remindType;
        return cell;
    }else if (indexPath.row == 6){
        TitleAndImageTableViewCell * cell = getCell(TitleAndImageTableViewCell);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.iconImageView.image = [UIImage imageNamed:@"tixing"];
        cell.titleLabel.text = @"标签";
        cell.summeryLabel.text = self.eventModel.tag;
        return cell;
    }
    return [UITableViewCell new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3){
        [self.pickerWindow show];
    }else if (indexPath.row == 4){
        [self classTypeDoActionSheetShow];
    }else if (indexPath.row == 5){
        [self remindDoActionSheetShow];
    }else if (indexPath.row == 6){
        [self tagTypeDoActionSheetShow];
    }
}

- ( void )textFieldDidEndEditing:( UITextField *)textField{
    if (textField.text.length > 0) {
        _timeCell.titleLabel.text = textField.text;
        self.eventModel.title = textField.text;
    }
}

-(void)remindDoActionSheetShow{
    kWeakSelf;
    DoActionSheet *remindActionSheet = [DoActionSheet new];
    [remindActionSheet showC:@"循环"
                 cancel:@"取消"
                buttons:LCRemindTypeArray
                 result:^(int nResult) {
                     if (nResult < LCRemindTypeArray.count) {
                         weakSelf.eventModel.remindType = LCRemindType(nResult);
                         [weakSelf.tableView reloadData];
                     }
                 }
     ];
}

-(void)classTypeDoActionSheetShow{
    kWeakSelf;
    DoActionSheet *classTypeActionSheet = [DoActionSheet new];
    [classTypeActionSheet showC:@"类型"
                 cancel:@"取消"
                buttons:LCClassTypeArray
                 result:^(int nResult) {
                     if (nResult < LCClassTypeArray.count) {
                         weakSelf.eventModel.classType = LCClassType(nResult);
                         [weakSelf.tableView reloadData];
                     }
                 }
     ];
}

-(void)tagTypeDoActionSheetShow{
    kWeakSelf;
    DoActionSheet *tagTypeActionSheet = [DoActionSheet new];
    [tagTypeActionSheet showC:@"标签"
                 cancel:@"取消"
                buttons:LCTagTypeArray
                 result:^(int nResult) {
                     if (nResult < LCTagTypeArray.count) {
                         weakSelf.eventModel.tag = LCTagType(nResult);
                         [weakSelf.tableView reloadData];
                     }
                 }
     ];
}
@end
