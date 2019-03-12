//
//  LCRulesLineMovingView.m
//  LifeCollection
//
//  Created by gozap on 2019/3/12.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "LCRulesLineMovingView.h"

@interface LCRulesLineMovingView()
@property (assign, nonatomic) CGPoint beginpoint;
@end

@implementation LCRulesLineMovingView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (SlideHeight-((32*ScreenWidth)/374))/2, ScreenWidth, (32*ScreenWidth)/374)];
        imageView.image = [UIImage imageNamed:@"zhichizhixiang"];
        [self addSubview:imageView];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.beginpoint = [touch locationInView:self];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self];
    CGRect frame = self.frame;
    frame.origin.x = 0;
    frame.origin.y += currentLocation.y - self.beginpoint.y;
    
    if (frame.origin.y < - (SlideHeight/2)) {
        frame.origin.y = - (SlideHeight/2);
    }
    
    if (frame.origin.y > ScreenHeight - SlideHeight/2) {
        frame.origin.y = ScreenHeight - SlideHeight/2;
    }
    
    self.frame = frame;
    if ([self.delegate respondsToSelector:@selector(valueChange)]) {
        [self.delegate valueChange];
    }
    
    
}



@end
