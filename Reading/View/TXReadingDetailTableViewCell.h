//
//  TXReadingDetailTableViewCell.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXReadingDetailLIstModel.h"
@interface TXReadingDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *leftImgView;

@property (nonatomic, strong) UILabel *abstractLabel;

@property (nonatomic, strong) TXReadingDetailLIstModel *txReadingDetailLIstModel;

+ (CGFloat)heightForString:(NSString *)aString;
@end
