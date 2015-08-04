//
//  TXRadioTableViewCell.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXRadioListModel.h"
@interface TXRadioTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *leftImgView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *userNameLabel;

@property (nonatomic, strong) UILabel *descrtptionLabel;

@property (nonatomic, strong) UIImageView *listenImgView;

@property (nonatomic, strong) UILabel *listenNumber;

@property (nonatomic, strong) UIView *viewOfTitel;

@property (nonatomic, strong) TXRadioListModel *txRadioListModel;

@end
