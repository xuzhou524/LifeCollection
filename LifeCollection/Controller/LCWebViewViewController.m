//
//  LCWebViewViewController.m
//  LifeCollection
//
//  Created by gozap on 2018/12/21.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "LCWebViewViewController.h"

@interface LCWebViewViewController ()

@end

@implementation LCWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _titleStr;
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    [self.view addSubview:webView];

}

@end
