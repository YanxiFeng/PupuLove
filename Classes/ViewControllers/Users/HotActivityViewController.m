//
//  HotActivityViewController.m
//  LeCao
//
//  Created by Mr. Feng on 3/3/16.
//  Copyright © 2016 YX. All rights reserved.
//

#import "HotActivityViewController.h"

#define HOTURL @"http://7xqhpt.com1.z0.glb.clouddn.com/be_invite_7.html"

@interface HotActivityViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webview;
@end

@implementation HotActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"热门活动";
    [self.view addSubview:self.webview];
    [self requestWebview];
}

- (void)requestWebview
{
    //加载网页
    NSURL *url = [NSURL URLWithString:HOTURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webview loadRequest:request];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

#pragma mark --getter
- (UIWebView *)webview
{
    if (!_webview) {
        _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _webview.dataDetectorTypes = UIDataDetectorTypeAll;
        _webview.delegate = self;
        [_webview setScalesPageToFit:YES];
    }
    return _webview;
}

@end
