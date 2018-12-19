//
//  LCDatePickerView.m
//  LifeCollection
//
//  Created by gozap on 2018/12/19.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "LCDatePickerView.h"

@implementation LCDatePickerView{
    UIDatePicker * _datePicker;
    CGRect _viewFrame;
}
@synthesize datePickers;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _viewFrame = frame;

        self.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 256);

        self.backgroundColor = [UIColor whiteColor];

        self.alpha = 0.9;

        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 25,_viewFrame.size.width, 216)];

        _datePicker.backgroundColor = [UIColor clearColor];

        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;

        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];

        datePickers = _datePicker;

        [self.datePickers addTarget:self action:@selector(didDateChange) forControlEvents:UIControlEventValueChanged];

        [self toolTateBar];

        [self addSubview:_datePicker];
    }
    return self;
}


+(LCDatePickerView *)initWithPicker:(CGRect )viewFrame{
    return [[self alloc]initWithFrame:viewFrame];
}

+(LCDatePickerView *)initWithPicker{
    return [[self alloc]init];
}

+(NSString *)getNowDateFormat:(NSString *)date{
    NSDate * selected = [NSDate date];

    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];

    [dateFormatter setDateFormat:date];

    NSString * selectDate = [dateFormatter stringFromDate:selected];

    return selectDate;
}

-(NSString *)getNowDatePicker:(NSString *)date{

    NSDate * selected = [_datePicker date];

    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];

    [dateFormatter setDateFormat:date];

    NSString * selectDate = [dateFormatter stringFromDate:selected];

    return selectDate;
}


-(void) popDatePickerView{
    [UIView animateWithDuration:0.2 animations:^{

        self.frame = CGRectMake(0, _viewFrame.size.height - 256, _viewFrame.size.width, 256);

    } completion:^(BOOL finished) {
    }];
}

-(void) hiddenDatePickerView{
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, _viewFrame.size.height, _viewFrame.size.width, 256);
    } completion:^(BOOL finished) {
    }];
}

-(void) datePickerWillHidden:(BOOL)hidden{
    [UIView animateWithDuration:0.3 animations:^{
        if (hidden){
            self.frame = CGRectMake(0, _viewFrame.size.height, _viewFrame.size.width, 256);
        }else{
            // self.hidden = hidden;
            self.frame = CGRectMake(0, _viewFrame.size.height - 256, _viewFrame.size.width, 256);
        }
    } completion:^(BOOL finished) {
        [self setHidden:hidden];
    }];
}

-(void)resetToZero{
    [_datePicker setDate:[NSDate date] animated:YES];
}

-(void)toolTateBar{
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _viewFrame.size.width, 30)];

    UIButton * leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(8, 5, 60, 30)];
    leftBtn.selected = NO;
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor: [UIColor colorWithRed:0/255.0 green:122/255.0 blue:252/255.0 alpha:1] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    leftBtn.titleLabel.textColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:252/255.0 alpha:1];

    leftBtn.layer.cornerRadius = 5;
    leftBtn.layer.masksToBounds = YES;
    leftBtn.layer.borderWidth = 1;
    leftBtn.layer.borderColor = [[UIColor colorWithRed:0/255.0 green:122/255.0 blue:252/255.0 alpha:1] CGColor];

    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(_viewFrame.size.width - 68, 5, 60, 30)];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:252/255.0 alpha:1] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    rightBtn.titleLabel.textColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:252/255.0 alpha:1];

    rightBtn.layer.cornerRadius = 5;
    rightBtn.layer.masksToBounds = YES;
    rightBtn.layer.borderWidth = 1;
    rightBtn.layer.borderColor = [[UIColor colorWithRed:0/255.0 green:122/255.0 blue:252/255.0 alpha:1] CGColor];

    [leftBtn addTarget:self action:@selector(cancelDate:) forControlEvents:UIControlEventAllEvents];

    [rightBtn addTarget:self action:@selector(saveDate:) forControlEvents:UIControlEventAllEvents];

    [topView addSubview:leftBtn];
    [topView addSubview:rightBtn];

    [self addSubview:topView];

}

-(void)cancelDate:(id)sender{
    if ([self.delegate respondsToSelector:@selector(didCancelSelectDate)]){
        [self.delegate didCancelSelectDate];
    }
    [self hiddenDatePickerView];
}

-(void)saveDate:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(didSaveDate)]){
        [self.delegate didSaveDate];

    }
    [self hiddenDatePickerView];
}

-(void)didDateChange{
    if ([self.delegate respondsToSelector:@selector(didDateChangeTo)]){
        [self.delegate didDateChangeTo];
    }
}


@end
