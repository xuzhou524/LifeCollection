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

@interface AddNoteViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NoteListTableViewCell * noteListCell;
@property(nonatomic,strong)AddNoteTableViewCell * addNoteViewCell;

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
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backupgroupTap:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGestureRecognizer]; //只需要点击非文字输入区域就会响应
    [tapGestureRecognizer setCancelsTouchesInView:NO];
}

- (void)backupgroupTap:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

-(NoteModel *)noteModel{
    if (_noteModel == nil){
        _noteModel = [NoteModel new];
    }
    return _noteModel;
}

-(void)rightBtnClick{
    if (_addNoteViewCell.contentTextView.text.length <= 0) {
        return;
    }
    self.noteModel.content = _addNoteViewCell.contentTextView.text;
    if (self.noteModel.ids > 0) {
        //编辑状态  更新数据
        [self.noteModel updataNote:self.noteModel];
    }else{
        self.noteModel.time = [DateFormatter stringFromBirthday:[NSDate new]];
        [self.noteModel insertNote:self.noteModel];
    }
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
        return 175;
    }else if (indexPath.row == 2 || indexPath.row == 3 ||indexPath.row == 4 ||indexPath.row == 5){
        return 300;
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
        _noteListCell = getCell(NoteListTableViewCell);
        _noteListCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return _noteListCell;
    }else if (indexPath.row == 2){
        _addNoteViewCell = getCell(AddNoteTableViewCell);
        _addNoteViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _addNoteViewCell.contentTextView.delegate = self;
        [_addNoteViewCell.coverImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(converTapClick)]];
        return _addNoteViewCell;
    }
    return nil;
}

-(void)converTapClick{
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    [imagePicker.navigationBar  setBackgroundImage:[LCColor createImageWithColor:[LCColor whiteColor]] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    [imagePicker.navigationBar setTitleTextAttributes:@{
                                                        NSFontAttributeName:LCFont2(18) ,
                                                        NSForegroundColorAttributeName: [LCColor LCColor_77_92_127]
                                                        }];
    imagePicker.navigationBar.tintColor=[LCColor LCColor_77_92_127];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.allowsEditing = NO;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    //获取照片的原图
    UIImage *original = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self compressionUploadingImage:original];
}
-(void)compressionUploadingImage:(UIImage *)image{
    NSLog(@"%@",image);
    _addNoteViewCell.coverImageView.image = image;
    _noteListCell.coverImageView.image = image;
    
    NSData * imageData = UIImagePNGRepresentation(image);
    self.noteModel.coverImageData = [imageData base64EncodedStringWithOptions:0];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"写下你的描述"]) {
        textView.text = @"";
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]){
        textView.text = @"写下你的描述";
    }
}

-(void)textViewDidChange:(UITextView *)textView{
    _noteListCell.contentLabel.text = textView.text;
}

@end
