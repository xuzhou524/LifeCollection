//
//  WidgetModel.h
//  LifeCollection
//
//  Created by gozap on 2020/9/17.
//  Copyright © 2020 com.longdai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WidgetModel : NSObject
@property (nonatomic, assign) int ids;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * content;

@property (nonatomic, copy) NSString * time;

@property (nonatomic, copy) NSString * classType;

@property (nonatomic, copy) NSString * remindType;

@property (nonatomic, copy) NSString * colorType;
@end

NS_ASSUME_NONNULL_END
