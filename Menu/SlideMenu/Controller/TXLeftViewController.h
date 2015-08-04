//
//  TXLeftViewController.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXLeftViewController : UIViewController

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImageView *picImgView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UIButton *setBtn;
@property (nonatomic, strong) UIButton *nightPattem;
@property(nonatomic, strong) UIButton *loginButton;
@property (nonatomic, assign) BOOL didSelectInitialViewController;

@property(nonatomic, assign) int selectedIndex;

@end
