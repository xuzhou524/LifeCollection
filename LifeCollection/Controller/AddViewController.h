//
//  AddViewController.h
//  LifeCollection
//
//  Created by gozap on 2018/12/17.
//  Copyright © 2021 com.xuzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventModel.h"

@interface AddViewController : UIViewController
@property (nonatomic, strong) EventModel * eventModel;
@property (nonatomic, assign) BOOL isEditor;
@end
