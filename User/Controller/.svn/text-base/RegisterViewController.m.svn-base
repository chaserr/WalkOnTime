//
//  RegisterViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "SustainManage.h"
#import "LoginView.h"
#import "NSString+Password.h"
@interface RegisterViewController ()<UIAlertViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic, strong) UIImageView *headPortraitView;
@property(nonatomic, strong) UITextField *nameTF;
@property(nonatomic, strong) UITextField *emailTF;
@property(nonatomic, strong) UITextField *passWordTF;
@property(nonatomic, strong) UIButton *finishBtn;
@property (nonatomic, strong)LoginView *backGround;
@property (nonatomic, strong)LoginView *backGround_Pwd;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    
    //返回
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backToLoginView)];
    self.navigationItem.leftBarButtonItem = back;

    
    [self layoutRegisterView];
}
#pragma mark - 返回登录页面
- (void)backToLoginView
{
    TXLog(@"返回登录页面");
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
}

#pragma mark - 点击注册按钮完成注册
- (void)finishedRegister
{
    TXLog(@"完成注册");
    NSString *userName = [[SustainManage shareInstance] userName];//从本地取出用户邮箱
    NSString *email = [[SustainManage shareInstance] email];
    
    if (_nameTF.text == nil || _emailTF.text == nil || _passWordTF.text ==nil|| [_nameTF.text isEqualToString:@""] ||[_emailTF.text isEqualToString:@""]|| [_passWordTF.text isEqualToString:@""] ) {
        UIAlertView *alertFailed = [[UIAlertView alloc] initWithTitle:@"错误" message:@"信息不完整" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"返回",nil];
        [alertFailed show];
        alertFailed.tag = 101;
        
        
           }
    else {//信息完整
        if ([_nameTF.text isEqualToString:userName]|[_emailTF.text isEqualToString:email]) {//用户存在
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"用户已存在" message:@"请直接登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
            [alertView show];
        }
    
    
    else{
        NSString *fieldPwd = [_passWordTF.text MD5]; // 给密码加密
        [[SustainManage shareInstance] setUserName:self.nameTF.text];//用户信息保存到本地
        [[SustainManage shareInstance] setUserPassWord:fieldPwd];
        [[SustainManage shareInstance] setUserEmail:self.emailTF.text];
        
        [[SustainManage shareInstance] synchronized];
        _headPortraitView.image.accessibilityIdentifier = @"userIcon"; // 给图片添加一个名字
        TXLog(@"昵称:%@, 密码:%@,邮箱:%@",self.nameTF.text,fieldPwd,self.emailTF.text);
//        TXLog(@"用户图标:%@",_headPortraitView.image.accessibilityIdentifier);
      
      UIAlertView *alertSucceed = [[UIAlertView alloc] initWithTitle:nil message:@"注册成功" delegate:self cancelButtonTitle:@"留在页面" otherButtonTitles: @"返回登录",nil];
      [alertSucceed show];
      alertSucceed.tag = 102;
        }
}

}


#pragma mark - 注册成功返回登录(返回按钮事件)
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    switch (buttonIndex) {
        case 1:{
            if ([alertView firstOtherButtonIndex] || [alertView viewWithTag:102]) {
                [self.navigationController popViewControllerAnimated:YES];
            }else
            {
                
                
            }}
            break;
            
        default:
            break;
    }

}

#pragma mark  - 点击空白回收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    [self.view endEditing:YES];
    
}
#pragma mark - 布局注册页面
- (void)layoutRegisterView
{
    

    
    //头像
    self.headPortraitView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 80)/2, 60, 100, 120 )];
    _headPortraitView.backgroundColor = [UIColor lightGrayColor];
    _headPortraitView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addUserIcon:)];
    [_headPortraitView addGestureRecognizer:tapGesture];

    [self.view addSubview:_headPortraitView];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(85, 105, 24, 24)];
    imageView.image = [UIImage imageNamed:@"camera"];
    [_headPortraitView addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture_camera = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addUserIcon_camera:)];
    [imageView addGestureRecognizer:tapGesture_camera];
  //昵称
    self.nameTF = [[UITextField alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(_headPortraitView.frame)+20 , SCREEN_WIDTH - 60, SCREEN_HEIGHT / 11)];
    _nameTF.backgroundColor = [UIColor whiteColor];
    _nameTF.layer.cornerRadius = 5;
    _nameTF.placeholder = @"昵称";
    _nameTF.delegate = self;
    _nameTF.keyboardType = UIKeyboardTypeDefault;
    [_nameTF setReturnKeyType:UIReturnKeyNext];
    
    [self.view addSubview:_nameTF];
    


    
    //邮箱
    self.emailTF = [[UITextField alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(_nameTF.frame), SCREEN_WIDTH - 60, SCREEN_HEIGHT / 11)];
    _emailTF.backgroundColor = [UIColor whiteColor];
    _emailTF.layer.cornerRadius = 5;
    _emailTF.placeholder = @"邮箱";
    _emailTF.keyboardType = UIKeyboardTypeEmailAddress;
    _emailTF.delegate = self;
    [_emailTF setReturnKeyType:UIReturnKeyNext];
    
    [self.view addSubview:_emailTF];

    

    
    //密码
    self.passWordTF = [[UITextField alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(_emailTF.frame)-1 , SCREEN_WIDTH - 60, SCREEN_HEIGHT / 11)];
    _passWordTF.backgroundColor = [UIColor whiteColor];
    _passWordTF.layer.cornerRadius = 5;
    _passWordTF.placeholder = @"密码";
    _passWordTF.delegate = self;
    _passWordTF.keyboardType = UIKeyboardTypeDefault;
    [_passWordTF setReturnKeyType:UIReturnKeyDone];
    _passWordTF.secureTextEntry = YES;
    [self.view addSubview:_passWordTF];
    // 线条
    self.backGround = [[LoginView alloc] initWithFrame:CGRectMake(35, CGRectGetMaxY(_nameTF.frame), SCREEN_WIDTH - 70, 1)];
    [_backGround setBackgroundColor:[UIColor lightGrayColor]];
    [[_backGround layer] setCornerRadius:5];
    [[_backGround layer] setMasksToBounds:YES];
    [self.view addSubview:_backGround];
    
    //    // 线条
    self.backGround_Pwd = [[LoginView alloc] initWithFrame:CGRectMake(35, CGRectGetMaxY(_emailTF.frame), SCREEN_WIDTH - 70, 1)];
    [_backGround_Pwd setBackgroundColor:[UIColor lightGrayColor]];
    [[_backGround_Pwd layer] setCornerRadius:5];
    [[_backGround_Pwd layer] setMasksToBounds:YES];
    [self.view addSubview:_backGround_Pwd];
    
    //完成
    self.finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _finishBtn.frame = CGRectMake(SCREEN_WIDTH /4, SCREEN_HEIGHT / 7 * 5 , SCREEN_WIDTH /2, SCREEN_HEIGHT / 11) ;
    [_finishBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_finishBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    _finishBtn.backgroundColor = [UIColor whiteColor];
    _finishBtn.layer.cornerRadius = 5;
    [_finishBtn addTarget:self action:@selector(finishedRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_finishBtn];
    

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    if (textField == _nameTF) {
        [_nameTF resignFirstResponder];
    }else if (textField == _emailTF){
    
        [_emailTF resignFirstResponder];
    }else{
    
        [_passWordTF resignFirstResponder];
    }
    
    return YES;
}


#pragma mark -- 添加用户图像
- (void)addUserIcon:(UITapGestureRecognizer *)tapGesture{

    TXLog(@"添加用户图像");
    
    // 访问相册
    [self visitPhoto];
}


#pragma mark -- 访问系统相册
- (void)visitPhoto{

    UIImagePickerController *imagePick = [[UIImagePickerController alloc] init];
    [self presentViewController:imagePick animated:YES completion:^{
        imagePick.delegate = self;
        imagePick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }];
    
}

#pragma mark -- UIImagePickerController delegate
// 相册选中后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        //先把图片转成NSData
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // 转换图片格式,
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil) {
            data = UIImageJPEGRepresentation(image, 1);
        }else{
            
            data = UIImagePNGRepresentation(image);
        }
        
#pragma mark-- 将选中的照片保存到沙盒中供使用
        //这里将图片放在沙盒的documents文件夹中

            // 获取doucument路径
        NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentsPath = [array lastObject];
          TXLog(@"documentsPath>>>>%@", documentsPath);
        
        // 文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:documentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createFileAtPath:[documentsPath stringByAppendingPathComponent:@"userIcon.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
       NSString *filePath_icon = [[NSString alloc]initWithFormat:@"%@%@",documentsPath,  @"/userIcon.png"];
        
        TXLog(@"图片完整路径:filePath%@",filePath_icon);
        
        TXLog(@"图片名:%@",filePath_icon.lastPathComponent);
//        NSString *iconName = filePath_icon.lastPathComponent;
        
        [[SustainManage shareInstance] setuserIcon:data];
        [[SustainManage shareInstance] synchronized];
        
        self.headPortraitView.image = image;

//        UIImageView *imView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 550, 150, 150)];
//        imView.backgroundColor = [UIColor blueColor];
//        imView.image = [UIImage imageWithData:data];
        
//        [self.view addSubview:imView];
        

    }

    [picker dismissViewControllerAnimated:YES completion:^{
        TXLog(@"相册调用完成");
    }];
}

// 取消按钮点击事件
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    TXLog(@"你取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark -- 调用摄像头
- (void)addUserIcon_camera:(UITapGestureRecognizer *)tapGesture{

    TXLog(@"调用摄像头");
    //调用摄像头
    [self camera];
    
}

- (void)camera{

    UIImagePickerController *imagePick = [[UIImagePickerController alloc] init];
    [self presentViewController:imagePick animated:YES completion:^{
        
        // 判断是否有后置摄像头
        //        UIImagePickerControllerCameraDeviceFront ,为前置摄像头
        BOOL iscamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!iscamera) {
            NSLog(@"没有摄像头");
            return ;
        }
        imagePick.delegate = self;
        imagePick.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePick.allowsEditing = YES; //拍完照可以进行编辑

    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
