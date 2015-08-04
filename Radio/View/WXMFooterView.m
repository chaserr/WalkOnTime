 //
//  WXMFooterView.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "WXMFooterView.h"

@implementation WXMFooterView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
//        //添加上一曲按钮
//        self.lastSongButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _lastSongButton.frame = CGRectMake(80, 35, 30, 30);
//        _lastSongButton.backgroundColor = [UIColor grayColor];
//        [_lastSongButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [self addSubview:_lastSongButton];
        
        //添加播放按钮
        self.playerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playerButton.frame = CGRectMake(frame.size.width / 2 - 20, (frame.size.height-40)/2, 40, 40);
    [_playerButton setImage:[UIImage imageNamed:@"musicImage"] forState:UIControlStateNormal];
        [self addSubview:_playerButton];
        
        
//        //添加下一曲按钮
//        self.nextSongButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _nextSongButton.frame = CGRectMake(SCREEN_WIDTH - 80 - 30, 35, 30, 30);
//        _nextSongButton.backgroundColor = [UIColor grayColor];
//    [_nextSongButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [self addSubview:_nextSongButton];
        
        
    }
    return self;


}

#pragma mark - 绘制分隔线
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.2);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 5, 0);
    CGContextAddLineToPoint(context, self.frame.size.width - 5, 0);
    CGContextClosePath(context);
    [[UIColor grayColor] setStroke];
    CGContextStrokePath(context);
    
    
}


@end