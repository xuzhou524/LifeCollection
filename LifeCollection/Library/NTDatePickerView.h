//
//  NTDatePickerView.h
//  simple
//
//  Created by qaaaa on 2018/12/7.
//  Copyright (c) 2018 qaaaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NTDatePickerViewDelegate <NSObject>

@optional

-(void)didCancelSelectDate;

-(void)didSaveDate;

-(void)didDateChangeTo;

@end


@interface NTDatePickerView : UIView


@property (nonatomic, weak) UIDatePicker * datePickers;

@property (nonatomic, weak) id<NTDatePickerViewDelegate> delegate;

+(NTDatePickerView *)initWithPicker:(CGRect )viewFrame;

+(NTDatePickerView *)initWithPicker;

+(NSString *)getNowDateFormat:(NSString *)date;

-(NSString *)getNowDatePicker:(NSString *)date;


-(void) resetToZero;

-(void) popDatePickerView;

-(void) hiddenDatePickerView;

-(void) datePickerWillHidden:(BOOL)hidder;



@end
