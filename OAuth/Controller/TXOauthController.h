//
//  OauthController.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UserInfo_Sina_Block)(NSString *access_token , NSString *uid); // 登录成功回调到left控制器

@interface TXOauthController : UIViewController

@property (nonatomic, copy) UserInfo_Sina_Block userInfo_Sina_Block;

single_interface(TXOauthController);

@end
