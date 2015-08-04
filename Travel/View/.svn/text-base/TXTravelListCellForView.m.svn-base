//
//  TXTravelListCellForView.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXTravelListCellForView.h"

@implementation TXTravelListCellForView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        // 图片
        self.imgView = [[UIImageView alloc ] initWithFrame:CGRectMake(10, 10, (SCREEN_WIDTH-60)/3, 130)];
        _imgView.backgroundColor = [UIColor lightGrayColor];
        _imgView.userInteractionEnabled = YES;
        [self addSubview:_imgView];
        

        // 书名
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_imgView.frame)+10, (SCREEN_WIDTH-60)/3, kCellDistanceFromLeft)];
        self.nameLabel.font = kTypeLabelFont;
        [self addSubview:_nameLabel];
        

//        // 星级
//        self.startView = [[UIView alloc] initWithFrame:CGRectMake(kCellDistanceFromTop, CGRectGetMaxY(_nameLabel.frame), (SCREEN_WIDTH-60)/3-20, kCellDistanceFromLeft-5)];
//        _startView.backgroundColor = [UIColor greenColor];
//        [self addSubview:_startView];
        
//        //
//        self.imgView = [[UIImageView alloc ] initWithFrame:CGRectMake(0, 0, 24, 24)];
//        _imgView.backgroundColor = [UIColor lightGrayColor];
//        [_startView addSubview:_imgView];
        
        // 评分
//        self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_startView.frame), CGRectGetMaxY(_nameLabel.frame), 20, kCellDistanceFromLeft-5)];
//        _scoreLabel.font = [UIFont systemFontOfSize:11];
//        _scoreLabel.textAlignment = NSTextAlignmentLeft;
//        _scoreLabel.backgroundColor = [UIColor yellowColor];
//        [self addSubview:_scoreLabel];
        
        
        self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCellDistanceFromTop, CGRectGetMaxY(_nameLabel.frame), (SCREEN_WIDTH-60)/3, kCellDistanceFromLeft-5)];
        _scoreLabel.font = [UIFont systemFontOfSize:11];
        _scoreLabel.textAlignment = NSTextAlignmentLeft;
//        _scoreLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:_scoreLabel];
        
    }
    return self;
}




@end
