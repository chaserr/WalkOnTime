//
//  TXDoulistsModel.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/11.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXDoulistsModel.h"

@implementation TXDoulistsModel

- (instancetype)initWithTXDoulistModelDictionary:(NSDictionary *)dict{

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)txDoulistsModelWithDictionary:(NSDictionary *)dict{

    return  [[self alloc] initWithTXDoulistModelDictionary:dict];
}


- (void)setValue:(id)value forKey:(NSString *)key{

    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        self.itemId = value;
    }
    
    if ([key isEqualToString:@"url"]) {
        self.itemUrl = value;
    }
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