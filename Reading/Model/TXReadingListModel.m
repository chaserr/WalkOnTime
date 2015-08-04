//
//  TXReadingListModel.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXReadingListModel.h"
#import "NSObject+NSCoding.h"
@implementation TXReadingListModel


- (instancetype)initWithTXReadingListDictionary:(NSDictionary *)dictionary{

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dictionary];
    }
    
    return self;
}

+ (instancetype)txReadingListWithDictionary:(NSDictionary *)dictionary{

    return [[self alloc] initWithTXReadingListDictionary:dictionary];
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
