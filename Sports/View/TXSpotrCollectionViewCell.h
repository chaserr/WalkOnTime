//
//  TXSpotrCollectionViewCell.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/11.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXSpotrCollectionViewCell : UICollectionViewCell

/**名称*/
@property (nonatomic, strong) UILabel *nameLabel;

/**图片*/
@property (nonatomic, strong) UIImageView *imgView;

/**评分*/
@property (nonatomic, strong) UILabel *scoreLabel;

@property (nonatomic, strong) UIView *startView;

@end
