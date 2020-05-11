//
//  TimeDetailViewController.m
//  LifeCollection
//
//  Created by gozap on 2020/5/11.
//  Copyright © 2020 com.longdai. All rights reserved.
//

#import "TimeDetailViewController.h"
#import "TimeListTableViewCell.h"

@interface TimeDetailViewController ()
@property(nonatomic,strong)LDNavigationTapView *topView;
@end

@implementation TimeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [LCColor backgroudColor];
    self.fd_prefersNavigationBarHidden = YES;
    
    [self subEnoughViews];
    [self subViews];
}

-(void)liftNavigationClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)subEnoughViews{
    UIImageView * backgroundImageView = [UIImageView new];
    NSString * imageStr = LCEventBackgroundImage([self.eventModel.colorType integerValue]);
    backgroundImageView.image = [UIImage imageNamed:imageStr];
    [self.view addSubview:backgroundImageView];
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    //模糊的效果
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    visualEffectView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    visualEffectView.alpha = 0.6;
    [backgroundImageView addSubview:visualEffectView];
    
    [self.view addSubview:self.topView];
    
}

-(void)subViews{
    UIView * bgView = [UIView new];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 8;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-((ScreenWidth - 60) * 0.26));
        make.width.equalTo(@(ScreenWidth - 60));
        make.height.equalTo(@((ScreenWidth - 60) * 0.55));
    }];
    
    TimeListTableView* timeView = [TimeListTableView new];
    timeView.bgView.backgroundColor = [UIColor clearColor];
    [bgView addSubview:timeView];
    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(bgView);
    }];
    [timeView bind:self.eventModel];
}

- (UIView *)topView{
    if (_topView == nil) {
        _topView = [[LDNavigationTapView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
        if(LCiPhoneX){
            _topView.frame = CGRectMake(0, 0, ScreenWidth, 64 + 22);
        }
        _topView.titleLabel.text = @"";
        _topView.leftImageView.image = [[UIImage imageNamed:@"d_Arrow_left"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _topView.leftImageView.tintColor = [UIColor whiteColor];
        [_topView.tapLeftView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(liftNavigationClick)]];
    }
    return _topView;
}
@end


@implementation LDNavigationTapView
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
    _bgView.backgroundColor = [UIColor clearColor];
    _bgView.userInteractionEnabled = YES;
    [self addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = LCFont2(18);
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
    _tapLeftView.backgroundColor = [UIColor clearColor];
    [self addSubview:_tapLeftView];
    [_tapLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageView).offset(-10);
        make.right.equalTo(_leftImageView).offset(60);
        make.bottom.equalTo(_leftImageView).offset(10);
        make.top.equalTo(_leftImageView).offset(-10);
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

