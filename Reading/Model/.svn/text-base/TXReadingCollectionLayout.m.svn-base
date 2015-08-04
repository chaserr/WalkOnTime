//
//  TXReadingCollectionLayout.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/12.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXReadingCollectionLayout.h"


@implementation TXReadingCollectionLayout


- (instancetype)init{
    
    if (self = [super init]) {
        
        // 初始化
        //        self.itemSize = CGSizeMake(105, 120);
        
    }
    
    return self;
}




// 重新绘制cell大小
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    

    
    NSMutableArray *attribute = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    for (int i = 1; i<attribute.count; ++i) {
        // 当前attribute
        UICollectionViewLayoutAttributes *currentLayoutAttribute = attribute[i];
        
        // 上一个attribute
        UICollectionViewLayoutAttributes *preLaayoutAttribute = attribute[i-1];
        
        //设置最大列间距
        NSInteger maximunSpace = 5;
        
        
        // 前一个cell的最右边
        NSInteger originX = CGRectGetMaxX(preLaayoutAttribute.frame);
//                TXLog(@"前一个item的x:%ld",(long)originX);
        
        
        // 如果当前一个cell的最右边加上刚才设置的间距再加上当前cell的宽度依然是contentSize中,我们改变当前cell的原点位置
        // 不加判断的后果是:UICollectionView只显示一行,原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
        if(originX + maximunSpace + currentLayoutAttribute.frame.size.width < self.collectionViewContentSize.width) {
            CGRect frame = currentLayoutAttribute.frame;
            frame.origin.x = originX + maximunSpace;
            currentLayoutAttribute.frame = frame;
        }
    }
    
    //
    //    for (UICollectionViewLayoutAttributes *atts in attribute) {
    //
    //        TXLog(@"位置:%@", NSStringFromCGRect(atts.frame));
    //    }
    //        return attribute;
    return attribute;
}


/**
 *  只要显示的边界发生改变就重新布局:
 内部会重新调用prepareLayout和layoutAttributesForElementsInRect方法获得所有cell的布局属性
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
}

/**
 *  一些初始化工作最好在这里实现
 */
- (void)prepareLayout{
    [super prepareLayout];
//    CGFloat TXItemW = (SCREEN_WIDTH - 40)/3;
////    TXLog(@"item的宽度:%f",TXItemW);
//     CGFloat TXItemH = 120;
//////    [super prepareLayout];
//    self.itemSize = CGSizeMake(TXItemW, TXItemH);
//    self.sectionInset = UIEdgeInsetsMake(5, 5, 10, 10);
//    self.minimumLineSpacing = 5;
}

@end