//
//  PrivacyViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/30.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "PrivacyViewController.h"

@interface PrivacyViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation PrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"关于行走·时光APP服务条款";
    

    NSString *mainPath = [[NSBundle mainBundle] pathForResource:@"privacy" ofType:@"txt"];
//    NSURL *url = [NSURL fileURLWithPath:mainPath];
    NSData *data = [NSData dataWithContentsOfFile:mainPath];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    [_webView loadData:data MIMEType:@"text/plain" textEncodingName:@"UTF-8" baseURL:nil];
    
    [self.view addSubview:_webView];
    
 
    
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
