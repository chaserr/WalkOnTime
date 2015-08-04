//
//  CollectionWithTableViewCell.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/11.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TXDoulistsModel;
@protocol CollectionWithTableViewCellDelegate <NSObject>

@optional
- (void)CollectionWithTableViewCellDelegate:(TXDoulistsModel *)txDoulistModel;

@end

@interface CollectionWithTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign)  id<CollectionWithTableViewCellDelegate> delegate;



@end
