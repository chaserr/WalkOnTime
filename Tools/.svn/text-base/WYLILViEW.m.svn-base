//
//  WYLILViEW.m
//  WYLILView
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#define WYLILHeight frame.size.height
#define WYLILWidth frame.size.width
#import "WYLILViEW.h"

@implementation WYLILViEW

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, WYLILHeight / 3  - 12, WYLILWidth / 10 + 12, WYLILHeight / 3)];
        _firstLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:_firstLabel];
        
        self.image = [[UIImageView alloc] initWithFrame:CGRectMake(WYLILWidth / 5 + 10, 0, WYLILWidth / 7, WYLILHeight / 4 * 2)];
        _image.backgroundColor = [UIColor orangeColor];
        [self addSubview:_image];
        
        self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(WYLILWidth / 2 - 10, WYLILHeight / 3 - 12, WYLILWidth / 2, WYLILHeight / 3)];
        _secondLabel.textAlignment = NSTextAlignmentLeft;
       
        [self addSubview:_secondLabel];
        
    
        
    }
    return self;
}

@end
