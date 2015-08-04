//
//  CyclePictureDetailViewController.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/20.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CyclePictureDetailViewController : UIViewController
/**轮播图列表详情*/
@property (nonatomic, strong) UIWebView *webView;

/**网络请求指示器*/
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, copy) NSString *urlStringWithPicture;
@end
