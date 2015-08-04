//
//  TXPhotoViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/11.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXPhotoViewController.h"
#import "TXPhotoTableViewCell.h"
#import "TXPhotoDetailViewController.h"
#import "AFNetworking.h"
#import "TXPhotoListModel.h"
#import "MJExtension.h"
#import "Subject_collection_model.h"
#import "SubjectsModel.h"
#import "TXPhotoCollectionListTableViewCell.h"
#import "TXDoulistsModel.h"
#import "DataBaseHandle.h"
@interface TXPhotoViewController ()<UITableViewDataSource,UITableViewDelegate,TXPhotoListTableViewCellDelegate, TXPhotoCollectionListTableViewCellDelegate>


@property (nonatomic, strong) NSMutableArray *photoListArray; // 大列表

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureWithTitle;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureWithfirstImg;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureWithsecondImg;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureWiththirdImg;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) DataBaseHandle *databaseHandle;
@end

@implementation TXPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"电影";
    
    self.databaseHandle = [DataBaseHandle sharedDataBaseHandle];
    // 监测网络
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status <= 0) {
            
            // 从数据库加载
            NSArray *array = [self.databaseHandle resoreTXTravellistModel];
            self.photoListArray = [NSMutableArray arrayWithArray:array];
            [self.tableView reloadData];
        }else{
            // 有网从网络加载
            
            [self loadData_ptoto];
        }
        
    }];
    
    // 加载数据
//    [self loadData_ptoto];
    
    // 布局旅行的tableView
    [self photoTableView];
    
    
    // 布局感兴趣collectionView
    [self groupCollectionView_photo];
    
    // 布局日记
    [self diaryLayout_photo];
    
}

#pragma mark -- 加载数据
- (void)loadData_ptoto{
    
    self.photoListArray = [NSMutableArray array];
    
    
    // 请求管理者
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    // 请求参数:
    [manger GET:movieUrl parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 请求数据成功
        //         TXLog(@"请求的数据:%@",responseObject[@"subject_collection_boards"]);
        NSArray *subject_collection_boardsArray = responseObject[@"subject_collection_boards"];
        for (NSDictionary *dict in subject_collection_boardsArray) {
            
            // 大字典
            TXPhotoListModel *txPhotoListModel = [TXPhotoListModel objectWithKeyValues:dict];
            [self.photoListArray addObject:txPhotoListModel];
            
            [self.databaseHandle saveNewTXPhotoListModel:txPhotoListModel];
        }
        
        [self.photoListArray addObject:@"1"];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求数据失败
        TXLog(@"错误代码:%@",error);
       
            
            // 让刷新控件停止显示刷新状态
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                //                [self.header endRefreshing];
//                TXLog(@"connectionError%@", connectionError);
                [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试" duration:1];
                
            });
            
        
    }];
    
}

#pragma mark -- 摄影页列表
- (void)photoTableView{
    
    CGFloat tableX = 0;
    CGFloat tableY = 0;
    CGFloat tableW = SCREEN_WIDTH;
    CGFloat tableH = SCREEN_HEIGHT-tableY;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableX, tableY, tableW, tableH) style:(UITableViewStyleGrouped)];
    //    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.showsVerticalScrollIndicator = NO;
    
}

#pragma mark -- tableView Delegate and Datasource
// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _photoListArray.count;
}

// 分区所在行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

// 绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section<self.photoListArray.count-1) {
        static NSString *PhotoCellIdentifier = @"PhotoListTableViewCell";
        
        TXPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PhotoCellIdentifier];
        if (cell == nil) {
            
            cell = [[TXPhotoTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:PhotoCellIdentifier];
        }
        
        TXPhotoListModel *txPhotoListModel = _photoListArray[indexPath.section];
        cell.txPhotoListModel = txPhotoListModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        
        
        
        
        return cell;
    }
    else{
        
        TXPhotoCollectionListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TXPhotoCollectionListTableViewCell"];
        if (cell == nil) {
            cell = [[TXPhotoCollectionListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TXPhotoCollectionListTableViewCell"];
        
        }
        cell.delegate = self;
        return cell;
    }
    return nil;
}

// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 7) {
        return 180;
//        TXLog(@"indexPath.section:%ld", (long)indexPath.section);
    }
    return 240;
}

// 分区头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 5;
    }
    
    return 10;
}


#pragma mark -- 旅行页小组部分
- (void)groupCollectionView_photo{
    
}

#pragma mark -- 旅行页日记部分
- (void)diaryLayout_photo{
    
    
}


#pragma mark -- 进入详情页
- (void)reserviceUrl:(NSString *)urlString{
    
    TXPhotoDetailViewController *txPhotoDetail = [[TXPhotoDetailViewController alloc] init];
    txPhotoDetail.detailWithUrl = urlString;
    [self.navigationController pushViewController:txPhotoDetail animated:YES];
}

#pragma mark --  TXTravelViewControllerCell delegate
// 轻拍标题
- (void)txPhotoTableViewCellShowDetailWithTapGesture:(UITapGestureRecognizer *)tapGesture txPhotoListModelWithUrl:(NSString *)urlString{
    
    [self reserviceUrl:urlString];

}

// 轻拍第一个图片
- (void)txPhotoTableViewCellShowDetailWithTapGesture:(UITapGestureRecognizer *)tapGesture txPhotoListModelFirstImgWithUrl:(NSString *)urlString{
    
    [self reserviceUrl:urlString];
    
}

// 轻拍第二个图片
- (void)txPhotoTableViewCellShowDetailWithTapGesture:(UITapGestureRecognizer *)tapGesture txPhotoListModelSecondImgWithUrl:(NSString *)urlString{
    
    [self reserviceUrl:urlString];
}
// 轻拍第三个图片
- (void)txPhotoTableViewCellShowDetailWithTapGesture:(UITapGestureRecognizer *)tapGesture txPhotoListModelThirdImgWithUrl:(NSString *)urlString{
    
    [self reserviceUrl:urlString];
}


#pragma mark -- TXPhotoCollectionListTableViewCellDelegate
- (void)CollectionWithTableViewCellDelegate:(TXPhotoDoulistModel *)txPhotoDoulistModel{
    
    TXPhotoDetailViewController *txPhotoDetail = [[TXPhotoDetailViewController alloc] init];
    txPhotoDetail.detailWithUrl = txPhotoDoulistModel.itemUrl;
    [self.navigationController pushViewController:txPhotoDetail animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
