//
//  TimeDetailViewController.h
//  LifeCollection
//
//  Created by gozap on 2020/5/11.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//


#import "EventModel.h"

@interface TimeDetailViewController : UIViewController
@property (nonatomic, strong) EventModel * eventModel;
@end


@interface LDNavigationTapView : UIView
@property(nonatomic,strong)UIImageView * bgView;
@property(nonatomic,strong)UIImageView * leftImageView;
@property(nonatomic,strong)UIView * tapLeftView;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIImageView * rightImageView;
@end
