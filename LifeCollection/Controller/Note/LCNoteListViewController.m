//
//  LCNoteListViewController.m
//  LifeCollection
//
//  Created by gozap on 2019/4/30.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "LCNoteListViewController.h"
#import "LMNote.h"
#import "NoteListTableViewCell.h"
@interface LCNoteListViewController ()

@property (nonatomic, strong, readwrite) LMNFolder *folder;

@end

@implementation LCNoteListViewController

- (instancetype)init
{
    return [self initWithFolder:nil];
}

- (instancetype)initWithFolder:(LMNFolder *)folder
{
    self = [super init];
    if (self) {
        self.folder = folder ?: [LMNStore shared].rootFolder;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [LCColor backgroudColor];
    self.tableView.backgroundColor = [LCColor backgroudColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storeChanged:) name:LMNStoreDidChangedNotification object:nil];
}

- (void)rightBtnClick{
    LMNDraft *draft = [[LMNDraft alloc] initWithUUID:[NSUUID UUID] name:@"" date:[NSDate date]];
    draft.parent = self.folder;
    LMNoteViewController *vc = [[LMNoteViewController alloc] initWithDraft:draft];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)storeChanged:(NSNotification *)notification{
    [[LMNStore shared] reload];
    self.folder = [LMNStore shared].rootFolder;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.folder.contents.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LMNItem *item = self.folder.contents[indexPath.row];
    NoteListTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"NoteListTableViewCell"];
    if (!cell) {
        cell = [[NoteListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoteListTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell bindLMNote:item];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LMNItem *item = self.folder.contents[indexPath.row];
    LMNoteViewController *vc = [[LMNoteViewController alloc] initWithDraft:(LMNDraft *)item];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        LMNItem *item  = self.folder.contents[indexPath.row];
        [self.folder remove:item];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

@end
