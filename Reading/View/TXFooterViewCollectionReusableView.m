//
//  TXFooterViewCollectionReusableView.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/12.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXFooterViewCollectionReusableView.h"

@implementation TXFooterViewCollectionReusableView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
    }
    return  self;
}

- (UIImageView *)footerImgView{
    
    if (_footerImgView == nil) {
        self.footerImgView = [[UIImageView alloc ] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _footerImgView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_footerImgView];
    }
    
    return _footerImgView;
    
}


@end
