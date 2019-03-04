//
//  LCTabBar.m
//  LCTabBar
//
//  Created by qaaaa on 2017/9/7.
//  Copyright © 2017 qaaaa. All rights reserved.
//

#import "LCTabBar.h"

@implementation LCTabBar

-(void)layoutSubviews{
    [super layoutSubviews];
    for (UITabBarItem * item in self.items) {
        if (LDiPhoneX) {
            item.imageInsets = UIEdgeInsetsMake(5.0, 0, -5.0, 0);
        }else{
            item.imageInsets = UIEdgeInsetsMake(-5.0, 0, 5.0, 0);
        }
//        item.titlePositionAdjustment = UIOffsetMake(0,-3);
    }
    for (UIControl * tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            for (UIView * view in tabBarButton.subviews) {
                if ([view isKindOfClass:NSClassFromString(@"UIImageView")]) {
                    view.layer.shadowOffset = CGSizeMake(1,1);
                    view.layer.shadowOpacity = 1;
                    view.layer.shadowRadius = 3.0;
                    view.layer.shadowColor = [UIColor grayColor].CGColor;
                    view.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)].CGPath;
                }
                view.backgroundColor = [UIColor whiteColor];
            }
        }
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)tabBarButtonClick:(UIControl *)tabBarButton{
    for (UIView * view in tabBarButton.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")] || [view isKindOfClass:NSClassFromString(@"UITabBarButtonLabel")]) {

            CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.05,@0.98,@1.0];
            animation.duration = 1;
            animation.calculationMode = kCAAnimationCubic;

            [view.layer addAnimation:animation forKey:nil];
        }
    }
}

- (void) safeAreaInsetsDidChange{
    [super safeAreaInsetsDidChange];
    if(self.oldSafeAreaInsets.left != self.safeAreaInsets.left ||
       self.oldSafeAreaInsets.right != self.safeAreaInsets.right ||
       self.oldSafeAreaInsets.top != self.safeAreaInsets.top ||
       self.oldSafeAreaInsets.bottom != self.safeAreaInsets.bottom){
        self.oldSafeAreaInsets = self.safeAreaInsets;
        [self invalidateIntrinsicContentSize];
        [self.superview setNeedsLayout];
        [self.superview layoutSubviews];
    }
}

- (CGSize) sizeThatFits:(CGSize) size{
    CGSize s = [super sizeThatFits:size];
    if(@available(iOS 11.0, *)){
        CGFloat bottomInset = self.safeAreaInsets.bottom;
        if( bottomInset > 0 && s.height < 50) {
            s.height += bottomInset;
        }
    }
    return s;
}
@end
