//
//  WXMRadioDetailTableViewCell.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXMRadioInfoModel.h"
@interface WXMRadioDetailTableViewCell : UITableViewCell


@property (nonatomic, strong) UIImageView *userInfoCoveringImg;

@property (nonatomic, strong) UILabel *userInfoNameLabel;

@property (nonatomic , strong) UILabel *descLabel;

@property (nonatomic, strong) UIImageView *listenImgView;

@property (nonatomic, strong) UILabel *listenNumber;

@property (nonatomic, strong ) WXMRadioInfoModel *wxmRadioInfoModel;

@end
