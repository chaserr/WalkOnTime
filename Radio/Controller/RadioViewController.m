//
//  RadioViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "RadioViewController.h"

@interface RadioViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation RadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 布局webView
    [self layoutWebView];
    
    // 布局tableView
    [self layoutTableView];
    
    // 数据请求
//    [self loadData];
}

#pragma mark -- 布局webView
- (void)layoutWebView{

    self.title = @"电台";
    
    // 初始化webview
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://old.yuelvxing.com/app/fm/"]]];
}

#pragma mark -- 布局tableView
- (void)layoutTableView{

    CGFloat tableX = 0;
    CGFloat tableY = 64;
    CGFloat tableW = SCREEN_WIDTH;
    CGFloat tableH = SCREEN_HEIGHT-tableY;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableX, tableY, tableW, tableH) style:(UITableViewStylePlain)];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}


#pragma mark -- tableView delegate and datasource
// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
}

// 绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *Radioidentifier = @"TXRadioTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Radioidentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:Radioidentifier];
    }
    cell.textLabel.text = @"刘亦菲,我稀饭你";
    
    return cell;
}






//- (void)loadData{
//    // 1.创建URL对象
//    NSURL *url = [NSURL URLWithString:articalUrl];
//    
//    // 2.创建NSMutableRequest
//    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
//    
//    // 3.设置HTTP请求类型
//    [mutableRequest setHTTPMethod:@"POST"];
//    
//    // 设置请求体
//    NSString *articalID = [NSString stringWithFormat:@"%@",_txMainList.ID];
//    
//    NSString *bodyString = [NSString stringWithFormat:@"contentid=%@&client=2", articalID];
//    //    TXLog(@"请求体:%@", bodyString);
//    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
//    [mutableRequest setHTTPBody:bodyData];
//    
//    // 使用block进行网络请求
//    [NSURLConnection sendAsynchronousRequest:mutableRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        
//        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        //        TXLog(@"请求成功>>>>%@", responseDict[@"data"]);
//        NSDictionary *dataDict = responseDict[@"data"];
//        NSString *urlString = dataDict[@"html"];
//        
//        //        TXLog(@"urlString:%@",urlString);
//#pragma mark -- 加载URL
//        
//        NSURL *url = [NSURL URLWithString:urlString];
//        //        [self.webView loadHTMLString:@"<html></html>" baseURL:url];
//        [self.webView loadHTMLString:urlString baseURL:url];
//        [self.webView reload];
//        
//        
//    }];// 数据请求结束
//    
//    
//}

















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
    // Dispose of any resources that can be recreated.
}


@end
