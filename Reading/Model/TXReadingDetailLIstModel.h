//
//  TXReadingDetailLIstModel.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXReadingDetailLIstModel : NSObject

@property (nonatomic, copy) NSString *columnsInfo_typename;

@property (nonatomic, copy) NSString *columnsInfo_typeid;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *coverimg;

@property (nonatomic, copy) NSString *itemId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *title;


- (instancetype)initWithTXReadingDetailLIstModelDictionary:(NSDictionary *)dict;

+ (instancetype)txReadingDetailLIstModelWithDictionary:(NSDictionary *)dict;


@end
