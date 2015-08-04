//
//  WXMPlayerViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "WXMPlayerViewController.h"
#import "WXMFooterView.h"
#import "WXMPlayerScrollViewFirstView.h"
#import "WXMPlayerScrollViewThirdView.h"
#import "WXMPlayerFirstViewModel.h"
#import "WXMRadioListModel.h"
#import "MJExtension.h"
#import "WXMPlayerThirdViewModel.h"
#import "UIImageView+WebCache.h"
#import "WXMFooterView.h"
#import "TXRadioViewController.h"
#import "AppDelegate.h"
#import "TXNavigationController.h"
#import "TXMainViewController.h"
#import "AFSoundManager.h"

@interface WXMPlayerViewController ()<UIScrollViewDelegate,UIWebViewDelegate>

@property (nonatomic, strong) WXMPlayerScrollViewFirstView *firstView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) WXMPlayerScrollViewThirdView *thirdView;
@property (nonatomic, strong) NSString *musicUrlString;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) NSDate *elapsedTimeDate;
@property (nonatomic, strong) NSDate *timeRemainingDate;
@property (nonatomic, assign) int percentage;


@end


@implementation WXMPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.wxmRadioListModel.title;
    
    
    [self layoutTotalPlayerView];
    [self layoutPageControl];
    
    //请求数据
    [self loadDataPlayer];
    
    
}

#pragma mark - 网络请求
- (void)loadDataPlayer
{
        //创建NSURL
    NSURL *url = [NSURL URLWithString:radioPlayerUrl];
    
        //创建NSMutableRequest
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //设置HTTP请求类型
    [request setHTTPMethod:@"POST"];
    
    //设置请求体
    NSString *bodyString = [NSString stringWithFormat:@"auth=&client=1&deviceid=19277E37-CDE3-4691-BCE3FEA693CA2BC6&tingid=%@&55a3595d53479c6a7c8b4621&version=3.0.4",self.wxmRadioListModel.tingid];
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    //使用block进行网络请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data) {
            NSDictionary *requestDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dataDict = requestDict[@"data"];
#pragma mark - 设置第一页
            
            self.firstView.commentNumLabel.text = [NSString stringWithFormat:@"%@", [dataDict objectForKey:@"comment"]];
            self.firstView.interestNumLabel.text = [NSString stringWithFormat:@"%@", [dataDict objectForKey:@"like"]];
            
            NSDictionary *playInfoDic = dataDict[@"playInfo"];
            NSString *imgUrl = playInfoDic[@"imgUrl"];
            [self.firstView.titleImage sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
            self.musicUrlString = playInfoDic[@"musicUrl"];
            self.firstView.titleLabel.text = playInfoDic[@"title"];
    
#pragma mak - 设置webview页面
            // NSDictionary *playInfoDic = dataDict[@"playInfo"];
            NSString *urlString = playInfoDic[@"webview_url"];
            NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
            [_webView loadRequest:request];
            [self.webView reload];
            
#pragma mak - 设置第三页
       
            NSDictionary *userinfoDic = dataDict[@"userinfo"];
            [self.thirdView.lilView1.image sd_setImageWithURL:[NSURL URLWithString:userinfoDic[@"icon"]]];
            self.thirdView.lilView1.secondLabel.text = userinfoDic[@"uname"];
            NSDictionary *authorinfoDic = dataDict[@"authorinfo"];
            [self.thirdView.lilView2.image sd_setImageWithURL:[NSURL URLWithString:authorinfoDic[@"icon"]]];
            self.thirdView.lilView2.secondLabel.text = authorinfoDic[@"uname"];
            
            self.thirdView.fromStationcontent.text = dataDict[@"radioname"];
            
            //图片
            self.moreting_playinfoArray = [NSMutableArray array];
            _moreting_playinfoArray = dataDict[@"moreting"];
            for (int i = 0; i < [_moreting_playinfoArray count]; i ++) {
                NSDictionary *dic = _moreting_playinfoArray[i ];
                NSString *coverimgString = dic[@"coverimg"];
                [self.thirdView.imageArray[i] sd_setImageWithURL:[NSURL URLWithString:coverimgString ]];
                self.thirdView.titleLabel  =  [self.thirdView.titleLabelArray objectAtIndex:i ];
                self.thirdView.titleLabel.text = dic[@"title"];
                
            }
        }
        
        else{
            
            // 让刷新控件停止显示刷新状态
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
//                [self.footer endRefreshing];
                TXLog(@"connectionError%@", connectionError);
                [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试" duration:1];
                
            });
            
        }
        
        
    }];
}

#pragma mark - 布局totalPlayerView
- (void)layoutTotalPlayerView
{
#pragma mark - 添加ScrolView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT - 100)];
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, 0);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.pagingEnabled = YES;
    
    
#pragma mark - 添加第一个滚动页
    
    self.firstView = [[WXMPlayerScrollViewFirstView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 100)];
    [self.scrollView addSubview:_firstView];
    
#pragma mark - 添加第二个滚动页
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 1, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 100)];
    _webView.delegate = self;
    [_scrollView addSubview:_webView];
    
#pragma mark - 添加第三个滚动页
    
    self.thirdView = [[WXMPlayerScrollViewThirdView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 2, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 100)];
    [self.thirdView.backToAllStationBtn addTarget:self action:@selector(backToAllStationView) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:_thirdView];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
#pragma mark - 添加底部播放功能View
    self.wxmFooterView = [[WXMFooterView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 150, SCREEN_WIDTH, 100)];
    _wxmFooterView.backgroundColor = [UIColor colorWithRed:0.919 green:0.946 blue:1.000 alpha:1.000];
    //暂停和播放
    [_wxmFooterView.playerButton addTarget:self action:@selector(startMusic) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_wxmFooterView];
}

#pragma mark - 视图出现加载音乐播放
- (void)viewDidAppear:(BOOL)animated{
    [self loadMusicData];
}

#pragma mark -- 加载播放
-(void)loadMusicData{
    TXLog(@"播放");
    _firstView.playerSlider.value = 0;
    [_wxmFooterView.playerButton setImage:[UIImage imageNamed:@"ic_pause_normal"] forState:UIControlStateNormal];
    _play = YES;//播放状态
    // [[AFSoundManager sharedManager].audioPlayer stop];
    
    [[AFSoundManager sharedManager] startStreamingRemoteAudioFromURL: _musicUrlString andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
        if (! error) {
            [self show:percentage and:elapsedTime and:timeRemaining];
            
        }
    }];
    
}

#pragma mark - 播放暂停按钮事件
- (void)startMusic
{
    self.play = ! self.play;
    if (_play == NO) {
        [_wxmFooterView.playerButton setImage:[UIImage imageNamed:@"ic_play_normal"] forState:UIControlStateNormal];
        [[AFSoundManager sharedManager].player pause];
    }else{
        
        [_wxmFooterView.playerButton setImage:[UIImage imageNamed:@"ic_pause_normal"] forState:UIControlStateNormal];
        [[AFSoundManager sharedManager].player play];
    }
}
- (void)stopMusic
{
    [[AFSoundManager sharedManager].audioPlayer stop];
    [[AFSoundManager sharedManager].player pause];
}

#pragma mark - 时间进度
- (void)show:(int)percentage and:(CGFloat)elapsedTime and:(CGFloat)timeRemaining{
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"mm:ss"];
    _elapsedTimeDate = [NSDate dateWithTimeIntervalSince1970:elapsedTime];
//    _firstView.elapsedTime.text = [_formatter stringFromDate:_elapsedTimeDate];
    _timeRemainingDate = [NSDate dateWithTimeIntervalSince1970:timeRemaining];
    _firstView.timeRemaining.text = [_formatter stringFromDate:_timeRemainingDate];
    _firstView.playerSlider.value = percentage * 0.001;
    
}

#pragma mark - 返回所有电台页面
- (void)backToAllStationView
{
    TXRadioViewController *txRadioViewController = [[TXRadioViewController alloc] init];
    TXNavigationController *nv = [[TXNavigationController alloc] initWithRootViewController:txRadioViewController];
     AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.slider.rootViewController = nv;
    [self presentViewController:nv animated:YES completion:nil];
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //根据scrollView的x的偏移量来计算当前是第几页
    NSInteger currentPage = scrollView.contentOffset.x / self.view.bounds.size.width;
    self.pageControl.currentPage = currentPage;
    
}
#pragma mark - 布局PageControl
- (void) layoutPageControl
{
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 150)/2, SCREEN_HEIGHT - 180, 150, 30)];
    _pageControl.numberOfPages = 3;
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.865 green:1.000 blue:0.988 alpha:1.000];
    _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.725 alpha:1.000];
    
    [_pageControl addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    
}
#pragma mark - UIPageContorl事件
- (void)changeView:(UIPageControl *)pageControl
{
    self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width * pageControl.currentPage, 0);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
