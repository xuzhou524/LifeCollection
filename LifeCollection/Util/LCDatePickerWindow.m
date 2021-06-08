//
//  LCDatePickerWindow.m
//  LifeCollection
//
//  Created by gozap on 2018/12/19.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import "LCDatePickerWindow.h"

@interface LCDatePickerWindow()
@property(nonatomic,strong)UIView * backgroundView;
@property(nonatomic,strong)UIView * backgroundMaskView;
@property(nonatomic,strong)UIView * contentView;

@property(nonatomic,strong)UIView * topCheckView;
@end

@implementation LCDatePickerWindow

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)dealloc{
    [self.backgroundView removeFromSuperview];
}

-(void)setup{
    self.hided=YES;
    self.backgroundView=[UIView new];
    [[UIApplication sharedApplication].delegate.window addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.backgroundView.superview);
    }];
    
    self.backgroundMaskView=[UIView new];
    self.backgroundMaskView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.6];
    [self.backgroundMaskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    [self.backgroundView addSubview:self.backgroundMaskView];
    [self.backgroundMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.backgroundView);
    }];
    
    self.contentView=[UIView new];
    self.contentView.clipsToBounds=YES;
    self.contentView.backgroundColor=[LCColor backgroudColor];
    [self.backgroundView addSubview:self.contentView];
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundView);
        make.width.equalTo(@0);
        make.height.equalTo(@0);
        make.centerY.equalTo(self.backgroundView);
    }];
    
    [self.backgroundView setNeedsLayout];
    [self.backgroundView layoutIfNeeded];
    
    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, ScreenHeight-256 - 88,ScreenWidth, 216)];
    _datePicker.backgroundColor = [UIColor clearColor];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    
    if (@available(iOS 14.0, *)) {
        _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
    }
    
    _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [self.contentView addSubview:_datePicker];
    [self.datePicker mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@256);
    }];
    
    UIView * sepView = [UIView new];
    sepView.backgroundColor = [LCColor LCColor_232_229_222];
    [self.contentView addSubview:sepView];
    [sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.datePicker.mas_top);
        make.height.equalTo(@10);
    }];
    
    UIView * topView = [UIView new];
    topView.backgroundColor = [LCColor clearColor];
    [self.contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.bottom.equalTo(sepView.mas_top);
    }];

    _cancelButton = [UIButton new];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor: [LCColor LCColor_77_92_127] forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = LCFont(15);
    _cancelButton.titleLabel.textColor = [LCColor LCColor_77_92_127];
    [topView addSubview:_cancelButton];
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(20);
        make.centerY.equalTo(topView);
        make.width.height.equalTo(@40);
    }];

    _enterButton = [UIButton new];
    [_enterButton setTitle:@"确定" forState:UIControlStateNormal];
    [_enterButton setTitleColor: [LCColor LCColor_77_92_127] forState:UIControlStateNormal];
    _enterButton.titleLabel.font = LCFont(15);
    _enterButton.titleLabel.textColor = [LCColor LCColor_77_92_127];
    [topView addSubview:_enterButton];
    [_enterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView).offset(-20);
        make.centerY.equalTo(topView);
        make.width.height.equalTo(@40);
    }];
    
    [_cancelButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
}

-(void)show{
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backgroundView);
        make.height.equalTo(@0);
        make.bottom.equalTo(self.backgroundView);
    }];
    [self.backgroundView setNeedsLayout];
    [self.backgroundView layoutIfNeeded];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backgroundView);
        make.height.equalTo(@(310));
        make.bottom.equalTo(self.backgroundView);
    }];
    
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.backgroundView layoutIfNeeded];
        self.backgroundMaskView.alpha=1;
    } completion:nil];
    
    self.backgroundView.userInteractionEnabled=YES;
    self.hided=NO;
}

-(void)hide{
    self.hided=YES;
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backgroundView);
        make.height.equalTo(@(310));
        make.top.equalTo(self.backgroundView.mas_bottom);
    }];
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.backgroundView layoutIfNeeded];
        self.backgroundMaskView.alpha=0;
    } completion:nil];
    self.backgroundView.userInteractionEnabled=NO;
}

@end
