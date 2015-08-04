//
//  AboutWalkViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "AboutWalkViewController.h"

@interface AboutWalkViewController ()<UIScrollViewDelegate>

@end

@implementation AboutWalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"关于行走·时光";
    
    CGFloat contentSizeH = 800;
    //字体
    CGFloat Fotsize = 15;
    //文字高度
    CGFloat H = 200;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 3)];
    imageView.image = [UIImage imageNamed:@"aboutApp.jpg"];
    
    UILabel *aboutMe = [[UILabel alloc] initWithFrame:CGRectMake(15, SCREEN_HEIGHT / 3 + 20, SCREEN_WIDTH - 30, H)];
    aboutMe.numberOfLines = 0;
    
    aboutMe.font = [UIFont systemFontOfSize:Fotsize];
    
    
    aboutMe.text = @"欢迎来到行走·时光\n\n世界那么大,我们都想去看看,一边行走,一边享受时光,一边享受耳边的故事.\n\n本应用为不同爱好者人群提供了丰富的资源。针对不同的兴趣爱好者设计了不同的分类，推荐好看的图书、提供好看的片源、动听的电台DJ美声，集阅读、播放于一体。让你的生活更加精彩。" ;
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    // 设置是否回到顶部
    scrollView.scrollsToTop = NO;
    // 设置contentSize
    scrollView.contentSize = CGSizeMake(0, contentSizeH);
    //显示垂直方向的滚动条
    scrollView.showsVerticalScrollIndicator = YES;
    // 垂直方向遇到边框是否反弹
    scrollView.alwaysBounceVertical = YES;
    
    [self.view addSubview:scrollView];
    
    [scrollView addSubview:imageView];
    
    [scrollView addSubview:aboutMe];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
