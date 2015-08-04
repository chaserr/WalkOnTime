//
//  TXMainableViewCell.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXMainViewList.h"

@interface TXMainableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *typeLable; // 类型名

@property (nonatomic, strong) UIImageView *imgView; // 图片

@property (nonatomic, strong) UILabel *titleLabel; // 标题

@property (nonatomic, strong) UILabel *detailLabel; // 内容

@property (nonatomic, strong) UIImageView *loveImgView; // lova图片

@property (nonatomic, strong) UILabel *loveCount; // 收藏人数

@property (nonatomic, strong) UIView *loveView; // 放置空心图和收藏人数


@property (nonatomic, strong) TXMainViewList *txMainList;

/** 计算文字高度*/
+ (CGFloat)heightForString:(NSString *)astring;


@end
