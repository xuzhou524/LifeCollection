//
//  LCRuleViewController.m
//  LifeCollection
//
//  Created by gozap on 2019/3/12.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "LCRuleViewController.h"

#import "LCRulesLineView.h"

@interface LCRuleViewController ()

@property (nonatomic, strong) LCRulesLineView *lineView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation LCRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)buttonClick
{
    [_lineView removeFromSuperview];
    [_button removeFromSuperview];
    UIWindow *application = [UIApplication sharedApplication].keyWindow;
    application.windowLevel = 0.0;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIWindow *application = [UIApplication sharedApplication].keyWindow;
    application.windowLevel = UIWindowLevelAlert;
    LCRulesLineView *lineView = [[LCRulesLineView alloc] initWithFrame:application.bounds];
    [application addSubview:lineView];
    _lineView = lineView;
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.tintColor = [UIColor whiteColor];
    button.frame = CGRectMake(ScreenWidth-100, 35, 37, 37);
    [button setImage:[UIImage imageNamed:@"tool_fanhui"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [application addSubview:button];
    _button = button;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
