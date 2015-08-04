//
//  ForgetPasswordViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ForgetPasswordView.h"
#import "SustainManage.h"
#import "LoginViewController.h"

@interface ForgetPasswordViewController ()<UIAlertViewDelegate>

@end

@implementation ForgetPasswordViewController


- (void)loadView
{

    self.forgetView = [[ForgetPasswordView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _forgetView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.view.backgroundColor = [UIColor colorWithRed:0.618 green:0.927 blue:1.000 alpha:1.000];
    self.navigationItem.title = @"重置密码";
    TXLog(@"标题：%@", self.navigationItem.title);
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backLoginView)];
    self.navigationItem.leftBarButtonItem = leftItem;
    TXLog(@"返回：%@", leftItem);
    
    //添加button事件
    [_forgetView.resetPassword addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    
    }
#pragma mark - 重置密码按钮
//点击重置密码按钮，密码重置成功，返回登录界面
- (void)reset
{
    
    if (_forgetView.loginEmail.textField.text ==nil ||[_forgetView.loginEmail.textField.text isEqualToString:@""] || _forgetView.againPassword.textField.text == nil || [_forgetView.againPassword.textField.text isEqualToString:@""] || _forgetView.affirmPassword.textField.text == nil  || [_forgetView.affirmPassword.textField.text isEqualToString:@""]) {
        TXLog(@"输入信息不完整");
        UIAlertView *notFinishMessage = [[UIAlertView alloc] initWithTitle:@"输入信息不完整" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [notFinishMessage show];
    }else{
    
     NSString *userName = [[SustainManage shareInstance] userName];
    if ([_forgetView.loginEmail.textField.text isEqualToString:userName] && [_forgetView.againPassword.textField.text isEqualToString:_forgetView.affirmPassword.textField.text] ) {
        TXLog(@"密码重置成功，返回登录界面");
        
        //用户信息保存到本地
        [[SustainManage shareInstance] setUserName:_forgetView.loginEmail.textField.text];
        [[SustainManage shareInstance] setUserPassWord:_forgetView.affirmPassword.textField.text];
        
        //延时
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"密码重置成功" message:nil delegate:self cancelButtonTitle:@"返回" otherButtonTitles: nil];
        [alertView show];
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];

        
    }
    else if (![_forgetView.loginEmail.textField.text isEqualToString:userName])
    {
        UIAlertView *isNotExit = [[UIAlertView alloc] initWithTitle:@"邮箱不存在" message:nil delegate:self cancelButtonTitle:@"返回" otherButtonTitles: nil];
        [isNotExit show];
        TXLog(@"该用户不存在");
    }
    else
    {
    
        UIAlertView *errorPwd = [[UIAlertView alloc] initWithTitle:@"密码不一致" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [errorPwd show];
        TXLog(@"两次密码不一致");
    }

}
}

#pragma mark - 返回登录界面
- (void)backLoginView
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}
#pragma mark - 键盘回收
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    [self resignFirstResponder];
}
//- (void)alertViewCancel:(UIAlertView *)alertView
//{
//    LoginViewController *loginView = [[LoginViewController alloc] init];
//    [self presentViewController:loginView animated:YES completion:^{
//        
//    }];
//
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
