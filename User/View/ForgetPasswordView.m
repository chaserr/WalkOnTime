//
//  ForgetPasswordView.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "ForgetPasswordView.h"

@implementation ForgetPasswordView

//初始化
- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        //注册邮箱
        self.loginEmail = [[LTView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 30)];
        _loginEmail.label.text = @"注册邮箱";
        _loginEmail.textField.placeholder = @"请输入邮箱";
        [self addSubview:_loginEmail];
        _loginEmail.textField.returnKeyType = UIReturnKeyNext;
        //重置密码
        self.againPassword = [[LTView alloc] initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 30)];
        _againPassword.label.text = @"密     码";
        _againPassword.textField.placeholder = @"请输入密码";
        _againPassword.textField.keyboardType = UIKeyboardTypeNumberPad;
        _againPassword.textField.returnKeyType = UIReturnKeyNext;
        _againPassword.textField.secureTextEntry = YES;
        [self addSubview:_againPassword];
        //确认密码
        self.affirmPassword = [[LTView alloc] initWithFrame:CGRectMake(0, 220, SCREEN_WIDTH, 30)];
     _affirmPassword.label.text = @"确认密码";
        _affirmPassword.textField.placeholder = @"请再次输入密码";
        _affirmPassword.textField.keyboardType = UIKeyboardTypeNumberPad;
        _affirmPassword.textField.returnKeyType = UIReturnKeyNext;
        _affirmPassword.textField.secureTextEntry = YES;
        [self addSubview:_affirmPassword];

        //按钮
        self.resetPassword = [UIButton buttonWithType:UIButtonTypeSystem];
        _resetPassword.frame = CGRectMake(SCREEN_WIDTH / 3, SCREEN_HEIGHT / 3 * 2, SCREEN_WIDTH / 3, 30);
        [_resetPassword setTitle:@"重置密码" forState:UIControlStateNormal];
        _resetPassword.backgroundColor = [UIColor whiteColor];
        [self addSubview:_resetPassword];
    }
    return self;
}
@end
