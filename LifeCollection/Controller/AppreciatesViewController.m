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
@property(nonatomic,strong)UILabel * titleLabel;
@end

@implementation AppreciatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"赞赏开发者";
    self.view.backgroundColor = [LCColor backgroudColor];
    
    _iconImageView = [UIImageView new];
    _iconImageView.image = [UIImage imageNamed:@"WechatIMG16.jpeg"];
    [self.view addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-150);
        make.width.equalTo(@250);
        make.height.equalTo(@240);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = LCFont(15);
    _titleLabel.text = @"乞求赞赏";
    _titleLabel.textColor = [LCColor LCColor_77_92_127];
    [self.view addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(20);
    }];
}

@end
