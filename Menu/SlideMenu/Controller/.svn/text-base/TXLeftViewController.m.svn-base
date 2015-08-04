//
//  TXLeftViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXLeftViewController.h"
#import "AppDelegate.h"
#import "LeftTableViewCell.h"
#import "TXMainViewController.h"
#import "TXRadioViewController.h"
#import "TXTravelViewController.h"
#import "TXPhotoViewController.h"
#import "TXReadingViewController.h"
#import "SettingViewController.h"
#import "LoginViewController.h"
#import "UIButton+colorWithBackground.h"
#import "TXOauthController.h"
#import "TXAccountTool.h"
#import "TXAccount.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
@interface TXLeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) BOOL isNight;
@property(nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) TXAccount *account;

@end

@implementation TXLeftViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 用户选择记住密码
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rememberPasswordSuccess:) name:@"isRememberPasswordState" object:nil];
    
    self.titles = @[@"首页", @"图书",@"电影",@"阅读",@"电台"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 布局用户头像,昵称
    self.picImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40, 60, 60)];
    
    self.picImgView.layer.cornerRadius = 30;
    self.picImgView.layer.masksToBounds = YES;
    self.picImgView.backgroundColor = [UIColor colorWithRed:0.667 green:0.621 blue:0.627 alpha:1.000];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickUserIcon:)];
    [_picImgView addGestureRecognizer:tapGesture];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_picImgView];

    //创建登录注册按钮
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame = CGRectMake(0, CGRectGetMaxY(_picImgView.frame)+20, SCREEN_WIDTH / 3, 20);
    _loginButton.backgroundColor = [UIColor clearColor];
    _loginButton.titleLabel.font = ksectionFont;
    [self.loginButton addTarget:self action:@selector(gotoLoginView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];

#pragma mark -- 设置用户图像
    
    _picImgView.image = [UIImage imageNamed:@"ic_default_head"];
    [_loginButton setTitle:@"登录/注册" forState: UIControlStateNormal];
    _loginButton.userInteractionEnabled = YES;
  
#pragma mark -- 如果用户登录成功,返回此处调用block及时修改用户图像和名称
    LoginViewController *loginVC = [LoginViewController shareInstance];
    loginVC.successBlock = ^(NSData *userIcon, NSString *userName){
        
        _picImgView.image = [UIImage imageWithData:userIcon];
        
        // 用户名
        [_loginButton setTitle:userName forState: UIControlStateNormal];
        
        _loginButton.userInteractionEnabled = NO;
        
    };
    
#pragma mark -- 如果用户第三方sina授权成功,返回此处调用block及时修改用户图像和名称
#warning 第三方sina授权登录是否成功 此处创建授权页面,在回调的时候会再次加载页面从而导致回到主页后会出现HUD的bug?
    TXOauthController *txoauthVC = [TXOauthController sharedTXOauthController];
    txoauthVC.userInfo_Sina_Block = ^(NSString *access_token , NSString *uid){
    
        
        // 设置用户登录状态
        [[SustainManage shareInstance] setUserLoginState:YES];
        [[SustainManage shareInstance] synchronized];

        [self invokBlockOfThirdLogin:(NSString *)access_token Uid:(NSString *)uid];
    };
    
#pragma mark -- 判断用户是否自动登录.如果自动登录那么刚进应用的时候就设置为记录的用户名 ,默认记住用户名
    if ([[SustainManage shareInstance] rememberPasswordState]) {
        
        [[SustainManage shareInstance] setUserLoginState:YES];
        [[SustainManage shareInstance] synchronized];
        // 用户成功登录
        _picImgView.image = [UIImage imageWithData:[[SustainManage shareInstance] userIcon]];
        
        // 用户名
        [_loginButton setTitle:[[SustainManage shareInstance] userName] forState: UIControlStateNormal];
        
        _loginButton.userInteractionEnabled = NO;

        
    }

    // 创建侧边菜单tableView
    [self layoutTableView];
    
    // 布局设置和夜间按钮
    self.setBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _setBtn.frame = CGRectMake(20, SCREEN_HEIGHT - 100, 50, 40);
    [_setBtn setTitle:@"设置" forState:(UIControlStateNormal)];
    _setBtn.tintColor = [UIColor blackColor];
    [_setBtn addTarget:self action:@selector(clickSet:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_setBtn];
    
    self.nightPattem = [UIButton buttonWithType:UIButtonTypeCustom];
    _nightPattem.frame = CGRectMake(90, SCREEN_HEIGHT - 100, 50, 40);
    [_nightPattem setTitle:@"夜间" forState:(UIControlStateNormal)];
    [_nightPattem setTitle:@"白天" forState:(UIControlStateSelected)];
    _nightPattem.titleLabel.font = [UIFont systemFontOfSize:14];
    [_nightPattem setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
    [_nightPattem setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_nightPattem setBackgroundColor:[UIColor clearColor] forState:(UIControlStateNormal)];
    [_nightPattem setBackgroundColor:[UIColor clearColor] forState:(UIControlStateSelected)];
    _nightPattem.imageView.backgroundColor = [UIColor clearColor];
    _nightPattem.selected = NO;
    // 当按钮在高亮的时候不需要变成灰色
    _nightPattem.adjustsImageWhenHighlighted = NO;
    [_nightPattem addTarget:self action:@selector(changePattem:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_nightPattem];

    }
#pragma mark -- 创建tableView
- (void)layoutTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, SCREEN_HEIGHT - 200) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate  =self;
    _tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [self performSelector:@selector(setupSlected) withObject:nil afterDelay:0.01];

}

- (void)setupSlected
{
    [self tableView:[self tableView] didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
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
    return 44;
}

// cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"LeftCell";
    
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        // 创建UITableViewCell并且给其设置重用标识,把cell添加到重用队列中
        cell = [[LeftTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = [NSString stringWithFormat: @"%@",self.titles[indexPath.row]];
    
    return cell;
}

// 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    if (indexPath.row == 0) { // 首页
        TXMainViewController *homeVC = [TXMainViewController shareInstance];
        TXNavigationController *nav = [[TXNavigationController alloc] initWithRootViewController:homeVC];
        app.slider.rootViewController = nav;
    }
    else if(indexPath.row == 1) { // 旅行
        TXTravelViewController *mainVC = [[TXTravelViewController alloc] init];
        TXNavigationController *nav = [[TXNavigationController alloc] initWithRootViewController:mainVC];
        app.slider.rootViewController = nav;
    }
    else if(indexPath.row == 2) { // 摄影
        TXPhotoViewController *mainVC = [[TXPhotoViewController alloc] init];
        TXNavigationController *nav = [[TXNavigationController alloc] initWithRootViewController:mainVC];
        app.slider.rootViewController = nav;
    }
    else if(indexPath.row == 3) { // 阅读
        TXReadingViewController *mainVC = [[TXReadingViewController alloc] init];
        TXNavigationController *nav = [[TXNavigationController alloc] initWithRootViewController:mainVC];
        app.slider.rootViewController = nav;
    }
    else if(indexPath.row == 4) { // 电台
        TXRadioViewController *mainVC = [[TXRadioViewController alloc] init];
        TXNavigationController *nav = [[TXNavigationController alloc] initWithRootViewController:mainVC];
        app.slider.rootViewController = nav;
    }
    
}


#pragma mark -- 若用户选择注销用户
- (void)rememberPasswordSuccess:(NSNotificationCenter *)notificationCenter{

    _picImgView.image = [UIImage imageNamed:@"ic_default_head"];
    [_loginButton setTitle:@"登录/注册" forState: UIControlStateNormal];
    _loginButton.userInteractionEnabled = YES;
    
}



#pragma mark - 登录注册按钮点击事件
- (void)gotoLoginView
{
    TXLog(@"点击登录注册，进入登录界面");

    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    LoginViewController *loginVC = [[LoginViewController shareInstance] init];
    
#pragma mark -- 如果用户第三方QQ授权成功,返回此处调用block及时修改用户图像和名称
    loginVC.userInfo_QQ_Block = ^(NSString *username, NSString *iconUrlString){
    
        // 设置用户图像和昵称
        [_picImgView sd_setImageWithURL:[NSURL URLWithString:iconUrlString]];
        // 用户名
        [_loginButton setTitle:username forState: UIControlStateNormal];
        
        _loginButton.userInteractionEnabled = NO;

    };
    
    TXNavigationController *nav = [[TXNavigationController alloc] initWithRootViewController:loginVC];
    app.slider.rootViewController = nav;
    [self.navigationController pushViewController:nav animated:YES];
    

}

#pragma mark -- 菜单栏底部的设置和夜间模式按钮事件
- (void)clickSet:(UIButton *)sender{
    
    TXLog(@"点击了设置按钮,跳出设置页面");
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    SettingViewController *settingNextView = [[SettingViewController alloc] init];
    settingNextView.view.backgroundColor = [UIColor whiteColor];
    TXNavigationController *nav = [[TXNavigationController alloc] initWithRootViewController:settingNextView];
    app.slider.rootViewController = nav;
    [self.navigationController pushViewController:settingNextView animated:YES];
    
}

- (void)changePattem:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
//        TXLog(@"点击了夜间按钮,转换为夜间模式");
        // 第一种方法
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        UIView *coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        coverView.backgroundColor = [UIColor colorWithRed:0.092 green:0.090 blue:0.098 alpha:0.600];
        coverView.userInteractionEnabled = NO;
        coverView.tag = 1000;
        [app.window addSubview:coverView];
    
    }else{

        UIView *coverView = [self.view.window viewWithTag:1000 ];
        [coverView removeFromSuperview];
    }
    
}

#pragma mark -- 第三方授权修改用户图标
- (void)invokBlockOfThirdLogin:(NSString *)access_token Uid:(NSString *)uid{

    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    // AFN的AFJSONResponseSerializer默认不接受text/plain这种类型
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = access_token;
    params[@"uid"] = uid;
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 设置用户图像和昵称
        [_picImgView sd_setImageWithURL:[NSURL URLWithString:responseObject[@"profile_image_url"]]
         ];
        // 用户名
        [_loginButton setTitle:responseObject[@"screen_name"] forState: UIControlStateNormal];
        
        _loginButton.userInteractionEnabled = NO;

  
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD hideHUD];
        TXLog(@"请求失败-%@", error);
    }];

}

#pragma mark -- 点击用户图像
- (void)clickUserIcon:(UITapGestureRecognizer *)tapGesture{

    TXLog(@"用户登录成功可以设置头像");
    if ([[SustainManage shareInstance] loginState]) {
#warning 调用系统相册,在登录注册里面,可以抽出来
  
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
