//
//  LoginViewController.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^LoginSuccessBlock)(NSData *userIcon, NSString *userName); // 普通注册
typedef void(^LoginSuccessBlock_collect)(id userInfo, NSString *username);
typedef void(^UserInfo_QQ_Block)(NSString *username , NSString *iconUrlString); // QQ登录成功回调到left控制器
@interface LoginViewController : UIViewController

@property (nonatomic, copy) LoginSuccessBlock successBlock;
@property (nonatomic, copy) LoginSuccessBlock_collect successBlock_collect; // 登录成功回调
@property (nonatomic, copy) UserInfo_QQ_Block userInfo_QQ_Block;
+ (LoginViewController *)shareInstance;



@end
