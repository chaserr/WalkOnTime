//
//  TXTravelDetailViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/11.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXTravelDetailViewController.h"
#import "SubjectsModel.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MyUILabel.h"
#import "NSString+TXTrimming.h"
@interface TXTravelDetailViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) NSMutableArray *subjectArray;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollerview;
@property (strong, nonatomic) IBOutlet UIView *showView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *showView_height;

@property (strong, nonatomic) IBOutlet UIImageView *lagerImg;
@property (strong, nonatomic) IBOutlet UIImageView *smallImg;
@property (strong, nonatomic) IBOutlet UIView *subView_scroller;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sunbView_height;
@property (strong, nonatomic) IBOutlet UILabel *itemName;
@property (strong, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutlet UILabel *itemMsg;

@property (strong, nonatomic) IBOutlet UILabel *item_tro;

@property (strong, nonatomic)  UILabel *moreLabel;

@property (nonatomic, assign) BOOL isClose;

@property (nonatomic, assign) CGRect rect_moreLablePreFrame;
@property (nonatomic, assign) CGRect rect_introPreFrame;

@property (nonatomic, strong) NSString *into;

@property (nonatomic, strong) MyUILabel *descLabel;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture_more;

@end

@implementation TXTravelDetailViewController


- (void)loadView{

    self.view = [[[NSBundle mainBundle] loadNibNamed:@"TXTravelDetailViewController" owner:self options:nil] lastObject];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 利用webview展示详情
    
    
    [NSCharacterSet decimalDigitCharacterSet];
    
    
    if ([[self.detailWithUrl stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] trimming].length >0) {
        TXLog(@"不是纯数字");
        [self showDetail];
    }else{
        
        TXLog(@"纯数字");
        [self loadData_detail];
    }
    
}


#pragma mark -- 利用网络展示详情
- (void)showDetail{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.txTravelModel.subject_collection.name;
    
    // 初始化webview
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    // 创建Url对象
    NSURL *url = [NSURL URLWithString:self.detailWithUrl];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}

#pragma mark -- 请求详情页数据
- (void)loadData_detail{

        // 请求管理者
        AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
        // 请求参数:
    
    NSString *urlString = [NSString stringWithFormat:@"https://frodo.douban.com/api/v2/book/%@?apikey=0dad551ec0f84ed02907ff5c42e8ec70", self.detailWithUrl];
    
        [manger GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
            // 请求数据成功

            
            // 评分
            
            NSDictionary *ratingDict = responseObject[@"rating"];
            NSString *count = [NSString stringWithFormat:@"%@", ratingDict[@"count"]];
            NSString *valueStr = [[NSString stringWithFormat:@"%@", ratingDict[@"value"]] substringToIndex:3];
            NSString *scoreString = [NSString stringWithFormat:@"评分:%@  %@人评分", valueStr, count];
            self.score.text = scoreString;
            
            // itemMsg
            NSString *itemMsgString = [NSString stringWithFormat:@"%@/%@/%@", [[responseObject objectForKey:@"author"]objectAtIndex:0 ], [[responseObject objectForKey:@"press"]objectAtIndex:0 ], [[responseObject objectForKey:@"pubdate"]objectAtIndex:0 ]];
            self.itemMsg.text = itemMsgString;
            
            self.item_tro.text = @"简介:";
            
            // introduce
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreIntroduce:)];
            self.tapGesture = tapGesture;
            self.into = responseObject[@"intro"];
            self.descLabel = [[MyUILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_item_tro.frame)+10 , SCREEN_WIDTH - 40, 60)];
//            _descLabel.backgroundColor = [UIColor colorWithRed:0.432 green:1.000 blue:0.288 alpha:1.000];
            _descLabel.text = _into;
            _descLabel.numberOfLines = 3;
            _descLabel.userInteractionEnabled = YES;
            self.lagerImg.userInteractionEnabled = YES;
            _descLabel.font = [UIFont systemFontOfSize:14];
            [_descLabel addGestureRecognizer:tapGesture];
            [self.showView addSubview:_descLabel];
            
            self.rect_introPreFrame = _descLabel.frame;
            
            // 更多
            self.moreLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 50)/2, CGRectGetMaxY(_descLabel.frame)+10, 50, 20)];
            _moreLabel.text = @"更多";
            _moreLabel.font = [UIFont systemFontOfSize:14];
            _moreLabel.textColor = [UIColor colorWithRed:0.331 green:0.763 blue:1.000 alpha:1.000];
            _moreLabel.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tapGesture_more = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreIntroduce:)];
            self.tapGesture_more = tapGesture_more;
            [self.moreLabel addGestureRecognizer:tapGesture_more];
            self.rect_moreLablePreFrame = self.moreLabel.frame ;
            
            self.isClose = YES;
            
            [self.showView addSubview:_moreLabel];
            

            // 实现照片模糊
            CIContext *context = [CIContext contextWithOptions:nil];
            CIImage *inputImage = [[CIImage alloc] initWithContentsOfURL:[NSURL URLWithString:[[responseObject objectForKey:@"pic"] objectForKey:@"large"]]];
            // create gaussian blur filter
            CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
            [filter setValue:inputImage forKey:kCIInputImageKey];
            [filter setValue:[NSNumber numberWithFloat:6.0] forKey:@"inputRadius"];
            // blur image
            CIImage *result = [filter valueForKey:kCIOutputImageKey];
            CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
            UIImage *image = [UIImage imageWithCGImage:cgImage];
            CGImageRelease(cgImage);
            
            // 大图
            self.lagerImg.image = image;
            // 小图
            [self.smallImg sd_setImageWithURL:[NSURL URLWithString:[[responseObject objectForKey:@"pic"] objectForKey:@"normal"]]];
            self.itemName.text = responseObject[@"title"];

            
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            // 请求数据失败
            TXLog(@"错误代码:%@",error);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                //                [self.header endRefreshing];
                //                TXLog(@"connectionError%@", connectionError);
                [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试" duration:1];
                
            });
        }];
        
    
}

#pragma mark -- 点击查看更多
- (void)moreIntroduce:(UIGestureRecognizer *)tapGesture{

    _isClose = !_isClose;
    if (_isClose) {
        TXLog(@"还原位置");
        self.descLabel.numberOfLines = 3;
        self.moreLabel.frame = self.rect_moreLablePreFrame;
        self.descLabel.frame = self.rect_introPreFrame;
        [self updateViewConstraints];
        self.moreLabel.text = @"更多";
    }else{
    
        TXLog(@"更多");
        _descLabel.numberOfLines = 0;
        self.descLabel.frame = CGRectMake(20, CGRectGetMaxY(_item_tro.frame)+10, SCREEN_WIDTH-40, [TXTravelDetailViewController heightForString:self.into]);
        self.moreLabel.frame = CGRectMake((SCREEN_WIDTH- 50)/2, CGRectGetMaxY(_descLabel.frame)+20, 50, 30);
//        TXLog(@"改变后self.item_detailMsg.frame:%@", NSStringFromCGRect(self.moreLabel.frame));
        self.moreLabel.text = @"收起";
        [self updateViewConstraints];

    }

    
}


- (void)updateViewConstraints{

    [super updateViewConstraints];

    self.showView_height.constant = self.moreLabel.frame.origin.y +self.moreLabel.frame.size.height+50;
    
    self.sunbView_height.constant = self.showView_height.constant + self.showView.frame.origin.y;
}

#pragma mark -- 计算introduce高度
+ (CGFloat)heightForString:(NSString *)aString{

    CGRect rect = [aString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-40, 1000) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    return rect.size.height;
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

    // 让刷新控件停止显示刷新状态
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试" duration:1.5];
        
    });
}

// 懒加载
// 懒加载
- (NSMutableArray *)subjectArray{
    
    if (!_subjectArray) {
        self.subjectArray = [NSMutableArray array];
    }
    return _subjectArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
