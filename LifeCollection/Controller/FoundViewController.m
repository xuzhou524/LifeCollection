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
    NSString * url = @"https://api.tuchong.com/feed-app?os_api=22&device_type=MI&device_platform=android&ssmix=a&manifest_version_code=232&dpi=400&abflag=0&uuid=651384659521356&version_code=232&app_name=tuchong&version_name=2.3.2&openudid=65143269dafd1f3a5&resolution=1280*1000&os_version=5.8.1&ac=wifi&aid=0&page=1&type=refresh";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.foundListArray = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[FoundListModel class] json:responseObject[@"feedList"]]];
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
    
    return 135;
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
    webViewVC.urlStr = mdeol.url;
    [self.navigationController pushViewController:webViewVC animated:YES];
}

@end

