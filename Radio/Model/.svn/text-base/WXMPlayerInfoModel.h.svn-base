//
//  WXMPlayerInfoModel.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXMPlayerUserModel.h"
#import "WXMPlayerAuthorModel.h"
@interface WXMPlayerInfoModel : NSObject

/**  作者信息 */
@property (nonatomic, strong) WXMPlayerAuthorModel *authorinfo;

/**  用户信息 */
@property (nonatomic, strong) WXMPlayerUserModel *userinfo;

/**  图片地址 */
@property (nonatomic, strong) NSString *imgUrl;


/**  音乐播放地址 */
@property (nonatomic, strong) NSString *musicUrl;

/**  收听题目 */
@property (nonatomic, strong) NSString *title;

/**  webview地址 */
@property (nonatomic, strong) NSString *webview_url;

@property (nonatomic, strong) NSString *contentid;
@property (nonatomic, strong) NSString *tingid;

- (instancetype)initWithPlayerDictionary:(NSDictionary *)dic;
+ (instancetype)playerDictionary:(NSDictionary *)dic;

@end
