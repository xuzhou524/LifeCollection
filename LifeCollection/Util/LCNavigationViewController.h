//
//  LCNavigationViewController.h
//  LittleSesame
//
//  Created by xuzhou on 2018/7/11.
//  Copyright © 2018年 chenyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCNavigationViewController : UINavigationController

@end

@interface LCNavigationTapView : UIView
@property(nonatomic,strong)UIImageView * bgView;
@property(nonatomic,strong)UIImageView * leftImageView;
@property(nonatomic,strong)UIView * tapLeftView;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIImageView * rightImageView;
@end
