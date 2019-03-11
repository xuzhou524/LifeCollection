//
//  ToolViewController.m
//  LifeCollection
//
//  Created by gozap on 2019/3/11.
//  Copyright © 2019 com.longdai. All rights reserved.
//

#import "ToolViewController.h"

@interface ToolViewController ()

@end

@implementation ToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [LCColor backgroudColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UILabel * liftLabel = [UILabel new];
    liftLabel.text = @"生活";
    liftLabel.font = LCFont(23);
    liftLabel.textColor = [LCColor LCColor_77_92_127];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:liftLabel];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
