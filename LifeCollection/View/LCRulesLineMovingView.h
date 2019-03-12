//
//  LCRulesLineMovingView.h
//  LifeCollection
//
//  Created by gozap on 2019/3/12.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SlideHeight 60

@protocol ValueChangeDelegate <NSObject>

- (void)valueChange;

@end

@interface LCRulesLineMovingView : UIView

@property (nonatomic, weak) id<ValueChangeDelegate> delegate;

@end
