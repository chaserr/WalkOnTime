//
//  TXRadioHotListModel.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXRadioHotListModel.h"

@implementation TXRadioHotListModel


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self autoEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
        [self autoDecode:aDecoder];
    }
    
    return self;
}

@end
