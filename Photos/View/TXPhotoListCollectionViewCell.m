//
//  TXPhotoListCollectionViewCell.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXPhotoListCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation TXPhotoListCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        
        self.collectionImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        _collectionImgView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_collectionImgView];
        
        // 遮盖
        UIView *coverView = [[UIView alloc] initWithFrame:self.bounds];
        coverView.backgroundColor = [UIColor colorWithRed:0.046 green:0.064 blue:0.184 alpha:0.3];
        [self.contentView addSubview:coverView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(_collectionImgView.frame )-25, 50)];
        //        _titleLabel.backgroundColor = [UIColor yellowColor];
        _titleLabel.font = kcollectiontitleFont;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_titleLabel];
        
        self.flowCountLable = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(_collectionImgView.frame)-25, CGRectGetWidth(_collectionImgView.frame), 15)];
        _flowCountLable.font = kcollectionFont;
        _flowCountLable.textColor = [UIColor colorWithWhite:0.841 alpha:1.000];
        [self.contentView addSubview:_flowCountLable];
        
    }
    return self;
}


- (void)setTxPhotoDoulistModel:(TXPhotoDoulistModel *)txPhotoDoulistModel{
    
    _txPhotoDoulistModel = txPhotoDoulistModel;
    
    // 赋值
    self.titleLabel.text = txPhotoDoulistModel.title;
    
    NSString *flowCountLableString = [NSString stringWithFormat:@"%@人关注", txPhotoDoulistModel.followers_count];
    
    self.flowCountLable.text = flowCountLableString;/*txDoulistModel.followers_count;*/
    [self.collectionImgView sd_setImageWithURL:[NSURL URLWithString:txPhotoDoulistModel.merged_cover_url]];
    
}

@end
