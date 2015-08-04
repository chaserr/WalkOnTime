//
//  WXMRadioDetailViewController.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXRadioListModel.h"
#import "WXMRadioInfoModel.h"
#import "TXRadioHotListModel.h"
@interface WXMRadioDetailViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *headView;

@property (nonatomic ,strong) TXRadioListModel *txRadioListModel;

@property (nonatomic, strong) TXRadioHotListModel *txRadioHotListModel;

@property (nonatomic, strong) UIButton *button_collect;
@property (nonatomic, copy) NSString *radioId;

@property (nonatomic, copy) NSString *titles;

@end
