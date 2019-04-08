//
//  NoteListViewController.m
//  LifeCollection
//
//  Created by gozap on 2019/4/8.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "NoteListViewController.h"

@interface NoteListViewController ()

@end

@implementation NoteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [LCColor backgroudColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UILabel * liftLabel = [UILabel new];
    liftLabel.text = @"小记";
    liftLabel.font = LCFont(23);
    liftLabel.textColor = [LCColor LCColor_77_92_127];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:liftLabel];
    
}

@end
