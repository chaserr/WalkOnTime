//
//  TXRadioHotListModel.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo_hotlist.h"
@interface TXRadioHotListModel : NSObject

/** 图片*/
@property (nonatomic, copy) NSString *coverimg;

/** 收听人数*/
@property (nonatomic, copy) NSString *count;

/** 简介*/
@property (nonatomic, copy) NSString *desc;

/** radioId*/
@property (nonatomic, copy) NSString *radioid;

/** hotList_userinfo*/
@property (nonatomic, strong) UserInfo_hotlist *userinfo;

/** 标题*/
@property (nonatomic, copy) NSString *title;
@end
