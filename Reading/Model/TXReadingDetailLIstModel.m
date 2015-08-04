//
//  TXReadingDetailLIstModel.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXReadingDetailLIstModel.h"

@implementation TXReadingDetailLIstModel

- (instancetype)initWithTXReadingDetailLIstModelDictionary:(NSDictionary *)dict{

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)txReadingDetailLIstModelWithDictionary:(NSDictionary *)dict{

    return [[self alloc] initWithTXReadingDetailLIstModelDictionary:dict];
}


- (void)setValue:(id)value forKey:(NSString *)key{

    [super setValue:value forKey:key];
    
    
    if ([key isEqualToString:@"id"]) {
        self.itemId = value;
    }
    
    if ([key isEqualToString:@"typeid"]) {
        self.columnsInfo_typeid = value;
    }
    
    if ([key isEqualToString:@"typename"]) {
        self.columnsInfo_typename = value;
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
