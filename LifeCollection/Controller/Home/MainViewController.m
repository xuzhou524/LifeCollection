//
//  MainViewController.m
//  LifeCollection
//
//  Created by gozap on 2021/6/7.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import "MainViewController.h"
#import "HomeListCollectionViewCell.h"
#import "AddViewController.h"

@interface MainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView * collectionView;

@property (nonatomic, strong) NSMutableArray * eventModelLists;
@property (nonatomic, strong) EventModel * eventModel;

@end

@implementation MainViewController

-(EventModel *)eventModel{
    if (_eventModel == nil){
        _eventModel = [EventModel new];
    }
    return _eventModel;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.eventModelLists = [self.eventModel queryWithTime];
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.xuzhou.LifeCollection"];
    
    EventModel * eventModel = self.eventModelLists.firstObject;
    
    NSMutableDictionary * dic = [NSMutableDictionary new];
    [dic setObject:eventModel.title forKey:@"title"];
    [dic setValue:eventModel.content forKey:@"content"];
    [dic setObject:eventModel.time forKey:@"time"];
    [dic setObject:eventModel.classType forKey:@"classType"];
    [dic setObject:eventModel.tag forKey:@"tag"];
    [dic setObject:eventModel.remindType forKey:@"remindType"];
    [dic setObject:eventModel.colorType forKey:@"colorType"];

    [userDefaults setObject:dic forKey:@"widget"];
    
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [LCColor backgroudColor];

    UILabel * liftLabel = [UILabel new];
    liftLabel.text = @"记点生活";
    liftLabel.font = LCFont(20);
    liftLabel.textColor = [LCColor LCColor_235_235_235];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:liftLabel];
    
    UIButton * rightBtn = [UIButton new];
    UIImage * addIamge = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    rightBtn.tintColor = [LCColor LCColor_77_92_127];
    [rightBtn setImage:addIamge forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];

    [self createCollectionView];
}

- (void)createCollectionView{
    
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:fl];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [LCColor backgroudColor];
    [self.view addSubview: _collectionView];
    //布局
    fl.minimumInteritemSpacing = 0;
    fl.minimumLineSpacing = 0;
    
    [_collectionView registerClass:[HomeListCollectionViewCell class] forCellWithReuseIdentifier:@"HomeListCollectionViewCell"];
    
}

-(void)rightBtnClick{
    AddViewController * addVC = [AddViewController new];
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark -- dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.eventModelLists.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeListCollectionViewCell" forIndexPath:indexPath];
    [cell bind:self.eventModelLists[indexPath.row]];
    return cell;
}

//item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ScreenWidth - 16) / 2.0 , (ScreenWidth - 16) / 2.0);
}

//调节item边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 8, 0, 8);
}

@end

