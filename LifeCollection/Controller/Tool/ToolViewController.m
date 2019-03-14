//
//  ToolViewController.m
//  LifeCollection
//
//  Created by gozap on 2019/3/11.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "ToolViewController.h"
#import "ToolCollectionViewCell.h"

#import "LCProtractorViewController.h"
#import "LCLevelViewController.h"
#import "LCNoiseViewController.h"
#import "LCCorrectViewController.h"
#import "LCRuleViewController.h"


@interface ToolViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)NSArray *imageArr;
@property(nonatomic,strong)NSArray * titleArray;
@end

@implementation ToolViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [LCColor backgroudColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UILabel * liftLabel = [UILabel new];
    liftLabel.text = @"生活";
    liftLabel.font = LCFont(23);
    liftLabel.textColor = [LCColor LCColor_77_92_127];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:liftLabel];
    
    _titleArray = @[@"量角器",@"水平仪",@"噪音",@"矫正",@"直尺"];
    _imageArr = @[@"liangjiaoqi",@"shuipingyi",@"zaoyin",@"jiaozheng",@"chizi"];
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
    cell.iconImageView.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
    NSString * imageStr = LCEventBackgroundImage(indexPath.row);
    cell.bgImageView.image = [UIImage imageNamed:imageStr];
    return cell;
}

//item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake((ScreenWidth - 16) , 220);
    }
    return CGSizeMake((ScreenWidth - 16) / 2.0 , 80);
}

//调节item边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 8, 0, 8);
}

#pragma mark -- item点击跳转

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            LCProtractorViewController *VC = [[LCProtractorViewController alloc] init];
            self.navigationController.navigationBarHidden = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }else if(indexPath.row == 1){
            LCLevelViewController *VC = [[LCLevelViewController alloc] init];
            self.navigationController.navigationBarHidden = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }else if(indexPath.row == 2){
            LCNoiseViewController *VC = [[LCNoiseViewController alloc] init];
            self.navigationController.navigationBarHidden = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }else if(indexPath.row == 3){
            LCCorrectViewController *VC = [[LCCorrectViewController alloc] init];
            self.navigationController.navigationBarHidden = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }else if(indexPath.row == 4){
            LCRuleViewController *VC = [[LCRuleViewController alloc] init];
            self.navigationController.navigationBarHidden = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }

}

@end
