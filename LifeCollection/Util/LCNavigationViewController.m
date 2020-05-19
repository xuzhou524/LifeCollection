//
//  LCNavigationViewController.m
//  LittleSesame
//
//  Created by xuzhou on 2018/7/11.
//  Copyright © 2018年 chenyk. All rights reserved.
//

#import "LCNavigationViewController.h"

@interface LCNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation LCNavigationViewController

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.navigationBar setBackgroundImage:[LCColor createImageWithColor:[LCColor backgroudColor]]
                             forBarMetrics:UIBarMetricsDefault];
    //navigationBar Title 样式
    [self.navigationBar setTitleTextAttributes:@{
                                                 NSFontAttributeName : LCFont(18),
                                                 NSForegroundColorAttributeName : [LCColor LCColor_77_92_127]
                                                 }];
    [self.navigationBar setShadowImage:[LCColor createImageWithColor:[LCColor backgroudColor]]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1 ) {
        return NO;
    }
    return YES;
}

#pragma mark 返回按钮
-(void)popself {
    UIViewController *currentVC = [self.viewControllers lastObject] ;
    if ( [currentVC respondsToSelector:@selector(popself)] ) {
        [currentVC performSelector:@selector(popself)];
    }else{
        [self popViewControllerAnimated:YES];
    }
}

#pragma mark 创建返回按钮
-(UIBarButtonItem *)createBackButton {
    UIButton *liftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    UIImage * arrowIamge = [[UIImage imageNamed:@"d_Arrow_left"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    liftBtn.tintColor = [LCColor LCColor_77_92_127];
    liftBtn.imageEdgeInsets = UIEdgeInsetsMake( 0, -5, 0, 5);
    [liftBtn setImage:arrowIamge forState:UIControlStateNormal];
    [liftBtn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * liftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:liftBtn];
    return liftButtonItem;
}

#pragma mark 重写方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断子控制器的数量
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1) {
        viewController.navigationItem.leftBarButtonItem =[self createBackButton];
    }
}

//-(void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated{
//    // 判断子控制器的数量
//    if (viewControllers.count > 1) {
//        UIViewController * lastViewController = viewControllers.lastObject;
//        lastViewController.hidesBottomBarWhenPushed = YES;
//    }
//    [super setViewControllers:viewControllers animated:animated];
//    for (UIViewController * viewController in viewControllers) {
//        if (viewController.navigationItem.leftBarButtonItem == nil) {
//            viewController.navigationItem.leftBarButtonItem =[self createBackButton];
//        }
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end


@implementation LCNavigationTapView
- (instancetype)init{
    self = [super init];
    if (self) {
        [self sebView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self sebView];
    }
    return self;
}

-(void)sebView{
    _bgView = [UIImageView new];
    _bgView.backgroundColor = [LCColor clearColor];
    _bgView.userInteractionEnabled = YES;
    [self addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [LCColor whiteColor];
    _titleLabel.font = LCFont2(17);
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-13);
    }];
    
    _leftImageView = [UIImageView new];
    _leftImageView.userInteractionEnabled = YES;
    [self addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(13);
        make.bottom.equalTo(self).offset(-13);
        make.width.height.equalTo(@20);
    }];
    
    _tapLeftView = [UIView new];
    _tapLeftView.backgroundColor = [LCColor clearColor];
    [self addSubview:_tapLeftView];
    [_tapLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView).offset(-10);
        make.right.equalTo(self.leftImageView).offset(60);
        make.bottom.equalTo(self.leftImageView).offset(10);
        make.top.equalTo(self.leftImageView).offset(-10);
    }];
    
    _rightImageView = [UIImageView new];
    _rightImageView.userInteractionEnabled = YES;
    [self addSubview:_rightImageView];
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-13);
        make.width.height.equalTo(@20);
    }];
}
@end
