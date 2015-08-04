//
//  MyUILabel.m
//  文字靠近顶部
//
//  Created by lanou3g on 15/6/2.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "MyUILabel.h"

@implementation MyUILabel

@synthesize verticalAlignment = verticalAlignment_;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.verticalAlignment = VerticalAlignmentMiddle;
    }
    return self;
}

- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment{
    
    verticalAlignment_ = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
    
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
            
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y +bounds.size.height - textRect.size.height;
            break;
            
        case VerticalAlignmentMiddle:
            
            break;
            
        default:
            textRect.origin.y = bounds.origin.y +(bounds.size.height - textRect.size.height) /2.0;
    }
    return textRect;
}

- (void)drawTextInRect:(CGRect)requestRect{
    
    CGRect actualRect = [self textRectForBounds:requestRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
    
}


@end
