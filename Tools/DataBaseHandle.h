//
//  DataBaseHandle.h
//  WalkOnTime
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TXMainViewList.h"
#import "TXRadioListModel.h"
#import "TXReadingListModel.h"
#import "TXPhotoListModel.h"
#import "TXTravellistModel.h"
#import "TXReadingDetailLIstModel.h"
#import "TXRadioListModel.h"
#import "WXMRadioListModel.h"
#import "TXPhotoListModel.h"
#import <sqlite3.h>
@interface DataBaseHandle : NSObject

single_interface(DataBaseHandle)

// 打开数据库
- (sqlite3 *)openDatabase;

// 关闭数据库
- (void)closeDatabase;

#pragma mark -- 首页界面
// 保存主页模型数据
- (void)saveNewTXMainViewList:(TXMainViewList *)txMainViewList;

// 获取所有模型数据
- (NSArray *)resoreTxMainViewList;

#pragma mark -- 旅游界面
// 保存模型数据
- (void)saveNewTXTravelListModel:(TXTravellistModel *)txTravellistModel;

// 获取所有模型数据
- (NSArray *)resoreTXTravellistModel;

#pragma mark-- 电影界面
- (void)saveNewTXPhotoListModel:(TXPhotoListModel *)txPhotoListModel;

- (NSArray *)resoreTXPhotoListModel;
#pragma mark -- 阅读界面

// 保存TXReadingListModel数据
- (void)saveNewTXReadingListModel:(TXReadingListModel *)txReadingListModel;

// 获取所有TXReadingListModel数据
- (NSArray *)resoreTXReadingListModel;

// 保存TXReadingDetailLIstModel数据
- (void)saveNewTXReadingDetailLIstModel:(TXReadingDetailLIstModel *)txReadingDetailLIstModel;

// 获取所有TXReadingDetailLIstModel数据
- (NSArray *)resoreTXReadingDetailLIstModel;



#pragma mark -- 电台界面

/** 电台详情页 (收藏)*/
// 保存TXReadingListModel数据
- (void)saveNewTXRadioListModel:(TXRadioListModel *)txRadioListModel;

// 获取所有TXReadingListModel数据
- (NSArray *)resoreTXRadioListModel;

//获取某个收藏的电台对象
- (TXRadioListModel *)selectTXRadioListModelWithID:(NSString *)radioId;

// 删除电台收藏
- (void)deleteAlltxRadioListModel;

// 判断电台是否已被收藏
- (BOOL)isFavoriteTXRadioListModelWithID:(NSString *)ID;

// 插入收藏电台信息
- (void)insertNewTXRadioListModel:(TXRadioListModel *)txRadioListModel;

- (NSArray *)selectAllTXRadioListModel;
@end
