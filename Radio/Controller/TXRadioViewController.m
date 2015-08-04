//
//  TXRadioViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
// 电台首页


#define kImageWidthH  ((SCREEN_WIDTH-30)/3)      //UITableViewCell里面图片的宽度

#import "TXRadioViewController.h"
#import "TXRadioHotListCell.h"
#import "TXRadioTableViewCell.h"
#import "SDCycleScrollView.h"
#import "TXRadioListModel.h"
#import "TXRadioHotListModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "TXTravelDetailViewController.h"
#import "WXMRadioDetailViewController.h"
#import "AFSoundManager.h"
#import "DataBaseHandle.h"
#import "AFNetworking.h"
@interface TXRadioViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,TXRadioHotListDelegate>

@property (nonatomic, strong) NSMutableArray *radioCyclePicUrlArray;

@property (nonatomic, strong) NSMutableArray *radioListArray;

@property (nonatomic, strong) DataBaseHandle *databaseHnadle;

@end

@implementation TXRadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.databaseHnadle = [DataBaseHandle sharedDataBaseHandle];
    
    // 监测网络
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status <= 0) {
            // 从数据库加载
            NSArray *array = [self.databaseHnadle resoreTXRadioListModel];
            self.radioListArray = [NSMutableArray arrayWithArray:array];
            [self.tableView reloadData];

        }else{
            
            // 有网从网络加载
            [self loadRadioData];
        }
        
    }];

    // 布局tableView
    [self layoutTableView];
    
}


#pragma mark -- 数据请求
- (void)loadRadioData{
    
    // 1.创建URL对象
    NSURL *url = [NSURL URLWithString:radioListUrl];
    
    // 2.创建NSMutableRequest
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
    
    // 3.设置HTTP请求类型
    [mutableRequest setHTTPMethod:@"POST"];
    
    // 设置请求体
    NSString *bodyString = @"client=2";
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [mutableRequest setHTTPBody:bodyData];
    
    // 使用block进行网络请求
    [NSURLConnection sendAsynchronousRequest:mutableRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            TXLog(@"connectionError%@", connectionError);
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //        TXLog(@"请求成功>>>>%@", responseDict[@"data"]);
            NSDictionary *dataDict = responseDict[@"data"];
            NSArray *carouselArray = dataDict[@"carousel"];
            
#pragma mark -- 设置顶部轮播图
            self.radioCyclePicUrlArray = [NSMutableArray array];
            
            // 遍历轮播图片
            for (NSDictionary *dict in carouselArray) {
                [self.radioCyclePicUrlArray addObject:dict[@"img"]];
                //            TXLog(@"图片Url:%@",_cycleScrollePictureUrl);
            }
            // 请求完成设置轮播图
            // 设置headView轮播图
            
            [self rafio_CyclePicture];
            
#pragma mark -- 设置主页列表
            
            self.radioListArray = [NSMutableArray array];
            
            NSArray *tmpListArray = dataDict[@"alllist"];
            //        TXLog(@"listArray个数:%ld", [listArray count]);
            
            for (NSDictionary *dict in tmpListArray) {

                TXRadioListModel *txRadioListModel = [TXRadioListModel objectWithKeyValues:dict];
                
                [_radioListArray addObject:txRadioListModel];
                
                [self.databaseHnadle saveNewTXRadioListModel:txRadioListModel];
                
                
            }
#warning 在数据请求下来后一定要进行数据刷新
            [self.tableView reloadData];
            
            //        TXLog(@"listArray:%@", listArray );
        }
        else{
            
            // 让刷新控件停止显示刷新状态
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
//                [self.header endRefreshing];
                TXLog(@"connectionError%@", connectionError);
                [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试" duration:1];
                
            });
            
        }

        
    }];
    // 数据请求结束
    
}


#pragma mark -- 布局tableView
- (void)layoutTableView{
    
    CGFloat tableX = 0;
    CGFloat tableY = 0;
    CGFloat tableW = SCREEN_WIDTH;
    CGFloat tableH = SCREEN_HEIGHT-64;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableX, tableY, tableW, tableH) style:(UITableViewStylePlain)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;

}


#pragma mark -- tableView delegate and datasource
// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
    }
    return _radioListArray.count;
}

// 绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section ==0 && indexPath.row == 0) {
        
        static NSString *Radioidentifier = @"TXRadioTableViewCell";
        TXRadioHotListCell *cell = [tableView dequeueReusableCellWithIdentifier:Radioidentifier];
        if (cell == nil) {
            cell = [[TXRadioHotListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:Radioidentifier];
            
            cell.selectedBackgroundView = [[UIView alloc] init];

            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        
        cell.delegate = self;
        
        return cell;
    }
    else{
        static NSString *Radioidentifier = @"TXRadioAllListTableViewCell";
        TXRadioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Radioidentifier];
        if (cell == nil) {
            cell = [[TXRadioTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:Radioidentifier];
        }
        
        TXRadioListModel *txRadioListModel = _radioListArray[indexPath.row];
        cell.txRadioListModel = txRadioListModel;
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        return cell;
    }
    
}

// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        return kImageWidthH+40;
    }
    else{
        
        return 110;
    }
}

// 分区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 5;
    }
    
    return 0;
}

// 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        WXMRadioDetailViewController *RadioDetailView = [[WXMRadioDetailViewController alloc] init];
        TXRadioListModel *txRadioListModel = _radioListArray[indexPath.row];
        RadioDetailView.radioId = txRadioListModel.radioid;
        RadioDetailView.txRadioListModel = txRadioListModel;
        RadioDetailView.title = txRadioListModel.title;
        [self.navigationController pushViewController:RadioDetailView animated:YES];
    }
    
    
}


#pragma mark -- 设置轮播图
- (void)rafio_CyclePicture{
    
    NSArray *titles = @[@" ",@" ",@" ",@" ",@" ",@" "];
    //网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT/4) imageURLStringsGroup:_radioCyclePicUrlArray]; // 模拟网络延时情景
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.delegate = self;
    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.dotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
    //         --- 轮播时间间隔，默认1.0秒，可自定义
    cycleScrollView2.autoScrollTimeInterval = 3.0;
    self.tableView.tableHeaderView = cycleScrollView2;
    
}


#pragma mark - SDCycleScrollViewDelegate 点击图片进入相应的详情页

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
#warning 点击轮播图进入首页
{
    TXLog(@"---点击了第%ld张图片", (long)index);
    
}


#pragma mark -- txRadioHotListCellDelegate
- (void)txRadioHotListCell:(TXRadioHotListModel *)txRadioHotListModel{

    WXMRadioDetailViewController *RadioDetailView = [[WXMRadioDetailViewController alloc] init];
    RadioDetailView.radioId = txRadioHotListModel.radioid;
    RadioDetailView.title = txRadioHotListModel.title;
    RadioDetailView.txRadioHotListModel = txRadioHotListModel;
    [self.navigationController pushViewController:RadioDetailView animated:YES];
}
// 懒加载
- (UIWebView *)webView{
    
    if (!_webView) {
        self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    }
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)viewDidDisappear:(BOOL)animated{

    // 暂停播放 / 当页面
    [[AFSoundManager sharedManager].audioPlayer stop];
    [[AFSoundManager sharedManager].player pause];
}


@end
