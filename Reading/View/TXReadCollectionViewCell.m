//
//  TXReadCollectionViewCell.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/12.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXReadCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation TXReadCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.collectionImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 20)/ 3, (SCREEN_WIDTH - 20)/ 3)];
        _collectionImgView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_collectionImgView];
        
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(_collectionImgView.frame)-25, CGRectGetWidth(_collectionImgView.frame), 15)];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLabel];
        
    }
    return self;
}

- (void)setTxReadingListModel:(TXReadingListModel *)txReadingListModel{

    _txReadingListModel = txReadingListModel;
    
    // 赋值
    [_collectionImgView sd_setImageWithURL:[NSURL URLWithString:txReadingListModel.coverimg]];
    NSString *titleString = [NSString stringWithFormat:@"%@ %@", txReadingListModel.name, txReadingListModel.enname];
    _titleLabel.text = titleString;
    
}

@end
