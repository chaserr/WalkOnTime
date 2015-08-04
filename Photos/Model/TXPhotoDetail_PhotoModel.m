//
//  TXPhotoDetail_PhotoModel.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/26.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXPhotoDetail_PhotoModel.h"

@implementation TXPhotoDetail_PhotoModel

- (instancetype)initWithTXPhotoDetail_photoModelDict:(NSDictionary *)dict{

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)txPhotoDetail_photoModelWithDict:(NSDictionary *)dict{

    return [[self alloc] initWithTXPhotoDetail_photoModelDict:dict];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};

- (void)setValue:(id)value forKey:(NSString *)key{

    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"url"]) {

        self.merged_cover_url  = value;
    }
}

@end
