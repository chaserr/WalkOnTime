//
//  TXPhotoDetail_PhotoModel.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/26.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXPhotoDetail_PhotoModel : NSObject

@property (nonatomic, copy) NSString *image;

@property (nonatomic, strong) NSString *merged_cover_url;

- (instancetype)initWithTXPhotoDetail_photoModelDict:(NSDictionary *)dict;

+ (instancetype)txPhotoDetail_photoModelWithDict:(NSDictionary *)dict;

@end
