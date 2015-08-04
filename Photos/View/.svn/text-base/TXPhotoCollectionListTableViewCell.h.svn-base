//
//  TXPhotoCollectionListTableViewCell.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXPhotoDoulistModel.h"
@protocol TXPhotoCollectionListTableViewCellDelegate <NSObject>

@optional
- (void)CollectionWithTableViewCellDelegate:(TXPhotoDoulistModel *)txDoulistModel;

@end

@interface TXPhotoCollectionListTableViewCell : UITableViewCell
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign)  id<TXPhotoCollectionListTableViewCellDelegate> delegate;
@end
