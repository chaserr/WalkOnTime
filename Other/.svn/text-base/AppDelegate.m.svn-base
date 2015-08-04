//
//  AppDelegate.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "AppDelegate.h"
#import "TXLeftViewController.h"
#import "TXMainViewController.h"
#import "TXNewFeatureViewController.h"
#import "SDWebImageManager.h"
#import "UMSocialSinaHandler.h"
#import "UMSocial.h"
#import <TencentOpenAPI/TencentOAuth.h>
@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    // 集成友盟分享
    [UMSocialData setAppKey:@"55a5ed9867e58e2bd100416e"];
    
    // 打开新浪微博SSO开关
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];


    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    TXMainViewController *mainVC = [TXMainViewController shareInstance];
    TXLeftViewController *leftVC = [[TXLeftViewController alloc] init];
    leftVC.selectedIndex = 0; // 设置菜单默认选中栏
    TXNavigationController *nav = [[TXNavigationController alloc] initWithRootViewController:mainVC];
    SLideZoomMenuController *slideZoomMenu = [[SLideZoomMenuController alloc] initWithRootController:nav];
    slideZoomMenu.leftViewController = leftVC;
    self.window.rootViewController = slideZoomMenu;
    self.slider = slideZoomMenu;
    
    // 开机引导页
//    [self newFeature];
    
    // 设置开机启动页面的动画效果
    UIImageView *niceView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 375, 667)];
    niceView.image = [UIImage imageNamed:@"Default.png"];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    [self.window makeKeyAndVisible];
    

    
    //添加到场景
    [self.window addSubview:niceView];
    
    //放到最顶层;
    [self.window bringSubviewToFront:niceView];
    
    //开始设置动画;
    //     第一种方法
  
    [UIView animateWithDuration:2.0 animations:^{
        CGAffineTransform newTransform = CGAffineTransformMakeScale(1.2, 1.2);
        [niceView setTransform:newTransform];
    }completion:^(BOOL finished){
        [UIView animateWithDuration:1.2 animations:^{
            [niceView setAlpha:0];
        } completion:^(BOOL finished){
            [niceView removeFromSuperview];
            [UIApplication sharedApplication].statusBarHidden = NO;
        }];
    }];

    
    
    return YES;
}


// QQ登录
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [TencentOAuth HandleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{

    return [TencentOAuth HandleOpenURL:url];
}

#pragma mark -- 开机引导页
- (void)newFeature{

    //  获取plist文件的version对应的key
    NSString *key = (NSString *)kCFBundleVersionKey;
    // 1.从info.plist中取出版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    
    // 2.从沙盒中取出上一次存储的版本号
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if ([version isEqualToString:saveVersion]) { // 不是第一次使用新版本
        
        
        TXMainViewController *mainVC = [TXMainViewController shareInstance];
        TXLeftViewController *leftVC = [[TXLeftViewController alloc] init];
        leftVC.selectedIndex = 0; // 设置菜单默认选中栏
        TXNavigationController *nav = [[TXNavigationController alloc] initWithRootViewController:mainVC];
        SLideZoomMenuController *slideZoomMenu = [[SLideZoomMenuController alloc] initWithRootController:nav];
        slideZoomMenu.leftViewController = leftVC;
        self.window.rootViewController = slideZoomMenu;
        self.slider = slideZoomMenu;
        
        // 显示状态栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        

    }else{ // 版本号不一样,第一次使用新版本
        
        //        // 将新版本写入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //
        //        // 显示版本新特性界面
        self.window.rootViewController = [[TXNewFeatureViewController alloc] init];
    }

    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{

    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    
    // 取消下载
    [mgr cancelAll];
    
    // 清除内存中的所有图片
    [mgr.imageCache clearMemory];
}

@end
