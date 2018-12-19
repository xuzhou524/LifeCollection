//
//  LCDatePickerView.h
//  LifeCollection
//
//  Created by gozap on 2018/12/19.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LCDatePickerViewDelegate <NSObject>

@optional

-(void)didCancelSelectDate;

-(void)didSaveDate;

-(void)didDateChangeTo;

@end


@interface LCDatePickerView : UIView

@property (nonatomic, weak) UIDatePicker * datePickers;

@property (nonatomic, weak) id<LCDatePickerViewDelegate> delegate;

+(LCDatePickerView *)initWithPicker:(CGRect )viewFrame;

+(LCDatePickerView *)initWithPicker;

+(NSString *)getNowDateFormat:(NSString *)date;

-(NSString *)getNowDatePicker:(NSString *)date;


-(void) resetToZero;

-(void) popDatePickerView;

-(void) hiddenDatePickerView;

-(void) datePickerWillHidden:(BOOL)hidder;

@end


