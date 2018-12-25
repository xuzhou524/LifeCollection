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

@interface FoundViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSString * _last_id;
}
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
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-(Height_TabBar));
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [LCColor backgroudColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    
    regClass(self.tableView, FoundTableViewCell);
    kWeakSelf;
    self.tableView.mj_header = [LCRefresh lcRefreshHeader:^{
        [weakSelf refreshRequestData];
    }];
    
    self.tableView.mj_footer = [LCRefresh lcRefreshFooter:^{
        [weakSelf lastRequestData];
    }];
    
    [self refreshRequestData];
}

-(void)refreshRequestData{
    _last_id = @"0";
    [self requestData];
}

-(void)lastRequestData{
    if (self.foundListArray.count <= 0) {
        [self refreshRequestData];
        return;
    }
    FoundListModel * model = self.foundListArray.lastObject;
    _last_id = model.id;
    kWeakSelf;
    NSString * url = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/banner/list/4?last_id=%@",_last_id];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf.foundListArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[FoundListModel class] json:responseObject[@"data"]]];
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
    }];
}

-(void)requestData{
    kWeakSelf;
    NSString * url = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/banner/list/4?last_id=%@",_last_id];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.foundListArray = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[FoundListModel class] json:responseObject[@"data"]]];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
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

    kWeakSelf;
    NSString * url = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/topic/htmlcontent/%@?source_id=%@",mdeol.content_id,mdeol.id];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary * dic = responseObject[@"data"];
        webViewVC.urlStr = dic[@"web_url"];
        webViewVC.htmlStr = dic[@"html_content"];
        [weakSelf.navigationController pushViewController:webViewVC animated:YES];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

@end

