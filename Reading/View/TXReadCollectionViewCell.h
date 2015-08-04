//
//  TXReadCollectionViewCell.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/12.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXReadingListModel.h"
@interface TXReadCollectionViewCell : UICollectionViewCell


@property (nonatomic, strong) UIImageView *collectionImgView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) TXReadingListModel *txReadingListModel;

@end
