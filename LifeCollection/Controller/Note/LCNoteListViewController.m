//
//  LCNoteListViewController.m
//  LifeCollection
//
//  Created by gozap on 2019/4/30.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "LCNoteListViewController.h"
#import "LMNote.h"

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
    self.view.backgroundColor = [UIColor whiteColor];
    
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

- (void)storeChanged:(NSNotification *)notification
{
    [[LMNStore shared] reload];
    self.folder = [LMNStore shared].rootFolder;
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.folder.contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LMNItem *item = self.folder.contents[indexPath.row];
    UITableViewCell *cell;
    if ([item isKindOfClass:[LMNFolder class]]) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = item.name;
    }
    else if ([item isKindOfClass:[LMNDraft class]]) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.textLabel.text = item.name;
        cell.detailTextLabel.text = item.date.description;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMNItem *item = self.folder.contents[indexPath.row];
    if ([item isKindOfClass:[LMNFolder class]]) {
//        FolderViewController *vc = [[FolderViewController alloc] initWithFolder:(LMNFolder *)item];
//        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([item isKindOfClass:[LMNDraft class]]) {
        LMNoteViewController *vc = [[LMNoteViewController alloc] initWithDraft:(LMNDraft *)item];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
