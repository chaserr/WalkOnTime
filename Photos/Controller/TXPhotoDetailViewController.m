//
//  TXPhotoDetailViewController.m
//  WalkOnTime
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "TXPhotoDetailViewController.h"
#import "SubjectsModel.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MyUILabel.h"
#import "TXPhotoDetail_PhotoModel.h"
#import "TXPhotoDetail_photoCollectionViewCell.h"
#import "NSString+TXTrimming.h"
@interface TXPhotoDetailViewController ()<UIWebViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
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

@property (nonatomic, strong) UILabel *prevueLabel;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *photoArray;
@end

@implementation TXPhotoDetailViewController

- (void)loadView{
    
    self.view = [[[NSBundle mainBundle] loadNibNamed:@"TXPhotoDetailViewController" owner:self options:nil] lastObject];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [NSCharacterSet decimalDigitCharacterSet];
    
    if ([[self.detailWithUrl stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] trimming].length >0) {
        TXLog(@"不是纯数字");
        // 标题使用webView显示详情页
        [self loaddetail_film];
    }else{
        
        TXLog(@"纯数字");
        // 加载详情页
        [self loadData_detail];
    }
    
}

#pragma mark -- 使用webView显示详情页
- (void)loaddetail_film{

    self.title = self.txPhotoModel.subject_collection.name;
    
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
    
    NSString *urlString = [NSString stringWithFormat:@"https://frodo.douban.com/api/v2/tv/%@?apikey=0dad551ec0f84ed02907ff5c42e8ec70", self.detailWithUrl];
    
    [manger GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 请求数据成功
        
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
        // 评分
        
        NSDictionary *ratingDict = responseObject[@"rating"];
        NSString *count = [NSString stringWithFormat:@"%@", ratingDict[@"count"]];
        NSString *valueStr = [[NSString stringWithFormat:@"%@", ratingDict[@"value"]] substringToIndex:3];
        NSString *scoreString = [NSString stringWithFormat:@"评分:%@  %@人评分", valueStr, count];
        self.score.text = scoreString;
        
        // itemMsg
        NSMutableString *genresString = [NSMutableString string];
        NSArray *genresArray = responseObject[@"genres"];
        for (NSString *str in genresArray) {
            
            [genresString appendString:[NSString stringWithFormat:@"%@/", str]];
            
        }
        
        self.item_tro.text = @"简介:";
        
//        TXLog(@">>>%@", genresString);
        NSMutableString *actorsString = [NSMutableString string];
        NSArray *actorsArray = responseObject[@"actors"];
        for (NSString *str in actorsArray) {
            
            [actorsString appendString:[NSString stringWithFormat:@"%@/", str]];
            
        }
        
        NSString *typeString = responseObject[@"type"];
        if ([typeString isEqualToString:@"movie"]) {
            
            NSString *itemMsgString = [NSString stringWithFormat:@"%@(导演)/%@/%@%@",  [[[responseObject objectForKey:@"directors"]objectAtIndex:0 ] objectForKey:@"name"], actorsString, genresString, [[responseObject objectForKey:@"pubdate"]objectAtIndex:0 ]];
            self.itemMsg.text = itemMsgString;
            
            
        }else{
        
            NSString *itemMsgString = [NSString stringWithFormat:@"%@%@", genresString, [[responseObject objectForKey:@"pubdate"]objectAtIndex:0 ]];
            self.itemMsg.text = itemMsgString;
        }
        

        
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
        
        

        
        
        UILabel *prevueLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_moreLabel.frame)+20, 200, 20)];
        prevueLabel.text = @"预告片/剧照";
//        prevueLabel.backgroundColor = [UIColor redColor];
        prevueLabel.font = [UIFont systemFontOfSize:14];
        [self.showView addSubview:prevueLabel];
        self.prevueLabel = prevueLabel;
        
        // 布局剧照collection
        [self layoutPrevuecollec:responseObject[@"id"]];
        
        
        
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

#pragma mark -- 布局剧照collec
- (void)layoutPrevuecollec:(NSString *)itemId{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_prevueLabel.frame)+10, SCREEN_WIDTH, 150) collectionViewLayout:flowLayout];
    
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    // 水平滚动时代表列最小间距
    flowLayout.minimumLineSpacing = 3;
    // 水平滚动时代表行最小间距
    flowLayout.minimumInteritemSpacing = 3;
    
    // 设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置item大小
    flowLayout.itemSize = CGSizeMake(170, 150);
    
    // 设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    // 注册可重用标识
    [_collectionView registerClass:[TXPhotoDetail_photoCollectionViewCell class] forCellWithReuseIdentifier:@"TXPhotoDetail_photoCollectionViewCell"];
    
    // 设置是否显示滚动条
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    // 设置是否反弹
    _collectionView.bounces = NO;
    
    // 设置item距离分区边界的位置
    //        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 15, 5);
    
    
    [self loadCollectionData_photo:itemId];
    
    [self.collectionView reloadData];
    
    [self.showView addSubview:_collectionView];
}


#pragma mark -- collecion数据请求
- (void)loadCollectionData_photo:(NSString *)itemId{
  
//    https://frodo.douban.com/api/v2/movie/1780330/photos?udid=1422361929c3079a48b9248d9b10e6f06eb61091&apikey=0dad551ec0f84ed02907ff5c42e8ec70&device_id=1422361929c3079a48b9248d9b10e6f06eb61091
    
    NSString *urlString = [NSString stringWithFormat:@"https://frodo.douban.com/api/v2/movie/%@/photos?udid=1422361929c3079a48b9248d9b10e6f06eb61091&apikey=0dad551ec0f84ed02907ff5c42e8ec70&device_id=1422361929c3079a48b9248d9b10e6f06eb61091", itemId];
    
    // 对第4个section上的collectionView进行数据请求
    // 请求管理者
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    
    
    
    // 请求参数:
    [manger GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 请求数据成功
        
        NSArray *photoTempArray = responseObject[@"photos"];
        
        for (NSDictionary *dict in photoTempArray) {
        
            NSDictionary *dict_photo = dict[@"image"];
            TXLog(@">>>>>>%@",  dict_photo);
            NSDictionary *normal_photo = dict_photo[@"normal"];
            
            TXPhotoDetail_PhotoModel *photoModel = [TXPhotoDetail_PhotoModel txPhotoDetail_photoModelWithDict:normal_photo];
            [self.photoArray addObject:photoModel];
        }

         [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求数据失败
        TXLog(@"错误代码:%@",error);
    }];
    
}

#pragma mark -- collection dalegate and datasource
// 设置collection分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

// 设置item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _photoArray.count;
//        return 10;
}

// 绘制cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TXPhotoDetail_photoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TXPhotoDetail_photoCollectionViewCell" forIndexPath:indexPath];
    
    cell.txPhotoDetail_PhotoModel = _photoArray[indexPath.item];
    
    
    return cell;
}


// 选中item
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    TXLog(@"选中第%ld个item", (long)indexPath.item);
//    TXPhotoDoulistModel *txPhotoDoulistModel = _photoDoulistsArray[indexPath.item];
//    if ([_delegate respondsToSelector:@selector(CollectionWithTableViewCellDelegate:)]) {
//        [_delegate CollectionWithTableViewCellDelegate:txPhotoDoulistModel];
//    }
//}






#pragma mark -- 点击查看更多
- (void)moreIntroduce:(UIGestureRecognizer *)tapGesture{
    
    _isClose = !_isClose;
    if (_isClose) {
        TXLog(@"还原位置");
        self.descLabel.numberOfLines = 3;
        self.moreLabel.frame = self.rect_moreLablePreFrame;
        self.descLabel.frame = self.rect_introPreFrame;
        
        self.moreLabel.text = @"更多";
        _prevueLabel.frame = CGRectMake(20, CGRectGetMaxY(self.moreLabel.frame)+20, 200, 20);
        self.collectionView.frame = CGRectMake(20, CGRectGetMaxY(_prevueLabel.frame)+10, SCREEN_WIDTH, 150);
        [self updateViewConstraints];
    }else{
        
        TXLog(@"更多");
        _descLabel.numberOfLines = 0;
        self.descLabel.frame = CGRectMake(20, CGRectGetMaxY(_item_tro.frame)+10, SCREEN_WIDTH-40, [TXPhotoDetailViewController heightForString:self.into]);
        self.moreLabel.frame = CGRectMake((SCREEN_WIDTH- 50)/2, CGRectGetMaxY(_descLabel.frame)+20, 50, 30);
        //        TXLog(@"改变后self.item_detailMsg.frame:%@", NSStringFromCGRect(self.moreLabel.frame));
        self.moreLabel.text = @"收起";
        
        _prevueLabel.frame = CGRectMake(20, CGRectGetMaxY(self.moreLabel.frame)+20, 200, 20);
        self.collectionView.frame = CGRectMake(20, CGRectGetMaxY(_prevueLabel.frame)+10, SCREEN_WIDTH, 150);
        [self updateViewConstraints];
    }
    
    
}


- (void)updateViewConstraints{
    
    [super updateViewConstraints];
    
//    self.showView_height.constant = self.moreLabel.frame.origin.y +self.moreLabel.frame.size.height+50;
    self.showView_height.constant = self.collectionView.frame.origin.y +self.collectionView.frame.size.height+50;
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
- (NSMutableArray *)subjectArray{
    
    if (!_subjectArray) {
        self.subjectArray = [NSMutableArray array];
    }
    return _subjectArray;
}

// 懒加载
- (NSMutableArray *)photoArray{
    
    if (!_photoArray) {
        self.photoArray = [NSMutableArray array];
    }
    return _photoArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
