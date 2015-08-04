//
//  SettingViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "AboutWalkViewController.h"
#import "SuggestOfBackViewController.h"
#import "WCAlertView.h"
#import "LoginViewController.h"
#import "SDWebImageManager.h"
#import "AppDelegate.h"
#import "CollecTableViewController.h"
#import "DataBaseHandle.h"
#import "PrivacyViewController.h"
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property(nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *statueOfLogin;

@property (nonatomic, strong) DataBaseHandle *databaseHandle;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.databaseHandle = [DataBaseHandle sharedDataBaseHandle];
//    self.statueOfLogin = @[@"登录行走·时光", @"注销用户"];
    self.titles = @[@"隐私", @"关于行走",@"所在位置",@"清除缓存",@"我的收藏", @"登录行走·时光", @"退出应用"];
    
   self.navigationItem.title = @"设置";
    
    // 布局tableView
    [self layoutTableView];
    
    // 判断是否登录

    
}

//创建TableView
- (void)layoutTableView
{
        
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
  
    _tableView.delegate  =self;
    _tableView.dataSource = self;
   // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];


}


// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

// row行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
    
}

// row的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_HEIGHT / 11;
}


// cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
    if (cell == nil) {
        // 创建UITableViewCell并且给其设置重用标识,把cell添加到重用队列中
        cell = [[SettingTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"settingCell"];
    }

    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = [NSString stringWithFormat: @"%@",self.titles[indexPath.row]];
    
    if (indexPath.row == 5 && [[SustainManage shareInstance] loginState]) {
        
        cell.textLabel.text = @"注销用户";
    }
    
    
    return cell;
}

// 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == 0) {
        PrivacyViewController *privacyVC = [[PrivacyViewController alloc] init];
        [self.navigationController pushViewController:privacyVC animated:YES];
        TXLog(@"点击关于行走，进入关于行走详情页面");
    }
    if (indexPath.row == 1) {
        AboutWalkViewController *aboutWalkVC = [[AboutWalkViewController alloc] init];
        [self.navigationController pushViewController:aboutWalkVC animated:YES];
        TXLog(@"点击关于行走，进入关于行走详情页面");
    }
    
    if (indexPath.row == 2) {
        
#pragma mark-- 使用系统自带的地图
        SuggestOfBackViewController *suggestOfBackVC = [[SuggestOfBackViewController alloc] init];
        suggestOfBackVC.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:suggestOfBackVC animated:YES];
        TXLog(@"查看所在位置");
        
#pragma mark -- 集成百度地图
        
        
    }
    if (indexPath.row == 3) {
        
        TXLog(@"清除缓存");
        SDWebImageManager *mgr = [SDWebImageManager sharedManager];
        
//        // 取消下载
        [mgr cancelAll];
        
        // 清除内存中的所有图片
        [mgr.imageCache clearMemory];
        // 是否清除缓存
        // 删除操作通常都是很危险的操作,所以通常都会先给出一个警示框,来确认用户是否真的执行该操作
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"清除缓存" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil];
        
        [sheet showInView:self.view];
    }
    if (indexPath.row == 4) {
//        TXLog(@"热点推送");
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(125, SCREEN_HEIGHT/2, 120, 50)];
//        label.alpha = 0.0;
//        [self.view addSubview:label];
//
//        [UIView animateWithDuration:1.0 animations:^{
//            
//            label.frame = CGRectMake(125, SCREEN_HEIGHT/2, 120, 50);
//            label.text = @"敬请期待";
//            label.textColor = [UIColor whiteColor];
//            label.textAlignment = NSTextAlignmentCenter;
//            label.font = ksectionFont;
//            label.backgroundColor = [UIColor colorWithWhite:0.377 alpha:1.000];
//            label.alpha = 1.0;
//            
//        } completion:^(BOOL finished) {
//        
//            [UIView animateWithDuration:0.5 animations:^{
//                label.alpha = 0.0;
//            }];
//            
//            [label removeFromSuperview];
//            
//        }];
        
        // 我的收藏
        CollecTableViewController *collectionView = [[CollecTableViewController alloc] init];
        [self.navigationController pushViewController:collectionView animated:YES];
        
        
        
    }
    if (indexPath.row == 5) {
        
        // 注销用户
        if ([[SustainManage shareInstance] loginState]) {
            SettingTableViewCell *cell = (SettingTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            [WCAlertView showAlertWithTitle:@"" message:@"你确定要退出账号吗?"customizationBlock:^(WCAlertView *alertView) {
                alertView.style = WCAlertViewStyleWhiteHatched;
            } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
                if (buttonIndex == 0) {
                    [self exitUserAccount:(SettingTableViewCell *)cell IndexPath:(NSIndexPath *)indexPath ];
                }
            } cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        }else{
            
            LoginViewController *loginVC = [LoginViewController shareInstance];
            //    TXLog(@"在登录注册里创建的:LoginViewController:%p",mainVC);
            TXNavigationController *nv = [[TXNavigationController alloc] initWithRootViewController:loginVC];
            AppDelegate *app = [UIApplication sharedApplication].delegate;
            app.slider.rootViewController = nv;
            [self presentViewController:nv animated:YES completion:nil];

            
        }

    }
    if (indexPath.row == 6) {
        TXLog(@"点击退出应用，进入退出应用详情页面");
        
        [WCAlertView showAlertWithTitle:@" " message:@"你确定要退出程序吗?"customizationBlock:^(WCAlertView *alertView) {
            alertView.style = WCAlertViewStyleWhiteHatched;
        } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
            if (buttonIndex == 0) {
                [self exitApplication];
            }
        } cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        
        
    }
    
}

#pragma mark -- 注销用户
- (void)exitUserAccount:(SettingTableViewCell *)cell IndexPath:(NSIndexPath *)indexPath{

    TXLog(@"注销用户");
    [[SustainManage shareInstance] setUserLoginState:NO];
    [[SustainManage shareInstance] synchronized];
    cell.textLabel.text = _titles[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"isRememberPasswordState" object:nil];
    
    
}

#pragma mark --ActionSheet delegate(清除缓存)
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:{
            

            // 清除内存中的所有图片
            SDWebImageManager *mgr = [SDWebImageManager sharedManager];

            [self.databaseHandle deleteAlltxRadioListModel]; // 删除收藏
            
            [mgr.imageCache clearMemory];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"清除缓存成功" preferredStyle:UIAlertControllerStyleAlert];
            // 确认按钮
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:nil];
            [alert addAction:confirmAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -- 退出应用程序
- (void)exitApplication {
    
    [UIView beginAnimations:@"exitApplication" context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view.window cache:NO];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];

    
    self.view.window.bounds = CGRectMake(0, 0, 0, 0);
    
    [UIView commitAnimations];
    
}

// 退出程序动画
- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    TXLog(@"程序要推出了");
    if ([animationID compare:@"exitApplication"] == 0) {
        
        if (![[SustainManage shareInstance] rememberPasswordState]) {
            [[SustainManage shareInstance] setUserLoginState:NO];
        }
        
        exit(0);
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
