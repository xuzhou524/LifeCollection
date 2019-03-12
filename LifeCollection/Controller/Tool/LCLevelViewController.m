//
//  LCLevelViewController.m
//  LifeCollection
//
//  Created by gozap on 2019/3/12.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "LCLevelViewController.h"

#import "LCCompassManage.h"

@interface LCLevelViewController ()

@property (nonatomic, strong) UIImageView *levelImg;
@property (nonatomic, strong) LCCompassManage *manager;
@property (nonatomic, assign) CGPoint point;

@property (nonatomic, strong) UILabel *labelX;
@property (nonatomic, strong) UILabel *labelY;

@end

@implementation LCLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.tintColor = [UIColor whiteColor];
    button.frame = CGRectMake(15, 35, 37, 37);
    [button setImage:[UIImage imageNamed:@"tool_fanhui_left"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    _point = CGPointMake(self.view.center.x, self.view.center.y-50);
    
    UIImageView *backImg =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spy-bg"]];
    backImg.center = _point;
    [self.view addSubview:backImg];
    
    _levelImg =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spy"]];
    _levelImg.center = _point;
    [self.view addSubview:_levelImg];
    
    _labelX = [[UILabel alloc] initWithFrame:CGRectMake(0, backImg.frame.origin.y + backImg.frame.size.height+30, [UIScreen mainScreen].bounds.size.width/2, 30)];
    _labelX.font = [UIFont systemFontOfSize:16];
    _labelX.textAlignment = NSTextAlignmentCenter;
    _labelX.textColor = [UIColor whiteColor];
    [self.view addSubview:_labelX];
    
    _labelY = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, backImg.frame.origin.y + backImg.frame.size.height+30, [UIScreen mainScreen].bounds.size.width/2, 30)];
    _labelY.font = [UIFont systemFontOfSize:16];
    _labelY.textAlignment = NSTextAlignmentCenter;
    _labelY.textColor = [UIColor whiteColor];
    [self.view addSubview:_labelY];
    
    [self startSensor];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_manager stopSensor];
}

/**
 *  启动传感器
 */
- (void)startSensor
{
    __weak typeof(self)mySelf = self;
    _manager = [LCCompassManage shared];
    _manager.updateDeviceMotionBlock = ^(CMDeviceMotion *data){
        
        mySelf.levelImg.center = CGPointMake(mySelf.point.x + data.gravity.x*100, mySelf.point.y + data.gravity.y*100);
        mySelf.labelX.text = [NSString stringWithFormat:@"X: %.2f",data.gravity.x*100];
        mySelf.labelY.text = [NSString stringWithFormat:@"Y: %.2f",data.gravity.y*100];
    };
    [_manager startSensor];
    [_manager startGyroscope];
}

- (void)buttonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

