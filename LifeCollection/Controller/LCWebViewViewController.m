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
    // Do any additional setup after loading the view.
    //http://img.gozap.com/group19/M02/7F/FD/wKgCN1wcqNTh4ENTAAHnW6-B0xc350.pdf;
    
    self.navigationItem.title = @"服务条款";
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight)];
    NSString * url = @"http://img.gozap.com/group19/M01/80/08/wKgCN1wcrJ6WDKlrAAHm_9rYe-c967.pdf";
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:webView];

    
    
}

@end
