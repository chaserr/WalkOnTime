//
//  DataBaseHandle.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "DataBaseHandle.h"

@implementation DataBaseHandle

single_implementation(DataBaseHandle);


// static的作用,保证db这个变量值被本类直接访问
static sqlite3 *db = nil;


// 打开数据库
- (sqlite3 *)openDatabase{

    if (db != nil) {
        //如果数据库已经打开,直接返回
        return db;
    }
    
    NSString *databasePath = [[SustainManage shareInstance] databaseFilePath:@"walkOnTime.sqlite"];
    
    
    
    int result = sqlite3_open([databasePath UTF8String], &db);
    if (result == SQLITE_OK) {
        
        // 建主页模型表
//        NSString *createTableSql = @"CREATE TABLE HOME_TXMainViewList ('content' TEXT, 'coverimg' TEXT, 'enname' TEXT, 'ID' TEXT PRIMARY KEY, 'name' TEXT, 'title' TEXT, 'like' TEXT, 'type' TEXT, 'uid' TEXT, 'uname' TEXT, 'data' BLOB NOT NULL)";

        
    
        NSString *createTableSql = @"CREATE TABLE HOME_TXMainViewList ('content' TEXT, 'coverimg' TEXT, 'enname' TEXT, 'ID' TEXT PRIMARY KEY, 'name' TEXT, 'title' TEXT, 'like' TEXT, 'type' TEXT,  'data' BLOB NOT NULL)";
        sqlite3_exec(db, [createTableSql UTF8String], NULL, NULL, NULL);
        
        
        // 旅游界面
        // 建主页模型表
        NSString *createTable_Travel = @"CREATE TABLE HOME_TXTravelListModel ('subject_collection_id' TEXT PRIMARY KEY, 'data' BLOB NOT NULL)";
        
        sqlite3_exec(db, [createTable_Travel UTF8String], NULL, NULL, NULL);
        
        // 电影界面
        NSString *createTable_movie = @"CREATE TABLE HOME_TXPhotoListModel ('subject_collection_id' TEXT PRIMARY KEY, 'data' BLOB NOT NULL)";
        
        sqlite3_exec(db, [createTable_movie UTF8String], NULL, NULL, NULL);
        
        // 阅读界面
        NSString *createTable_Reading = @"CREATE TABLE Reading_TXReadingListModel ('coverimg' TEXT, 'enname' TEXT, 'name' TEXT, 'type' TEXT PRIMARY KEY, 'data' BLOB NOT NULL)";
        
        sqlite3_exec(db, [createTable_Reading UTF8String], NULL, NULL, NULL);
 
        NSString *createTable_Reading_detail = @"CREATE TABLE Reading_TXReadingDetailListModel ('typename' TEXT, 'typeid' TEXT , 'content' TEXT, 'coverimg' TEXT , 'itemId' TEXT PRIMARY KEY , 'name' TEXT, 'title' TEXT, 'data' BLOB NOT NULL)";
        
        sqlite3_exec(db, [createTable_Reading_detail UTF8String], NULL, NULL, NULL);
        
        // 电台界面
        NSString *createTable_Radio_allList = @"CREATE TABLE Radio_TXRadioDetailListModel ('coverimg' TEXT, 'count' TEXT , 'desc' TEXT , 'radioid' TEXT PRIMARY KEY, 'title' TEXT, 'data' BLOB NOT NULL)";
        
        sqlite3_exec(db, [createTable_Radio_allList UTF8String], NULL, NULL, NULL);

        
        NSString *createTable_Radio_allList_collec = @"CREATE TABLE Radio_TXRadioDetailListModel_collec ('radioid' TEXT PRIMARY KEY, 'data' BLOB NOT NULL)";
        
        sqlite3_exec(db, [createTable_Radio_allList_collec UTF8String], NULL, NULL, NULL);

    }
    else{
    
        TXLog(@"打开数据库失败");
    }
    
    return db;
}

// 关闭数据库
- (void)closeDatabase{

    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        db = nil;
    }
}

#pragma mark -- 电台界面

/** 电台详情页*/

// 保存电台首页信息
- (void)saveNewTXRadioListModel:(TXRadioListModel *)txRadioListModel{

    [self openDatabase];
    sqlite3_stmt *stmt = nil;
    NSString *inserttxMainViewListSql = @" INSERT INTO Radio_TXRadioDetailListModel (coverimg, count , desc , radioid , title , data ) VALUES (?, ?, ?, ?, ?, ?)";
    int result = sqlite3_prepare_v2(db, [inserttxMainViewListSql UTF8String], -1, &stmt, nil);
    if (result == SQLITE_OK) {
        // 绑定数据
        sqlite3_bind_text(stmt, 1, [txRadioListModel.coverimg UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [txRadioListModel.count UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 3, [txRadioListModel.desc UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 4, [txRadioListModel.radioid UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 5, [txRadioListModel.title UTF8String], -1, nil);
        // 把model对象归档为data
        NSString *archiveKey = [NSString stringWithFormat:@"txRadioListModel%@",txRadioListModel.radioid];
       
        NSData *data = [[SustainManage shareInstance] dataOfArchiveObject:txRadioListModel forKey:archiveKey];
        sqlite3_bind_blob(stmt, 6, [data bytes], (int)[data length], nil);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}

// 获取所有TXReadingListModel数据
- (NSArray *)resoreTXRadioListModel{
    [self openDatabase];
    
    sqlite3_stmt *stmt = nil;
    NSString *selectAllTXRadioListModel = @"SELECT radioid , data FROM Radio_TXRadioDetailListModel";
    int result = sqlite3_prepare_v2(db, [selectAllTXRadioListModel UTF8String], -1, &stmt, NULL);
    
    NSMutableArray *txRadioListModelArray = [NSMutableArray arrayWithCapacity:40];
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSString *radioid = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            NSString *archiveKey = [NSString stringWithFormat:@"txRadioListModel%@",radioid];
            
            // 解档
            TXRadioListModel *txRadioListModel = [[SustainManage shareInstance] unarchiveObject:data forKey:archiveKey];
            [txRadioListModelArray addObject:txRadioListModel];
            
        }
    }
    
    sqlite3_finalize(stmt);
    
    return txRadioListModelArray;
    

    
}

/** 电台详情页 (收藏)*/
// 插入收藏电台信息
- (void)insertNewTXRadioListModel:(TXRadioListModel *)txRadioListModel{
    
    [self openDatabase];
    sqlite3_stmt *stmt = nil;
    NSString *inserttxMainViewListSql = @"insert into Radio_TXRadioDetailListModel_collec (radioid, data ) VALUES (?, ?)";
    int result = sqlite3_prepare_v2(db, [inserttxMainViewListSql UTF8String], -1, &stmt, nil);
    if (result == SQLITE_OK) {
        // 绑定数据
        sqlite3_bind_text(stmt, 1, [txRadioListModel.radioid UTF8String], -1, nil);
       
        
        // 把model对象归档为data
        NSString *archiveKey = [NSString stringWithFormat:@"txRadioListModel_collec%@",txRadioListModel.radioid];
        
        NSData *data = [[SustainManage shareInstance] dataOfArchiveObject:txRadioListModel forKey:archiveKey];
        sqlite3_bind_blob(stmt, 2, [data bytes], (int)[data length], nil);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}

// 获取所有收藏电台
- (NSArray *)selectAllTXRadioListModel{

    [self openDatabase];
    
    sqlite3_stmt *stmt = nil;
    NSString *selectAllTXRadioListModel = @"SELECT radioid , data FROM Radio_TXRadioDetailListModel_collec";
    int result = sqlite3_prepare_v2(db, [selectAllTXRadioListModel UTF8String], -1, &stmt, NULL);
    
    NSMutableArray *txRadioListModelArray = [NSMutableArray arrayWithCapacity:40];
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSString *radioid = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            NSString *archiveKey = [NSString stringWithFormat:@"txRadioListModel_collec%@",radioid];
            
            // 解档
            TXRadioListModel *txRadioListModel = [[SustainManage shareInstance] unarchiveObject:data forKey:archiveKey];
            [txRadioListModelArray addObject:txRadioListModel];
            
        }
    }
    
    sqlite3_finalize(stmt);
    
    return txRadioListModelArray;
    
}


//获取某个收藏的电台对象
- (TXRadioListModel *)selectTXRadioListModelWithID:(NSString *)radioId{
    
    [self openDatabase];
    
    sqlite3_stmt *stmt = NULL;
    
    NSString *selectSql = @"select data from Radio_TXRadioDetailListModel_collec where radioid = ?";
    
    int result = sqlite3_prepare_v2( db, [selectSql UTF8String], -1, &stmt, NULL);
    
    TXRadioListModel *txRadioListModel =nil;
    if (result == SQLITE_OK) {
        // 值的绑定(绑定SQL语句中的?),下面函数的第二个参数sql语句里面的第几个问号,从1开始
        sqlite3_bind_text(stmt, 1, [radioId UTF8String], -1, NULL);
        
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            // 解档
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 0) length:sqlite3_column_bytes(stmt, 0)];
            NSString *archiveKey = [NSString stringWithFormat:@"txRadioListModel_collec%@", radioId];
            
            txRadioListModel = [[SustainManage shareInstance] unarchiveObject:data forKey:archiveKey];
        }
    }
    sqlite3_finalize(stmt);
    //     NSLog(@"-------%@---------", activity);
    return txRadioListModel;
    
}

// 删除电台收藏
- (void)deleteAlltxRadioListModel{
    
#pragma mark -- sqlite3 ios自带原生数据库删除操作
    NSString *deleteSql = @"delete from Radio_TXRadioDetailListModel_collec";
    char *error = nil;
    int result = sqlite3_exec(db, [deleteSql UTF8String], NULL, NULL, &error);
    if (result) {
        NSLog(@"删除成功");
    }
}

// 判断电台是否已被收藏
- (BOOL)isFavoriteTXRadioListModelWithID:(NSString *)radioId{
    
    TXRadioListModel *txRadioListModel = [self selectTXRadioListModelWithID:radioId];
    if (txRadioListModel == nil) {
        return NO;
    }else{
        
        return YES;
        
    }
    
}



#pragma mark -- 首页界面
// 保存主页模型数据
- (void)saveNewTXMainViewList:(TXMainViewList *)txMainViewList{

    [self openDatabase];
    sqlite3_stmt *stmt = nil;
    NSString *inserttxMainViewListSql = @" INSERT INTO HOME_TXMainViewList (content, coverimg , enname , ID , name , title , like  , data ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    int result = sqlite3_prepare_v2(db, [inserttxMainViewListSql UTF8String], -1, &stmt, nil);
    if (result == SQLITE_OK) {
        // 绑定数据
        sqlite3_bind_text(stmt, 1, [txMainViewList.content UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [txMainViewList.coverimg UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 3, [txMainViewList.enname UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 4, [txMainViewList.ID UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 5, [txMainViewList.name UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 6, [txMainViewList.title UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 7, [[NSString stringWithFormat:@"%@", txMainViewList.like] UTF8String], -1, nil);
//        sqlite3_bind_text(stmt, 8, [txMainViewList.uid UTF8String], -1, nil);
//        sqlite3_bind_text(stmt, 9, [txMainViewList.uname UTF8String], -1, nil);
        
        // 把model对象归档为data
        NSString *archiveKey = [NSString stringWithFormat:@"txMainViewList%@",txMainViewList.ID];
        NSData *data = [[SustainManage shareInstance] dataOfArchiveObject:txMainViewList forKey:archiveKey];
        sqlite3_bind_blob(stmt, 8, [data bytes], (int)[data length], nil);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}

// 获取所有模型数据
- (NSArray *)resoreTxMainViewList{

    [self openDatabase];
    
    sqlite3_stmt *stmt = nil;
    NSString *alltxMainViewList = @"SELECT ID , data FROM HOME_TXMainViewList";
    int result = sqlite3_prepare_v2(db, [alltxMainViewList UTF8String], -1, &stmt, NULL);
    
    NSMutableArray *txMainViewListArray = [NSMutableArray arrayWithCapacity:40];
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSString *ID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            NSString *archiveKey = [NSString stringWithFormat:@"txMainViewList%@",ID];
            
            // 解档
            TXMainViewList *txMainViewList = [[SustainManage shareInstance] unarchiveObject:data forKey:archiveKey];
            [txMainViewListArray addObject:txMainViewList];
            
        }
    }
    
    sqlite3_finalize(stmt);
    
    return txMainViewListArray;
}

#pragma mark-- 读书界面
// 保存旅游模型数据
- (void)saveNewTXTravelListModel:(TXTravellistModel *)txTravellistModel{
//    
    [self openDatabase];
    sqlite3_stmt *stmt = nil;
    NSString *inserttxMainViewListSql = @" INSERT INTO HOME_TXTravelListModel ( subject_collection_id, data ) VALUES (?, ?)";
    int result = sqlite3_prepare_v2(db, [inserttxMainViewListSql UTF8String], -1, &stmt, nil);
    if (result == SQLITE_OK) {
        // 绑定数据
        sqlite3_bind_text(stmt, 1, [txTravellistModel.subject_collection.subject_collection_id UTF8String], -1, nil);

        
        // 把model对象归档为data
        NSString *archiveKey = [NSString stringWithFormat:@"txTravellistModel%@",txTravellistModel.subject_collection.subject_collection_id];
        NSData *data = [[SustainManage shareInstance] dataOfArchiveObject:txTravellistModel forKey:archiveKey];
        sqlite3_bind_blob(stmt, 2, [data bytes], (int)[data length], nil);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}

// 获取所有模型数据
- (NSArray *)resoreTXTravellistModel{
    
    [self openDatabase];
    sqlite3_stmt *stmt = nil;
    NSString *alltxMainViewList = @"SELECT subject_collection_id , data FROM HOME_TXTravelListModel";
    int result = sqlite3_prepare_v2(db, [alltxMainViewList UTF8String], -1, &stmt, NULL);
    
    NSMutableArray *txTravellistModelArray = [NSMutableArray arrayWithCapacity:40];
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSString *ID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            NSString *archiveKey = [NSString stringWithFormat:@"txTravellistModel%@",ID];
            
            // 解档
            TXTravellistModel *txTravellistModel = [[SustainManage shareInstance] unarchiveObject:data forKey:archiveKey];
            [txTravellistModelArray addObject:txTravellistModel];
            
        }
    }
    
    sqlite3_finalize(stmt);
    
    return txTravellistModelArray;
}

#pragma mark -- 电影界面
// 保存电影模型数据
- (void)saveNewTXPhotoListModel:(TXPhotoListModel *)txPhotoListModel{
    //
    [self openDatabase];
    sqlite3_stmt *stmt = nil;
    NSString *inserttxMainViewListSql = @" INSERT INTO HOME_TXPhotoListModel ( subject_collection_id, data ) VALUES (?, ?)";
    int result = sqlite3_prepare_v2(db, [inserttxMainViewListSql UTF8String], -1, &stmt, nil);
    if (result == SQLITE_OK) {
        // 绑定数据
        sqlite3_bind_text(stmt, 1, [txPhotoListModel.subject_collection.subject_collection_id UTF8String], -1, nil);
        
        
        // 把model对象归档为data
        NSString *archiveKey = [NSString stringWithFormat:@"txPhotoListModel%@",txPhotoListModel.subject_collection.subject_collection_id];
        NSData *data = [[SustainManage shareInstance] dataOfArchiveObject:txPhotoListModel forKey:archiveKey];
        sqlite3_bind_blob(stmt, 2, [data bytes], (int)[data length], nil);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}

// 获取所有模型数据
- (NSArray *)resoreTXPhotoListModel{
    
    [self openDatabase];
    sqlite3_stmt *stmt = nil;
    NSString *alltxPhotoList = @"SELECT subject_collection_id , data FROM HOME_TXPhotoListModel";
    int result = sqlite3_prepare_v2(db, [alltxPhotoList UTF8String], -1, &stmt, NULL);
    
    NSMutableArray *txPhotoListModelArray = [NSMutableArray arrayWithCapacity:40];
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSString *ID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            NSString *archiveKey = [NSString stringWithFormat:@"txPhotoListModel%@",ID];
            
            // 解档
            TXPhotoListModel *txPhotoListModel = [[SustainManage shareInstance] unarchiveObject:data forKey:archiveKey];
            [txPhotoListModelArray addObject:txPhotoListModel];
            
        }
    }
    
    sqlite3_finalize(stmt);
    
    return txPhotoListModelArray;
}
#pragma mark -- 阅读界面

// 保存TXReadingListModel数据
- (void)saveNewTXReadingListModel:(TXReadingListModel *)txReadingListModel{

    [self openDatabase];
//    TXLog(@"保存阅读界面数据");
    sqlite3_stmt *stmt = nil;
    NSString *inserttxReadingListModelSql = @" INSERT INTO Reading_TXReadingListModel (coverimg , enname , name , type , data ) VALUES (?, ?, ?, ?, ?)";
    int result = sqlite3_prepare_v2(db, [inserttxReadingListModelSql UTF8String], -1, &stmt, nil);
    if (result == SQLITE_OK) {
        // 绑定数据
        sqlite3_bind_text(stmt, 1, [txReadingListModel.coverimg UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [txReadingListModel.enname UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 3, [txReadingListModel.name UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 4, [[NSString stringWithFormat:@"%@", txReadingListModel.type] UTF8String], -1, nil);
 
        // 把model对象归档为data
        NSString *archiveKey = [NSString stringWithFormat:@"txReadingListModel%@",txReadingListModel.type];
        NSData *data = [[SustainManage shareInstance] dataOfArchiveObject:txReadingListModel forKey:archiveKey];
        sqlite3_bind_blob(stmt, 5, [data bytes], (int)[data length], nil);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);

    
}

// 获取所有TXReadingListModel数据
- (NSArray *)resoreTXReadingListModel{

    
    sqlite3_stmt *stmt = nil;
    NSString *alltxReadingListModel = @"SELECT type , data FROM Reading_TXReadingListModel";
    int result = sqlite3_prepare_v2(db, [alltxReadingListModel UTF8String], -1, &stmt, NULL);
    
    NSMutableArray *txReadingListModelArray = [NSMutableArray arrayWithCapacity:40];
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSString *type = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            NSString *archiveKey = [NSString stringWithFormat:@"txReadingListModel%@",type];
            
            // 解档
            TXMainViewList *txMainViewList = [[SustainManage shareInstance] unarchiveObject:data forKey:archiveKey];
            [txReadingListModelArray addObject:txMainViewList];
            
        }
    }
    
    sqlite3_finalize(stmt);
    
    return txReadingListModelArray;
}


// 保存TXReadingListModel数据
- (void)saveNewTXReadingDetailLIstModel:(TXReadingDetailLIstModel *)txReadingDetailLIstModel{
    
        [self openDatabase];
    //    TXLog(@"保存阅读界面数据");
    sqlite3_stmt *stmt = nil;
    NSString *inserttxReadingDetailLIstModelSql = @" INSERT INTO Reading_TXReadingDetailListModel (typename, typeid , content , coverimg , itemId , name, title, data ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    int result = sqlite3_prepare_v2(db, [inserttxReadingDetailLIstModelSql UTF8String], -1, &stmt, nil);
    if (result == SQLITE_OK) {
        // 绑定数据
        sqlite3_bind_text(stmt, 1, [txReadingDetailLIstModel.columnsInfo_typename UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [txReadingDetailLIstModel.columnsInfo_typeid UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 3, [txReadingDetailLIstModel.content UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 4, [txReadingDetailLIstModel.coverimg UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 5, [txReadingDetailLIstModel.itemId UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 6, [txReadingDetailLIstModel.name UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 7, [txReadingDetailLIstModel.title UTF8String], -1, nil);
        // 把model对象归档为data
        NSString *archiveKey = [NSString stringWithFormat:@"txReadingDetailLIstModel%@",txReadingDetailLIstModel.itemId];
        NSData *data = [[SustainManage shareInstance] dataOfArchiveObject:txReadingDetailLIstModel forKey:archiveKey];
        sqlite3_bind_blob(stmt, 8, [data bytes], (int)[data length], nil);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
    
    
}

// 获取所有TXReadingListModel数据
- (NSArray *)resoreTXReadingDetailLIstModel{
    
    
    sqlite3_stmt *stmt = nil;
    NSString *alltxMainViewList = @"SELECT itemId , data FROM Reading_TXReadingDetailListModel";
    int result = sqlite3_prepare_v2(db, [alltxMainViewList UTF8String], -1, &stmt, NULL);
    
    NSMutableArray *txReadingDetailLIstModelArray = [NSMutableArray arrayWithCapacity:40];
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSString *itemId = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            NSString *archiveKey = [NSString stringWithFormat:@"txReadingDetailLIstModel%@",itemId];
            
            // 解档
            TXMainViewList *txMainViewList = [[SustainManage shareInstance] unarchiveObject:data forKey:archiveKey];
            [txReadingDetailLIstModelArray addObject:txMainViewList];
            
        }
    }
    
    sqlite3_finalize(stmt);
    
    return txReadingDetailLIstModelArray;
}




@end