//
//  Account.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXAccount : NSObject<NSCoding>

/**　string	用于调用access_token，接口获取授权后的access token。*/
@property (nonatomic, copy) NSString *access_token;

/**　string	access_token的生命周期，单位是秒数。*/
@property (nonatomic, copy) NSNumber *expires_in;

/**　string	当前授权用户的UID。*/
@property (nonatomic, copy) NSString *uid;

/**	access token的创建时间 */
@property (nonatomic, strong) NSDate *created_time;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
