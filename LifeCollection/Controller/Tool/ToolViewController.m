//
//  ToolViewController.m
//  LifeCollection
//
//  Created by gozap on 2019/3/11.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "ToolViewController.h"
#import "ToolCollectionViewCell.h"

@interface ToolViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView * collectionView;

@property(nonatomic,strong)NSArray * titleArray;
@end

@implementation ToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [LCColor backgroudColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UILabel * liftLabel = [UILabel new];
    liftLabel.text = @"生活";
    liftLabel.font = LCFont(23);
    liftLabel.textColor = [LCColor LCColor_77_92_127];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:liftLabel];
    
    _titleArray = @[@"指南针",@"手电筒",@"量角器",@"水平仪",@"噪音",@"网速",@"矫正",@"直尺"];
    
    [self createCollectionView];
}

- (void)createCollectionView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:fl];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [LCColor backgroudColor];
    [self.view addSubview: _collectionView];
    //布局
    fl.minimumInteritemSpacing = 0;
    fl.minimumLineSpacing = 0;
    
    [_collectionView registerClass:[ToolCollectionViewCell class] forCellWithReuseIdentifier:@"ToolCollectionViewCell"];
    [_collectionView registerClass:[ToolHeaderCollectionViewCell class] forCellWithReuseIdentifier:@"ToolHeaderCollectionViewCell"];
    
}

#pragma mark -- dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ToolHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ToolHeaderCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }
    ToolCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ToolCollectionViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    return cell;
}

//item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake((ScreenWidth - 16) , 200);
    }
    return CGSizeMake((ScreenWidth - 16) / 2.0 , 100);

}

//调节item边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 8, 0, 8);
    
}

#pragma mark -- item点击跳转

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

}






@end
