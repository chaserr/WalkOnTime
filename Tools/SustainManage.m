//
//  SustainManage.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "SustainManage.h"
#import "UserMessage.h"
#import "AFHTTPRequestOperationManager.h"
@implementation SustainManage

static SustainManage *manage = nil;
+ (SustainManage *)shareInstance
{
    @synchronized(self){
        if (manage == nil) {
            manage = [[SustainManage alloc] init];//伪单例
        }
    }
    return manage;
}
//用户信息
- (void)synchronized
{
    [[NSUserDefaults standardUserDefaults] synchronize];

}

//设置用户信息（存储用户信息到本地）
- (void)setUserLoginState:(BOOL)isOnline
{

    [[NSUserDefaults standardUserDefaults] setBool:isOnline forKey:@"isOnline"];
}
- (void)setUserName:(NSString *)userName
{

    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"];
}
- (void)setUserPassWord:(NSString *)passWord
{
    [[NSUserDefaults standardUserDefaults] setObject:passWord forKey:@"passWord"];
}

- (void)setUserEmail:(NSString *)email{

    [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"email"];
    
}

- (void)setuserIcon:(NSData *)userIcon{

    [[NSUserDefaults standardUserDefaults] setObject:userIcon forKey:@"userIcon"];
}

- (void)setRememberPasswordState:(BOOL)isRememberPassword{

    [[NSUserDefaults standardUserDefaults] setBool:isRememberPassword forKey:@"isRememberPassword"];
    
}

//获取用户信息
//(登录状态)
- (BOOL)loginState
{

    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isOnline"];
}
//(用户名)
- (NSString *)userName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
}
//（密码）
- (NSString *)passWord
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"];
}

- (NSString *)email{

    return [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
}

- (NSString *)userIcon{

    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userIcon"];
}

- (BOOL)rememberPasswordState
{
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isRememberPassword"];
}



// 用户图像
//- (NSString *)userNameIcon{
//
//    NSString *userIconString = [[NSString alloc] initWithData:userIconString encoding:NSUTF8StringEncoding];
//    return userIconString;
//}

- (UserMessage *)userMessage
{
    UserMessage *userMessage = [[UserMessage alloc] init];
    userMessage.userName = [self userName];
    userMessage.passWord = [self passWord];
    userMessage.emailAddress = [self email];
    userMessage.userIcon = [self userIcon];
    userMessage.rememberPassword = [self rememberPasswordState];
//    userMessage.userNameIcon = [self userNameIcon];
    userMessage.isOnline = YES;
    userMessage.rememberPassword = NO;
    return userMessage;

}

//数据库缓存
//数据库路径
- (NSString *)databaseFilePath:(NSString *)databaseName
{
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [cachesPath stringByAppendingPathComponent:databaseName];
    TXLog(@"数据库路径:walkOnTime.sqlite:>>%@", cachesPath);
}

//将对象归档
- (NSData *)dataOfArchiveObject:(id)object forKey:(NSString *)key
{

    NSMutableData *data = [NSMutableData data];
    //创建归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //归档
    [archiver encodeObject:object forKey:key];
    //结束归档
    [archiver finishEncoding];
    return data;
}

//解档
- (id)unarchiveObject:(NSData *)data forKey:(NSString *)key
{
//创建解档对象
    NSKeyedUnarchiver *unArchived = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    //解档
    id object = [unArchived decodeObjectForKey:key];
    //结束解档
    [unArchived finishDecoding];
    return object;
}
@end
