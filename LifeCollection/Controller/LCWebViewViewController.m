//
//  LCWebViewViewController.m
//  LifeCollection
//
//  Created by gozap on 2018/12/21.
//  Copyright © 2018 com.longdai. All rights reserved.
//

#import "LCWebViewViewController.h"

@interface LCWebViewViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * webView;
@end

@implementation LCWebViewViewController{
    NSString * _type;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _titleStr;
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -45, ScreenWidth,ScreenHeight)];
    if (!_htmlStr) {
       [_webView loadHTMLString:_htmlStr baseURL:nil];
    }else{
       [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    }
    _webView.delegate = self;
    
    [self.view addSubview:_webView];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self handelRightDeil:webView];
    
}

- (void)handelRightDeil:(UIWebView *)awebView {
    NSString * javaScriptString = @"document.body.getElementsByClassName('header')[0].remove()";
    _type =[awebView stringByEvaluatingJavaScriptFromString:javaScriptString];
}

@end
