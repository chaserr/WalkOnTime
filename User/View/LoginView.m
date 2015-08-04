//
//  LoginView.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.2);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 5, 60);
    CGContextAddLineToPoint(context, self.frame.size.width - 5, 60);
    CGContextClosePath(context);
    [[UIColor grayColor] setStroke];
    CGContextStrokePath(context);
    
    
}


@end
