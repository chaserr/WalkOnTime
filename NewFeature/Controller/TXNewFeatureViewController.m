//
//  TXNewFeatureViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXNewFeatureViewController.h"
#import "UIImage+TX.h"
#import "TXMainViewController.h"
#import "AppDelegate.h"
#import "TXLeftViewController.h"
#define kCount 5
@interface TXNewFeatureViewController ()<UIScrollViewDelegate>{
    
    UIPageControl *_page;
    UIScrollView *_scroll;
}


@end

@implementation TXNewFeatureViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加UIScrollView
    [self addScrollView];
    
    // 2.添加图片
    [self addScrollImages];
    
    // 3.添加UIPageControl
    [self addPageControll];
}

#pragma mark -- 添加滚动视图
- (void)addScrollView{

    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.frame = self.view.bounds;
    scroll.showsHorizontalScrollIndicator = NO; // 隐藏水平滚动条
    CGSize size = scroll.frame.size;
    scroll.pagingEnabled = YES;
    scroll.contentSize = CGSizeMake(size.width*kCount, 0);
    scroll.delegate = self;
    [self.view addSubview:scroll];
    _scroll = scroll;
}




#pragma mark -- 添加滚动显示图片
- (void)addScrollImages{
    
    CGSize size = _scroll.frame.size;
    for (int i = 0; i<kCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        // 显示图片
        NSString *imageName = [NSString stringWithFormat:@"ic_guide_0%d.png", i+1 ];
        // 设置frame
        imageView.frame = CGRectMake(i*size.width, 0, size.width, size.height);
        imageView.image = [UIImage fullscreenImage:imageName];
        [_scroll addSubview:imageView];
        if (i == kCount - 1) { // 最后一页,添加两个按钮
            // 立即体验按钮
            UIButton *start = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [start setTitle:@"立即体验" forState:(UIControlStateNormal)];
            [start setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            start.frame = CGRectMake(150, SCREEN_HEIGHT - 70, 80, 20);
            start.titleLabel.font = ksectionFont;
            [start addTarget:self action:@selector(start) forControlEvents:(UIControlEventTouchUpInside)];
            [imageView addSubview:start];
            
            //分享
            
//            UIButton *share = [UIButton buttonWithType:(UIButtonTypeCustom)];
//            //            // 普通状态显示的图片
//            UIImage *shareNormal = [UIImage imageNamed:@"new_feature_share_false.png"];
//            // 普通状态显示的图片（selected=NO）
//            [share setBackgroundImage:shareNormal forState:UIControlStateNormal];
//            // 选中状态显示的图片（selected=YES）
//            [share setBackgroundImage:[UIImage imageNamed:@"new_feature_share_true.png"] forState:UIControlStateSelected];
//            
//            share.center = CGPointMake(start.center.x, start.center.y - 50);
//            share.bounds = (CGRect){CGPointZero, shareNormal.size};
//            [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
//            //           设置选中
//            share.selected = YES;
//            
//            // 当按钮在高亮的时候不需要变成灰色
//            share.adjustsImageWhenHighlighted = NO;
        
            imageView.userInteractionEnabled = YES;
            
//            [imageView addSubview:share];
        }
    }
}


#pragma mark -- 添加分页指示器
- (void)addPageControll{
    CGSize size = self.view.frame.size;
    UIPageControl *page = [[UIPageControl alloc] init];
    page.numberOfPages = kCount;
    page.center = CGPointMake(size.width *0.5, size.height * 0.95);
    page.bounds = CGRectMake(0, 0, 150, 0);
    page.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point.png"]];
    page.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point.png"]];
    [self.view addSubview:page];
    _page = page;
    
}

    
- (void)start{
    
    TXLog(@"开始体验");
    //    [[UIApplication sharedApplication].keyWindow ]
    /*!
     *  @author 朝夕
     *
     *  @brief  在显示控制器View之前显示状态栏:460
     *
     *  @since 在显示控制器View之后显示状态栏: 480;
     */
    
    // 控制器的View时延迟加载,需要显示或者用到的时候才会加载
    //    显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
   
    AppDelegate *app = [UIApplication sharedApplication].delegate;

    TXMainViewController *mainVC = [TXMainViewController shareInstance];
    TXLeftViewController *leftVC = [[TXLeftViewController alloc] init];
    leftVC.selectedIndex = 0; // 设置菜单默认选中栏
    TXNavigationController *nav = [[TXNavigationController alloc] initWithRootViewController:mainVC];
    SLideZoomMenuController *slideZoomMenu = [[SLideZoomMenuController alloc] initWithRootController:nav];
    slideZoomMenu.leftViewController = leftVC;
    app.window.rootViewController = slideZoomMenu;
    app.slider = slideZoomMenu;
    

    
    
}

// 分享
- (void)share:(UIButton *)button{
    
    button.selected = !button.selected;
}

#pragma mark -- scrollerView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _page.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
