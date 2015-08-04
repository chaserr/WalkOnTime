//
//  WXMRadioListModel.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "WXMRadioListModel.h"

@implementation WXMRadioListModel

- (instancetype)initWithRadioListDictionary:(NSDictionary *)dict{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)radioListDictionary:(NSDictionary *)dict{

    return [[self alloc] initWithRadioListDictionary:dict];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    
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
