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
@property(nonatomic,strong)UIButton *closeBtn;
@end

@implementation LCWebViewViewController{
    NSString * _type;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * liftLabel = [UILabel new];
    liftLabel.text = _titleStr;
    liftLabel.font = LCFont(18);
    liftLabel.textColor = [LCColor LCColor_77_92_127];
    self.navigationItem.titleView = liftLabel;
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight)];
    _webView.backgroundColor = [LCColor backgroudColor];
    if (_bg_color) {
        _webView.frame = CGRectMake(0, -45, ScreenWidth,ScreenHeight);
        _webView.backgroundColor = [LCColor colorWithHexString:_bg_color];
    }
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    _webView.delegate = self;
    
    [self.view addSubview:_webView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0, 0, 24, 24)];
    btn.imageView.contentMode=UIViewContentModeTopLeft;
    btn.imageEdgeInsets = UIEdgeInsetsMake( 0, -5, 0, 5);
    [btn setImage:[UIImage imageNamed:@"d_Arrow_left"] forState:UIControlStateNormal];
    
    _closeBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeBtn addTarget:self action:@selector(back2) forControlEvents:UIControlEventTouchUpInside];
    [_closeBtn setFrame:CGRectMake(0, 0, 35, 44)];
    [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    _closeBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_closeBtn setTitleColor:[LCColor LCColor_77_92_127] forState:UIControlStateNormal];
    _closeBtn.titleLabel.font = LCFont(16);
    _closeBtn.hidden = YES;
    
    self.navigationItem.leftBarButtonItems=@[
                                             [[UIBarButtonItem alloc] initWithCustomView:btn],
                                             [[UIBarButtonItem alloc] initWithCustomView:_closeBtn]
                                             ];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([_webView canGoBack]) {
        _closeBtn.hidden = NO;
    } else {
        _closeBtn.hidden = YES;
    }
    return YES;
}

- (void)back {
    if ([_webView canGoBack]) {
        [_webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)back2 {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString * javaScriptString = @"document.body.getElementsByClassName('header')[0].remove()";
    _type =[webView stringByEvaluatingJavaScriptFromString:javaScriptString];

}
@end
