//
//  LCNoteListViewController.h
//  LifeCollection
//
//  Created by gozap on 2019/4/30.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LMNFolder;

@interface LCNoteListViewController : UITableViewController

@property (nonatomic, strong, readonly) LMNFolder *folder;

@end

