//
//  WXMPlayerViewController.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXMFooterView.h"
#import "WXMRadioListModel.h"
@interface WXMPlayerViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) WXMFooterView *wxmFooterView;

@property (nonatomic, strong) WXMRadioListModel *wxmRadioListModel;

@property (nonatomic, assign) BOOL play;

@property (nonatomic, strong) NSMutableArray *firstModelArray;
@property (nonatomic, strong) NSMutableArray *moreting_coveringArray;
@property (nonatomic, strong) NSMutableArray *moreting_titleArray;
@property (nonatomic, strong) NSMutableArray *moreting_playinfoArray;
@end
