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
#import "LCCorrectViewController.h"
#import "LCRuleViewController.h"


@interface ToolViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)NSArray *imageArr;
@property (nonatomic,strong)NSArray *BgColorArr;
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
    self.navigationItem.title = @"日常工具";
    
    _titleArray = @[@"量角器",@"水平仪",@"矫正",@"直尺"];
    _imageArr = @[@"liangjiaoqi",@"shuipingyi",@"zaoyin",@"jiaozheng",@"chizi"];
    _BgColorArr = @[[LCColor colorWithHexString:@"#CC99F0"],
                   [LCColor colorWithHexString:@"#81BE8D"],
                   [LCColor colorWithHexString:@"#EF7D6C"],
                   [LCColor colorWithHexString:@"#65C0F5"],
                   [LCColor colorWithHexString:@"#FFC05D"],
                   [LCColor colorWithHexString:@"#FEA5A4"]];
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
    
}

#pragma mark -- dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ToolCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ToolCollectionViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
    cell.bgImageView.backgroundColor = self.BgColorArr[indexPath.row];
    return cell;
}

//item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ScreenWidth - 16) / 2.0 , 100);
}

//调节item边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 8, 0, 8);
}

#pragma mark -- item点击跳转

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LCProtractorViewController *VC = [[LCProtractorViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }else if(indexPath.row == 1){
            LCLevelViewController *VC = [[LCLevelViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }else if(indexPath.row == 2){
            LCCorrectViewController *VC = [[LCCorrectViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }else if(indexPath.row == 3){
            LCRuleViewController *VC = [[LCRuleViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
}

@end
