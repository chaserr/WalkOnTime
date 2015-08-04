//
//  TXPhotoListCollectionViewCell.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXPhotoDoulistModel.h"



@interface TXPhotoListCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *collectionImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *flowCountLable;
@property (nonatomic, strong) TXPhotoDoulistModel *txPhotoDoulistModel;

@end
