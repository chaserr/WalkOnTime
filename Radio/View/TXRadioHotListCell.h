//
//  TXRadioHotListCell.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXRadioHotListModel.h"

@protocol TXRadioHotListDelegate <NSObject>

@optional

- (void)txRadioHotListCell:(TXRadioHotListModel *)txRadioHotListModel;


@end

@interface TXRadioHotListCell : UITableViewCell


@property (nonatomic, strong) TXRadioHotListModel *txRadioHotListModel;

@property (nonatomic, assign) id<TXRadioHotListDelegate> delegate;

@end
