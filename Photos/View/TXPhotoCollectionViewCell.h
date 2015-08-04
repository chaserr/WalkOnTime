//
//  TXPhotoCollectionViewCell.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/11.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface TXPhotoCollectionViewCell : UICollectionViewCell

/**图片*/
@property (nonatomic, strong) UIImageView *collectionImgView;

/**名称*/
@property (nonatomic, strong) UILabel *titleLabel;

/**关注*/
@property (nonatomic, strong) UILabel *flowCountLable;

@property (nonatomic, strong) TXDoulistsModel *txDoulistModel;


@end
