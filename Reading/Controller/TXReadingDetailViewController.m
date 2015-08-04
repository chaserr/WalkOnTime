//
//  TXReadingDetailViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXReadingDetailViewController.h"
#import "TXReadingDetailLIstModel.h"
#import "TXReadingDetailTableViewCell.h"
#import "TXArticalDetailViewController.h"
#import "DataBaseHandle.h"
#import "AFNetworking.h"
@interface TXReadingDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView_addTime;
@property (nonatomic, strong) UITableView *tableView_hot;
@property (nonatomic, strong) NSMutableArray *txReadingDetailListArray;
@property (nonatomic, strong) NSMutableArray *txReadingDetailListArray_hot;
@property (nonatomic, strong) DataBaseHandle *dataBaseHandle;
@end

@implementation TXReadingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataBaseHandle = [DataBaseHandle sharedDataBaseHandle];
    
    
    // 监测网络
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {

        if (status <= 0) {

            // 从数据库加载
            NSArray *array = [self.dataBaseHandle resoreTXReadingDetailLIstModel];
            self.txReadingDetailListArray = [NSMutableArray arrayWithArray:array];
            [self.tableView_addTime reloadData];
            
            
        }else{
            
            // 有网从网络加载
            [self loadReadingDetailListData];
        }
        
    }];
    
    // 布局tableView
    [self layoutTableView_addTime];
    
    [self layoutTableView_hot];

    // hot数据请求
    [self loadReadingDetailListData_hot];

    // segumentControl创建
    [self createSegmentControl];
    
}

#pragma mark -- 布局tableView
- (void)layoutTableView_addTime{
    CGFloat tableX = 0;
    CGFloat tableY = 40;
    CGFloat tableW = SCREEN_WIDTH;
    CGFloat tableH = SCREEN_HEIGHT-tableY-64;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableX, tableY, tableW, tableH) style:(UITableViewStylePlain)];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    self.tableView_addTime = tableView;
}

- (void)layoutTableView_hot{

    CGFloat tableX = 0;
    CGFloat tableY = 40;
    CGFloat tableW = SCREEN_WIDTH;
    CGFloat tableH = SCREEN_HEIGHT-tableY-64;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableX, tableY, tableW, tableH) style:(UITableViewStylePlain)];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView_hot = tableView;

}


#pragma mark -- tableView delegate and datasource
// 分区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView == _tableView_hot) {
        return _txReadingDetailListArray_hot.count;
    }else{
    
        return _txReadingDetailListArray.count;
        
    }
    

}

// 绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == _tableView_addTime) {
       
        static NSString *cellForIdentifier = @"TXReadingDetailTableViewCell";
        
        TXReadingDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellForIdentifier];
        if (cell == nil) {
            cell = [[TXReadingDetailTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellForIdentifier];
        }
        
        TXReadingDetailLIstModel *txReadingDetailListModel = _txReadingDetailListArray[indexPath.row];
        
        cell.txReadingDetailLIstModel = txReadingDetailListModel;
        
        return cell;

    }else{
    
        static NSString *cellForIdentifier = @"TXReadingDetailTableViewCell_hot";
        
        TXReadingDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellForIdentifier];
        if (cell == nil) {
            cell = [[TXReadingDetailTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellForIdentifier];
        }
        
        TXReadingDetailLIstModel *txReadingDetailListModel = _txReadingDetailListArray_hot[indexPath.row];

        
        cell.txReadingDetailLIstModel = txReadingDetailListModel;
        
        return cell;
        
    }
    
    
}

// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 130;
}


// 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView_hot) {
        TXArticalDetailViewController *txArticalDetailVC = [[TXArticalDetailViewController alloc] init];
        TXReadingDetailLIstModel *txReadingDetailListModel = _txReadingDetailListArray_hot[indexPath.row];
        txArticalDetailVC.txReadingDetailLIstModel = txReadingDetailListModel;
        [self.navigationController pushViewController:txArticalDetailVC animated:YES];
    }else{
    
        TXArticalDetailViewController *txArticalDetailVC = [[TXArticalDetailViewController alloc] init];
        TXReadingDetailLIstModel *txReadingDetailListModel = _txReadingDetailListArray[indexPath.row];
        txArticalDetailVC.txReadingDetailLIstModel = txReadingDetailListModel;
        [self.navigationController pushViewController:txArticalDetailVC animated:YES];
        
    }
    


}


#pragma mark -- addtime数据请求
- (void)loadReadingDetailListData{

    self.txReadingDetailListArray = [NSMutableArray array]; // 使用懒加载
    
    
    // 1.创建URL对象
    NSURL *url = [NSURL URLWithString:readingDetailList_addTimeUrl];
    
    // 2.创建NSMutableRequest
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
    
    // 3.设置HTTP请求类型
    [mutableRequest setHTTPMethod:@"POST"];
    
    // 设置请求体
    NSString *typeId = self.txReadingListModel.type;
//    TXLog(@"typeId:%@", typeId);
    NSString *bodyString = [NSString stringWithFormat:@"sort=addtime&start=0&client=2&typeid=%@&limit=10", typeId];
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [mutableRequest setHTTPBody:bodyData];
    
    // 使用block进行网络请求
    [NSURLConnection sendAsynchronousRequest:mutableRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //        TXLog(@"请求成功>>>>%@", responseDict[@"data"]);
            NSDictionary *dataDict = responseDict[@"data"];
            
            self.title = [[dataDict objectForKey:@"columnsInfo"] objectForKey:@"typename"];
            
            NSArray *listArray = dataDict[@"list"];
            
#pragma mark -- 设置主页列表
            
            for (NSDictionary *dict in listArray) {
                
                TXReadingDetailLIstModel *txReadingListModel = [TXReadingDetailLIstModel txReadingDetailLIstModelWithDictionary:dict];
                
                [_txReadingDetailListArray addObject:txReadingListModel];
                
                [self.dataBaseHandle saveNewTXReadingDetailLIstModel:txReadingListModel];
                
            }
#warning 在数据请求下来后一定要进行数据刷新
            
            [self.tableView_addTime reloadData];
        }

        
        else{
            
            // 让刷新控件停止显示刷新状态
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                //                [self.header endRefreshing];
                TXLog(@"connectionError%@", connectionError);
                [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试" duration:1];
                
            });
            
        }
    }];

}

#pragma mark -- hot数据请求
- (void)loadReadingDetailListData_hot{
    
    self.txReadingDetailListArray_hot = [NSMutableArray array]; // 使用懒加载
    
    
    // 1.创建URL对象
    NSURL *url = [NSURL URLWithString:readingDetailList_addTimeUrl];
    
    // 2.创建NSMutableRequest
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
    
    // 3.设置HTTP请求类型
    [mutableRequest setHTTPMethod:@"POST"];
    
    // 设置请求体
    NSString *typeId = self.txReadingListModel.type;
    //    TXLog(@"typeId:%@", typeId);
    NSString *bodyString = [NSString stringWithFormat:@"sort=hot&start=0&client=2&typeid=%@&limit=10", typeId];
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [mutableRequest setHTTPBody:bodyData];
    
    // 使用block进行网络请求
    [NSURLConnection sendAsynchronousRequest:mutableRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //        TXLog(@"请求成功>>>>%@", responseDict[@"data"]);
            NSDictionary *dataDict = responseDict[@"data"];
            
            self.title = [[dataDict objectForKey:@"columnsInfo"] objectForKey:@"typename"];
            
            NSArray *listArray = dataDict[@"list"];
            
#pragma mark -- 设置主页列表
            
            for (NSDictionary *dict in listArray) {
                
                TXReadingDetailLIstModel *txReadingListModel = [TXReadingDetailLIstModel txReadingDetailLIstModelWithDictionary:dict];
                
                [_txReadingDetailListArray_hot addObject:txReadingListModel];
                
                
            }
#warning 在数据请求下来后一定要进行数据刷新
            
            [self.tableView_addTime reloadData];
        }
        else{
            
            // 让刷新控件停止显示刷新状态
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                //                [self.header endRefreshing];
                TXLog(@"connectionError%@", connectionError);
                [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试" duration:1];
                
            });
            
        }

        

    }];
    
}

#pragma mark -- 创建SegmentControl
- (void)createSegmentControl{

    NSArray *array = [NSArray arrayWithObjects:@"最新", @"最热",  nil];
    UISegmentedControl *segumengtColtrol = [[UISegmentedControl alloc] initWithItems:array];
    segumengtColtrol.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,  [UIFont fontWithName:@"Helvetica" size:20],NSForegroundColorAttributeName ,[UIColor colorWithRed:0.395 green:0.583 blue:0.826 alpha:1.000],NSForegroundColorAttributeName ,nil];
    [segumengtColtrol setBackgroundImage:[UIImage imageNamed:@"ic_image_pic_bg"] forState:(UIControlStateNormal) barMetrics:UIBarMetricsDefault];
        [segumengtColtrol setBackgroundImage:[UIImage imageNamed:@"abc_list_longpressed_holo.9"] forState:(UIControlStateSelected) barMetrics:UIBarMetricsDefault];
    [segumengtColtrol setTitleTextAttributes:dic forState:UIControlStateNormal];
    [segumengtColtrol setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    // 设置默认选中下标
    segumengtColtrol.selectedSegmentIndex = 0;
    
    // 设置frame
    
    [segumengtColtrol setTintColor:[UIColor whiteColor]];
    
    
    [segumengtColtrol addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segumengtColtrol];
    
}

// segumentControl点击事件
- (void)segmentAction:(UISegmentedControl *)segumentControl{

    switch (segumentControl.selectedSegmentIndex) {
        case 0:{
            TXLog(@"点击了最新的tableview");
            self.tableView_addTime.hidden = NO;
            self.tableView_hot.hidden  = YES;
            
            [self.tableView_addTime reloadData];
        }
            break;
        case 1:{
            
            TXLog(@"点击了最热的tableview,把最新的隐藏掉了");
            [self.view addSubview:_tableView_hot];
            self.tableView_hot.hidden  = NO;
            self.tableView_addTime.hidden = YES;
            [self.tableView_hot reloadData];
        }
            
            break;
        default:
            break;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end