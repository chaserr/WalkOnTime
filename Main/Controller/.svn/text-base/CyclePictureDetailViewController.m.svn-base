//
//  CyclePictureDetailViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/20.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "CyclePictureDetailViewController.h"

@interface CyclePictureDetailViewController ()<UIWebViewDelegate>

@end

@implementation CyclePictureDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化webview
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStringWithPicture]]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
