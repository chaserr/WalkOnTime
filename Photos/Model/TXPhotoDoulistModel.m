//
//  TXPhotoDoulistModel.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXPhotoDoulistModel.h"

@implementation TXPhotoDoulistModel

- (instancetype)initWithTXPhotoDoulistModelDictionary:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)txPhotoDoulistsModelWithDictionary:(NSDictionary *)dict{
    
    return  [[self alloc] initWithTXPhotoDoulistModelDictionary:dict];
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
