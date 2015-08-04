//
//  TXPhotoTableViewCell.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXPhotoListModel.h"

#import "TXTravelListCellForView.h"
@protocol TXPhotoListTableViewCellDelegate <NSObject>

@required
// 标题手势

- (void)txPhotoTableViewCellShowDetailWithTapGesture:(UITapGestureRecognizer *)tapGesture txPhotoListModelWithUrl:(NSString *)urlString;

// 第一本书
- (void)txPhotoTableViewCellShowDetailWithTapGesture:(UITapGestureRecognizer *)tapGesture txPhotoListModelFirstImgWithUrl:(NSString *)urlString;

// 第二本书
- (void)txPhotoTableViewCellShowDetailWithTapGesture:(UITapGestureRecognizer *)tapGesture txPhotoListModelSecondImgWithUrl:(NSString *)urlString;

// 第三本书
- (void)txPhotoTableViewCellShowDetailWithTapGesture:(UITapGestureRecognizer *)tapGesture txPhotoListModelThirdImgWithUrl:(NSString *)urlString;

@end

@interface TXPhotoTableViewCell : UITableViewCell


/**封装查看人数和跳转图片*/
@property (nonatomic, strong) UIView *titleView;

/**第一本书*/
@property (nonatomic, strong) TXTravelListCellForView *first_txTravelListCellForView;

/**第二本书*/
@property (nonatomic, strong) TXTravelListCellForView *second_txTravelListCellForView;

/**第三本书*/
@property (nonatomic, strong) TXTravelListCellForView *third_txTravelListCellForView;

/**标题*/
@property (nonatomic, strong) UILabel *titleLabel;

/**查看人数*/
@property (nonatomic, strong) UILabel *lookCount;

/**跳转图片*/
@property (nonatomic, strong) UIImageView *nextImg;


@property (nonatomic, strong) TXPhotoListModel *txPhotoListModel;

@property (nonatomic, strong) SubjectsModel *subjects;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureWithTitle;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureWithFirstImg;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureWithSecondImg;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureWithThirdImg;

@property (nonatomic, assign) id<TXPhotoListTableViewCellDelegate> delegate;

@end
