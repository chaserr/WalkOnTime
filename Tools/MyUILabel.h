//
//  MyUILabel.h
//  文字靠近顶部
//
//  Created by lanou3g on 15/6/2.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
    
} VerticalAlignment;
@interface MyUILabel : UILabel{
    
@private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;

#pragma mark -- 设置文字居中还是靠近顶端还是接近底部显示
- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment;
@end
