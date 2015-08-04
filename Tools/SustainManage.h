//
//  SustainManage.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserMessage;
@interface SustainManage : NSObject

+ (SustainManage *)shareInstance;

//用户信息
- (void)synchronized;

//设置用户信息
- (void)setUserLoginState:(BOOL)isOnline;
- (void)setUserName:(NSString *)userName;
- (void)setUserPassWord:(NSString *)passWord;
- (void)setUserEmail:(NSString *)email;
- (void)setuserIcon:(NSData *)userIcon;
- (void)setRememberPasswordState:(BOOL)isRememberPassword;
//获取用户信息
- (BOOL)loginState;
- (NSString *)userName;
- (NSString *)passWord;
- (NSString *)email;
- (NSData *)userIcon;
- (BOOL)rememberPasswordState;

- (UserMessage *)userMessage;

//数据库缓存
//数据库路径
- (NSString *)databaseFilePath:(NSString *)databaseName;
//将对象归档
- (NSData *)dataOfArchiveObject:(id)object forKey:(NSString *)key;
//解档
- (id)unarchiveObject:(NSData *)data forKey:(NSString *)key;

//网络监测



@end
