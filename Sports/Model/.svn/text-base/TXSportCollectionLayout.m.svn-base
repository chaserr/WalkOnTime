//
//  TXSportCollectionLayout.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/12.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXSportCollectionLayout.h"

@implementation TXSportCollectionLayout

- (instancetype)init{

    if (self = [super init]) {
        
        // 初始化
        self.itemSize = CGSizeMake((SCREEN_WIDTH-60)/3, 180);
        
    }
    
    return self;
}

// 重新绘制cell大小
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{

    NSMutableArray *attribute = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
//    for (UICollectionViewLayoutAttributes *atts in attribute) {
//        
//        TXLog(@"位置:%@", NSStringFromCGRect(atts.frame));
//    }
//    return attribute;
    
    for (int i = 1; i<attribute.count; ++i) {
        // 当前attribute
        UICollectionViewLayoutAttributes *currentLayoutAttribute = attribute[i];
        
        // 上一个attribute
        UICollectionViewLayoutAttributes *preLaayoutAttribute = attribute[i-1];
        
        //设置最大列间距
        NSInteger maximunSpace = 18;
        
        // 前一个cell的最右边
        NSInteger origin = CGRectGetMaxX(preLaayoutAttribute.frame);
        
        
        
        // 如果当前一个cell的最右边加上刚才设置的间距再加上当前cell的宽度依然是contentSize中,我们改变当前cell的原点位置
        // 不加判断的后果是:UICollectionView只显示一行,原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
        if(origin + maximunSpace + currentLayoutAttribute.frame.size.width < self.collectionViewContentSize.width) {
            CGRect frame = currentLayoutAttribute.frame;
            frame.origin.x = origin + maximunSpace;
            currentLayoutAttribute.frame = frame;
        }
    }
    return attribute;
}

@end
