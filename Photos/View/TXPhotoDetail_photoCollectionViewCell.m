//
//  TXPhotoDetail_photoCollectionViewCell.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/26.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXPhotoDetail_photoCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation TXPhotoDetail_photoCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        
        self.collectionImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 170, 150)];
        _collectionImgView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_collectionImgView];
        
        // 遮盖
//        UIView *coverView = [[UIView alloc] initWithFrame:self.bounds];
//        coverView.backgroundColor = [UIColor colorWithRed:0.046 green:0.064 blue:0.184 alpha:0.3];
//        [self.contentView addSubview:coverView];
        

        
    }
    return self;
}


- (void)setTxPhotoDetail_PhotoModel:(TXPhotoDetail_PhotoModel *)txPhotoDetail_PhotoModel{
    
    _txPhotoDetail_PhotoModel = txPhotoDetail_PhotoModel;
    
    // 赋值

    [self.collectionImgView sd_setImageWithURL:[NSURL URLWithString:txPhotoDetail_PhotoModel.merged_cover_url]];
    
}


@end
