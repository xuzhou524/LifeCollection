//
//  AppreciatesViewController.m
//  LifeCollection
//
//  Created by gozap on 2018/12/25.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "AppreciatesViewController.h"

@interface AppreciatesViewController ()
@property(nonatomic,strong)UIImageView * iconImageView;
@property(nonatomic,strong)UILabel * summeryLabel;
@end

@implementation AppreciatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"赞赏开发者";
    self.view.backgroundColor = [LCColor backgroudColor];
    
    _iconImageView = [UIImageView new];
    _iconImageView.image = [UIImage imageNamed:@"WechatIMG1.jpeg"];
    [self.view addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-150);
        make.width.equalTo(@250);
        make.height.equalTo(@240);
    }];
    _iconImageView.userInteractionEnabled = YES;
    [_iconImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(saoyisaoImageView)]];
    
    _summeryLabel = [UILabel new];
    _summeryLabel.font = LCFont(18);
    _summeryLabel.text = @"点击二维码即可赞赏";
    _summeryLabel.textColor = [LCColor LCColor_77_92_127];
    [self.view addSubview:_summeryLabel];
    [_summeryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(25);
    }];
}

-(void)saoyisaoImageView{
    NSString *str = @"alipayqr://platformapi/startapp?saId=10000007&qrcode=https://qr.alipay.com/fkx01590ythcty3atyusi88?t=1545729953985";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

@end
