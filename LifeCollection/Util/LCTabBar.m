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
    }
    for (UIControl * tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            for (UIView * view in tabBarButton.subviews) {
                if ([view isKindOfClass:NSClassFromString(@"UIImageView")]) {
                    view.layer.shadowOffset = CGSizeMake(1,0);
                    view.layer.shadowOpacity = 0.5;
                    view.layer.shadowRadius = 3.0;
                    view.layer.shadowColor = [UIColor grayColor].CGColor;
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
@end
