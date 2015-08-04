//
//  TXReadingListModel.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXReadingListModel : NSObject

@property (nonatomic, copy) NSString *coverimg;
@property (nonatomic, copy) NSString *enname;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;


- (instancetype)initWithTXReadingListDictionary:(NSDictionary *)dictionary;

+ (instancetype)txReadingListWithDictionary:(NSDictionary *)dictionary;


@end
