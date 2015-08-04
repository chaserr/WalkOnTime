//
//  TXMainListDetailViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXMainListDetailViewController.h"




@interface TXMainListDetailViewController ()<UIWebViewDelegate>

@end

@implementation TXMainListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 初始化webview
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
     _webView.scrollView.contentSize = CGSizeMake( SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    [self loadData];
}



#pragma mark -- 数据请求
- (void)loadData{

    // 1.创建URL对象
    NSURL *url = [NSURL URLWithString:articalUrl];
    
    // 2.创建NSMutableRequest
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
    
    // 3.设置HTTP请求类型
    [mutableRequest setHTTPMethod:@"POST"];
    
    // 设置请求体
    NSString *articalID = [NSString stringWithFormat:@"%@",_txMainList.ID];
    
    NSString *bodyString = [NSString stringWithFormat:@"contentid=%@&client=2", articalID];
//    TXLog(@"请求体:%@", bodyString);
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [mutableRequest setHTTPBody:bodyData];
    
    // 使用block进行网络请求
    [NSURLConnection sendAsynchronousRequest:mutableRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data) {
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //        TXLog(@"请求成功>>>>%@", responseDict[@"data"]);
            NSDictionary *dataDict = responseDict[@"data"];
            NSString *urlString = dataDict[@"html"];
            
            //        TXLog(@"urlString:%@",urlString);
#pragma mark -- 加载URL
            
            NSURL *url = [NSURL URLWithString:urlString];
            //        [self.webView loadHTMLString:@"<html></html>" baseURL:url];
            [self.webView loadHTMLString:urlString baseURL:url];
            [self.webView reload];
        }
        else{
            
            // 让刷新控件停止显示刷新状态
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
//                [self.footer endRefreshing];
                TXLog(@"connectionError%@", connectionError);
                [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试" duration:1];
                
            });
            
        }

    }];// 数据请求结束

    
}


- (void)webViewDidStartLoad:(UIWebView *)webView{

    [SVProgressHUD showWithStatus:@"正在加载..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{

    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

    [SVProgressHUD showErrorWithStatus:@"网络繁忙,请稍后再试" duration:1];
}

// 懒加载
- (UIWebView *)webView{
    
    if (!_webView) {
        self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
//        self.webView.backgroundColor = [UIColor yellowColor];
    }
    return _webView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
