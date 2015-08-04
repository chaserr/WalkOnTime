//
//  TXSpotrCollectionViewCell.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/11.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXSpotrCollectionViewCell.h"

@implementation TXSpotrCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor redColor];
        // (SCREEN_WIDTH-60)/3
        // 图片
        self.imgView = [[UIImageView alloc ] initWithFrame:CGRectMake(0, 10, (SCREEN_WIDTH-60)/3, 130)];
        _imgView.backgroundColor = [UIColor colorWithRed:0.015 green:0.667 blue:0.614 alpha:1.000];
        _imgView.userInteractionEnabled = YES;
        [self addSubview:_imgView];
        
        
        // 书名
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imgView.frame)+10, (SCREEN_WIDTH-60)/3, kCellDistanceFromLeft)];
        self.nameLabel.font = kTypeLabelFont;
        [self addSubview:_nameLabel];
        
        // 评分
        self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameLabel.frame), (SCREEN_WIDTH-60)/3, kCellDistanceFromLeft-5)];
        _scoreLabel.font = [UIFont systemFontOfSize:11];
        _scoreLabel.textAlignment = NSTextAlignmentLeft;
        //        _scoreLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:_scoreLabel];
        
    }
    return self;
}




@end

