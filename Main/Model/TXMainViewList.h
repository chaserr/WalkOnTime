//
//  TXMainViewList.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXMainViewList : NSObject

/**内容*/
@property (nonatomic, copy) NSString *content;

/**图片*/
@property (nonatomic, copy) NSString *coverimg;

/**类型名*/
@property (nonatomic, copy) NSString *enname;

/**id*/
@property (nonatomic, copy) NSString *ID;

/**类型名称*/
@property (nonatomic, copy) NSString *name;

/**标题*/
@property (nonatomic, copy) NSString *title;

/**收藏人数*/
@property (nonatomic, copy) NSString *like;

/**类型*/
@property (nonatomic, copy) NSString *type;

/**作者id*/
@property (nonatomic, copy) NSString *uid;

/**作者名*/
@property (nonatomic, copy) NSString *uname;

/**列表总数*/
@property (nonatomic, copy) NSString *total;


- (instancetype)initWithMainViewListDictionary:(NSDictionary *)dict;

// 便利构造器
+ (instancetype)txMainViewListWithDictionary:(NSDictionary *)dict;




@end
