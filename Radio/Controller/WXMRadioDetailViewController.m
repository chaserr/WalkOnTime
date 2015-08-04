//
//  WXMRadioDetailViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//
#define kCellHight  ((SCREEN_WIDTH-30)/3)      //WXMRadioDetailTableViewCell的高度
//#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)//屏幕宽度

#import "WXMRadioDetailViewController.h"
#import "WXMRadioDetailTableViewCell.h"
#import "WXMRadioListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "WXMUserInfoModel.h"
#import "WXMRadioInfoModel.h"
#import "WXMRadioListModel.h"
#import "TXRadioListModel.h"
#import "MJExtension.h"
#import "WXMPlayerViewController.h"
#import "LoginViewController.h"
#import "DataBaseHandle.h"
@interface WXMRadioDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *radioListArray;

@property (nonatomic, strong) NSMutableArray *radioInfoArray;

@property (nonatomic, strong) DataBaseHandle *databaseHandle;


@end

@implementation WXMRadioDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.databaseHandle = [DataBaseHandle sharedDataBaseHandle];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.titles;
    // 收藏按钮
    UIButton *rightButton_collec = [UIButton buttonWithType:(UIButtonTypeCustom)];
    rightButton_collec.frame = CGRectMake(0, 0, 21, 17);
    //    leftButton.backgroundColor = [UIColor redColor];
    [rightButton_collec setImage:[UIImage imageNamed:@"ic_heart_withe"] forState:(UIControlStateNormal)];
    
    [rightButton_collec addTarget:self action:@selector(clickCollect_radio:) forControlEvents:(UIControlEventTouchUpInside)];
    self.button_collect = rightButton_collec;
    UIBarButtonItem *rightBtn_collection = [[UIBarButtonItem alloc] initWithCustomView:_button_collect];
    

    self.navigationItem.rightBarButtonItem = rightBtn_collection;
    
    //加载电台详情数据
    [self loadRadioDetailData];
    
    //布局headView
    [self layoutHeadView];
    
    //布局tableView
    [self layoutTableView];

}

#pragma mark - 数据请求
- (void)loadRadioDetailData
{
      //创建URL对象
    NSURL *url = [NSURL URLWithString:radioDetailUrl];
    
    //创建NSMutableRequest
    NSMutableURLRequest *mutableRequst = [NSMutableURLRequest requestWithURL:url];
    
    //设置HTTP请求类型
    [mutableRequst setHTTPMethod:@"POST"];
    
    //设置请求体
     // cellID（需获取上个页面的ID，嵌入到请求体中）
    NSString *bodyString = [NSString stringWithFormat:@"auth=&client=1&deviceid=19277E37-CDE3-4691-BCE3-FEA693CA2BC6&radioid=%@&version=3.0.4",self.radioId];
//    TXLog(@"bodyString:%@>>>>",bodyString);

    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [mutableRequst setHTTPBody:bodyData];
    
    //使用Block进行网络请求
    [NSURLConnection sendAsynchronousRequest:mutableRequst queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data) {
#pragma mark - 设置WXMRadioDetailTableViewCell
            self.radioInfoArray = [NSMutableArray array];
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //        TXLog(@"===%@", responseDict);
            NSDictionary *dataDict = responseDict[@"data"];
            NSDictionary *radioInfoDict = dataDict[@"radioInfo"];
            //        TXLog(@"===%@", radioInfoDict);
            //第三方MJExtension（字典封装成对象）
            WXMRadioInfoModel *wxmRadioInfoModel = [WXMRadioInfoModel  objectWithKeyValues:radioInfoDict];
            [_radioInfoArray addObject:wxmRadioInfoModel];
            //        TXLog(@"===%@", _radioInfoArray);
            
#pragma mark - 设置headView
            [self.headView sd_setImageWithURL:radioInfoDict[@"coverimg"]];
            
            
#pragma mark - 设置WXMRadioListTableViewCell
            self.radioListArray = [NSMutableArray array];
            NSArray *radioListArray = dataDict[@"list"];
            for (NSDictionary  *dict in radioListArray) {
                
                WXMRadioListModel *wxmRadioListModel = [WXMRadioListModel radioListDictionary:dict];
                
                [_radioListArray addObject:wxmRadioListModel];
                
                
            }
            
#pragma mark - 数据刷新
            [self.tableView reloadData];
        }
        else{
            
            // 让刷新控件停止显示刷新状态
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                TXLog(@"connectionError%@", connectionError);
                [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试" duration:1];
                
            });
            
        }
    }];

}

#pragma mark -- 收藏
- (void)clickCollect_radio:(UIButton *)button{

    
    // 判断用户是否登录,如果登录直接收藏,否则,进入登录界面,登录成功后自动执行收藏
    BOOL isLogin = [[SustainManage shareInstance] loginState];
    if (isLogin == YES) {
        // 用户已经登录,收藏活动
        TXLog(@"收藏");
        [self favoriteActivity];
        
    }else{
        // 用户没有登录,先登录
        [self userLogin];
    }
    
}

// 电台收藏
- (void)favoriteActivity{
    
    // 判断活动是否被收藏,弹出提示框告知用户,如果没有收藏,则收藏
    BOOL isFavorite = [[DataBaseHandle sharedDataBaseHandle] isFavoriteTXRadioListModelWithID:self.txRadioListModel.radioid];
    if (isFavorite == YES) {
//        NSLog(@"电台已经收藏");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"该电台已经被收藏" preferredStyle:UIAlertControllerStyleAlert];
        // 确认按钮
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:nil];
        [alert addAction:confirmAction];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        
        [[DataBaseHandle sharedDataBaseHandle] insertNewTXRadioListModel:self.txRadioListModel];
        [self.button_collect setImage:[UIImage imageNamed:@"ic_heart_red"] forState:(UIControlStateNormal)];
    }
}

// 用户登录
- (void)userLogin{
    
    // 进入登录界面
    LoginViewController *loginVC = [LoginViewController shareInstance];
    __weak WXMRadioDetailViewController *detailVC = self;
    loginVC.successBlock_collect = ^(id userInfo, NSString *username){
        
        // 收藏电台
        [detailVC favoriteActivity];
    };
    
    [self.navigationController pushViewController:loginVC animated:YES];
    
    
}


#pragma mark - 布局headView
- (void)layoutHeadView
{
    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    headView.backgroundColor = [UIColor colorWithRed:0.500 green:0.329 blue:0.399 alpha:0.3];
    [self.view addSubview:headView];
    self.headView = headView;

}

#pragma mark - 布局tableView
- (void)layoutTableView
{

    CGFloat tableX = 0;
    CGFloat tableY = 0;
    CGFloat tableW = SCREEN_WIDTH;
    CGFloat tableH = SCREEN_HEIGHT-64;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableX, tableY, tableW, tableH) style:(UITableViewStylePlain)];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.tableHeaderView = _headView;
    
    

}

#pragma mark - tableViewDelegate && tableViewDataSource
//分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return _radioListArray.count;
}
//绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0 && indexPath.row == 0) {
        static NSString *RadioIdentifer = @"WXMRadioDetailTableViewCell";
        WXMRadioDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RadioIdentifer];
        
        if (cell == nil) {
            cell = [[WXMRadioDetailTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:RadioIdentifer];
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
//            cell.selectedBackgroundView = [[UIView alloc] init];
//            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        WXMRadioInfoModel  *wxmRadioInfoModel = [_radioInfoArray firstObject];
        
        cell.wxmRadioInfoModel = wxmRadioInfoModel;
        
        return cell;
    }else{
    
    static NSString *RadioListIdentifer = @"WXMRadioListTableViewCell";
        WXMRadioListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RadioListIdentifer];
        if (cell == nil) {
            cell = [[WXMRadioListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RadioListIdentifer];
        }
    
        WXMRadioListModel *wxmRadioListModel = _radioListArray[indexPath.row];
        cell.wxmRadioListModel = wxmRadioListModel;
        return cell;
    }
}

//分区头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0  ) {
        return 0;
    }
    return 0;
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
       return kCellHight - 20;
        
    }
    return 80;

}

//选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        
        WXMPlayerViewController *wxmPlayerView = [[WXMPlayerViewController alloc] init];
        
        WXMRadioListTableViewCell *cell =( WXMRadioListTableViewCell * )[tableView cellForRowAtIndexPath:indexPath];
        wxmPlayerView.wxmRadioListModel = cell.wxmRadioListModel;
        
        [self.navigationController pushViewController:wxmPlayerView animated:YES];

    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
