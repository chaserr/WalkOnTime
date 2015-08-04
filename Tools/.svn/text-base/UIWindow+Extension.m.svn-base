//
//  UIWindow+Extension.m
//  黑马微博2期
//
//  Created by apple on 14-10-12.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "TXMainViewController.h"
#import "TXLeftViewController.h"
#import "TXNewFeatureViewController.h"
#import "SLideZoomMenuController.h"
#import "AppDelegate.h"
@implementation UIWindow (Extension)
- (void)switchRootViewController
{

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
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        app.window.rootViewController = slideZoomMenu;
        app.slider = slideZoomMenu;
        
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
@end
