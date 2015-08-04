
//
//  NSString+TXTrimming.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "NSString+TXTrimming.h"

@implementation NSString (TXTrimming)

- (NSString *)trimming{

    return [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
}

@end
