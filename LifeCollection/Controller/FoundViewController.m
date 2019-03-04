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

//-(void)viewWillAppear:(BOOL)animated{
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        self.tableView.estimatedRowHeight = 0;
//        self.tableView.estimatedSectionFooterHeight = 0;
//        self.tableView.estimatedSectionHeaderHeight = 0;
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [LCColor backgroudColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UILabel * liftLabel = [UILabel new];
    liftLabel.text = @"发现";
    liftLabel.font = LCFont(23);
    liftLabel.textColor = [LCColor LCColor_77_92_127];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:liftLabel];
    
    UILabel * rightLabel = [UILabel new];
    rightLabel.text = [self getCurrentDate];
    rightLabel.font = LCFont(15);
    rightLabel.textColor = [LCColor LCColor_77_92_127];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightLabel];
    
    _tableView = [UITableView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [LCColor backgroudColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    if (@available(iOS 11.0, *)) {
        self.tableView.estimatedRowHeight = 0;
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
    webViewVC.titleStr = @"专题";
    //图片
    //https://gank.io/api/data/福利/10/10
    
    //http://v3.wufazhuce.com:8000/api/channel/one/0/0?platform=ios&sign=98f5fb5f92c35e49cf6a93fed22c4885&user_id=&uuid=B1A45930-C3D8-453A-81C9-9782150CA634&version=v4.6.1
    //2019-01-01
    kWeakSelf;
    NSString * url = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/topic/htmlcontent/%@?source_id=%@",mdeol.content_id,mdeol.id];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary * dic = responseObject[@"data"];
        webViewVC.urlStr = dic[@"web_url"];
        webViewVC.htmlStr = dic[@"html_content"];
        webViewVC.bg_color = dic[@"bg_color"];
        [weakSelf.navigationController pushViewController:webViewVC animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

-(NSString *)getCurrentDate{
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dateComponent = [[NSCalendar currentCalendar] components:unitFlags fromDate:[NSDate date]];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    NSString * currentDate = [NSString stringWithFormat:@"%ld年%.2ld月%.2ld日",year,month,day];
    return currentDate;
}
@end

