//
//  SubjectsModel.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "SubjectsModel.h"
#import "MJExtension.h"

@implementation SubjectsModel

- (NSDictionary *)replacedKeyFromPropertyName{
    
    return @{@"itemId":@"id", @"ItemUrl":@"url"};
}

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
