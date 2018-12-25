//
//  FoundViewController.m
//  LifeCollection
//
//  Created by gozap on 2018/12/24.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "FoundViewController.h"
#import "FoundTableViewCell.h"
#import "FoundListModel.h"
#import "LCWebViewViewController.h"

@interface FoundViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * foundListArray;
@end

@implementation FoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [LCColor backgroudColor];
    
    UILabel * liftLabel = [UILabel new];
    liftLabel.text = @"发现";
    liftLabel.font = LCFont(25);
    liftLabel.textColor = [LCColor LCColor_77_92_127];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:liftLabel];
    
    _tableView = [UITableView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [LCColor backgroudColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    regClass(self.tableView, FoundTableViewCell);
    
    [self requestData];
}

-(void)requestData{
    kWeakSelf;
    //https://api.tuchong.com/discover/tag_id/热门
    NSString * url = @"http://v3.wufazhuce.com:8000/api/banner/list/4?last_id=0&platform=ios&sign=c16b8933f84b87033705764be157a257&user_id=&uuid=037A90C5-EDF0-4554-A854-6704032E3BCD&version=v4.6.1";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.foundListArray = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[FoundListModel class] json:responseObject[@"data"]]];
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.foundListArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return (ScreenWidth - 20 - 20) / 1.67 + 5 + 20 + 20 + 20 + 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FoundTableViewCell * cell = getCell(FoundTableViewCell);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell bind:self.foundListArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LCWebViewViewController * webViewVC =[LCWebViewViewController new];
    FoundListModel * mdeol = self.foundListArray[indexPath.row];
    webViewVC.titleStr = mdeol.title;
    webViewVC.urlStr = mdeol.cover;
    [self.navigationController pushViewController:webViewVC animated:YES];
}

@end

