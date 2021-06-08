//
//  LCDatePickerWindow.h
//  LifeCollection
//
//  Created by gozap on 2018/12/19.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LCDatePickerWindow : NSObject
@property (nonatomic, strong) UIDatePicker * datePicker;
@property (nonatomic,strong) UIButton * cancelButton;
@property (nonatomic,strong) UIButton * enterButton;
@property(nonatomic,assign)BOOL hided;

-(void)show;
-(void)hide;

@end

