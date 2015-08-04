//
//  TXPhotoDoulistModel.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXPhotoDoulistModel : NSObject

/** itemId */
@property (nonatomic, copy) NSString *itemId;
/** title*/
@property (nonatomic, copy) NSString *title;
/** 关注人数*/
@property (nonatomic, copy) NSString *followers_count;
/** 图片*/
@property (nonatomic, copy) NSString *merged_cover_url;

/** 详情url*/
@property (nonatomic, copy) NSString *itemUrl;

- (instancetype)initWithTXPhotoDoulistModelDictionary:(NSDictionary *)dict;

+ (instancetype)txPhotoDoulistsModelWithDictionary:(NSDictionary *)dict;

@end
