//
//  WXMRadioListModel.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXMRadioListModel : NSObject

/** 图片 */
@property (nonatomic, strong) NSString *coverimg;

/** isnew */
@property (nonatomic, strong) NSString *isnew;

/** 音乐播放地址 */
@property (nonatomic, strong) NSString *musicUrl;

/** 参与人数  */
@property (nonatomic, strong) NSString *musicVisit;

///** 播放页面信息  */
@property (nonatomic, strong) NSString *playInfo;

/**  ID */
@property (nonatomic, strong) NSString *tingid;

/**  标题 */
@property (nonatomic, strong) NSString *title;


- (instancetype)initWithRadioListDictionary:(NSDictionary *)dict;

+ (instancetype)radioListDictionary:(NSDictionary *)dict;

@end
