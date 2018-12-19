//
//  NTDatePickerView.m
//  simple
//
//  Created by qaaaa on 2018/12/7.
//  Copyright (c) 2018 qaaaa. All rights reserved.
//

#import "NTDatePickerView.h"

@implementation NTDatePickerView

@synthesize datePickers;

UIDatePicker * datePicker;

NSString * turnNowDate;

CGRect viewFrame;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        viewFrame = frame;
        
        self.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 256);
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.alpha = 0.9;
        
        datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 25,viewFrame.size.width, 216)];
        
        datePicker.backgroundColor = [UIColor clearColor];
        
        datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        
        datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        
        datePickers = datePicker;

        [self.datePickers addTarget:self action:@selector(didDateChange) forControlEvents:UIControlEventValueChanged];
        
        [self toolTateBar];
        
        [self addSubview:datePicker];
       
        
        
    }
    return self;
}


+(NTDatePickerView *)initWithPicker:(CGRect )viewFrame{
    return [[self alloc]initWithFrame:viewFrame];
}

+(NTDatePickerView *)initWithPicker{
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
    
    NSDate * selected = [datePicker date];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:date];
    
    NSString * selectDate = [dateFormatter stringFromDate:selected];
    
    return selectDate;
}


-(void) popDatePickerView{
    [UIView animateWithDuration:0.2 animations:^{
        
        self.frame = CGRectMake(0, viewFrame.size.height - 256, viewFrame.size.width, 256);
        
    } completion:^(BOOL finished) {
    }];
}

-(void) hiddenDatePickerView{
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, viewFrame.size.height, viewFrame.size.width, 256);
    } completion:^(BOOL finished) {
    }];
}

-(void) datePickerWillHidden:(BOOL)hidden{
    [UIView animateWithDuration:0.3 animations:^{
        if (hidden){
            self.frame = CGRectMake(0, viewFrame.size.height, viewFrame.size.width, 256);
        }else{
           // self.hidden = hidden;
            self.frame = CGRectMake(0, viewFrame.size.height - 256, viewFrame.size.width, 256);
        }
    } completion:^(BOOL finished) {
        [self setHidden:hidden];
    }];
}

-(void)resetToZero{
    [datePicker setDate:[NSDate date] animated:YES];
}

-(void)toolTateBar{
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewFrame.size.width, 30)];
    
    UIButton * leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(8, 5, 60, 30)];
    leftBtn.selected = NO;
    [leftBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [leftBtn setTitleColor: [UIColor colorWithRed:0/255.0 green:122/255.0 blue:252/255.0 alpha:1] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    leftBtn.titleLabel.textColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:252/255.0 alpha:1];
    
    leftBtn.layer.cornerRadius = 5;
    leftBtn.layer.masksToBounds = YES;
    leftBtn.layer.borderWidth = 1;
    leftBtn.layer.borderColor = [[UIColor colorWithRed:0/255.0 green:122/255.0 blue:252/255.0 alpha:1] CGColor];
    
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewFrame.size.width - 68, 5, 60, 30)];
    [rightBtn setTitle:@"Determine" forState:UIControlStateNormal];
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
