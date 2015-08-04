//
//  TXMainViewList.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXMainViewList.h"
#import "NSObject+NSCoding.h"
@implementation TXMainViewList

- (instancetype)initWithMainViewListDictionary:(NSDictionary *)dict{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

// 便利构造器
+ (instancetype)txMainViewListWithDictionary:(NSDictionary *)dict{

    return [[self alloc] initWithMainViewListDictionary:dict];
}

// 重写setValueforkey方法

- (void)setValue:(id)value forKey:(NSString *)key{
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
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


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
 
//    TXLog(@"属性缺省");
    
}
@end
