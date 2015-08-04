//
//  commonMacro.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#ifndef WalkOnTime_commonMacro_h
#define WalkOnTime_commonMacro_h


//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define IPHONE5 ([UIScreen mainScreen].bounds.size.height == 568)

// 距离cell顶部高度
#define kCellDistanceFromTop 10

// 距离cell左边间距
#define kCellDistanceFromLeft 20

/**类型字体大小*/
#define kTypeLabelFont [UIFont fontWithName:@"Courier" size:12]

/**标题字体大小*/
#define kTitleFont [UIFont fontWithName:@"Helvetica-Bold" size:18]

/**内容字体大小*/
#define kContentFont [UIFont fontWithName:@"Courier" size:13]

/**sectionFont*/
#define ksectionFont [UIFont fontWithName:@"Courier" size:15]


/** 电台列表字体*/
#define kRadioTitleFont [UIFont fontWithName:@"Courier" size:13]

#define kRadioDescFont [UIFont fontWithName:@"Courier" size:10]

/** 旅游界面collction字体*/
#define kcollectionFont [UIFont fontWithName:@"Helvetica-Bold" size:10]

#define kcollectiontitleFont [UIFont fontWithName:@"Helvetica-Bold" size:14]




/** 数据库单例*/
//#import "DataBaseHandle.h"


// sina微博账号的存储路径
#define TXAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

#endif
