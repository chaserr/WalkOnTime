//
//  WXMRadioListTableViewCell.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXMRadioListModel.h"
@interface WXMRadioListTableViewCell : UITableViewCell


@property (nonatomic, strong) UIImageView *coveringView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *playerView;

@property (nonatomic, strong) UILabel *numberOfListenLabel;

@property (nonatomic, strong) UIImageView *numberOfListenView;

@property (nonatomic, strong) NSString *freshMusicView;



@property (nonatomic, strong) WXMRadioListModel *wxmRadioListModel;

@end
