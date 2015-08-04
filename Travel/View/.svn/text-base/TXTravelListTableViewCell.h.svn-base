//
//  TXTravelListTableViewCell.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXTravelListCellForView.h"
#import "TXTravellistModel.h"
#import "SubjectsModel.h"

@protocol TXTravelListTableViewCellDelegate <NSObject>

@required
// 标题手势

- (void)txTravelListTableViewCellShowDetailWithTapGesture:(UITapGestureRecognizer *)tapGesture txTravellistModelWithUrl:(NSString *)urlString;

// 第一本书
- (void)txTravelListTableViewCellShowDetailWithTapGesture:(UITapGestureRecognizer *)tapGesture txTravellistModelFirstImgWithUrl:(NSString *)urlString;

// 第二本书
- (void)txTravelListTableViewCellShowDetailWithTapGesture:(UITapGestureRecognizer *)tapGesture txTravellistModelSecondImgWithUrl:(NSString *)urlString;

// 第三本书
- (void)txTravelListTableViewCellShowDetailWithTapGesture:(UITapGestureRecognizer *)tapGesture txTravellistModelThirdImgWithUrl:(NSString *)urlString;

@end


@interface TXTravelListTableViewCell : UITableViewCell

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


@property (nonatomic, strong) TXTravellistModel *txTravellistModel;

@property (nonatomic, strong) SubjectsModel *subjects;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureWithTitle;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureWithFirstImg;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureWithSecondImg;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureWithThirdImg;

@property (nonatomic, assign) id<TXTravelListTableViewCellDelegate> delegate;


/** 计算文字高度*/
//+ (CGFloat)heightForString:(NSString *)astring;

@end
