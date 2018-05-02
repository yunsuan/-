//
//  WebViewVC.m
//  云渠道
//
//  Created by xiaoq on 2018/5/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "WebViewVC.h"

@interface WebViewVC ()<UIWebViewDelegate>

@end

@implementation WebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    webView.delegate = self;
    [self.view addSubview:webView];
    self.view.backgroundColor = [UIColor whiteColor];
    NSURL *url = [NSURL URLWithString:@"https://img360.fang.com/2018/04/19/bj/720/5c5ee6ee7285410a9f87db339f7c375d/html/index.html?type=quanjing&channel=newhouse&p=110"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    //[webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
    [webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
