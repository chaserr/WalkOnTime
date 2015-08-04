//
//  TXTravellistModel.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXTravellistModel.h"
#import "MJExtension.h"
@implementation TXTravellistModel


- (NSDictionary *)objectClassInArray{

    return @{@"subjects" : [SubjectsModel class]};
}



- (NSDictionary *)replacedKeyFromPropertyName{
    
    return @{@"subject_collection_id":@"id", @"subject_collection_url":@"url"};
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