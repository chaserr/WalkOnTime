//
//  CollecTableViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "CollecTableViewController.h"
#import "LoginViewController.h"
#import "RadioFavoriteTableViewController.h"
#import "WXMRadioDetailTableViewCell.h"
#import "WCAlertView.h"
@interface CollecTableViewController ()<UIActionSheetDelegate>
@property (nonatomic, retain) NSArray *dataArray;
@end

@implementation CollecTableViewController


// 懒加载
- (NSArray *)dataArray{
    
    if (!_dataArray) {
        self.dataArray = [NSArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSArray arrayWithObjects: @"我的电台",  nil];
    
    if ([[SustainManage shareInstance] loginState]) {
        
        self.navigationItem.title = [[SustainManage shareInstance] userName];
    }else{
    
        self.navigationItem.title = @"我的收藏";
        
    }
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 只显示有cell内容的分割线
    // 第一种方法
    self.tableView.tableFooterView = [[UIView alloc] init];
    // 第二种方法 隐藏系统的所有cell分割线,在自定义cell中封装一条分割线,(UIView高度为0)
    //    - layoutSubviews
    
}


#pragma mark - Table view data source

// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

// 绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollecCell"];
    if (cell == nil) {

        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"CollecCell"];
        
    }

    cell.textLabel.text = _dataArray[indexPath.row];

    
    return cell;
    
}

// 允许选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    if (![[SustainManage shareInstance] loginState]) {
        
        TXLog(@"请登录");
        [WCAlertView showAlertWithTitle:@"请登录后查看" message:nil customizationBlock:^(WCAlertView *alertView) {
            alertView.style = WCAlertViewStyleWhiteHatched;
        } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
            if (buttonIndex == 0) {
                
                // 进入登录界面
                LoginViewController *loginVC = [LoginViewController shareInstance];
                
                [self.navigationController pushViewController:loginVC animated:YES];
                
            }
        } cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        
    }else{
        
        RadioFavoriteTableViewController *radioFavorite = [[RadioFavoriteTableViewController alloc] init];
        
        [self.navigationController pushViewController:radioFavorite animated:YES];
    }

}


// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}
#pragma mark -- 登录





@end
