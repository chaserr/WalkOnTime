//
//  WXMPlayerInfoModel.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "WXMPlayerInfoModel.h"

@implementation WXMPlayerInfoModel

- (instancetype)initWithPlayerDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }

    return self;

}

+ (instancetype)playerDictionary:(NSDictionary *)dic
{

    return [[self alloc] initWithPlayerDictionary:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

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
