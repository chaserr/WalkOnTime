//
//  TXAccountTool.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXAccountTool.h"



// 账号的存储路径
#define TXAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation TXAccountTool


/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(TXAccount *)account
{
    // 获得账号存储的时间（accessToken的产生时间）
    account.created_time = [NSDate date];
    
    // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:TXAccountPath];
}


/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (TXAccount *)account
{
    // 加载模型
    TXAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:TXAccountPath];
    
    /* 验证账号是否过期 */
    
    // 过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    // 获得过期时间
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    // 获得当前时间
    NSDate *now = [NSDate date];
    
    // 如果expiresTime <= now，过期
    /**
     NSOrderedAscending = -1L, 升序，右边 > 左边
     NSOrderedSame, 一样
     NSOrderedDescending 降序，右边 < 左边
     */
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) { // 过期
        return nil;
    }
    
    return account;
}


@end
